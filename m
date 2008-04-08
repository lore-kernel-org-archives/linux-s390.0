Return-Path: <linux-kernel-owner+w=401wt.eu-S1751121AbYDHEAG@vger.kernel.org>
Date: Mon, 7 Apr 2008 20:59:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] hugetlbfs: architecture header cleanup
Message-Id: <20080407205906.25bd06c6.akpm@linux-foundation.org>
In-Reply-To: <1207327790.4605.21.camel@localhost.localdomain>
References: <1207327534.4605.18.camel@localhost.localdomain>
	<1207327790.4605.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Paul Mundt <lethal@linux-sh.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 04 Apr 2008 18:49:50 +0200 Gerald Schaefer <gerald.schaefer@de.ibm.com> wrote:

> Subject: [PATCH 1/3] hugetlbfs: architecture header cleanup
> 
> From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> 
> This patch moves all architecture functions for hugetlb to architecture
> header files (include/asm-foo/hugetlb.h) and converts all macros to inline
> functions. It also removes (!) ARCH_HAS_HUGEPAGE_ONLY_RANGE,
> ARCH_HAS_HUGETLB_FREE_PGD_RANGE, ARCH_HAS_PREPARE_HUGEPAGE_RANGE,
> ARCH_HAS_SETCLEAR_HUGE_PTE and ARCH_HAS_HUGETLB_PREFAULT_HOOK.
> 
> Getting rid of the ARCH_HAS_xxx #ifdef and macro fugliness should increase
> readability and maintainability, at the price of some code duplication.
> An asm-generic common part would have reduced the loc, but we would end up
> with new ARCH_HAS_xxx defines eventually.
> 
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> ---
> 
>  include/asm-ia64/hugetlb.h    |   37 +++++++++++++++++++++++++++++++
>  include/asm-ia64/page.h       |    6 -----
>  include/asm-powerpc/hugetlb.h |   37 +++++++++++++++++++++++++++++++
>  include/asm-powerpc/page_64.h |    7 ------
>  include/asm-sh/hugetlb.h      |   49 ++++++++++++++++++++++++++++++++++++++++++
>  include/asm-sparc64/hugetlb.h |   42 ++++++++++++++++++++++++++++++++++++
>  include/asm-sparc64/page.h    |    2 -
>  include/asm-x86/hugetlb.h     |   49 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/hugetlb.h       |   46 ---------------------------------------

Seem that git-s390 is currently carrying the old versions of these patches.

I'll drop git-s390.  Which will presumably kick off a cascade of droppages
due to git-s390 versus git-kvm damage control.  All of which will need to
be undropped in some fashion when those trees come to their senses.  Ho
hum.
