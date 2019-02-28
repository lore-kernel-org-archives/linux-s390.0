From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v4 0/7] vfio: ap: AP Queue Interrupt Control
Date: Thu, 28 Feb 2019 16:08:05 +0100
Message-ID: <20190228160805.3fcc126b@oc2783563651>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 22 Feb 2019 16:29:53 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> This patch implement PQAP/AQIC interception in KVM.
> 
> To implement this we need to add a new structure, vfio_ap_queue,to be
> able to retrieve the mediated device associated with a queue and specific
> values needed to register/unregister the interrupt structures:
>  - APQN: to be able to issue the commands and search for queue structures
>  - NIB : to unpin the NIB on clear IRQ
>  - ISC : to unregister with the GIB interface
>  - MATRIX: a pointer to the matrix mediated device
>  - LIST: the list_head to handle the vfio_queue life cycle
> 
> Having this structure and the list management greatly ease the handling
> of the AP queues and diminues the LOCs needed in the vfio_ap driver by
> more than 150 lines in comparison with the previous version.
> 
> 
> 0) Queues life cycle
> 
> vfio_ap_queues are created on probe
> 
> We define one bucket on the matrix device to store the free vfio_ap_queues,
> the queues not assign to any matrix mediated device.
> 
> We define one bucket on each matrix mediated device to hold the
> vfio_ap_queues belonging to it.
> 
> vfio_ap_queues are deleted on remove
> 
> This makes the search for a queue easy and the detection of assignent
> incoherency obvious (the queue is not avilable) and simplifies assignment.
> 
> 
> 1) Phase 1, probe and remove from vfio_ap_queue
> 
> The vfio_ap_queue structures are dynamically allocated and setup
> when a queue is probed by the ap_vfio_driver.
> The vfio_ap_queue is linked to the ap_queue device as the driver data.
> 
> The new The vfio_ap_queue is put on a free_list belonging to the
> matrix device.
> 
> The vfio_ap_queue are free during remove.
> 
> 
> 2) Phase 2, assignment of vfio_ap_queue to a mediated device
> 
> When a APID is assigned we look for APQI already assigned to
> the matrix mediated device and associate all the queue with the
> APQN = (APID,APQI) to the mediated device by adding them to
> the mediated device queue list.
> We do the same when a APQI is assigned.
> 
> If any queue with a matching APQN can not be found on the matrix
> device free list it means it is already associated to another matrix
> mediated device and no queue is added to the matrix mediated device.
> 
> 3) Phase 3, starting the guest
> 
> When the VFIO device is opened the PQAP callback and a pointer to
> the matrix mediated device are set inside KVM during the open callback.
> 
> When the device is closed or if a queue is removed, the vfio_ap_queue is
> dissociated from the mediated device.
> 
> 
> 4) Phase 3 intercepting the PQAP/AQIC instruction
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
> We take care when enabling GISA that the guest may have issued a
> reset and will not need to disable the interuptions before
> re-enabling interruptions.

Please let us know what guarantees, that we will disable the
interruptions we previously enabled using AQIC (and generally facilitate
proper cleanup) *before* kvm_s390_gisa_destroy() makes the gisa and
with that the IPM go away!

Please note that IMHO this needs to be guaranteed by the kernel
regardless of what userspace (QEMU) or the guest does.

(I've asked this question before during our internal review but I could
not find the answer if there was one after going trough my mails.)

Regards,
Halil
