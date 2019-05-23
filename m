Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v9 0/4] vfio: ap: AP Queue Interrupt Control
References: <1558452877-27822-1-git-send-email-pmorel@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 23 May 2019 11:36:12 -0400
MIME-Version: 1.0
In-Reply-To: <1558452877-27822-1-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5b46f988-fa79-4d84-c81f-144daa0c4426@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com

On 5/21/19 11:34 AM, Pierre Morel wrote:
> This patch series implements PQAP/AQIC interception in KVM.
> 
> 1) Data to handle GISA interrupt for AQIC
> 
> To implement this we need to add a new structure, vfio_ap_queue,
> to be able to retrieve the mediated device associated with a queue
> and specific values needed to register/unregister the interrupt
> structures:
>    - APQN: to be able to issue the commands and search for queue
>      structures
>    - saved NIB : to keep track of the pin page for unpining it
>    - saved ISC : to unregister with the GIB interface
>    - matrix_mdev: to retrieve the associate matrix, the mediated device
>      and KVM
> 
> Specific handling bei keeping old values when re-registering is
> needed because the guest could unregister interrupt in a invisble
> manner bei issuing an un-interceptible RESET command.
> 
> Reset commands issued directly by the guest and indirectly when
> removing the guest unpin the memory and deregister the ISC.
> 
> The vfio_ap_queue is associated to the ap_device during the probe
> of the device and dissociated during the remove of the ap_device.
> 
> The vfio_ap_queue is associated to the matrix mediated device during
> each interception of the AQIC command, so it does not need to be
> dissociated until the guest is terminated.
> 
> The life of the vfio_ap_queue will be protected by the matrix_dev lock
> to guaranty that no change can occur to the CRYCB or that devices can
> not be removed when a vfio_ap_queue is in use.
> 
> 2) KVM destroy race conditions
> 
> To make sure that KVM do not vanish and GISA is still available
> when the VFIO_AP driver is in used we take a reference to KVM
> during the opening of the mediated device and release it on
> releasing the mediated device.
> 
> 3) Interception of PQAP
> 
> The driver registers a hook structure to KVM providing:
> - a pointer to a function implementing PQAP(AQIC) handling
> - the reference to the module owner of the hook
> 
> On interception by KVM we do not change the behavior, returning
>   -EOPNOTSUPP to the user in the case AP instructions are not
> supported by the host or by the guest.
> Otherwise we verify the exceptions cases before trying to call
> the vfio_ap hook.
> 
> In the case we do not find a hook we assume that the CRYCB has not
> been setup for the guest and is empty.
> 
> 4) Enabling and disabling the IRQ
> 
> When enabling the IRQ care is taken to unping the saved NIB.
> When disabling IRQ care is taken to wait until the IRQ bit
> of the queue status is cleared before unpining the NIB.
> 
> On RESET and before unpinning the NIB and unregistering the ISC
> the IRQ is disabled using PQAP/AQIC even when a PQAP/APZQ have
> been done.
> 
> 5) Removing the AP device
> 
> Removing the AP device without having unassign it is clearly
> discourage by the documentation.
> The patch series does not check if the queue is used by a
> guest. It only de-register the IRQ, unregister ISC and unpin
> the NIB, then free the vfio_ap_queue.
> 
> 6) Associated QEMU patch
> 
> There is a QEMU patch which is needed to enable the PQAP/AQIC
> facility in the guest.
> 
> Posted in qemu-devel@nongnu.org as:
> Message-Id: <1550146494-21085-1-git-send-email-pmorel@linux.ibm.com>
> 
> 7) Compatibility with Dynamic configuration patches
> 
> Tony, I did not rebase this series above the dynamic configuration
> patches because:
> - This series do the work it needs to do without having to take
>    care on the dynamic configuration.
> - It is guarantied that interrupt will be shut off after removing
>    the APQueue device
> - The dynamic configuration series is not converging.

Would you consider the following?

* Take dynconfig patch "s390: vfio-ap: wait for queue empty on queue
   reset" and include it in your series. This patch modifies the
   reset function to wait for queue empty.

* In dynconfig patch "s390: vfio-ap: handle bind and unbind of AP queue
   device" the following functions are introduced:

      void vfio_ap_mdev_probe_queue(struct ap_queue *queue)
      void vfio_ap_mdev_remove_queue(struct ap_queue *queue)

   The vfio_ap_mdev_probe_queue function is called from the vfio_ap
   driver probe callback. You could embed the code you've introduced in
   the probe callback there. Of course, you would need to return int
   from the function for the -ENOMEM error.

   The vfio_ap_mdev_remove_queue function is called from the vfio_ap
   driver remove callback. You could embed the code you've introduced in
   the remove callback there.

* Move your vfio_ap_irq_disable function to vfio_ap_ops.c and make it a
   static function.

* Leave the vfio_ap_mdev_reset_queue function as a static function in
   vfio_ap_ops.c

If you do the things above, then I can base the dynconfig series on
the IRQ series without much of a merge issue. What say you?

Note: I've included review comments for patch 3/4 to match the
       suggestions above.

> 
> However Tony, the choice is your's, I won't be able to help
> in a near future.
> 
> 
> Pierre Morel (4):
>    s390: ap: kvm: add PQAP interception for AQIC
>    vfio: ap: register IOMMU VFIO notifier
>    s390: ap: implement PAPQ AQIC interception in kernel
>    s390: ap: kvm: Enable PQAP/AQIC facility for the guest
> 
>   arch/s390/include/asm/kvm_host.h      |   7 +
>   arch/s390/kvm/priv.c                  |  86 ++++++++
>   arch/s390/tools/gen_facilities.c      |   1 +
>   drivers/s390/crypto/vfio_ap_drv.c     |  34 ++-
>   drivers/s390/crypto/vfio_ap_ops.c     | 379 +++++++++++++++++++++++++++++++++-
>   drivers/s390/crypto/vfio_ap_private.h |  15 ++
>   6 files changed, 514 insertions(+), 8 deletions(-)
> 
