{\rtf1\ansi\ansicpg936\cocoartf1504\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;\csgray\c100000;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 pragma solidity ^0.4.14;\
import './Ownable.sol';\
import './SafeMath.sol';\
contract Payroll is Ownable\{\
    using SafeMath for uint;\
    struct Employee\{\
        address id;\
        uint salary;\
        uint lastPayday;\
    \}\
    uint constant payDuration = 10 seconds;\
    address owner;  \
    uint public totalsalary ;\
    mapping(address=>Employee) public employees;\
\
    \
    modifier employeeNotExist(address employeeID)\{\
         var employee = employees[employeeID]; \
         assert(employee.id == 0x0);\
         _;\
    \}\
     modifier employeeExist(address employeeID)\{\
         var employee = employees[employeeID]; \
         assert(employee.id != 0x0);\
         _;\
    \}\
    \
    \
    function _partialPaid(Employee employee) private\{\
          uint payment = employee.salary * (now - employee.lastPayday)/payDuration;\
          employee.id.transfer(payment);\
    \}\
    \
  \
    \
    \
    function addEmployee(address employeeID,uint salary) onlyOwner employeeNotExist(employeeID)\{\
        employees[employeeID] = Employee(employeeID,salary*1 ether,now);\
        totalsalary = totalsalary.add(salary * 1 ether);\
    \}\
    \
    \
    function removeEmployee(address employeeID) onlyOwner employeeExist(employeeID)\{\
        var employee = employees[employeeID]; \
        _partialPaid(employee);\
        totalsalary = totalsalary.sub(employee.salary);\
        delete employees[employeeID];\
    \}\
    \
    function updateEmployee(address employeeID, uint salary) onlyOwner employeeExist(employeeID)\{\
        var employee = employees[employeeID];\
        _partialPaid(employee);\
        totalsalary = totalsalary.sub(employee.salary);\
        employees[employeeID].salary = salary * 1 ether;\
        totalsalary.add(employees[employeeID].salary);\
        employees[employeeID].lastPayday = now;\
        \
        \
    \}\
    function changePaymentAddress(address oldAddress,address newAddress) onlyOwner employeeExist(oldAddress)\{\
        var employee = employees[oldAddress];\
        uint salary = employee.salary;\
        uint lastPayday = employee.lastPayday;\
        delete employees[oldAddress];\
        addEmployee(newAddress,salary/1 ether);\
        var newEmployee = employees[newAddress];\
        newEmployee.lastPayday = lastPayday;\
    \}\
\
  \
    \
    function addFund() payable returns(uint)\{\
        return this.balance;  \
    \}\
    function calculateRunway() returns(uint)\{\
        return this.balance/totalsalary;\
    \}\
    function hasEnough() returns (bool)\{\
        return calculateRunway()>0;\
    \}\
    \
    \
    \
    function getPaid() employeeExist(msg.sender)\{\
        var employee = employees[msg.sender];\
        uint nextPayday = employee.lastPayday + payDuration;\
        assert(nextPayday < now);\
        employee.lastPayday = nextPayday;\
        employee.id.transfer(employee.salary);\
    \}\
\}}