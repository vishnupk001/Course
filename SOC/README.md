# Cyber Kill Chain Steps

There are several actions that an attacker can take before, during, and after a successful cyber attack. These actions are sequential, and if the attacker fails at one stage, it is not possible to execute the next step of the cyber attack. The Cyber Kill Chain model divides these stages of attackers into 7 steps. The steps of cyber attacks are depicted in the visual  below:

* Reconnaissance
* Weaponization
* Delivery
* Exploitation
* Installation
* Command & Control (C2)
* Actions on Objectives

  ## Reconnaissance

The Cyber Kill Chain begins with the "Reconnaissance" step. The attacker attempts to obtain information about the target system at this step. The more knowledge an attacker has about the target system, the more the attack surface seems to him. Attack vectors for the target are disclosed in this way. The techniques employed at this stage may be divided into two subcategories:

### Passive Reconnaissance
### Active Reconnaissance
The term "Passive Reconnaissance" refers to the collecting of information from sources about the target system without physically engaging with the target system. As an instance of this, Web archive websites can be used to obtain information that is no longer available on the target system's website.

"Active Reconnaissance" refers to the method of acquiring information about a target system by engaging with it directly. By submitting a request to a web server, for instance, version information about the web server may be acquired from the response.

## Adversary
The attacker can gather information from a variety of sources using a variety of approaches during the "Reconnaissance" process. At this phase, the attacker can perform the following operations:

Obtaining version information of servers and software belonging to the target
Obtaining information from open sources of information about the target has previously been released
Obtaining e-mail addresses of employees of the organization
Obtaining internal or personal information about employees of the organization using social networking platforms
Detection of devices that are connected to the Internet
Detection of security vulnerabilities on servers open to access on the Internet
Identifying the IP address block belonging to the organization
Identification of vendors that the organization cooperates with


## Defender
Blueteams may take action in response to attackers' attempts at this stage. This reduces the amount of information that an attacker can obtain. Some methods that SOC analysts and blueteams can implement are listed below:

Detection of areas of information disclosure with external pentest
Obtaining leak information about the organization from Threat Intelligence sources
Not to keep the documents providing organizational information available on the internet
Monitoring traffic by installing security solutions such as firewalls in areas of the company that are accessible over the internet
Instantly updating to avoid new security vulnerabilities from being exploited


The first phase of the Cyber Kill Chain, the "Reconnaissance" step, is discussed in this section of the training, along with some actions that attackers can take and some precautions that Blueteams can adopt at this stage. "Weaponization" is explained in the following section of the course.

