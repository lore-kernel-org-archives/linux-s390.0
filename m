From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [RFC 00/19] KVM: s390/crypto/vfio: guest dedicated crypto adapters
Date: Fri, 13 Oct 2017 13:38:45 -0400
Message-ID: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Overview:
--------
An adjunct processor (AP) facility is an IBM Z cryptographic facility. The 
AP facility is comprised of three AP instructions and from 1 to 256 AP 
adapter cards. The design takes advantage of the interpretive execution mode 
provided by the SIE architecture. With interpretive execution mode, the AP 
instructions executed on the guest are interpreted by the hardware. This 
allows guests direct access to AP adapter cards. The first goal of this 
patch series is to provide direct access by a KVM guest to an AP as a 
pass-through device. The second goal is to provide administrators with the
means to configure KVM guests to grant direct access to AP facilities 
assigned to the LPAR in which the host linux system is running. 

To facilitate the comprehension of the design, let's present an overview of
the AP architecture.

AP Architectural Overview
-------------------------
Let's start with some definitions:

* AP adapter

  An AP adapter is an IBM Z adapter card that can perform cryptographic 
  functionality. There can be from 0 to 256 adapters assigned to an LPAR.
  Each adapter is identified by a number from 0 to 255.   When 
  installed, an AP is accessed by AP instructions executed by any CPU. 

* AP domain

  An adapter can be partitioned into domains. An adapter can hold up to 256 
  domains. Each domain is identified by a number from 0 to 255. Domains can 
  be further classified into two types: 
  
    * Usage domains are domains that can be accessed directly to process AP 
      commands
  
    * Control domains are domains that are accessed indirectly by AP 
      commands sent to a usage domain to control or change the domain.

* AP Queue

  An AP queue is the means by which an AP command is sent to an 
  AP usage domain inside a specific AP. An AP queue is identified by a tuple 
  comprised of an AP adapter ID and a usage domain index corresponding
  to a given usage domain within the adapter. This tuple forms an AP Queue 
  Number (APQN) uniquely identifying an AP queue. AP instructions include 
  a field containing the APQN to identify the AP queue to which the AP 
  command is targetted.

* AP Instructions:

  There are three AP instructions:

  * NQAP: to enqueue an AP command-request message to a queue
  * DQAP: to dequeue an AP command-reply message from a queue
  * PQAP: to adminster the queues

Let's now see how AP instructions are interpreted by the hardware.

Start Interpretive Execution (SIE) Instruction
---------------------------------------------- 
A KVM guest is started by executing the Start Interpretive Execution (SIE)
instruction. The SIE state description is a control block that contains the
state information for a KVM guest and is supplied as input to the SIE 
instruction. The SIE state description contains a field that references 
a Crypto Control Block (CRYCB). The CRYCB contains three bitmask fields 
identifying the adapters, usage domains and control domains assigned to the 
KVM guest: 

* The AP Mask (APM) field specifies the AP adapters assigned to the 
  KVM guest. The APM controls which adapters are valid for the KVM guest. 
  The bits in the mask, from left to right, correspond to APIDs 
  0 up to the number of adapters that can be assigned to the LPAR. If a bit 
  is set, the corresponding adapter is valid for use by the KVM guest.

* The AP Queue Mask (AQM) field specifies the AP usage domains assigned 
  to the KVM guest. The bits in the mask, from left to right, correspond
  to the usage domains, from 0 up to the number of domains that can be 
  assigned to the LPAR. If a bit is set, the corresponding usage domain is 
  valid for use by the KVM guest. 

* The AP Domain Mask field specifies the AP control domains assigned to the 
  KVM guest. The ADM bitmask controls which domains can be changed by an AP 
  command-request message sent to a usage domain from the guest. The bits in 
  the mask, from left to right, correspond to domain 0 up to the number of 
  domains that can be assigned to the LPAR. If a bit is set, the 
  corresponding domain can be modified by an AP command-request message 
  sent to a usage domain configured for the KVM guest.

