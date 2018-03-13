{\rtf1\ansi\ansicpg936\cocoartf1561\cocoasubrtf200
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 pragma solidity ^0.4.14;\
contract Payroll\{\
    uint salary ;\
    uint constant payDuration = 10 seconds;\
    uint lastPayday = now;\
    address add;\
    function setSalary(uint s)\{\
        salary = s*1 ether;\
    \}\
    function setAdd(address a)\{\
        add = a;\
    \}\
    function addFund() payable returns(uint)\{\
        return this.balance;  \
    \}\
    function calculateRunway() returns(uint)\{\
        return this.balance/salary;\
    \}\
    function hasEnough() returns (bool)\{\
        return calculateRunway()>0;\
    \}\
    \
    function getPaid()\{\
     \
      uint nextPayDay = lastPayday + payDuration;\
      if(nextPayDay >now)\{\
          revert();\
      \}\
      add.transfer(salary);\
    \}\
\}}