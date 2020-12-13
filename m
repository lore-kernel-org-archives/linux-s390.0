Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727958AbgLMW6G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 13 Dec 2020 17:58:06 -0500
Date: Sun, 13 Dec 2020 23:57:14 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390/vfio-ap: Clean up vfio_ap resources when KVM
 pointer invalidated
Message-ID: <20201213235714.3e21cdab.pasic@linux.ibm.com>
In-Reply-To: <e196b743-74d8-398b-4b3e-4a64002d9bfc@linux.ibm.com>
References: <20201202234101.32169-1-akrowiak@linux.ibm.com>
        <20201203185514.54060568.pasic@linux.ibm.com>
        <a8a90aed-97df-6f10-85c2-8e18dba8f085@linux.ibm.com>
        <20201204200502.1c34ae58.pasic@linux.ibm.com>
        <683dd341-f047-0447-1ee8-c126c305b6c2@linux.ibm.com>
        <20201208010125.209883f5.pasic@linux.ibm.com>
        <e196b743-74d8-398b-4b3e-4a64002d9bfc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com, Janosch Frank <frankja@linux.ibm.com>

On Fri, 11 Dec 2020 15:52:55 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> 
> 
> On 12/7/20 7:01 PM, Halil Pasic wrote:
> > On Mon, 7 Dec 2020 13:50:36 -0500
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >
> >> On 12/4/20 2:05 PM, Halil Pasic wrote:
> >>> On Fri, 4 Dec 2020 09:43:59 -0500
> >>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>>   
> >>>>>> +{
> >>>>>> +	if (matrix_mdev->kvm) {
> >>>>>> +		(matrix_mdev->kvm);
> >>>>>> +		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> >>>>> Is a plain assignment to arch.crypto.pqap_hook apropriate, or do we need
> >>>>> to take more care?
> >>>>>
> >>>>> For instance kvm_arch_crypto_set_masks() takes kvm->lock before poking
> >>>>> kvm->arch.crypto.crycb.
> >>>> I do not think so. The CRYCB is used by KVM to provide crypto resources
> >>>> to the guest so it makes sense to protect it from changes to it while
> >>>> passing
> >>>> the AP devices through to the guest. The hook is used only when an AQIC
> >>>> executed on the guest is intercepted by KVM. If the notifier
> >>>> is being invoked to notify vfio_ap that KVM has been set to NULL, this means
> >>>> the guest is gone in which case there will be no AP instructions to
> >>>> intercept.
> >>> If the update to pqap_hook isn't observed as atomic we still have a
> >>> problem. With torn writes or reads we would try to use a corrupt function
> >>> pointer. While the compiler probably ain't likely to generate silly code
> >>> for the above assignment (multiple write instructions less then
> >>> quadword wide), I know of nothing that would prohibit the compiler to do
> >>> so.
> >> I'm sorry, but I still don't understand why you tkvm_vfio_group_set_kvmhink this is a problem
> >> given what I stated above.
> > I assume you are specifically referring to 'the guest is gone in which
> > case there will be no AP instructions to intercept'.  I assume by 'guest
> > is gone' you mean that the VM is being destroyed, and the vcpus are out
> > of SIE. You are probably right for the invocation of
> > kvm_vfio_group_set_kvm() in kvm_vfio_destroy(), but is that true for
> > the invocation in the KVM_DEV_VFIO_GROUP_DEL case in
> > kvm_vfio_set_group()? I.e. can't we get the notifier called when the
> > qemu device is hot unplugged (modulo remove which unregisters the
> > notifier and usually precludes the notifier being with NULL called at
> > all)?
> 
> I am assuming by your question that the qemu device you are
> talking about the '-device vfio-ap' specified on the qemu command
> line or attached vi||||||a qemu device_add. 

Yes.

> When an mdev is hot 
> unplugged, the
> vfio_ap driver's release callback gets invoked when the mdev fd is 
> closed. The
> release callback unregisters the notifier, so it does not get called
> when the guest subsequently shuts down.
> 

That is what I meant by 'modulo remove which unregisters the notifier
and usually precludes the notifier being with NULL called at all', but
unfortunately I mixed up remove and release.

AFAIU release should be called before the notifier gets invoked
regardless of whether we have a hot-unplug of '-device vfio-ap' or
a shutdown. The whole effort is about what happens if userspace does
not adhered to this. If I apply the logic of your last response to the
whole situation, then there is nothing to do (AFAIU).

The point I'm trying to make is, that in a case of the hot-unplug, the
guest may survive the call to the notifier and also the vfio_mdev device
it was associated to at some point. So your argument that 'the guest is
gone in which case there will be no AP instructions to interpret' does
not hold.

Regards,
Halil
