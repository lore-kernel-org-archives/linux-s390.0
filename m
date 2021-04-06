Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DE5C433ED
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 11:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B50613C6
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 11:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhDFLOb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Apr 2021 07:14:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231347AbhDFLOa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 07:14:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136B3qep121957;
        Tue, 6 Apr 2021 07:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Dbs/psLVGJfx04NcRcuwlqht9mR7jvufIewbb6MZGs0=;
 b=l7mZljKx8MO93EhXCHlmSM/Ai0pvJq0ubHm1GWIxQbgfGk8a6WW0w/FC2Nynr0fXN2cz
 sS+Dgy6t647mGXBDLv3OkYYQx1S1cPjYkhqE2IoHuP+vWzMRD8Lc6BDb7qqcCcWSeUqE
 g8m4lU9TGPtr2li7eeNfACmhKaeruM8Eeh/9VOWlJlZ5kkFYpG48VnzF7QLKGjs3gNpq
 6oIJbOD5Wvm0Mw+bnFqRA8sb19o1+XwYScpLgRWXo/gBVGPedNN8areKuFRRHWZm715E
 +9aJiH7aLy7MPrb7VlML17uFazdMmSq2XzeiqJMwrsAOXktnZGNdBThy9NDfkjBengYP SQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5byxc44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 07:14:17 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 136BDYRQ014501;
        Tue, 6 Apr 2021 11:14:15 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 37q2y9j2ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 11:14:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 136BEC9Q33292586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Apr 2021 11:14:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92395A404D;
        Tue,  6 Apr 2021 11:14:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24B94A4040;
        Tue,  6 Apr 2021 11:14:12 +0000 (GMT)
