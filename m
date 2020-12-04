Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38626 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbgLDTI1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Dec 2020 14:08:27 -0500
Date: Fri, 4 Dec 2020 20:05:02 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390/vfio-ap: Clean up vfio_ap resources when KVM
 pointer invalidated
Message-ID: <20201204200502.1c34ae58.pasic@linux.ibm.com>
In-Reply-To: <a8a90aed-97df-6f10-85c2-8e18dba8f085@linux.ibm.com>
References: <20201202234101.32169-1-akrowiak@linux.ibm.com>
        <20201203185514.54060568.pasic@linux.ibm.com>
        <a8a90aed-97df-6f10-85c2-8e18dba8f085@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com, Janosch Frank <frankja@linux.ibm.com>

On Fri, 4 Dec 2020 09:43:59 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> >> +{
> >> +	if (matrix_mdev->kvm) {
> >> +		(matrix_mdev->kvm);
> >> +		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;  
> > Is a plain assignment to arch.crypto.pqap_hook apropriate, or do we need
> > to take more care?
> >
> > For instance kvm_arch_crypto_set_masks() takes kvm->lock before poking
> > kvm->arch.crypto.crycb.  
> 
> I do not think so. The CRYCB is used by KVM to provide crypto resources
> to the guest so it makes sense to protect it from changes to it while 
> passing
> the AP devices through to the guest. The hook is used only when an AQIC
> executed on the guest is intercepted by KVM. If the notifier
> is being invoked to notify vfio_ap that KVM has been set to NULL, this means
> the guest is gone in which case there will be no AP instructions to 
> intercept.

If the update to pqap_hook isn't observed as atomic we still have a
problem. With torn writes or reads we would try to use a corrupt function
pointer. While the compiler probably ain't likely to generate silly code
for the above assignment (multiple write instructions less then
quadword wide), I know of nothing that would prohibit the compiler to do
so.

I'm not certain about the scope of the kvm->lock (if it's supposed to
protect the whole sub-tree of objects). Maybe Janosch can help us out.
@Janosch: what do you think?

Regards,
Halil
