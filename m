Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52081 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730622AbgBYRTv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 12:19:51 -0500
Date: Tue, 25 Feb 2020 18:19:36 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 18/36] KVM: S390: protvirt: Introduce instruction
 data area bounce buffer
Message-ID: <20200225181936.7f975394.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-19-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-19-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 24 Feb 2020 06:40:49 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.ibm.com>
> 
> Now that we can't access guest memory anymore, we have a dedicated
> satellite block that's a bounce buffer for instruction data.
> 
> We re-use the memop interface to copy the instruction data to / from
> userspace. This lets us re-use a lot of QEMU code which used that
> interface to make logical guest memory accesses which are not possible
> anymore in protected mode anyway.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 11 +++++-
>  arch/s390/kvm/kvm-s390.c         | 65 ++++++++++++++++++++++++++++----
>  arch/s390/kvm/pv.c               | 11 ++++++
>  include/uapi/linux/kvm.h         |  9 ++++-
>  4 files changed, 85 insertions(+), 11 deletions(-)
> 

(...)

> @@ -4512,8 +4540,8 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
>  		if (!tmpbuf)
>  			return -ENOMEM;
>  	}
> -
> -	srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
> +	if (kvm_s390_pv_cpu_is_protected(vcpu))
> +		return -EINVAL;

Doesn't that leak tmpbuf (allocated right above)? Maybe just move that
check up?

>  
>  	switch (mop->op) {
>  	case KVM_S390_MEMOP_LOGICAL_READ:

(...)