If you recall from the description of an AP Queue, AP instructions include
an APQN to identify the AP adapter and the specific usage domain within 
the adapter to which an AP command-request message is to be sent (NQAP 
and PQAP instructions), or from which a command-reply message is to be 
received (DQAP instruction). The validity of an APQN is defined by the 
matrix calculated from the APM and AQM; it is the intersection of all 
assigned adapter numbers (APM) with all assigned usage domain numbers (AQM).
For example, if adapters 1 and 2 and usage domains 5 and 6 are assigned to 
a guest, the APQNs (1,5), (1,6), (2,5) and (2,6) will be valid for the 
guest. 

The APQNs provide secure key functionality - i.e., the key is stored on the 
adapter card - so when the adapter card is not virtualized - i.e., the 
adapter is accessed directly by the guest - each APQN must be assigned to 
at most one guest.

   Example 1: Valid configuration:
   ------------------------------
   Guest1: adapters 1,2  domains 5,6
   Guest2: adapter  1,2  domain 7

   This is valid because both guests have a unique set of APQNs: Guest1 has
   APQNs (1,5), (1,6), (2,5) and (2,6); Guest2 has APQN (1,7) and (2,7).

   Example 2: Invalid configuration:
   --------------------------------
   Guest1: adapters 1,2  domains 5,6
   Guest2: adapter  1    domains 6,7

   This is an invalid configuration because both guests have access to 
   APQNs (1,6).  

Interruption architecture:

The AP interruption architecture may or may not generate interruptions to 
signal to the CPU the end of an AP transaction. The SIE interruption 
architecture, depending upon its configuration, may or may not redirect 
AP interrupts directly to a guest if the associated queue is valid for a 
guest, and may or may not report the interruption to the host.

Effective masking for guest level I and II:

A linux host running in the LPAR operates at guest-level 1 and has its own 
SIE state description. When operating at guest-level 1, the masks from the 
host's state description are used directly. A linux guest running in the 
host operates at guest-level 2. When operating at guest-level 2, the masks 
from the guest-level 1 (host) and guest-level 2 (guest) state descriptions 
are combined into a single description called an effective mask by 
performing a logical AND of the two state descriptions. 

The effective mask algorithm is used for the APM, AQM and ADM to create 
an EAPM, EAQM and EADM respectively. Use of the EAPM, EAQM and EADM 
precludes a guest-level 1 host program from passing to a guest-level 2
program APQNs to which it does not have access.

Linux cryptographic bus driver:

Linux already has a cryptographic bus driver that provides one AP device per
AP adapter and one device per AP queue. There is a device driver for each 
type of AP adapter device and each type of AP queue device. This design 
utilizes some of the interfaces and functionality provided by the AP bus 
driver.

Design Origin:
-------------

The original design was based on modelling AP Queue devices. The design
utilized the VFIO mediated device framework whereby a mediated AP queue
device would be created for each AP Queue bound to the VFIO AP Queue device
driver. This at first seemed like the most logical design choice for the 
following reasons:

* Securing access to an AP Queue device by unbinding it from its default 
  device driver and binding it to the VFIO device driver would not preclude 
  the host from having access to the other usage domains contained within 
  the same adapter card connected to the AP queue.

* An AP command is sent to a usage domain within a specific AP adapter via 
  an AP queue.

It became readily apparent that modelling the design on an AP queue was very 
convoluted for a number of reasons:

  * There is no convenient way to notify the VFIO device driver which guest 
    will have access to a given mediated AP queue device until the mediated 
    device's file descriptor is opened by the guest. Recall that the APQNs 
    configured for the guest are an intersection of all of the bits set in 
    both the APM and AQM, so the guest's APQNs can not be validated nor 
    its SIE state description configured until all of the guest's mediated 
    AP queue device file descriptors have been opened. 

    For example, suppose a guest opens file descriptors for mediated AP 
    queue devices representing APQNs 3,5 and 4,6. If bits 3 and 4 are set in 
    the guest's APM and bits 5 and 6 are set in the guest's AQM, then APQNs 
    (3,5), (3,6), (4,5) and (4,6) will be valid for the guest, but mediated 
    AP queue devices have been created only for APQNs (3,5) and (4,6). In 
    this case, APQNs still assigned to the host would also be available to 
    the guest which is a potential security breach.

  * Control domains are not devices and are not logically modelled as 
    mediated devices. In our original design, they were modelled as 
    attributes of a mediated AP queue device, but this was a clumsy use of
    the VFIO mediated device model.

  * The SIE state description models the assignment of AP resources as a
    matrix via the APM, AQM and ADM.   
     
