Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728617AbfKAKIF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Nov 2019 06:08:05 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA1A7UXt154118
        for <linux-s390@vger.kernel.org>; Fri, 1 Nov 2019 06:08:03 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w0hc1ttew-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 01 Nov 2019 06:08:02 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 1 Nov 2019 10:08:01 -0000
Subject: Re: [RFC 03/37] s390/protvirt: add ultravisor initialization
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-4-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 1 Nov 2019 11:07:55 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f00cf177-246d-8da8-ddfd-a0b1bea930d6@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com



On 24.10.19 13:40, Janosch Frank wrote:
> From: Vasily Gorbik <gor@linux.ibm.com>
> 
> Before being able to host protected virtual machines, donate some of
> the memory to the ultravisor. Besides that the ultravisor might impose
> addressing limitations for memory used to back protected VM storage. Treat
> that limit as protected virtualization host's virtual memory limit.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  arch/s390/include/asm/uv.h | 16 ++++++++++++
>  arch/s390/kernel/setup.c   |  3 +++
>  arch/s390/kernel/uv.c      | 53 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 6db1bc495e67..82a46fb913e7 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -23,12 +23,14 @@
>  #define UVC_RC_NO_RESUME	0x0007
>  
>  #define UVC_CMD_QUI			0x0001
> +#define UVC_CMD_INIT_UV			0x000f
>  #define UVC_CMD_SET_SHARED_ACCESS	0x1000
>  #define UVC_CMD_REMOVE_SHARED_ACCESS	0x1001
>  
>  /* Bits in installed uv calls */
>  enum uv_cmds_inst {
>  	BIT_UVC_CMD_QUI = 0,
> +	BIT_UVC_CMD_INIT_UV = 1,
>  	BIT_UVC_CMD_SET_SHARED_ACCESS = 8,
>  	BIT_UVC_CMD_REMOVE_SHARED_ACCESS = 9,
>  };
> @@ -59,6 +61,15 @@ struct uv_cb_qui {
>  	u64 reserved98;
>  } __packed __aligned(8);
>  
> +struct uv_cb_init {
> +	struct uv_cb_header header;
> +	u64 reserved08[2];
> +	u64 stor_origin;
> +	u64 stor_len;
> +	u64 reserved28[4];
> +
> +} __packed __aligned(8);
> +
>  struct uv_cb_share {
>  	struct uv_cb_header header;
>  	u64 reserved08[3];
> @@ -158,8 +169,13 @@ static inline int is_prot_virt_host(void)
>  {
>  	return prot_virt_host;
>  }
> +
> +void setup_uv(void);
> +void adjust_to_uv_max(unsigned long *vmax);
>  #else
>  #define is_prot_virt_host() 0
> +static inline void setup_uv(void) {}
> +static inline void adjust_to_uv_max(unsigned long *vmax) {}
>  #endif
>  
>  #if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) ||                          \
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index f36370f8af38..d29d83c0b8df 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -567,6 +567,8 @@ static void __init setup_memory_end(void)
>  			vmax = _REGION1_SIZE; /* 4-level kernel page table */
>  	}
>  
> +	adjust_to_uv_max(&vmax);
> +
>  	/* module area is at the end of the kernel address space. */
>  	MODULES_END = vmax;
>  	MODULES_VADDR = MODULES_END - MODULES_LEN;
> @@ -1147,6 +1149,7 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	memblock_trim_memory(1UL << (MAX_ORDER - 1 + PAGE_SHIFT));
>  
> +	setup_uv();
>  	setup_memory_end();
>  	setup_memory();
>  	dma_contiguous_reserve(memory_end);
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index 35ce89695509..f7778493e829 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -45,4 +45,57 @@ static int __init prot_virt_setup(char *val)
>  	return rc;
>  }
>  early_param("prot_virt", prot_virt_setup);
> +
> +static int __init uv_init(unsigned long stor_base, unsigned long stor_len)
> +{
> +	struct uv_cb_init uvcb = {
> +		.header.cmd = UVC_CMD_INIT_UV,
> +		.header.len = sizeof(uvcb),
> +		.stor_origin = stor_base,
> +		.stor_len = stor_len,
> +	};
> +	int cc;
> +
> +	cc = uv_call(0, (uint64_t)&uvcb);
> +	if (cc || uvcb.header.rc != UVC_RC_EXECUTED) {
> +		pr_err("Ultravisor init failed with cc: %d rc: 0x%hx\n", cc,
> +		       uvcb.header.rc);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +void __init setup_uv(void)
> +{
> +	unsigned long uv_stor_base;
> +
> +	if (!prot_virt_host)
> +		return;
> +
> +	uv_stor_base = (unsigned long)memblock_alloc_try_nid(
> +		uv_info.uv_base_stor_len, SZ_1M, SZ_2G,
> +		MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
> +	if (!uv_stor_base) {
> +		pr_info("Failed to reserve %lu bytes for ultravisor base storage\n",
> +			uv_info.uv_base_stor_len);
> +		goto fail;
> +	}
> +
> +	if (uv_init(uv_stor_base, uv_info.uv_base_stor_len)) {
> +		memblock_free(uv_stor_base, uv_info.uv_base_stor_len);
> +		goto fail;
> +	}
> +
> +	pr_info("Reserving %luMB as ultravisor base storage\n",
> +		uv_info.uv_base_stor_len >> 20);
> +	return;
> +fail:
> +	prot_virt_host = 0;
> +}
> +
> +void adjust_to_uv_max(unsigned long *vmax)
> +{
> +	if (prot_virt_host && *vmax > uv_info.max_sec_stor_addr)
> +		*vmax = uv_info.max_sec_stor_addr;
> +}
>  #endif
> 
