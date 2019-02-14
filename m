From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v3 0/9] [RFC] vfio: ap: ioctl definitions for AP Queue
 Interrupt Control
Date: Thu, 14 Feb 2019 15:33:55 -0500
Message-ID: <e3d4788e-eb01-6337-4267-432af53762e0@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/14/19 8:51 AM, Pierre Morel wrote:

The subject leads one to believe this patch series introduces
ioctl definitions for AQIC, but there is not a single ioctl
definition in the series. Something like this might be more
appropriate:

vfio: ap: support for AP Queue Interrupt Control

Regards
T. Krow

> This patch implement PQAP/AQIC interception in KVM.
> 
> To implement this we need to add a new structure, vfio_ap_queue,to be
> able to retrieve the mediated device associated with a queue and specific
> values needed to register/unregister the interrupt structures:
>   - APQN: to be able to issue the commands and search for queue structures
>   - NIB : to unpin the NIB on clear IRQ
>   - ISC : to unregister with the GIB interface
>   - MATRIX: a pointer to the matrix mediated device
>   - DEV: a pointer to the AP queue device from AP bus.
> 
> 
> 1) Phase 1, probe and remove from vfio_ap_queue
> 
> The vfio_ap_queue structures are dynamically allocated when a queue
> is probed by the ap_vfio_driver.
> It is linked to the ap_queue device as the driver data.
> We store the APQN of the ap_queue device inside the vfio_ap_queue.
> The vfio_ap_queue are free during remove.
> 
> 
> 2) Phase 2, assignment of vfio_ap_queue to a mediated device
> 
> When the VFIO device is opened the queues are associated to
> the mediated device, at the same time the CRYCB is setup.
> 
> When the device is closed or if a queue is removed the queue is
> dissociated from the mediated device, as the same time the
> CRYCB is cleared.
> 
> Two new functions are used for this: associate/disassociate.
> 
> 
> 3) Phase 3 intercepting the PQAP/AQIC instruction
> 
> On interception of the PQAP/AQIC instruction, the interception code
> makes sure the pqap_hook is initialized and allowed to be called
> and call it.
> Otherwise it reports the usual -EOPNOTSUPP return code to let
> QEMU handle the fault.
>    
> the pqap callback search for the queue asociated with the APQN
> stored in the register 0, setting the code to "illegal APQN"
> if the vfio_ap_queue can not be found.
> 
> Depending on the "i" bit of the register 1, the pqap callback
> setup or clear the interruption by calling the host format PQAP/AQIC
> instruction.
> When seting up the interruption it uses the NIB and the guest ISC
> provided by the guest and the host ISC provided by the registration
> to the GIB code, pin the NIB and also stores ISC and NIB inside
> the vfio_ap_queue structure.
> When clearing the interrupt it retrieves the host ISC to unregister
> with the GIB code and unpin the NIB.
> 
> There is a QEMU patch which is needed to enable the PQAP/AQIC
> facility in the guest.
> 
> Posted in qemu-devel@nongnu.org as:
> Message-Id: <1550146494-21085-1-git-send-email-pmorel@linux.ibm.com>
> 
> 
> 4) Phase 4 clean dissociation from the mediated device on remove
> 
> On removing of the AP device the remove callback is called.
> To be sure that the guest will not access the queue anymore
> we clear the APID CRYCB bit.
> Cleaning the APID, over the APQI, is chosen because the architecture
> specifies that only the APID can be dynamically changed outside IPL.
> After this the queue is zeroes, care is taken to correctly wait until
> the queue is empty.
> 
> 
> 
> Pierre Morel (9):
>    s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem
>    s390: ap: kvm: setting a hook for PQAP instructions
>    s390: ap: new vfio_ap_queue structure
>    s390: ap: tools to find a queue with a specific APQN
>    s390: ap: tools to associate a queue to a matrix
>    vfio: ap: register IOMMU VFIO notifier
>    s390: ap: implement PAPQ AQIC interception in kernel
>    s390: ap: Cleanup on removing the AP device
>    s390: ap: kvm: add AP Queue Interruption Control facility
> 
>   arch/s390/include/asm/kvm_host.h      |   1 +
>   arch/s390/kvm/priv.c                  |  50 +++++
>   arch/s390/tools/gen_facilities.c      |   1 +
>   drivers/s390/crypto/ap_bus.h          |   1 +
>   drivers/s390/crypto/vfio_ap_drv.c     | 178 ++++++++++++++++-
>   drivers/s390/crypto/vfio_ap_ops.c     | 363 +++++++++++++++++++++++++++++++++-
>   drivers/s390/crypto/vfio_ap_private.h |  12 ++
>   7 files changed, 593 insertions(+), 13 deletions(-)
> 
