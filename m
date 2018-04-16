From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 15/15] s390: doc: detailed specifications for AP
 virtualization
Date: Mon, 16 Apr 2018 15:13:59 +0200
Message-ID: <04a0cf49-71a1-214a-7261-d8e55adee1de@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-16-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523827345-11600-16-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 15/04/2018 23:22, Tony Krowiak wrote:
> This patch provides documentation describing the AP architecture and
> design concepts behind the virtualization of AP devices. It also
> includes an example of how to configure AP devices for exclusive
> use of KVM guests.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>   Documentation/s390/vfio-ap.txt |  567 ++++++++++++++++++++++++++++++++++++++++
>   MAINTAINERS                    |    1 +
>   2 files changed, 568 insertions(+), 0 deletions(-)
>   create mode 100644 Documentation/s390/vfio-ap.txt
>
> diff --git a/Documentation/s390/vfio-ap.txt b/Documentation/s390/vfio-ap.txt
> new file mode 100644
> index 0000000..a1e888a
> --- /dev/null
> +++ b/Documentation/s390/vfio-ap.txt
> @@ -0,0 +1,567 @@
> +Introduction:
> +============
> +The Adjunct Processor (AP) facility is an IBM Z cryptographic facility comprised
> +of three AP instructions and from 1 up to 256 PCIe cryptographic adapter cards.
> +The AP devices provide cryptographic functions to all CPUs assigned to a
> +linux system running in an IBM Z system LPAR.
> +
> +The AP adapter cards are exposed via the AP bus. The motivation for vfio-ap
> +is to make AP cards available to KVM guests using the VFIO mediated device
> +framework. This implementation relies considerably on the s390 virtualization
> +facilities which do most of the hard work of providing direct access to AP
> +devices.
> +
> +AP Architectural Overview:
> +=========================
> +To facilitate the comprehension of the design, let's start with some
> +definitions:
> +
> +* AP adapter
> +
> +  An AP adapter is an IBM Z adapter card that can perform cryptographic
> +  functions. There can be from 0 to 256 adapters assigned to an LPAR. Adapters
> +  assigned to the LPAR in which a linux host is running will be available to
> +  the linux host. Each adapter is identified by a number from 0 to 255. When
> +  installed, an AP adapter is accessed by AP instructions executed by any CPU.
> +
> +  The AP adapter cards are assigned to a given LPAR via the system's Activation
> +  Profile which can be edited via the HMC. When the system is IPL'd, the AP bus
> +  module is loaded and detects the AP adapter cards assigned to the LPAR. The AP
> +  bus creates a sysfs device for each adapter as they are detected. For example,
> +  if AP adapters 4 and 10 (0x0a) are assigned to the LPAR, the AP bus will
> +  create the following sysfs entries:
> +
> +    /sys/devices/ap/card04
> +    /sys/devices/ap/card0a
> +
> +  Symbolic links to these devices will also be created in the AP bus devices
> +  sub-directory:
> +
> +    /sys/bus/ap/devices/[card04]
> +    /sys/bus/ap/devices/[card04]
> +
> +* AP domain
> +
> +  An adapter is partitioned into domains. Each domain can be thought of as
> +  a set of hardware registers for processing AP instructions. An adapter can
> +  hold up to 256 domains. Each domain is identified by a number from 0 to 255.
> +  Domains can be further classified into two types:
> +
> +    * Usage domains are domains that can be accessed directly to process AP
> +      commands.
> +
> +    * Control domains are domains that are accessed indirectly by AP
> +      commands sent to a usage domain to control or change the domain, for
> +      example; to set a secure private key for the domain.
> +
> +  The AP usage and control domains are assigned to a given LPAR via the system's
> +  Activation Profile which can be edited via the HMC. When the system is IPL'd,
> +  the AP bus module is loaded and detects the AP usage and control domains
> +  assigned to the LPAR. The domain number of each usage domain will be coupled
> +  with the adapter number of each AP adapter assigned to the LPAR to identify
> +  the AP queues (see AP Queue section below). The domain number of each control
> +  domain will be represented in a bitmask and stored in a sysfs file
> +  /sys/bus/ap/ap_control_domain_mask created by the bus. The bits in the mask,
> +  from most to least significant bit, correspond to domains 0-255.
> +
> +  A domain may be assigned to a system as both a usage and control domain, or
> +  as a control domain only. Consequently, all domains assigned as both a usage
> +  and control domain can both process AP commands as well as be changed by an AP
> +  command sent to any usage domain assigned to the same system. Domains assigned
> +  only as control domains can not process AP commands but can be changed by AP
> +  commands sent to any usage domain assigned to the system.
> +
> +* AP Queue
> +
> +  An AP queue is the means by which an AP command-request message is sent to a
> +  usage domain inside a specific adapter. An AP queue is identified by a tuple
> +  comprised of an AP adapter ID (APID) and an AP queue index (APQI). The
> +  APQI corresponds to a given usage domain number within the adapter. This tuple
> +  forms an AP Queue Number (APQN) uniquely identifying an AP queue. AP
> +  instructions include a field containing the APQN to identify the AP queue to
> +  which the AP command-request message is to be sent for processing.
> +
> +  The AP bus will create a sysfs device for each APQN that can be derived from
> +  the intersection of the AP adapter and usage domain numbers detected when the
> +  AP bus module is loaded. For example, if adapters 4 and 10 (0x0a) and usage
> +  domains 6 and 71 (0x47) are assigned to the LPAR, the AP bus will create the
> +  following sysfs entries:
> +
> +    /sys/devices/ap/card04/04.0006
> +    /sys/devices/ap/card04/04.0047
> +    /sys/devices/ap/card0a/0a.0006
> +    /sys/devices/ap/card0a/0a.0047
> +
> +  The following symbolic links to these devices will be created in the AP bus
> +  devices subdirectory:
> +
> +    /sys/bus/ap/devices/[04.0006]
> +    /sys/bus/ap/devices/[04.0047]
> +    /sys/bus/ap/devices/[0a.0006]
> +    /sys/bus/ap/devices/[0a.0047]
> +
> +* AP Instructions:
> +
> +  There are three AP instructions:
> +
> +  * NQAP: to enqueue an AP command-request message to a queue
> +  * DQAP: to dequeue an AP command-reply message from a queue
> +  * PQAP: to administer the queues
> +
> +AP and SIE:
> +==========
> +Let's now see how AP instructions are interpreted by the hardware.
> +
> +A satellite control block called the Crypto Control Block is attached to our
> +main hardware virtualization control block. The CRYCB contains three fields to
> +identify the adapters, usage domains and control domains assigned to the KVM
> +guest:
> +
> +* The AP Mask (APM) field is a bit mask that identifies the AP adapters assigned
> +  to the KVM guest. Each bit in the mask, from most significant to least
> +  significant bit, corresponds to an APID from 0-255. If a bit is set, the
> +  corresponding adapter is valid for use by the KVM guest.
> +
> +* The AP Queue Mask (AQM) field is a bit mask identifying the AP usage domains
> +  assigned to the KVM guest. Each bit in the mask, from most significant to
> +  least significant bit, corresponds to an AP queue index (APQI) from 0-255. If
> +  a bit is set, the corresponding queue is valid for use by the KVM guest.
> +
> +* The AP Domain Mask field is a bit mask that identifies the AP control domains
> +  assigned to the KVM guest. The ADM bit mask controls which domains can be
> +  changed by an AP command-request message sent to a usage domain from the
> +  guest. Each bit in the mask, from least significant to most significant bit,
> +  corresponds to a domain from 0-255. If a bit is set, the corresponding domain
> +  can be modified by an AP command-request message sent to a usage domain
> +  configured for the KVM guest.
> +
> +If you recall from the description of an AP Queue, AP instructions include
> +an APQN to identify the AP adapter and AP queue to which an AP command-request
> +message is to be sent (NQAP and PQAP instructions), or from which a
> +command-reply message is to be received (DQAP instruction). The validity of an
> +APQN is defined by the matrix calculated from the APM and AQM; it is the
> +cross product of all assigned adapter numbers (APM) with all assigned queue
> +indexes (AQM). For example, if adapters 1 and 2 and usage domains 5 and 6 are
> +assigned to a guest, the APQNs (1,5), (1,6), (2,5) and (2,6) will be valid for
> +the guest.
> +
> +The APQNs can provide secure key functionality - i.e., a private key is stored
> +on the adapter card for each of its domains - so each APQN must be assigned to
> +at most one guest or the linux host.
> +
> +   Example 1: Valid configuration:
> +   ------------------------------
> +   Guest1: adapters 1,2  domains 5,6
> +   Guest2: adapter  1,2  domain 7
> +
> +   This is valid because both guests have a unique set of APQNs: Guest1 has
> +   APQNs (1,5), (1,6), (2,5) and (2,6); Guest2 has APQNs (1,7) and (2,7).
> +
> +   Example 2: Invalid configuration:
> +   --------------------------------is assigned by writing the adapter's number into the
> +   Guest1: adapters 1,2  domains 5,6
> +   Guest2: adapter  1    domains 6,7
> +
> +   This is an invalid configuration because both guests have access to
> +   APQN (1,6).
> +
> +The Design:
> +===========
> +The design introduces three new objects:
> +
> +1. AP matrix device
> +2. VFIO AP device driver (vfio_ap.ko)
> +3. AP mediated matrix passthrough device
> +
> +The VFIO AP device driver
> +-------------------------
> +The VFIO AP (vfio_ap) device driver serves the following purposes:
> +
> +1. Provides the interfaces to reserve APQNs for exclusive use of KVM guests.
> +
> +2. Sets up the VFIO mediated device interfaces to manage the mediated matrix
> +   device and create the sysfs interfaces for assigning adapters, usage domains,
> +   and control domains comprising the matrix for a KVM guest.
> +
> +3. Configure the APM, AQM and ADM in the CRYCB referenced by a KVM guest's
> +   SIE state description to grant the guest access to AP devices
> +
> +4. Initialize the CPU model feature indicating that a KVM guest may use
> +   AP facilities installed on the linux host.
> +
> +5. Enable interpretive execution mode for the KVM guest.
> +
> +Reserve APQNs for exclusive use of KVM guests
> +---------------------------------------------
> +The following block diagram illustrates the mechanism by which APQNs are
> +reserved:
> +
> +                              +------------------+
> +                 remove       |                  |   unbind
> +         +------------------->+ cex4queue driver +<-----------+
> +         |                    |                  |            |
> +         |                    +------------------+            |
> +         |                                                    |
> +         |                                                    |
> +         |                                                    |
> ++--------+---------+ register +------------------+      +-----+------+
> +|                  +<---------+                  | bind |            |
> +|      ap_bus      |          |  vfio_ap driver  +<-----+    admin   |
> +|                  +--------->+                  |      |            |
> ++------------------+  probe   +---+--------+-----+      +------------+
> +                                  |        |
> +                           create |        | store APQN
> +                                  |        |
> +                                  v        v
> +                              +---+--------+-----+
> +                              |                  |
> +                              |  matrix device   |
> +                              |                  |
> +                              +------------------+
> +
> +The process for reserving an AP queue for use by a KVM guest is:
> +
> +* The vfio-ap driver during its initialization will perform the following:
> +  * Create the 'vfio_ap' root device - /sys/devices/vfio_ap
> +  * Create the 'matrix' device in the 'vfio_ap' root
> +  * Register the matrix device with the device core
> +* Register with the ap_bus for AP queue devices of type CEX4, CEX5 and
> +  CEX6 and to provide the vfio_ap driver's probe and remove callback interfaces.

I wonder why the type of card has anything to do with this driver.
It should be transparent, the driver should be able to provide the 
matrix (APM/AQM/ADM)
independently from the type of card in the slot.

Regards,

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
