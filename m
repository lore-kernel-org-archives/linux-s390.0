Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387401AbgBNT7g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 14:59:36 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EJueW7112820
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 14:59:35 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j893ue9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 14:59:35 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 14 Feb 2020 19:59:33 -0000
Subject: Re: [PATCH 06/35] s390/mm: add (non)secure page access exceptions
 handlers
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-7-borntraeger@de.ibm.com>
 <c05f8672-dc29-271a-66d2-73138406cf21@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Feb 2020 20:59:27 +0100
MIME-Version: 1.0
In-Reply-To: <c05f8672-dc29-271a-66d2-73138406cf21@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9bbf5e4e-8bdc-b990-f39f-44c6a3f54ba0@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Janosch Frank <frankja@linux.ibm.com>



On 14.02.20 19:05, David Hildenbrand wrote:
> On 07.02.20 12:39, Christian Borntraeger wrote:
>> From: Vasily Gorbik <gor@linux.ibm.com>
>>
>> Add exceptions handlers performing transparent transition of non-secure
>> pages to secure (import) upon guest access and secure pages to
>> non-secure (export) upon hypervisor access.
>>
>> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
>> [frankja@linux.ibm.com: adding checks for failures]
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [imbrenda@linux.ibm.com:  adding a check for gmap fault]
>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kernel/pgm_check.S |  4 +-
>>  arch/s390/mm/fault.c         | 86 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 88 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/kernel/pgm_check.S b/arch/s390/kernel/pgm_check.S
>> index 59dee9d3bebf..27ac4f324c70 100644
>> --- a/arch/s390/kernel/pgm_check.S
>> +++ b/arch/s390/kernel/pgm_check.S
>> @@ -78,8 +78,8 @@ PGM_CHECK(do_dat_exception)		/* 39 */
>>  PGM_CHECK(do_dat_exception)		/* 3a */
>>  PGM_CHECK(do_dat_exception)		/* 3b */
>>  PGM_CHECK_DEFAULT			/* 3c */
>> -PGM_CHECK_DEFAULT			/* 3d */
>> -PGM_CHECK_DEFAULT			/* 3e */
>> +PGM_CHECK(do_secure_storage_access)	/* 3d */
>> +PGM_CHECK(do_non_secure_storage_access)	/* 3e */
>>  PGM_CHECK_DEFAULT			/* 3f */
>>  PGM_CHECK_DEFAULT			/* 40 */
>>  PGM_CHECK_DEFAULT			/* 41 */
>> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
>> index 7b0bb475c166..fab4219fa0be 100644
>> --- a/arch/s390/mm/fault.c
>> +++ b/arch/s390/mm/fault.c
>> @@ -38,6 +38,7 @@
>>  #include <asm/irq.h>
>>  #include <asm/mmu_context.h>
>>  #include <asm/facility.h>
>> +#include <asm/uv.h>
>>  #include "../kernel/entry.h"
>>  
>>  #define __FAIL_ADDR_MASK -4096L
>> @@ -816,3 +817,88 @@ static int __init pfault_irq_init(void)
>>  early_initcall(pfault_irq_init);
>>  
>>  #endif /* CONFIG_PFAULT */
>> +
>> +#if IS_ENABLED(CONFIG_KVM)
>> +void do_secure_storage_access(struct pt_regs *regs)
>> +{
>> +	unsigned long addr = regs->int_parm_long & __FAIL_ADDR_MASK;
>> +	struct vm_area_struct *vma;
>> +	struct mm_struct *mm;
>> +	struct page *page;
>> +	int rc;
>> +
>> +	switch (get_fault_type(regs)) {
>> +	case USER_FAULT:
>> +		mm = current->mm;
>> +		down_read(&mm->mmap_sem);
>> +		vma = find_vma(mm, addr);
>> +		if (!vma) {
>> +			up_read(&mm->mmap_sem);
>> +			do_fault_error(regs, VM_READ | VM_WRITE, VM_FAULT_BADMAP);
>> +			break;
>> +		}
>> +		page = follow_page(vma, addr, FOLL_WRITE | FOLL_GET);
>> +		if (IS_ERR_OR_NULL(page)) {
>> +			up_read(&mm->mmap_sem);
>> +			break;
>> +		}
>> +		if (arch_make_page_accessible(page))
>> +			send_sig(SIGSEGV, current, 0);
>> +		put_page(page);
>> +		up_read(&mm->mmap_sem);
>> +		break;
>> +	case KERNEL_FAULT:
>> +		page = phys_to_page(addr);
>> +		if (unlikely(!try_get_page(page)))
>> +			break;
>> +		rc = arch_make_page_accessible(page);
>> +		put_page(page);
>> +		if (rc)
>> +			BUG();
>> +		break;
>> +	case VDSO_FAULT:
>> +		/* fallthrough */
>> +	case GMAP_FAULT:
>> +		/* fallthrough */
> 
> Could we ever get here from the SIE?

GMAP_FAULT is only set if we came from the sie critical section, so unless we have a bug no.

> 
>> +	default:
>> +		do_fault_error(regs, VM_READ | VM_WRITE, VM_FAULT_BADMAP);
>> +		WARN_ON_ONCE(1);
>> +	}
>> +}
>> +NOKPROBE_SYMBOL(do_secure_storage_access);
>> +
>> +void do_non_secure_storage_access(struct pt_regs *regs)
>> +{
>> +	unsigned long gaddr = regs->int_parm_long & __FAIL_ADDR_MASK;
>> +	struct gmap *gmap = (struct gmap *)S390_lowcore.gmap;
>> +	struct uv_cb_cts uvcb = {
>> +		.header.cmd = UVC_CMD_CONV_TO_SEC_STOR,
>> +		.header.len = sizeof(uvcb),
>> +		.guest_handle = gmap->guest_handle,
>> +		.gaddr = gaddr,
>> +	};
>> +	int rc;
>> +
>> +	if (get_fault_type(regs) != GMAP_FAULT) {
>> +		do_fault_error(regs, VM_READ | VM_WRITE, VM_FAULT_BADMAP);
>> +		WARN_ON_ONCE(1);
>> +		return;
>> +	}
>> +
>> +	rc = uv_make_secure(gmap, gaddr, &uvcb);
>> +	if (rc == -EINVAL && uvcb.header.rc != 0x104)
>> +		send_sig(SIGSEGV, current, 0);
> 
> 
> Looks good to me, but I don't feel like being ready for an r-b. I'll
> have to let that sink in :)
> 
> Assumed-is-okay-by: David Hildenbrand <david@redhat.com>
> 
> 