The design we ultimately settled upon was modelled on the AP matrix as 
defined by the SIE state description. Supplying the complete AP matrix  
to SIE using bitmasks when starting a guest simplifies the code, is far 
easier to secure, and more closely matches the model employed by SIE. This 
is the design model implemented via this patch set. 

The Design
----------
This design introduces four new objects:

1. AP matrix bus

   The sysfs location of the AP matrix bus is /sys/bus/ap_matrix. This 
   bus will create a single AP matrix device (see below).

2. AP matrix device

   The AP matrix device is a singleton that hangs off of the AP matrix bus.
   This device holds the AP Queues that have been reserved for use by 
   KVM guests. The sysfs location of the AP matrix device is 
   /sys/devices/ap_matrix/matrix. It is also linked from the AP matrix
   bus at /sys/bus/ap_matrix/devices/matrix.  

3. VFIO AP matrix driver

   This driver is based on the VFIO mediated device framework. When the 
   driver is initialized, it will:

   * Get the AP matrix device created by AP matrix bus from the bus

   * Register with the AP bus to indicate that it can control AP Queue 
     devices. This allows AP Queue devices unbound from AP device drivers
     to be bound to the VFIO AP matrix driver. The AP Queues bound to the 
     VFIO AP matrix driver will be stored by the driver in the AP matrix 
     device. 

   * Register the AP matrix device with the VFIO mediated device 
     framework (MDEV). Registration with MDEV will create the sysfs 
     structures needed to create mediated matrix devices. Each MDEV matrix
     device is used to configure the AP matrix for a KVM guest. The MDEV
     matrix device's file descriptor can be used by QEMU to communicate
     with the VFIO AP matrix device driver.

   The VFIO AP matrix driver:

   * Provides the interfaces the administrator can use to secure AP Queues 
     for use by KVM guests. This is accomplished by unbinding the AP Queues 
     needed by each KVM guest from its AP device driver and binding it to 
     the VFIO AP queue driver. This prevents the host linux system from 
     using these Queues.

   * Provides an ioctl that can be used by QEMU to configure the 
     CRYCB referenced by the KVM guest's SIE state description. The ioctl 
     will 

     * Create an EAPM, EAQM and EADM by performing a logical AND of the 
       APM, AQM and ADM configured via the MDEV matrix device's sysfs 
       attributes files (see below) with the APM, AQM and ADM of the host's 
       SIE state description respectively. 

     * Configure the SIE state description for the KVM guest using the 
       effective masks created in the previous step.

4. VFIO MDEV matrix passthrough device

   An MDEV matrix passthrough device must be created for each KVM guest that 
   will need access to AP facilities. An MDEV matrix passthrough device is
   used by QEMU to configure the APM, AQM and ADM fields of the CRYCB 
   referenced by the KVM guest's SIE state description. The file descriptor
   for the MDEV matrix passthrough device provides the communication pathway
   between QEMU and the VFIO AP matrix device driver. 

   The MDEV matrix passthrough device, like the CRYCB, contains three 
   bitmasks - an APM, AQM and ADM - for specifying the AP matrix for the 
   KVM guest. Three sets of attributes files will be provided to allow an 
   administrator to set the bits in the MDEV matrix device's APM, AQM and
   ADM: 
 
   * A file to assign an AP adapter 
   * A file to unassign an AP adapter
   * A file to display the adapters assigned

   * A file to assign an AP domain 
   * A file to unassign an AP domain
   * A file to display the domains assigned

   * A file to assign an AP control domain 
   * A file to unassign an AP control domain
   * A file to display the control domains assigned

Example:
-------
Let's now provide an example to illustrate how KVM guests may be given
access to AP facilities. For this example, we will show how to configure 
two guests such that executing the lszcrypt command on the guests would 
look like this:

Guest1
------
CARD.DOMAIN TYPE  MODE        
------------------------------
05          CEX5C CCA-Coproc  
05.0004     CEX5C CCA-Coproc
05.00ab     CEX5C CCA-Coproc  
06          CEX5A Accelerator 
06.0004     CEX5A Accelerator 
06.00ab     CEX5C CCA-Coproc  

