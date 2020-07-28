Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgG1IJ5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Jul 2020 04:09:57 -0400
MIME-Version: 1.0
References: <20200728051153.1590-1-rppt@kernel.org> <20200728051153.1590-4-rppt@kernel.org>
In-Reply-To: <20200728051153.1590-4-rppt@kernel.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 28 Jul 2020 01:09:45 -0700
Message-ID: <CAMo8Bf+VKHmAm1GV=0D9Um2mpsxjnwp9WrAJq_eKW1MK+_8r6g@mail.gmail.com>
Subject: Re: [PATCH 03/15] arm, xtensa: simplify initialization of high memory pages
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, clang-built-linux@googlegroups.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org, "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>

On Mon, Jul 27, 2020 at 10:12 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> The function free_highpages() in both arm and xtensa essentially open-code
> for_each_free_mem_range() loop to detect high memory pages that were not
> reserved and that should be initialized and passed to the buddy allocator.
>
> Replace open-coded implementation of for_each_free_mem_range() with usage
> of memblock API to simplify the code.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm/mm/init.c    | 48 +++++++------------------------------
>  arch/xtensa/mm/init.c | 55 ++++++++-----------------------------------
>  2 files changed, 18 insertions(+), 85 deletions(-)

For the xtensa part:
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
