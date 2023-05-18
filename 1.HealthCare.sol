// SPDX-License-Identifier: PLUTO
pragma solidity ^0.8.0;

contract HealthcareContract {
    struct Patient {
        uint256 id;
        string name;
        uint256 age;
        string condition;
    }

    mapping(address => Patient) public patients;
    address[] public patientAddresses;

    event PatientAdded(uint256 id, string name, uint256 age, string condition);

    function addPatient(
        uint256 _id,
        string memory _name,
        uint256 _age,
        string memory _condition
    ) public {
        require(patients[msg.sender].id == 0, "Patient already exists");

        patients[msg.sender] = Patient(_id, _name, _age, _condition);
        patientAddresses.push(msg.sender);

        emit PatientAdded(_id, _name, _age, _condition);
    }

    function getPatientCount() public view returns (uint256) {
        return patientAddresses.length;
    }

    function getPatientByIdx(uint256 idx)
        public
        view
        returns (
            uint256,
            string memory,
            uint256,
            string memory
        )
    {
        require(idx < patientAddresses.length, "Invalid index");

        address patientAddress = patientAddresses[idx];
        Patient memory patient = patients[patientAddress];

        return (patient.id, patient.name, patient.age, patient.condition);
    }
}
