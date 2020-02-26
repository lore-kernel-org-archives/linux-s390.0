Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56305 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727314AbgBZQyn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Feb 2020 11:54:43 -0500
Date: Wed, 26 Feb 2020 17:54:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4.5 09/36] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
Message-ID: <20200226175428.40143164.cohuck@redhat.com>
In-Reply-To: <dcd80ccd-2d66-502f-62a1-3c794cfcde65@de.ibm.com>
References: <f80a0b58-5ed2-33b7-5292-2c4899d765b7@redhat.com>
        <20200225214822.3611-1-borntraeger@de.ibm.com>
        <20200226132640.36c32fd3.cohuck@redhat.com>
        <dcd80ccd-2d66-502f-62a1-3c794cfcde65@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: david@redhat.com, Ulrich.Weigand@de.ibm.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com

On Wed, 26 Feb 2020 14:31:36 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 26.02.20 13:26, Cornelia Huck wrote:
> > On Tue, 25 Feb 2020 16:48:22 -0500
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> From: Janosch Frank <frankja@linux.ibm.com>
> >>
> >> This contains 3 main changes:
> >> 1. changes in SIE control block handling for secure guests
> >> 2. helper functions for create/destroy/unpack secure guests
> >> 3. KVM_S390_PV_COMMAND ioctl to allow userspace dealing with secure
> >> machines
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  arch/s390/include/asm/kvm_host.h |  24 ++-
> >>  arch/s390/include/asm/uv.h       |  69 ++++++++
> >>  arch/s390/kvm/Makefile           |   2 +-
> >>  arch/s390/kvm/kvm-s390.c         | 209 +++++++++++++++++++++++-
> >>  arch/s390/kvm/kvm-s390.h         |  33 ++++
> >>  arch/s390/kvm/pv.c               | 269 +++++++++++++++++++++++++++++++
> >>  include/uapi/linux/kvm.h         |  31 ++++
> >>  7 files changed, 633 insertions(+), 4 deletions(-)
> >>  create mode 100644 arch/s390/kvm/pv.c  

> >> @@ -2262,6 +2419,27 @@ long kvm_arch_vm_ioctl(struct file *filp,
> >>  		mutex_unlock(&kvm->slots_lock);
> >>  		break;
> >>  	}
> >> +	case KVM_S390_PV_COMMAND: {
> >> +		struct kvm_pv_cmd args;
> >> +
> >> +		r = 0;
> >> +		if (!is_prot_virt_host()) {
> >> +			r = -EINVAL;
> >> +			break;
> >> +		}
> >> +		if (copy_from_user(&args, argp, sizeof(args))) {
> >> +			r = -EFAULT;
> >> +			break;
> >> +		}  
> > 
> > The api states that args.flags must be 0... better enforce that?  
> 
> 
> yes
> @@ -2431,6 +2431,10 @@ long kvm_arch_vm_ioctl(struct file *filp,
>                         r = -EFAULT;
>                         break;
>                 }
> +               if (args.flags) {
> +                       r = -EINVAL;
> +                       break;
> +               }
>                 mutex_lock(&kvm->lock);
>                 r = kvm_s390_handle_pv(kvm, &args);
>                 mutex_unlock(&kvm->lock);

Looks good.
