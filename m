Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57017 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727317AbgBHOzF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Feb 2020 09:55:05 -0500
Subject: Re: [PATCH 08/35] KVM: s390: protvirt: Add initial lifecycle handling
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-9-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2e5203d7-e162-ddd6-9281-44aa34fe32e7@redhat.com>
Date: Sat, 8 Feb 2020 15:54:49 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-9-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 07/02/2020 12.39, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> This contains 3 main changes:
> 1. changes in SIE control block handling for secure guests
> 2. helper functions for create/destroy/unpack secure guests
> 3. KVM_S390_PV_COMMAND ioctl to allow userspace dealing with secure
> machines
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  24 ++-
>  arch/s390/include/asm/uv.h       |  69 +++++++++
>  arch/s390/kvm/Makefile           |   2 +-
>  arch/s390/kvm/kvm-s390.c         | 191 +++++++++++++++++++++++-
>  arch/s390/kvm/kvm-s390.h         |  27 ++++
>  arch/s390/kvm/pv.c               | 244 +++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h         |  33 +++++
>  7 files changed, 586 insertions(+), 4 deletions(-)
>  create mode 100644 arch/s390/kvm/pv.c
[...]
> +struct kvm_pv_cmd {
> +	__u32	cmd;	/* Command to be executed */
> +	__u16	rc;	/* Ultravisor return code */
> +	__u16	rrc;	/* Ultravisor return reason code */

What are rc and rrc good for? I currently can't spot the code where they
are used...

> +	__u64	data;	/* Data or address */
> +};
> +
> +/* Available with KVM_CAP_S390_PROTECTED */
> +#define KVM_S390_PV_COMMAND		_IOW(KVMIO, 0xc5, struct kvm_pv_cmd)
> +#define KVM_S390_PV_COMMAND_VCPU	_IOW(KVMIO, 0xc6, struct kvm_pv_cmd)

If you intend to return values in rc and rrc, shouldn't this rather be
declared as _IOWR instead ?

 Thomas
