Return-Path: <linux-kernel-owner+w=401wt.eu-S1755074AbYC1QEW@vger.kernel.org>
Date: Fri, 28 Mar 2008 17:03:38 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 09/10] Hugetlb common code update for System z.
Message-ID: <20080328160338.GA5687@elte.hu>
References: <20080312173155.703966894@de.ibm.com> <20080312173218.186436562@de.ibm.com> <1205344286.9828.91.camel@nimitz.home.sr71.net> <1205363937.5237.60.camel@localhost.localdomain> <20080312164303.cac9cab5.akpm@linux-foundation.org> <1206713119.5186.52.camel@localhost.localdomain> <20080328140634.GA29218@elte.hu> <1206719599.6592.10.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1206719599.6592.10.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, haveblue@us.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Paul Mundt <lethal@linux-sh.org>
List-ID: <linux-s390.vger.kernel.org>


* Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> > >  include/asm-sh/hugetlb.h      |   28 +++++++++++++++++++++++++
> > >  include/asm-sparc64/hugetlb.h |   30 +++++++++++++++++++++++++++
> > >  include/asm-x86/hugetlb.h     |   28 +++++++++++++++++++++++++
> > 
> > these seem largely duplicated - shouldnt there be an 
> > asm-generic/hugetlb.h instead, which asm/hugetlb.h could include to 
> > get default behavior? It would probably reduce the linecount of your 
> > patch as well.
> 
> Well the hugetlbfs primitives are architecture specific, aren't they? 
> Just like the other page table manipulation functions. I find the 
> usual method to use asm-generic/<xxx> and a lot of defines and #ifdefs 
> to pick up the correct definition from a generic header file rather 
> hard to read. In the end each arch that wants to use hugetlbfs has to 
> define each of the hugetlb primitives. Most of them are rather simple, 
> e.g. the x86 set_huge_pte_at is just a set_pte_at. One line to define 
> the primitive. Now we could have an #ifdef block around the default 
> definition that maps set_huge_pte_at to set_pte_at in asm-generic and 
> an ARCH_HAS_xx override for architecture that need to do something 
> more complicated. Somehow that was where we started .. I think the 
> best way to get rid of the ARCH_HAS_xxx fugliness is to let each 
> architecture define their primitives, even if it looks like code 
> duplication.

sorry, i misread your patch - it indeed looks cleaner with your patch 
applied.

	Ingo
