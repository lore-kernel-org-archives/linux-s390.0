From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 15/15] s390: doc: detailed specifications for AP
 virtualization
Date: Tue, 27 Feb 2018 16:57:02 +0100
Message-ID: <20180227165702.67b171db.cohuck@redhat.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1519741693-17440-16-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519741693-17440-16-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 27 Feb 2018 09:28:13 -0500
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> This patch provides documentation describing the AP architecture and
> design concepts behind the virtualization of AP devices. It also
> includes an example of how to configure AP devices for exclusive
> use of KVM guests.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  Documentation/s390/vfio-ap.txt |  514 ++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                    |    1 +
>  2 files changed, 515 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/s390/vfio-ap.txt
> 
> diff --git a/Documentation/s390/vfio-ap.txt b/Documentation/s390/vfio-ap.txt
> new file mode 100644
> index 0000000..c599f30
> --- /dev/null
> +++ b/Documentation/s390/vfio-ap.txt
> @@ -0,0 +1,514 @@
> +Introduction:
> +============
> +The Adjunct Processor (AP) facility is an IBM Z cryptographic facility comprised
> +of three AP instructions and from 1 up to 256 PCIe cryptographic adapter cards.
> +The AP devices provide cryptographic functions to all CPUs assigned to a
> +linux system running in an IBM Z system LPAR.
> +
> +The AP adapter cards are exposed via the AP bus. The motivation for vfio-ap
> +is to make AP cards available to KVM guests using the VFIO mediated device
> +framework.

Maybe drop a sentence in here that this makes heavy usage of the s390
virtualization facilities, which do the heavy lifting?

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
> +* AP domain
> +
> +  An adapter is partitioned into domains. Each domain can be thought of as
> +  a set of hardware registers for processing AP instructions. An adapter can
> +  hold up to 256 domains. Each domain is identified by a number from 0 to 255.
> +  Domains can be further classified into two types:
> +
> +    * Usage domains are domains that can be accessed directly to process AP
> +      commands
> +
> +    * Control domains are domains that are accessed indirectly by AP
> +      commands sent to a usage domain to control or change the domain, for
> +      example; to set a secure private key for the domain.
> +
> +* AP Queue
> +
> +  An AP queue is the means by which an AP command-request message is sent to an
> +  AP usage domain inside a specific AP. An AP queue is identified by a tuple
> +  comprised of an AP adapter ID (APID) and an AP queue index (APQI). The
> +  APQI corresponds to a given usage domain number within the adapter. This tuple
> +  forms an AP Queue Number (APQN) uniquely identifying an AP queue. AP
> +  instructions include a field containing the APQN to identify the AP queue to
> +  which the AP command-request message is to be sent for processing.
> +
> +* AP Instructions:
> +
> +  There are three AP instructions:
> +
> +  * NQAP: to enqueue an AP command-request message to a queue
> +  * DQAP: to dequeue an AP command-reply message from a queue
> +  * PQAP: to administer the queues

Do you also want to explain how these entities show up on the ap bus in
Linux? It might make the explanations further down easier to
understand. (Is there any document for the ap bus you could point to?)

> +
> +Start Interpretive Execution (SIE) Instruction:
> +==============================================

Call this "AP and SIE" or so? You're not trying to explain the whole
SIE architecture :)


> +Let's now see how AP instructions are interpreted by the hardware.

(...)

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

Thank you for including diagrams, these are really helpful.

(...)

> +Initialize the CPU model feature for AP
> +---------------------------------------
> +This design exploits a feature of the SIE architecture called interpretive
> +execution (IE). When IE is enabled for a KVM guest, the AP instructions
> +executed in the guest will be interpreted by the firmware and the commands
> +contained therein will be passed directly through to an AP device assigned to
> +the linux host. In order to enable interpretive execution for a KVM guest, SIE
> +must have access to the AP facilities installed on the linux host. A new CPU
> +model feature is introduced by this design to indicate that the guest will
> +directly access the host AP facilities. This feature will be enabled by the
> +kernel only if the AP facilities are installed on the linux host. This feature
> +is turned on for the guest via the qemu command line:
> +
> +    /usr/bin/qemu-system-s390x ... -cpu xxx,ap=on
> +
> +    Where xxx is the CPU model being used.
> +
> +If the CPU model feature is not enabled by the kernel, QEMU
> +will fail and report that the feature is not supported.

The cpu model interface is supposed to be user space agnostic, although
it is only used by QEMU in practice. Mark this as an example more
clearly?

(...)

I have not looked at this in detail (will probably come back to this
later), but this looks like a useful document.
