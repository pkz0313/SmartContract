{\rtf1\ansi\ansicpg936\cocoartf1561\cocoasubrtf200
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 pragma solidity ^0.4.14;\
contract Payroll\{\
    struct Employee\{\
        address id;\
        uint salary;\
        uint lastPayday;\
    \}\
    uint constant payDuration = 10 seconds;\
    address owner;\
    Employee [] employees;\
    \
    function Payroll()\{\
        owner = msg.sender;\
    \}\
    \
    function _partialPaid(Employee employee) private\{\
          uint payment = employee.salary * (now - employee.lastPayday)/payDuration;\
          employee.id.transfer(payment);\
    \}\
    \
    function _findEmployee(address employeeID) private returns (Employee,uint)\{\
        for(uint i = 0;i < employees.length;i++)\{\
            if(employees[i].id == employeeID)\{\
                return (employees[i],i);\
            \}\
        \}\
\
    \}\
    \
    \
    function addEmployee(address employeeID,uint salary)\{\
        require(msg.sender == owner);\
        var (employee,index) = _findEmployee(employeeID);\
        assert(employee.id == 0x0);\
        employees.push(Employee(employeeID,salary,now));\
    \}\
    \
    \
    function removeEmploye(address employeeID)\{\
        require(msg.sender == owner);\
        \
        \
        var(employee,index) = _findEmployee(employeeID);\
        assert(employee.id != 0x0);\
        \
        _partialPaid(employee);\
        delete employees[index];\
        employees[index] = employees[employees.length-1];\
        employees.length -= 1;\
              \
\
    \}\
    \
    function updateEmployee(address employeeID, uint salary)\{\
        require(msg.sender == owner);\
        var (employee,index) = _findEmployee(employeeID);\
\
        assert(employee.id != 0x0);\
        _partialPaid(employee);\
        employees[index].salary = salary;\
        employees[index].lastPayday = now;\
\
    \}\
\
  \
    \
    function addFund() payable returns(uint)\{\
        return this.balance;  \
    \}\
    function calculateRunway() returns(uint)\{\
        uint totalsalary = 0;\
        for (uint i = 0;i<employees.length;i++)\{\
            totalsalary += employees[i].salary;\
        \}\
        return this.balance/totalsalary;\
    \}\
    function hasEnough() returns (bool)\{\
        return calculateRunway()>0;\
    \}\
    \
    function getPaid()\{\
        var (employee,index) = _findEmployee(msg.sender);\
        assert(employee.id != 0x0);\
        uint nextPayday = employee.lastPayday + payDuration;\
        assert(nextPayday < now);\
        employees[index].lastPayday = nextPayday;\
        employee.id.transfer(employee.salary);\
    \}\
\}}