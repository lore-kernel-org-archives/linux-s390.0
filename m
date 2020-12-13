Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbgLMXOA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 13 Dec 2020 18:14:00 -0500
Date: Mon, 14 Dec 2020 00:13:10 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390/vfio-ap: Clean up vfio_ap resources when KVM
 pointer invalidated
Message-ID: <20201214001310.2cb6f1ff.pasic@linux.ibm.com>
In-Reply-To: <ff21dd8e-9ac7-8625-5c77-4705e1344477@linux.ibm.com>
References: <20201202234101.32169-1-akrowiak@linux.ibm.com>
        <ab3f1948-bb23-c0d0-7205-f46cd6dbe99d@linux.ibm.com>
        <20201208014018.3f89527f.pasic@linux.ibm.com>
        <ff21dd8e-9ac7-8625-5c77-4705e1344477@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com

On Fri, 11 Dec 2020 16:08:53 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> >>> +static void vfio_ap_mdev_put_kvm(struct ap_matrix_mdev *matrix_mdev)
> >>> +{
> >>> +	if (matrix_mdev->kvm) {
> >>> +		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> >>> +		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> >>> +		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);  
> >> This reset probably does not belong here since there is no
> >> reason to reset the queues in the group notifier (see below).  
> > What about kvm_s390_gisc_unregister()? That needs a valid kvm
> > pointer, or? Or is it OK to not pair a kvm_s390_gisc_register()
> > with an kvm_s390_gisc_unregister()?  
> 
> I probably should have been more specific about what I meant.
> I was thinking that the reset should not be dependent upon
> whether there is a KVM pointer or not since this function is
> also called from the release callback. On the other hand,
> the vfio_ap_mdev_reset_queues function calls the
> vfio_ap_irq_disable (AQIC) function after each queue is reset.
> The vfio_ap_irq_disable function also cleans up the AQIC
> resources which requires that the KVM point is valid, so if
> the vfio_ap_reset_queues function is not called with a
> valid KVM pointer, that could result in an exception.
> 
> The thing is, it is unnecessary to disable interrupts after
> resetting a queue because the reset disables interrupts,
> so I think I should include a patch for this fix that does the
> following:
> 
> 1. Removes the disabling of interrupts subsequent to resetting
>      a queue.
> 2. Includes the cleanup of AQIC resources when a queue is
>      reset if a KVM pointer is present.

Sounds like a plan. I see, in your v2 vfio_ap_mdev_unset_kvm()
does call vfio_ap_mdev_reset_queues() even when called from the
group notifier. I also like that the cleanup of AQIC resources is
a part of queue_reset. In fact I asked a while ago (Message-ID:
<20201027074846.30ee0ddc.pasic@linux.ibm.com> in October) to make
vfio_ap_mdev_reset_queue() call vfio_ap_free_aqic_resources(q).

Regards,
Halil 