Guest2
------
CARD.DOMAIN TYPE  MODE        
------------------------------
05          CEX5A Accelerator 
05.0047     CEX5A Accelerator 
05.00ff     CEX5A Accelerator 

One thing to notice in this example is that each AP Queue set is identical.
For example, the two AP Queue sets for Guest1 both contain APQI 0004 and 
00ab. It would be an invalid condition if both queue sets did not contain
the same set of queues. We could not, for example, configure Guest1 with 
access to AP queue 05.00ff because the AP queue set for adapter 06 does not
contain AP queue 06.00ff. The point is, one must be careful to reserve 
a valid set of AP queues for a given guest.
a valid configuration. 

These are the steps for configuring the Guest1 and Guest2:
   
1. The first thing that needs to be done is to secure the AP queues to be 
   used by the two guests so that the host can not access them. This is done 
   by unbinding each AP Queue device from its respective AP driver. In our 
   example, these queues are bound to the cex4queue driver. This would be 
   the sysfs location of these devices: 

   /sys/bus/ap
   --- [drivers]
   ------ [cex4queue]
   --------- [05.0004]
   --------- [05.0047]
   --------- [05.00ab]
   --------- [05.00ff]
   --------- [06.0004]
   --------- [06.00ab]
   --------- unbind

   To unbind AP queue 05.0004 from the cex4queue device driver:

	echo 05.0004 > unbind

   This must also be done for AP queues 05.00ab, 05.0047, 05.00ff, 06.0004,
   and 06.00ab.

2. The next step is to reserve the queues for use by the two KVM guests. 
   This is accomplished by binding them to the VFIO AP matrix device driver. 
   This is the sysfs location of the VFIO AP matrix device driver:

   /sys/bus/ap
   ---[drivers]
   ------ [vfio_ap_matrix]
   ---------- bind

   To bind queue 05.0004 to the vfio_ap_matrix driver:

	echo 05.0004 > bind

   This must also be done for AP queues 05.00ab, 05.0047, 05.00ff, 06.0004,
   and 06.00ab.

3. Create the mediated devices needed to configure the AP matrices for the 
   two guests and to provide an interface to the vfio_ap_matrix driver for 
   use by the guests:

   /sys/devices/
   --- [ap_matrix]
   ------ [matrix] (this is the matrix device)
   --------- [mdev_supported_types]
   ------------ [ap_matrix-passthrough] (passthrough mediated device type)
   --------------- create
   --------------- [devices]

   To create the mediated devices for the two guests:

	uuidgen > create
	uuidgen > create

   This will create two mediated devices in the [devices] subdirectory named 
   with the UUID written to the create attribute file. We call them $uuid1
   and $uuid2:

   /sys/devices/
   --- [ap_matrix]
   ------ [matrix]
   --------- [mdev_supported_types]
   ------------ [ap_matrix-passthrough]
   --------------- [devices]
   ------------------ [$uuid1]
   --------------------- adapters
   --------------------- assign_adapter
   --------------------- assign_control_domain
   --------------------- assign_domain
   --------------------- control_domains
   --------------------- domains
   --------------------- unassign_adapter
   --------------------- unassign_control_domain
   --------------------- unassign_domain
   ------------------ [$uuid2]
   --------------------- adapters
   --------------------- assign_adapter
   --------------------- assign_control_domain
   --------------------- assign_domain
   --------------------- control_domains
   --------------------- domains
   --------------------- unassign_adapter
   --------------------- unassign_control_domain
   --------------------- unassign_domain

4. The administrator now needs to configure the matrices for mediated 
   devices $uuid1 (for Guest1) and $uuid2 (for Guest2). 

   This is how the matrix is configured for Guest1:

   echo 5 > assign_adapter
   echo 6 > assign_adapter 
   echo 4 > assign_domain
   echo ab > assign_domain

   When the assign.xxx file is written, the corresponding bit in the 
   respective MDEV matrix device's bitmask will be set. For example, when 
   adapter 5 is assigned, bit 5 - numbered from left to right starting with 
   bit 0 - will be set in the MDEV matrix device's APM. 

   By architectural convention, all usage domains - i.e., domains assigned 
   via the assign_domain attribute file - will also be configured in the ADM 
   field of the KVM guest's CRYCB, so there is no need to assign control 
   domains here unless you want to assign control domains that are not 
   assigned as usage domains. 

   If a mistake is made configuring an adapter, domain or control domain, 
   you can use the unassign_xxx files to unassign the adapter, domain or 
   control domain.

   To display the matrix configuration for Guest1:

   cat adapters
   cat domains
   cat control_domains

   This is how the matrix is configured for Guest2:

   echo 5 > assign_adapter 
   echo 47 > assign_domain
   echo ff > assign_domain

