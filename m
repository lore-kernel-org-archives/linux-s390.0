Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41451 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727137AbgBUKix (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Feb 2020 05:38:53 -0500
Subject: Re: [PATCH v3 06/37] s390/mm: add (non)secure page access exceptions
 handlers
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-7-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1a3c04d2-8dac-741a-e3db-e23414919ef4@redhat.com>
Date: Fri, 21 Feb 2020 11:38:41 +0100
MIME-Version: 1.0
In-Reply-To: <20200220104020.5343-7-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, Janosch Frank <frankja@linux.ibm.com>

On 20.02.20 11:39, Christian Borntraeger wrote:
> From: Vasily Gorbik <gor@linux.ibm.com>
> 
> Add exceptions handlers performing transparent transition of non-secure
> pages to secure (import) upon guest access and secure pages to
> non-secure (export) upon hypervisor access.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> [frankja@linux.ibm.com: adding checks for failures]
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [imbrenda@linux.ibm.com:  adding a check for gmap fault]
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kernel/pgm_check.S |  4 +-
>  arch/s390/mm/fault.c         | 78 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/pgm_check.S b/arch/s390/kernel/pgm_check.S
> index eee3a482195a..2c27907a5ffc 100644
> --- a/arch/s390/kernel/pgm_check.S
> +++ b/arch/s390/kernel/pgm_check.S
> @@ -78,8 +78,8 @@ PGM_CHECK(do_dat_exception)		/* 39 */
>  PGM_CHECK(do_dat_exception)		/* 3a */
>  PGM_CHECK(do_dat_exception)		/* 3b */
>  PGM_CHECK_DEFAULT			/* 3c */
> -PGM_CHECK_DEFAULT			/* 3d */
> -PGM_CHECK_DEFAULT			/* 3e */
> +PGM_CHECK(do_secure_storage_access)	/* 3d */
> +PGM_CHECK(do_non_secure_storage_access)	/* 3e */
>  PGM_CHECK_DEFAULT			/* 3f */
>  PGM_CHECK(monitor_event_exception)	/* 40 */
>  PGM_CHECK_DEFAULT			/* 41 */
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 7b0bb475c166..7bd86ebc882f 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -38,6 +38,7 @@
>  #include <asm/irq.h>
>  #include <asm/mmu_context.h>
>  #include <asm/facility.h>
> +#include <asm/uv.h>
>  #include "../kernel/entry.h"
>  
>  #define __FAIL_ADDR_MASK -4096L
> @@ -816,3 +817,80 @@ static int __init pfault_irq_init(void)
>  early_initcall(pfault_irq_init);
>  
>  #endif /* CONFIG_PFAULT */
> +
> +#if IS_ENABLED(CONFIG_PGSTE)
> +void do_secure_storage_access(struct pt_regs *regs)
> +{
> +	unsigned long addr = regs->int_parm_long & __FAIL_ADDR_MASK;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +	struct page *page;
> +	int rc;
> +
> +	switch (get_fault_type(regs)) {
> +	case USER_FAULT:
> +		mm = current->mm;
> +		down_read(&mm->mmap_sem);
> +		vma = find_vma(mm, addr);
> +		if (!vma) {
> +			up_read(&mm->mmap_sem);
> +			do_fault_error(regs, VM_READ | VM_WRITE, VM_FAULT_BADMAP);
> +			break;
> +		}
> +		page = follow_page(vma, addr, FOLL_WRITE | FOLL_GET);
> +		if (IS_ERR_OR_NULL(page)) {
> +			up_read(&mm->mmap_sem);
> +			break;
> +		}
> +		if (arch_make_page_accessible(page))
> +			send_sig(SIGSEGV, current, 0);
> +		put_page(page);
> +		up_read(&mm->mmap_sem);
> +		break;
> +	case KERNEL_FAULT:
> +		page = phys_to_page(addr);
> +		if (unlikely(!try_get_page(page)))
> +			break;
> +		rc = arch_make_page_accessible(page);
> +		put_page(page);
> +		if (rc)
> +			BUG();
> +		break;
> +	case VDSO_FAULT:
> +		/* fallthrough */
> +	case GMAP_FAULT:
> +		/* fallthrough */
> +	default:
> +		do_fault_error(regs, VM_READ | VM_WRITE, VM_FAULT_BADMAP);
> +		WARN_ON_ONCE(1);
> +	}
> +}
> +NOKPROBE_SYMBOL(do_secure_storage_access);
> +
> +void do_non_secure_storage_access(struct pt_regs *regs)
> +{
> +	unsigned long gaddr = regs->int_parm_long & __FAIL_ADDR_MASK;
> +	struct gmap *gmap = (struct gmap *)S390_lowcore.gmap;
> +
> +	if (get_fault_type(regs) != GMAP_FAULT) {
> +		do_fault_error(regs, VM_READ | VM_WRITE, VM_FAULT_BADMAP);
> +		WARN_ON_ONCE(1);
> +		return;
> +	}
> +
> +	if (gmap_convert_to_secure(gmap, gaddr) == -EINVAL)
> +		send_sig(SIGSEGV, current, 0);
> +}
> +NOKPROBE_SYMBOL(do_non_secure_storage_access);
> +
> +#else
> +void do_secure_storage_access(struct pt_regs *regs)
> +{
> +	default_trap_handler(regs);
> +}
> +
> +void do_non_secure_storage_access(struct pt_regs *regs)
> +{
> +	default_trap_handler(regs);
> +}
> +#endif
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