Received: from sig-9-145-79-107.uk.ibm.com (unknown [9.145.79.107])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Apr 2021 11:14:12 +0000 (GMT)
Message-ID: <a3005d2871d6571a436dacca2d93eb10cca54bed.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/pci: move
 ioremap/ioremap_prot/ioremap_wc/ioremap_wt/iounmap to arch/s390/mm/ioremap.c
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bixuan Cui <cuibixuan@huawei.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com, john.wanghui@huawei.com
Date:   Tue, 06 Apr 2021 13:14:11 +0200
In-Reply-To: <20210401124611.49917-1-cuibixuan@huawei.com>
References: <20210401124611.49917-1-cuibixuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cMHNJdLztIf9zXgrWLZzki3XzgfKcL5f
X-Proofpoint-ORIG-GUID: cMHNJdLztIf9zXgrWLZzki3XzgfKcL5f
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_02:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060076
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 2021-04-01 at 20:46 +0800, Bixuan Cui wrote:
> The ioremap/iounmap is implemented in arch/s390/pci/pci.c.
> While CONFIG_PCI is disabled,the compilation error is reported:
>     s390x-linux-gnu-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
>     cistpl.c:(.text+0x32a): undefined reference to `ioremap'
>     s390x-linux-gnu-ld: cistpl.c:(.text+0x360): undefined reference to `iounmap'
>     s390x-linux-gnu-ld: cistpl.c:(.text+0x384): undefined reference to `iounmap'
>     s390x-linux-gnu-ld: cistpl.c:(.text+0x396): undefined reference to `ioremap'
>     s390x-linux-gnu-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
>     cistpl.c:(.text+0xcb8): undefined reference to `iounmap'

Hmm, so I guess we're the only architecture which only defines
ioremap() if CONFIG_PCI is set and on top of that ioremap() only
actually remaps if we have a runtime detected hardware feature (MIO
support) and otherwise definitely only works for PCI BARs while in
theory it could also remap other physical memory with, though without
other (pseudo-)MMIO memory that's a bit pointless.

There doesn't seem to be a HAVE_IOREMAP config flag, only
HAVE_IOREMAP_PROT precicely because everyone else with an MMU probably
also uses ioremap(). Anything else that driver's that don't require PCI
but do require ioremap() could depend on?

> 
> Add arch/s390/mm/ioremap.c file and move ioremap/ioremap_wc/ioremap_rt/iounmap
> to it to fix the error.

See below but this patch code doesn't just move code around.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  arch/s390/include/asm/io.h |  8 ++---
>  arch/s390/mm/Makefile      |  2 +-
>  arch/s390/mm/ioremap.c     | 64 +++++++++++++++++++++++++++++++++
>  arch/s390/pci/pci.c        | 73 ++++++--------------------------------
>  4 files changed, 80 insertions(+), 67 deletions(-)
>  create mode 100644 arch/s390/mm/ioremap.c
> 
> diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
> index e3882b012bfa..48a55644c34f 100644
> --- a/arch/s390/include/asm/io.h
> +++ b/arch/s390/include/asm/io.h
> @@ -22,6 +22,10 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
>  
>  #define IO_SPACE_LIMIT 0
>  
> +#define ioremap ioremap
> +#define ioremap_wt ioremap_wt
> +#define ioremap_wc ioremap_wc
> +
>  void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
>  void __iomem *ioremap(phys_addr_t addr, size_t size);
>  void __iomem *ioremap_wc(phys_addr_t addr, size_t size);
> @@ -51,10 +55,6 @@ static inline void ioport_unmap(void __iomem *p)
>  #define pci_iomap_wc pci_iomap_wc
>  #define pci_iomap_wc_range pci_iomap_wc_range
>  
> -#define ioremap ioremap
> -#define ioremap_wt ioremap_wt
> -#define ioremap_wc ioremap_wc
> -
>  #define memcpy_fromio(dst, src, count)	zpci_memcpy_fromio(dst, src, count)
>  #define memcpy_toio(dst, src, count)	zpci_memcpy_toio(dst, src, count)
>  #define memset_io(dst, val, count)	zpci_memset_io(dst, val, count)
> diff --git a/arch/s390/mm/Makefile b/arch/s390/mm/Makefile
> index cd67e94c16aa..74c22dfb131b 100644
> --- a/arch/s390/mm/Makefile
> +++ b/arch/s390/mm/Makefile
> @@ -4,7 +4,7 @@
>  #
>  
>  obj-y		:= init.o fault.o extmem.o mmap.o vmem.o maccess.o
> -obj-y		+= page-states.o pageattr.o pgtable.o pgalloc.o
> +obj-y		+= page-states.o pageattr.o pgtable.o pgalloc.o ioremap.o
>  
>  obj-$(CONFIG_CMM)		+= cmm.o
>  obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
> diff --git a/arch/s390/mm/ioremap.c b/arch/s390/mm/ioremap.c
> new file mode 100644
> index 000000000000..132e6ddff36f
> --- /dev/null
> +++ b/arch/s390/mm/ioremap.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 Huawei Ltd.
> + * Author: Bixuan Cui <cuibixuan@huawei.com>
> + */
> +#include <linux/vmalloc.h>
> +#include <linux/io.h>
> +#include <linux/mm.h>
> +#include <linux/jump_label.h>
> +
> +static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
> +{
> +	unsigned long offset, vaddr;
> +	struct vm_struct *area;
> +	phys_addr_t last_addr;
> +
> +	last_addr = addr + size - 1;
> +	if (!size || last_addr < addr)
> +		return NULL;
> +
> +	offset = addr & ~PAGE_MASK;
> +	addr &= PAGE_MASK;
> +	size = PAGE_ALIGN(size + offset);
> +	area = get_vm_area(size, VM_IOREMAP);
> +	if (!area)
> +		return NULL;
> +
> +	vaddr = (unsigned long) area->addr;
> +	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
> +		free_vm_area(area);
> +		return NULL;
> +	}
> +	return (void __iomem *) ((unsigned long) area->addr + offset);
> +}
> +
> +void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
> +{
> +	return __ioremap(addr, size, __pgprot(prot));
> +}
> +EXPORT_SYMBOL(ioremap_prot);
> +
> +void __iomem *ioremap(phys_addr_t addr, size_t size)
> +{
> +	return __ioremap(addr, size, PAGE_KERNEL);
> +}
> +EXPORT_SYMBOL(ioremap);
> +
> +void __iomem *ioremap_wc(phys_addr_t addr, size_t size)
> +{
> +	return __ioremap(addr, size, pgprot_writecombine(PAGE_KERNEL));
> +}
> +EXPORT_SYMBOL(ioremap_wc);
> +
> +void __iomem *ioremap_wt(phys_addr_t addr, size_t size)
> +{
> +	return __ioremap(addr, size, pgprot_writethrough(PAGE_KERNEL));
> +}
> +EXPORT_SYMBOL(ioremap_wt);
> +
> +void iounmap(volatile void __iomem *addr)
> +{
> +	vunmap((__force void *) ((unsigned long) addr & PAGE_MASK));
> +}
> +EXPORT_SYMBOL(iounmap);
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index dd14641b2d20..be300850df9c 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -227,65 +227,6 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
>         zpci_memcpy_toio(to, from, count);
>  }
>  
> -static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
> -{
> -	unsigned long offset, vaddr;
> -	struct vm_struct *area;
> -	phys_addr_t last_addr;
> -
> -	last_addr = addr + size - 1;
> -	if (!size || last_addr < addr)
> -		return NULL;
> -
> -	if (!static_branch_unlikely(&have_mio))
> -		return (void __iomem *) addr;

Please don't make your commit message sound as if the commit only moves
code to a new file when your move instead fundamentally alters that
code by e.g. dropping the above static_branch out of ioremap() which
in
fact would completely break our PCI support on machines without the MIO
hardware feature this checks.

This code might look stupid to you but is actually our long standing
original ioremap() implementation dating back to our initial PCI
support in commit cd24834130ac ("s390/pci: base support").

This is because we need to work around the fact that s390 does not
currently have true MMIO support, that MIO flag we're checking on here
gives us pseudo-MMIO memory that works conceptually like MMIO but only
allows special PCI load/stores (on translated addresses). Without that
we can only access the PCI bus and PCI devices through special PCI
access instructions which do not use MMIO addresses. Instead they rely
on what we call a function handle, a BAR number and an offset. Since
Linux only knows how to work with PCI based on MMIO we adapt to that
interface by issuing artificial BAR/__iomem addresses which allow our
readX/writeX primities to map them back to the special PCI access
instructions. Since these aren't actuallyt physical addresses and can
only be used with these primitives remapping makes little sense.
Nevertheless PCI drivers expect to be able to call ioremap() on the BAR
physical addresses and get a usable __iomem address back.

I guess one way to fix this would be to turn the above if into:

if (IS_ENABLED(CONFIG_PCI) && !static_branch_unlikely(&have_mio))

and move the have_mio variable out of the PCI only code or use a raw
"#ifdef CONFIG_PCI". Obviously we don't have any actual users of
ioremap() that don't depend on CONFIG_PCI but it would make it so that
ioremap() exists and should actually function without CONFIG_PCI.
The weird part though is that for anyone using it without CONFIG_PCI it
would stop working if that is set and the machine doesn't have MIO
support but would work if it does.


> -
> -	offset = addr & ~PAGE_MASK;
> -	addr &= PAGE_MASK;
> -	size = PAGE_ALIGN(size + offset);
> -	area = get_vm_area(size, VM_IOREMAP);
> -	if (!area)
> -		return NULL;
> -
> -	vaddr = (unsigned long) area->addr;
> -	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
> -		free_vm_area(area);
> -		return NULL;
> -	}
> -	return (void __iomem *) ((unsigned long) area->addr + offset);
> -}
> -
> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
> -{
> -	return __ioremap(addr, size, __pgprot(prot));
> -}
> -EXPORT_SYMBOL(ioremap_prot);
> -
> -void __iomem *ioremap(phys_addr_t addr, size_t size)
> -{
> -	return __ioremap(addr, size, PAGE_KERNEL);
> -}
> -EXPORT_SYMBOL(ioremap);
> -
> -void __iomem *ioremap_wc(phys_addr_t addr, size_t size)
> -{
> -	return __ioremap(addr, size, pgprot_writecombine(PAGE_KERNEL));
> -}
> -EXPORT_SYMBOL(ioremap_wc);
> -
> -void __iomem *ioremap_wt(phys_addr_t addr, size_t size)
> -{
> -	return __ioremap(addr, size, pgprot_writethrough(PAGE_KERNEL));
> -}
> -EXPORT_SYMBOL(ioremap_wt);
> -
> -void iounmap(volatile void __iomem *addr)
> -{
> -	if (static_branch_likely(&have_mio))
> -		vunmap((__force void *) ((unsigned long) addr & PAGE_MASK));
> -}
> -EXPORT_SYMBOL(iounmap);
> -
>  /* Create a virtual mapping cookie for a PCI BAR */
>  static void __iomem *pci_iomap_range_fh(struct pci_dev *pdev, int bar,
>  					unsigned long offset, unsigned long max)
> @@ -312,7 +253,10 @@ static void __iomem *pci_iomap_range_mio(struct pci_dev *pdev, int bar,
>  	struct zpci_dev *zdev = to_zpci(pdev);
>  	void __iomem *iova;
>  
> -	iova = ioremap((unsigned long) zdev->bars[bar].mio_wt, barsize);
> +	if (!static_branch_unlikely(&have_mio))
> +		iova = (void __iomem *) zdev->bars[bar].mio_wt;
> +	else
> +		iova = ioremap((unsigned long) zdev->bars[bar].mio_wt, barsize);
>  	return iova ? iova + offset : iova;
>  }
>  
> @@ -342,7 +286,11 @@ static void __iomem *pci_iomap_wc_range_mio(struct pci_dev *pdev, int bar,
>  	struct zpci_dev *zdev = to_zpci(pdev);
>  	void __iomem *iova;
>  
> -	iova = ioremap((unsigned long) zdev->bars[bar].mio_wb, barsize);
> +	if (!static_branch_unlikely(&have_mio))
> +		iova = (void __iomem *) zdev->bars[bar].mio_wb;
> +	else
> +		iova = ioremap((unsigned long) zdev->bars[bar].mio_wb, barsize);
> +
>  	return iova ? iova + offset : iova;
>  }
>  
> @@ -381,7 +329,8 @@ static void pci_iounmap_fh(struct pci_dev *pdev, void __iomem *addr)
>  
>  static void pci_iounmap_mio(struct pci_dev *pdev, void __iomem *addr)
>  {
> -	iounmap(addr);
> +	if (static_branch_likely(&have_mio))
> +		iounmap(addr);
>  }
>  
>  void pci_iounmap(struct pci_dev *pdev, void __iomem *addr)

