Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbfKDIUy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 03:20:54 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA48KowW083962
        for <linux-s390@vger.kernel.org>; Mon, 4 Nov 2019 03:20:53 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w2egcbmem-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2019 03:20:52 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 4 Nov 2019 08:19:00 -0000
Subject: Re: [RFC 04/37] KVM: s390: protvirt: Add initial lifecycle handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-5-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 4 Nov 2019 09:18:56 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d87e2322-2dc6-0633-b64b-e3286186ea4c@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com



On 24.10.19 13:40, Janosch Frank wrote:
> Let's add a KVM interface to create and destroy protected VMs.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  24 +++-
>  arch/s390/include/asm/uv.h       | 110 ++++++++++++++
>  arch/s390/kvm/Makefile           |   2 +-
>  arch/s390/kvm/kvm-s390.c         | 173 +++++++++++++++++++++-
>  arch/s390/kvm/kvm-s390.h         |  47 ++++++
>  arch/s390/kvm/pv.c               | 237 +++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h         |  33 +++++
>  7 files changed, 622 insertions(+), 4 deletions(-)
>  create mode 100644 arch/s390/kvm/pv.c
[...]

> +	case KVM_PV_VM_UNPACK: {
> +		struct kvm_s390_pv_unp unp = {};
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&unp, argp, sizeof(unp)))
> +			break;
> +
> +		r = kvm_s390_pv_unpack(kvm, unp.addr, unp.size, unp.tweak);
> +		break;
> +	}



[....]

> +int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
> +		       unsigned long tweak)
> +{
> +	int i, rc = 0;
> +	struct uv_cb_unp uvcb = {
> +		.header.cmd = UVC_CMD_UNPACK_IMG,
> +		.header.len = sizeof(uvcb),
> +		.guest_handle = kvm_s390_pv_handle(kvm),
> +		.tweak[0] = tweak
> +	};
> +
> +	if (addr & ~PAGE_MASK || size & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +
> +	VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %lx size %lx",
> +		 addr, size);

Does it make sense to check for addr and addr+size to be within the memory
size of the guest? The uv_call or gmap_fault will fail later on, but we 
could do an early exit if the the site is wrong. 




> +	for (i = 0; i < size / PAGE_SIZE; i++) {
> +		uvcb.gaddr = addr + i * PAGE_SIZE;
> +		uvcb.tweak[1] = i * PAGE_SIZE;


> +retry:

> +		rc = uv_call(0, (u64)&uvcb);
> +		if (!rc)
> +			continue;
> +		/* If not yet mapped fault and retry */
> +		if (uvcb.header.rc == 0x10a) {
> +			rc = gmap_fault(kvm->arch.gmap, uvcb.gaddr,
> +					FAULT_FLAG_WRITE);
> +			if (rc)
> +				return rc;
> +			goto retry;
> +		}
> +		VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx rc %x rrc %x",
> +			 uvcb.gaddr, uvcb.header.rc, uvcb.header.rrc);
> +		break;
> +	}
[...]
