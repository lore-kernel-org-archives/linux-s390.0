Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbgF2SpP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Jun 2020 14:45:15 -0400
Date: Mon, 29 Jun 2020 18:59:20 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 4/8] asm-generic: pgalloc: provide generic
 pmd_alloc_one() and pmd_free_one()
Message-ID: <20200629155920.GD1492837@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
 <20200627143453.31835-5-rppt@kernel.org>
 <20200627190304.GG25039@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627190304.GG25039@casper.infradead.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Joerg Roedel <joro@8bytes.org>, Max Filippov <jcmvbkbc@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Stafford Horne <shorne@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org

On Sat, Jun 27, 2020 at 08:03:04PM +0100, Matthew Wilcox wrote:
> On Sat, Jun 27, 2020 at 05:34:49PM +0300, Mike Rapoport wrote:
> > More elaborate versions on arm64 and x86 account memory for the user page
> > tables and call to pgtable_pmd_page_ctor() as the part of PMD page
> > initialization.
> > 
> > Move the arm64 version to include/asm-generic/pgalloc.h and use the generic
> > version on several architectures.
> > 
> > The pgtable_pmd_page_ctor() is a NOP when ARCH_ENABLE_SPLIT_PMD_PTLOCK is
> > not enabled, so there is no functional change for most architectures except
> > of the addition of __GFP_ACCOUNT for allocation of user page tables.
> 
> Thanks for including this line; it reminded me that we're not setting
> the PageTable flag on the page, nor accounting it to the zone page stats.
> Hope you don't mind me tagging a patch to do that on as 9/8.

We also never set PageTable flag for early page tables and for the page
tables allocated directly with get_free_page(), e.g PTI, KASAN.

> We could also do with a pud_page_[cd]tor and maybe even p4d/pgd versions.
> But that brings me to the next question -- could/should some of this
> be moved over to asm-generic/pgalloc.h?  The ctor/dtor aren't called
> from anywhere else, and there's value to reducing the total amount of
> code in mm.h, but then there's also value to keeping all the ifdef
> ARCH_ENABLE_SPLIT_PMD_PTLOCK code together too.  So I'm a bit torn.
> What do you think?

-- 
Sincerely yours,
Mike.
