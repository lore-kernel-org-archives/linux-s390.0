Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42574 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbgBQJ5r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 04:57:47 -0500
Subject: Re: [PATCH v2 04/42] s390/protvirt: add ultravisor initialization
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-5-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ad934492-afcb-7a11-c682-6884e5c0ffed@redhat.com>
Date: Mon, 17 Feb 2020 10:57:33 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-5-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
> From: Vasily Gorbik <gor@linux.ibm.com>
> 
> Before being able to host protected virtual machines, donate some of
> the memory to the ultravisor. Besides that the ultravisor might impose
> addressing limitations for memory used to back protected VM storage. Treat
> that limit as protected virtualization host's virtual memory limit.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/uv.h | 15 +++++++++++
>  arch/s390/kernel/setup.c   |  5 ++++
>  arch/s390/kernel/uv.c      | 51 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+)
> 
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 34b1114dcc38..f5b55e3972b3 100644
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
> @@ -59,6 +61,14 @@ struct uv_cb_qui {
>  	u64 reserveda0;
>  } __packed __aligned(8);
>  
> +struct uv_cb_init {
> +	struct uv_cb_header header;
> +	u64 reserved08[2];
> +	u64 stor_origin;
> +	u64 stor_len;
> +	u64 reserved28[4];
> +} __packed __aligned(8);
> +
>  struct uv_cb_share {
>  	struct uv_cb_header header;
>  	u64 reserved08[3];
> @@ -159,8 +169,13 @@ static inline int is_prot_virt_host(void)
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
> index a2496382175e..e02727812e67 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -560,6 +560,9 @@ static void __init setup_memory_end(void)
>  			vmax = _REGION1_SIZE; /* 4-level kernel page table */
>  	}
>  
> +	if (prot_virt_host)
> +		adjust_to_uv_max(&vmax);
> +
>  	/* module area is at the end of the kernel address space. */
>  	MODULES_END = vmax;
>  	MODULES_VADDR = MODULES_END - MODULES_LEN;
> @@ -1134,6 +1137,8 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	memblock_trim_memory(1UL << (MAX_ORDER - 1 + PAGE_SHIFT));
>  
> +	if (prot_virt_host)
> +		setup_uv();
>  	setup_memory_end();
>  	setup_memory();
>  	dma_contiguous_reserve(memory_end);
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index b1f936710360..1424994f5489 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -49,4 +49,55 @@ static int __init prot_virt_setup(char *val)
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
> +
> +	if (uv_call(0, (uint64_t)&uvcb)) {
> +		pr_err("Ultravisor init failed with rc: 0x%x rrc: 0%x\n",
> +		       uvcb.header.rc, uvcb.header.rrc);
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

That can go.

> +
> +	uv_stor_base = (unsigned long)memblock_alloc_try_nid(
> +		uv_info.uv_base_stor_len, SZ_1M, SZ_2G,
> +		MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
