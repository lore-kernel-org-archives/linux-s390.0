Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36348 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726323AbgBRJyl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 Feb 2020 04:54:41 -0500
Subject: Re: [PATCH v2 35/42] KVM: s390: protvirt: Add UV cpu reset calls
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-36-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0b0b89f4-4c2d-9461-80c8-b38285e86360@redhat.com>
Date: Tue, 18 Feb 2020 10:54:30 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-36-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> For protected VMs, the VCPU resets are done by the Ultravisor, as KVM
> has no access to the VCPU registers.
> 
> Note that the ultravisor will only accept a call for the exact reset
> that has been requested.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/uv.h |  6 ++++++
>  arch/s390/kvm/kvm-s390.c   | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index d59825d95b9d..d4fb54231932 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -36,7 +36,10 @@
>  #define UVC_CMD_SET_SEC_CONF_PARAMS	0x0300
>  #define UVC_CMD_UNPACK_IMG		0x0301
>  #define UVC_CMD_VERIFY_IMG		0x0302
> +#define UVC_CMD_CPU_RESET		0x0310
> +#define UVC_CMD_CPU_RESET_INITIAL	0x0311
>  #define UVC_CMD_PREPARE_RESET		0x0320
> +#define UVC_CMD_CPU_RESET_CLEAR		0x0321
>  #define UVC_CMD_CPU_SET_STATE		0x0330
>  #define UVC_CMD_SET_UNSHARE_ALL		0x0340
>  #define UVC_CMD_PIN_PAGE_SHARED		0x0341
> @@ -59,8 +62,11 @@ enum uv_cmds_inst {
>  	BIT_UVC_CMD_SET_SEC_PARMS = 11,
>  	BIT_UVC_CMD_UNPACK_IMG = 13,
>  	BIT_UVC_CMD_VERIFY_IMG = 14,
> +	BIT_UVC_CMD_CPU_RESET = 15,
> +	BIT_UVC_CMD_CPU_RESET_INITIAL = 16,
>  	BIT_UVC_CMD_CPU_SET_STATE = 17,
>  	BIT_UVC_CMD_PREPARE_RESET = 18,
> +	BIT_UVC_CMD_CPU_PERFORM_CLEAR_RESET = 19,
>  	BIT_UVC_CMD_UNSHARE_ALL = 20,
>  	BIT_UVC_CMD_PIN_PAGE_SHARED = 21,
>  	BIT_UVC_CMD_UNPIN_PAGE_SHARED = 22,
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 16af4d1a2c29..932f7f32e82f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4695,6 +4695,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	void __user *argp = (void __user *)arg;
>  	int idx;
>  	long r;
> +	u16 rc, rrc;
>  
>  	vcpu_load(vcpu);
>  
> @@ -4716,14 +4717,33 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	case KVM_S390_CLEAR_RESET:
>  		r = 0;
>  		kvm_arch_vcpu_ioctl_clear_reset(vcpu);
> +		if (kvm_s390_pv_handle_cpu(vcpu)) {

_protected checks please. (if not already converted in your tree :) )


-- 
Thanks,

David / dhildenb
