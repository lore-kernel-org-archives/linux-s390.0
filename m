Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHBSC2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 2 Aug 2020 14:02:28 -0400
Date: Sun, 2 Aug 2020 20:02:23 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 14/17] x86/setup: simplify reserve_crashkernel()
Message-ID: <20200802180223.GB86614@gmail.com>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-15-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802163601.8189-15-rppt@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>, Emil Renner Berthing <kernel@esmil.dk>, Ingo Molnar <mingo@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, clang-built-linux@googlegroups.com, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org


* Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> * Replace magic numbers with defines
> * Replace memblock_find_in_range() + memblock_reserve() with
>   memblock_phys_alloc_range()
> * Stop checking for low memory size in reserve_crashkernel_low(). The
>   allocation from limited range will anyway fail if there is no enough
>   memory, so there is no need for extra traversal of memblock.memory
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Assuming that this got or will get tested with a crash kernel:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
