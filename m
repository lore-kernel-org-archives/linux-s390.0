Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731029AbfGOOVq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 10:21:46 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FEGMiw030363
        for <linux-s390@vger.kernel.org>; Mon, 15 Jul 2019 10:21:45 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2trrp3gecq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 15 Jul 2019 10:21:44 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 15 Jul 2019 15:21:42 +0100
Date: Mon, 15 Jul 2019 16:21:37 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/protvirt: restore force_dma_unencrypted()
In-Reply-To: <20190715132027.GA18357@infradead.org>
References: <20190715131719.100650-1-pasic@linux.ibm.com>
        <20190715132027.GA18357@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190715162137.325faf26.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 15 Jul 2019 06:20:27 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> This looks good to me - if you and Tom are fine with it I'd like to
> fold it into his commit so that what I'll send to Linus is bisection
> clean.

No objections here.

> 
> > Note: we still need sev_active() defined because of the reference
> > in fs/core/vmcore, but this one is likely to go away soon along
> > with the need for an s390 sev_active().
> 
> Any chance we could not change the return value from the function
> at least in this patch/fold as that change seems unrelated to the
> dma functionality.  If that is what you really wanted and only
> the dma code was in the way we can happily merge it as a separate
> patch, of couse.
> 

AFAIU the story form fs/core/vmcore.c boils down to the same on s390. I
explained this in an email I've sent a moment ago (to Thiago). I expect
sev_active() on s390 to go away soon as it really does not make sense
for us (any more).

Thus yes, we can restore the pre- e67a5ed1f86f ("dma-direct: Force
unencrypted DMA under SME for certain DMA masks") sev_active() behavior
as well, even if we don't care about it. What I did conveys the semantic
better. Not changing the behavior of however sev_active() makes more
sense if the two are going to be squashed.

The corresponding diff looks like follows. Would you like me to send it
out as v2?

Regards,
Halil

----------------------------8<---------------------------------------

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 5d8570ed6cab..a4ad2733eedf 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -189,6 +189,7 @@ config S390
        select VIRT_CPU_ACCOUNTING
        select ARCH_HAS_SCALED_CPUTIME
        select HAVE_NMI
+       select ARCH_HAS_FORCE_DMA_UNENCRYPTED
        select SWIOTLB
        select GENERIC_ALLOCATOR
 
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index f0bee6af3960..dfe47a22480a 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -155,12 +155,17 @@ int set_memory_decrypted(unsigned long addr, int numpages)
        return 0;
 }
 
-/* are we a protected virtualization guest? */
 bool sev_active(void)
 {
        return is_prot_virt_guest();
 }
 
+/* are we a protected virtualization guest? */
+bool force_dma_unencrypted(struct device *dev)
+{
+       return is_prot_virt_guest();
+}
+
 /* protected virtualization */
 static void pv_init(void)
 {
