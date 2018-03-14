{\rtf1\ansi\ansicpg936\cocoartf1504\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;\csgray\c100000;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 pragma solidity ^0.4.14;\
\
contract Payroll\{\
    address owner;\
    address currentEmployee;\
    uint lastPayday;\
    uint salary = 1 ether;\
    uint constant payDuration = 10 seconds;\
    \
    function Payroll()\{\
        owner = msg.sender;\
    \}\
    \
    function updateEmployee(address _address,uint _salary)\{\
        require(msg.sender == owner);\
        if(currentEmployee != 0x0)\{\
            uint payment = salary * (now - lastPayday)/payDuration;\
            currentEmployee.transfer(payment);\
        \}\
        currentEmployee = _address;\
        salary = _salary * 1 ether;\
        lastPayday = now;\
    \}\
    \
    function addFund() payable returns (uint)\{\
        return this.balance;\
    \}\
    \
    function calculateRunway() returns (uint)\{\
        return this.balance / salary;\
    \}\
    \
    function hasEnoughFund() returns (bool)\{\
        return calculateRunway() > 0;\
    \}\
    \
    function getPaid()\{\
        uint nextPayday = lastPayday + payDuration;\
        if(nextPayday > now)\{\
            revert();\
        \}\
        lastPayday = nextPayday;\
        currentEmployee.transfer(salary);\
    \}\
\}}