Return-Path: <linux-kernel-owner+w=401wt.eu-S1757166AbYDDQpv@vger.kernel.org>
Subject: [PATCH 0/3] hugetlbfs: cleanup and new primitives for s390, v3
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Content-Type: text/plain
Date: Fri, 04 Apr 2008 18:45:34 +0200
Message-Id: <1207327534.4605.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Paul Mundt <lethal@linux-sh.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-04-03 at 14:43 -0700, Andrew Morton wrote: 
> So basically the existing hugetlb arch support code needs a big de-macro
> crapectomy.  But your patch has gone and massively duplicated the existing
> crap, making that decrapectomy larger and harder.

ok, all good things come in threes I guess, so here is a new patchset that
also does the de-macro crapectomy. All macros are now replaced with inline
functions, which increased the total loc again by some amount.

This patchset cleans up hugetlbfs architecture headers and adds new
primitives as preparation for the s390 large page support. Most notably
we found that we need to add a new tlb flush for the copy-on-write of
a large page (patch 2/3). We think that this is a bug, but obviously one
that hasn't shown up so far on any of the other large page architectures.

Cross-Compile tests on the affected architectures (and one unaffected)
worked fine, but I had no cross-compiler for sh.

--
Gerald Schaefer
