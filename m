Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50460 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726267AbgBQLAB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Feb 2020 06:00:01 -0500
Subject: Re: [PATCH v2 15/42] KVM: s390: protvirt: Add interruption injection
 controls
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-16-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f5122739-bf1d-3e10-3953-c2b3487cc91a@redhat.com>
Date: Mon, 17 Feb 2020 11:59:46 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-16-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
> From: Michael Mueller <mimu@linux.ibm.com>
> 
> This defines the necessary data structures in the SIE control block to
> inject machine checks,external and I/O interrupts. We first define the
> the interrupt injection control, which defines the next interrupt to
> inject. Then we define the fields that contain the payload for machine
> checks,external and I/O interrupts
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 56 +++++++++++++++++++++++++-------
>  1 file changed, 44 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index c6694f47b73b..834b3b7a6e23 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -222,7 +222,15 @@ struct kvm_s390_sie_block {
>  	__u8	icptcode;		/* 0x0050 */
>  	__u8	icptstatus;		/* 0x0051 */
>  	__u16	ihcpu;			/* 0x0052 */
> -	__u8	reserved54[2];		/* 0x0054 */
> +	__u8	reserved54;		/* 0x0054 */
> +#define IICTL_CODE_NONE		 0x00
> +#define IICTL_CODE_MCHK		 0x01
> +#define IICTL_CODE_EXT		 0x02
> +#define IICTL_CODE_IO		 0x03
> +#define IICTL_CODE_RESTART	 0x04
> +#define IICTL_CODE_SPECIFICATION 0x10
> +#define IICTL_CODE_OPERAND	 0x11
> +	__u8	iictl;			/* 0x0055 */
>  	__u16	ipa;			/* 0x0056 */
>  	__u32	ipb;			/* 0x0058 */
>  	__u32	scaoh;			/* 0x005c */
> @@ -259,24 +267,48 @@ struct kvm_s390_sie_block {
>  #define HPID_KVM	0x4
>  #define HPID_VSIE	0x5
>  	__u8	hpid;			/* 0x00b8 */
> -	__u8	reservedb9[11];		/* 0x00b9 */
> -	__u16	extcpuaddr;		/* 0x00c4 */
> -	__u16	eic;			/* 0x00c6 */
> +	__u8	reservedb9[7];		/* 0x00b9 */
> +	union {
> +		struct {
> +			__u32	eiparams;	/* 0x00c0 */
> +			__u16	extcpuaddr;	/* 0x00c4 */
> +			__u16	eic;		/* 0x00c6 */
> +		};
> +		__u64	mcic;			/* 0x00c0 */
> +	} __packed;
>  	__u32	reservedc8;		/* 0x00c8 */
> -	__u16	pgmilc;			/* 0x00cc */
> -	__u16	iprcc;			/* 0x00ce */
> -	__u32	dxc;			/* 0x00d0 */
> -	__u16	mcn;			/* 0x00d4 */
> -	__u8	perc;			/* 0x00d6 */
> -	__u8	peratmid;		/* 0x00d7 */
> +	union {
> +		struct {
> +			__u16	pgmilc;		/* 0x00cc */
> +			__u16	iprcc;		/* 0x00ce */
> +		};
> +		__u32	edc;			/* 0x00cc */
> +	} __packed;
> +	union {
> +		struct {
> +			__u32	dxc;		/* 0x00d0 */
> +			__u16	mcn;		/* 0x00d4 */
> +			__u8	perc;		/* 0x00d6 */
> +			__u8	peratmid;	/* 0x00d7 */
> +		};
> +		__u64	faddr;			/* 0x00d0 */
> +	} __packed;
>  	__u64	peraddr;		/* 0x00d8 */
>  	__u8	eai;			/* 0x00e0 */
>  	__u8	peraid;			/* 0x00e1 */
>  	__u8	oai;			/* 0x00e2 */
>  	__u8	armid;			/* 0x00e3 */
>  	__u8	reservede4[4];		/* 0x00e4 */
> -	__u64	tecmc;			/* 0x00e8 */
> -	__u8	reservedf0[12];		/* 0x00f0 */
> +	union {
> +		__u64	tecmc;		/* 0x00e8 */
> +		struct {
> +			__u16	subchannel_id;	/* 0x00e8 */
> +			__u16	subchannel_nr;	/* 0x00ea */
> +			__u32	io_int_parm;	/* 0x00ec */
> +			__u32	io_int_word;	/* 0x00f0 */
> +		};
> +	} __packed;
> +	__u8	reservedf4[8];		/* 0x00f4 */
>  #define CRYCB_FORMAT_MASK 0x00000003
>  #define CRYCB_FORMAT0 0x00000000
>  #define CRYCB_FORMAT1 0x00000001
> 

I'd just squash that into the patch where it is actually used. (IOW, the
next one)

-- 
Thanks,

David / dhildenb
