//SPDX-License-Identifier: PLUTO
pragma solidity >=0.7.0 <0.9.0;

contract Feepayment {
    uint256 totalfee;
    uint256 fee;
    struct Student {
        string Name;
        string roll_no;
        string ac_year;
        string department;
        string account_ID;
    }
    Student student;

    function setStudent() public {
        student = Student(
            "Name",
            "1601xxxxxxxxx",
            "Academic year",
            "Department-Branch",
            "acc_ID"
        );
    }

    function getStudentInfo() public view returns (string memory) {
        return student.roll_no;
    }

    struct Management {
        string College_name;
        string Bank_Id;
        string bank_name;
        string Admin;
    }
    Management college;

    function setManagement() public {
        college = Management("CBIT", "bank_id", "ICICI", "administrator");
    }

    function getManagementInfo() public view returns (string memory) {
        return college.College_name;
    }

    function totalfeeset(uint256) public {
        totalfee = 150000;
    }

    function feeset(uint256 _paidfee) public {
        fee = _paidfee;
    }

    function DUE() public view returns (uint256) {
        uint256 due = totalfee - fee;
        return due;
    }

    function getResult() public view returns (string memory) {
        if (fee == 150000) {
            return "The fee is paid";
        } else if (fee <= 149999 && fee > 0) {
            return "There is a due in the fees to be paid";
        } else {
            return "Fees is Not Paid Yet!";
        }
    }
}
