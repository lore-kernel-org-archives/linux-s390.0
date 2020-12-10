Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387710AbgLJG7l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Dec 2020 01:59:41 -0500
Date: Thu, 10 Dec 2020 07:58:45 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 3/3] s390/mm: Define arch_get_mappable_range()
Message-ID: <20201210065845.GA20691@osiris>
References: <1607400978-31595-1-git-send-email-anshuman.khandual@arm.com>
 <1607400978-31595-4-git-send-email-anshuman.khandual@arm.com>
 <20201208152709.GA26979@osiris>
 <7484e153-6c77-8325-6195-621fe144011e@arm.com>
 <20201209145717.GD7160@osiris>
 <04da0f9c-d50e-7729-5e4c-b0dc4e76d608@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04da0f9c-d50e-7729-5e4c-b0dc4e76d608@arm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Thu, Dec 10, 2020 at 09:48:11AM +0530, Anshuman Khandual wrote:
> >> Alternatively leaving __segment_load() and vmem_add_memory() unchanged
> >> will create three range checks i.e two memhp_range_allowed() and the
> >> existing VMEM_MAX_PHYS check in vmem_add_mapping() on all the hotplug
> >> paths, which is not optimal.
> > 
> > Ah, sorry. I didn't follow this discussion too closely. I just thought
> > my point of view would be clear: let's not have two different ways to
> > check for the same thing which must be kept in sync.
> > Therefore I was wondering why this next version is still doing
> > that. Please find a way to solve this.
> 
> The following change is after the current series and should work with
> and without memory hotplug enabled. There will be just a single place
> i.e vmem_get_max_addr() to update in case the maximum address changes
> from VMEM_MAX_PHYS to something else later.

Still not. That's way too much code churn for what you want to achieve.
If the s390 specific patch would look like below you can add

Acked-by: Heiko Carstens <hca@linux.ibm.com>

But please make sure that the arch_get_mappable_range() prototype in
linux/memory_hotplug.h is always visible and does not depend on
CONFIG_MEMORY_HOTPLUG. I'd like to avoid seeing sparse warnings
because of this.

Thanks.

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 77767850d0d0..e0e78234ae57 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -291,6 +291,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
 		return -EINVAL;
 
+	VM_BUG_ON(!memhp_range_allowed(start, size, 1));
 	rc = vmem_add_mapping(start, size);
 	if (rc)
 		return rc;
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b239f2ba93b0..ccd55e2f97f9 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -4,6 +4,7 @@
  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
  */
 
+#include <linux/memory_hotplug.h>
 #include <linux/memblock.h>
 #include <linux/pfn.h>
 #include <linux/mm.h>
@@ -532,11 +533,23 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
 	mutex_unlock(&vmem_mutex);
 }
 
+struct range arch_get_mappable_range(void)
+{
+	struct range range;
+
+	range.start = 0;
+	range.end = VMEM_MAX_PHYS;
+	return range;
+}
+
 int vmem_add_mapping(unsigned long start, unsigned long size)
 {
+	struct range range;
 	int ret;
 
-	if (start + size > VMEM_MAX_PHYS ||
+	range = arch_get_mappable_range();
+	if (start < range.start ||
+	    start + size > range.end ||
 	    start + size < start)
 		return -ERANGE;
 