When a KVM guest is started, QEMU will open the file descriptor for its 
MDEV matrix device. The VFIO AP matrix device driver will be notified 
and will store the reference to the KVM guest's SIE state description. 
QEMU will then call the VFIO AP matrix ioctl requesting that the 
KVM guest's matrix be configured. The matrix driver will set the bits in the 
APM, AQM and ADM fields of the CRYCB referenced by the guest's SIE state 
description from the EAPM, EAQM and EADM created by performing a logical AND
of the AP masks configured in the MDEV matrix device and the masks 
configured in the host's SIE state description. When the guest comes up, it 
will have access to the APQNs identified in the AP matrix specified in the 
KVM guest's SIE state description. Programs running on the guest will then 
be able to use the cryptographic functions provided by the AP facilities 
configured for the guest.

Tony Krowiak (19):
  KVM: s390: SIE considerations for AP Queue virtualization
  KVM: s390: refactor crypto initialization
  s390/zcrypt: new AP matrix bus
  s390/zcrypt: create an AP matrix device on the AP matrix bus
  s390/zcrypt: base implementation of AP matrix device driver
  s390/zcrypt: register matrix device with VFIO mediated device
    framework
  KVM: s390: introduce AP matrix configuration interface
  s390/zcrypt: support for assigning adapters to matrix mdev
  s390/zcrypt: validate adapter assignment
  s390/zcrypt: sysfs interfaces supporting AP domain assignment
  s390/zcrypt: validate domain assignment
  s390/zcrypt: sysfs support for control domain assignment
  s390/zcrypt: validate control domain assignment
  KVM: s390: Connect the AP mediated matrix device to KVM
  s390/zcrypt: introduce ioctl access to VFIO AP Matrix driver
  KVM: s390: interface to configure KVM guest's AP matrix
  KVM: s390: validate input to AP matrix config interface
  KVM: s390: New ioctl to configure KVM guest's AP matrix
  s390/facilities: enable AP facilities needed by guest

 MAINTAINERS                                  |   13 +
 arch/s390/Kconfig                            |   13 +
 arch/s390/configs/default_defconfig          |    1 +
 arch/s390/configs/gcov_defconfig             |    1 +
 arch/s390/configs/performance_defconfig      |    1 +
 arch/s390/defconfig                          |    1 +
 arch/s390/include/asm/ap-config.h            |   32 +
 arch/s390/include/asm/kvm_host.h             |   26 +-
 arch/s390/kvm/Makefile                       |    2 +-
 arch/s390/kvm/ap-config.c                    |  224 ++++++++
 arch/s390/kvm/kvm-s390.c                     |   17 +-
 arch/s390/tools/gen_facilities.c             |    2 +
 drivers/s390/crypto/Makefile                 |    6 +-
 drivers/s390/crypto/ap_matrix_bus.c          |  115 ++++
 drivers/s390/crypto/ap_matrix_bus.h          |   25 +
 drivers/s390/crypto/vfio_ap_matrix_drv.c     |  107 ++++
 drivers/s390/crypto/vfio_ap_matrix_ops.c     |  790 ++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_matrix_private.h |   50 ++
 include/uapi/linux/vfio.h                    |   22 +
 19 files changed, 1438 insertions(+), 10 deletions(-)
 create mode 100644 arch/s390/include/asm/ap-config.h
 create mode 100644 arch/s390/kvm/ap-config.c
 create mode 100644 drivers/s390/crypto/ap_matrix_bus.c
 create mode 100644 drivers/s390/crypto/ap_matrix_bus.h
 create mode 100644 drivers/s390/crypto/vfio_ap_matrix_drv.c
 create mode 100644 drivers/s390/crypto/vfio_ap_matrix_ops.c
 create mode 100644 drivers/s390/crypto/vfio_ap_matrix_private.h
