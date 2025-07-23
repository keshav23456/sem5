#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/thmbox:0.2.0": *

#show: thmbox-init(counter-level: 2)
#set text(lang: "en")
#set figure(numbering: none)

#let definition-counter = counter("definition")
#show: sectioned-counter(definition-counter, level: 2)
#let definition = definition.with(counter: definition-counter)

#show: ilm.with(
  title: [Ethical Hacking],
  author: "Indranil Sengupta",
  abstract: [
    Remember to complete all the fucking assignments
  ],
)

= Week One

== Introduction to Ethical Hacking

#definition[Ethical Hacking][
  It refers to the act of locating weaknesses and vulnerabilities of computers and information systems by replicating the intent and actions of malicious hackers.\
  It is also called as penetration testing, intrusion testing or red teaming.
]
*Ethical Hackers* are employed by companies to perform penetration tests.\
A *Penetration Test* is a *legal* attempt to break into a company's network to find the weak links. It involves generating a report with all the vulnerabilities but does not provide solutions.\
A *Security Test* also includes analyzing a company's security policy and procedures but the tester offers solutions to secure or protect the network.

Some common terminologies are:
- *Cracking* refers to breaching security on software or systems
- *Spoofing* is faking the originating IP address in a datagram#footnote[It is a self-contained packet of data sent across a network without guaranteed delivery.]
- *Denial of Service (DoS)* is an attack which involves flooding a host with sufficient network traffic so that it cannot respond anymore
- *Port Scanning* is the process of probing a computer or network for open communication ports

Some methods to gain access are:
- *Front Door* refers to the intended methods for entry, these involve password guessing and stealing
- *Back Door* refers to any method that allows someone entry without going through the usual security checks, these involve abusing test accounts or debug/diagnostic tools
- *Trojan Horse* is a malware which installs back doors into a system. These disguise themselves as legitimate programs
- *Software Vulnerability Exploitation* is often advertised on the OEMs website along with security patches

Some things a hacker once inside can do are:
- *Modify Logs* thus covering their tracks
- *Steal files* which are important and then delete them while covering their tracks
- *Modify files*
- *Install backdoors*
- *Attack other systems*

Some penetration testing methodologies are:
- *Tiger Box* is a computer loaded with hacking tools for penetration testing and security assessments
- *White/Glass Box Model* is when the tester has full knowledge of the target system including source code, network diagrams, etc
- *Black Box Model* is when the tester has no information about the network
- *Gray Box Model* is when the tester has partial information about the network.

== Basic Concepts of Networking

#definition[Computer Network][
  It is a communication system that connects devices to share resources and information. It allows for diverse devices, resource sharing and connectivity.
]
Some types of networks are:
- *Local Area Network* is used to connect hosts within a relatively small geographical area, i.e. in the same building. It is faster and cheaper.
- *Wide Area Network* is used to connect hosts which are widely dispersed, i.e. across campuses or cities. It is slower and expensive.

Data is sent over a network via one of two approaches:
- *Circuit Switching* is a method of communication where a dedicated path is established between two nodes for the duration of their connection. It requires 3 steps for communication, Connection Establishment, Data Transfer and Connection Termination. However, the channel capacity is dedicated during the entire duration of the communication#footnote[Inefficient for bursty traffic like data] and there is initial delay due to connection establishment.
- *Packet Switching* is a communication method where data is broken into packets and sent independently across a shared network. This is a more modern approach where network resources are not dedicated and a link can be shared. The data is transmitted in small packets#footnote[A longer message is broken into packets each with sizes in Kilobytes] containing a header with relevant information about routing, etc. It is based on store-and-forward concept. Each intermediate node (router) maintains a routing table. It is more suitable for computer-generated (bursty) traffic, buffering and data rate conversion can be performed easily and packets can be given priority. #footnote[An old approach to this which is not used is the Virtual Circuit Approach. Here a *Call Request* packet is sent from source to destination and a *Call Accept* packet return back. It also follows a store-and-forward concept]
The widely used method for packet switching is the datagram approach. Here, no route is established beforehand and each packet is treated as an independent entity and can take any route to the destination. However, this means that the packets may arrive out of order, any node crash will result in loss of all queued packets and duplicate packets may be generated. It is faster than the virtual circuit approach, flexible and can handle congestion/failed link since packets follow different paths.

Some types of delays are:
- *Propagation Delay* is the time taken by a data signal to propagate from one node to the next
- *Transmission Time* is the time taken to send out a packet by the transmitter
- *Processing Delay* is the time taken by a node to process a packet

*Layered Network Architecture* divides networking into distinct layers, each with specific responsibilities.
#definition[OSI Model][
  The OSI Model (Open Systems Interconnection Model) is a conceptual model developed by the International Organization for Standardization (ISO) to standardize the functions of a communication system or network. It divides the process of network communication into seven distinct layers, each with specific roles and responsibilities. The 7 layers are#footnote[The first 3 are point-to-point, meaning each node contains these and the rest are host-to-host, meaning only the source and destination]:
  #columns(2)[
    - Physical
    - Data Link
    - Network
    #colbreak()
    - Transport
    - Session
    - Presentation
    - Application#footnote[Closest to end user]
  ]
]
The following is an introduction to each layer:
- *Physical Layer* transmits raw bit stream over a physical layer
- *Data Link Layer* guarantees reliable transfer of frames over a point-to-point link (flow-control, error-control)
- *Network Link* establishes, maintains and terminates connections and routes packets through point-to-point links
- *Transport Layer* ensures reliable, end-to-end communication between devices on a network
- *Session Layer* manages and controls the dialog (sessions) between two computers in a network
- *Presentation Layer* formats, encrypts, and translates data for the application layer above it
- *Application Layer* provides network services directly to end-user applications
#figure(
  image("Data-Flow.png"),
  caption: [
    Stack like flow of data
  ]
)
Some inter-networking devices are:
- *Hub* is a basic networking device that connects multiple computers in a network and transmits data to all connected devices. It is used to extend the span of a single LAN
- *Switch* is a network device that connects devices and intelligently forwards data only to the intended recipient
- *Bridge/Layer-2 Switch* is a network device that connects and filters traffic between two or more network segments at the data link layer. It is used to connect two or more LANs together. It works at the data link layer
- *Router/Layer-3 Switch* is a network device that directs data packets between different networks, choosing the best path for each packet. It is used to connect any combination of LANs and WANs. It works at the network layer
#figure(
  image("Internetworking-Structure.png"),
  caption: [
    Typical Inter-Networking Structure
  ]
)
