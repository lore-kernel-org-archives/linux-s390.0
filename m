Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45535 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728383AbgC3J0U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 05:26:20 -0400
Date: Mon, 30 Mar 2020 17:26:06 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Message-ID: <20200330092606.GC6352@MiWiFi-R3L-srv>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200330074246.GA14243@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330074246.GA14243@dhcp22.suse.cz>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Hoan Tran <Hoan@os.amperecomputing.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, lho@amperecomputing.com, mmorana@amperecomputing.com

On 03/30/20 at 09:42am, Michal Hocko wrote:
> On Sat 28-03-20 11:31:17, Hoan Tran wrote:
> > In NUMA layout which nodes have memory ranges that span across other nodes,
> > the mm driver can detect the memory node id incorrectly.
> > 
> > For example, with layout below
> > Node 0 address: 0000 xxxx 0000 xxxx
> > Node 1 address: xxxx 1111 xxxx 1111
> > 
> > Note:
> >  - Memory from low to high
> >  - 0/1: Node id
> >  - x: Invalid memory of a node
> > 
> > When mm probes the memory map, without CONFIG_NODES_SPAN_OTHER_NODES
> > config, mm only checks the memory validity but not the node id.
> > Because of that, Node 1 also detects the memory from node 0 as below
> > when it scans from the start address to the end address of node 1.
> > 
> > Node 0 address: 0000 xxxx xxxx xxxx
> > Node 1 address: xxxx 1111 1111 1111
> > 
> > This layout could occur on any architecture. Most of them enables
> > this config by default with CONFIG_NUMA. This patch, by default, enables
> > CONFIG_NODES_SPAN_OTHER_NODES or uses early_pfn_in_nid() for NUMA.
> 
> I am not opposed to this at all. It reduces the config space and that is
> a good thing on its own. The history has shown that meory layout might
> be really wild wrt NUMA. The config is only used for early_pfn_in_nid
> which is clearly an overkill.
> 
> Your description doesn't really explain why this is safe though. The
> history of this config is somehow messy, though. Mike has tried
> to remove it a94b3ab7eab4 ("[PATCH] mm: remove arch independent
> NODES_SPAN_OTHER_NODES") just to be reintroduced by 7516795739bd
> ("[PATCH] Reintroduce NODES_SPAN_OTHER_NODES for powerpc") without any
> reasoning what so ever. This doesn't make it really easy see whether
> reasons for reintroduction are still there. Maybe there are some subtle
> dependencies. I do not see any TBH but that might be burried deep in an
> arch specific code.

Since on all ARCHes NODES_SPAN_OTHER_NODES has dependency on NUMA,
replacing it with CONFIG_NUMA seems no risk. Just for those ARCHes which
don't have CONFIG_NODES_SPAN_OTHER_NODES before, it involves a tiny
performance degradation. Besides, s390 has removed support of
NODES_SPAN_OTHER_NODES already.

commit 701dc81e7412daaf3c5bf4bc55d35c8b1525112a
Author: Heiko Carstens <heiko.carstens@de.ibm.com>
Date:   Wed Feb 19 13:29:15 2020 +0100

    s390/mm: remove fake numa support

> 
> > v3:
> >  * Revise the patch description
> > 
> > V2:
> >  * Revise the patch description
> > 
> > Hoan Tran (5):
> >   mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
> >   powerpc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
> >   x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
> >   sparc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
> >   s390: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
> > 
> >  arch/powerpc/Kconfig | 9 ---------
> >  arch/s390/Kconfig    | 8 --------
> >  arch/sparc/Kconfig   | 9 ---------
> >  arch/x86/Kconfig     | 9 ---------
> >  mm/page_alloc.c      | 2 +-
> >  5 files changed, 1 insertion(+), 36 deletions(-)
> > 
> > -- 
> > 1.8.3.1
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
> 
