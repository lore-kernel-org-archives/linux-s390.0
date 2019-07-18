Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388249AbfGRQnx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 12:43:53 -0400
References: <20190718032858.28744-1-bauerman@linux.ibm.com> <20190718032858.28744-7-bauerman@linux.ibm.com> <20190718084456.GE24562@lst.de> <20190718150123.4230a00c.pasic@linux.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] s390/mm: Remove sev_active() function
In-reply-to: <20190718150123.4230a00c.pasic@linux.ibm.com>
Date: Thu, 18 Jul 2019 13:43:20 -0300
Message-ID: <87blxr47kn.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>


Halil Pasic <pasic@linux.ibm.com> writes:

> On Thu, 18 Jul 2019 10:44:56 +0200
> Christoph Hellwig <hch@lst.de> wrote:
>
>> > -/* are we a protected virtualization guest? */
>> > -bool sev_active(void)
>> > -{
>> > -	return is_prot_virt_guest();
>> > -}
>> > -
>> >  bool force_dma_unencrypted(struct device *dev)
>> >  {
>> > -	return sev_active();
>> > +	return is_prot_virt_guest();
>> >  }
>> 
>> Do we want to keep the comment for force_dma_unencrypted?
>
> Yes we do. With the comment transferred:
>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Thanks for your review.

Here is the new version. Should I send a new patch series with this
patch and the Reviewed-by on the other ones?

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


From 1726205c73fb9e29feaa3d8909c5a1b0f2054c04 Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Mon, 15 Jul 2019 20:50:43 -0300
Subject: [PATCH v4] s390/mm: Remove sev_active() function

All references to sev_active() were moved to arch/x86 so we don't need to
define it for s390 anymore.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/include/asm/mem_encrypt.h | 1 -
 arch/s390/mm/init.c                 | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index ff813a56bc30..2542cbf7e2d1 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -5,7 +5,6 @@
 #ifndef __ASSEMBLY__
 
 static inline bool mem_encrypt_active(void) { return false; }
-extern bool sev_active(void);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 78c319c5ce48..6c43a1ed1beb 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -156,14 +156,9 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 }
 
 /* are we a protected virtualization guest? */
-bool sev_active(void)
-{
-	return is_prot_virt_guest();
-}
-
 bool force_dma_unencrypted(struct device *dev)
 {
-	return sev_active();
+	return is_prot_virt_guest();
 }
 
 /* protected virtualization */
