Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbgELGRg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 May 2020 02:17:36 -0400
Date: Tue, 12 May 2020 08:16:54 +0200
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH -next] s390: Remove two unused inline functions
Message-ID: <20200512061653.GA33732@tuxmaker.boeblingen.de.ibm.com>
References: <20200508140724.11324-1-yuehaibing@huawei.com>
 <20200511060750.GA93884@tuxmaker.boeblingen.de.ibm.com>
 <20200511161756.7586afe6@gandalf.local.home>
 <cf344230-27b1-7302-36bb-55c25c6b5de4@de.ibm.com>
 <02b965de57774f393bb16d669164e0cef2497f2f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b965de57774f393bb16d669164e0cef2497f2f.camel@perches.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, YueHaibing <yuehaibing@huawei.com>, mingo@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Joe,

On Mon, May 11, 2020 at 01:38:57PM -0700, Joe Perches wrote:

> Awhile back, I posted a list of apparently unused static inline
> functions in .h files treewide found by a script:
> 
> https://lore.kernel.org/lkml/4603e761a5f39f4d97375e1e08d20d720c526341.camel@perches.com/
> 
> Here are the s390 entries:
> 
> arch/s390/include/asm/atomic_ops.h:138:static inline long __atomic64_cmpxchg_bool(long *ptr, long old, long new)
> arch/s390/include/asm/bitops.h:278:static inline void __set_bit_inv(unsigned long nr, volatile unsigned long *ptr)
> arch/s390/include/asm/bitops.h:283:static inline void __clear_bit_inv(unsigned long nr, volatile unsigned long *ptr)
> arch/s390/include/asm/cpu_mcf.h:106:static inline int kernel_cpumcf_begin(void)
> arch/s390/include/asm/cpu_mcf.h:114:static inline void kernel_cpumcf_end(void)
> arch/s390/include/asm/ftrace.h:64:static inline int is_ftrace_nop(struct ftrace_insn *insn)
> arch/s390/include/asm/kvm_para.h:146:static inline long kvm_hypercall5(unsigned long nr, unsigned long p1,
> arch/s390/include/asm/kvm_para.h:175:static inline long kvm_hypercall6(unsigned long nr, unsigned long p1,
> arch/s390/include/asm/pci_dma.h:134:static inline void invalidate_table_entry(unsigned long *entry)
> arch/s390/include/asm/pci_dma.h:176:static inline int entry_isprotected(unsigned long entry)
> arch/s390/include/asm/timex.h:52:static inline void store_clock_comparator(__u64 *time)

Thanks, i take a look and prepare a patch.

Regards
Sven
