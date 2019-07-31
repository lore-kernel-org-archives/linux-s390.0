Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54362 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfGaNAn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Jul 2019 09:00:43 -0400
Date: Wed, 31 Jul 2019 15:00:37 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: microblaze HAVE_MEMBLOCK_NODE_MAP dependency (was Re: [PATCH v2 0/5]
 mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA)
Message-ID: <20190731130037.GN9330@dhcp22.suse.cz>
References: <20190712121223.GR29483@dhcp22.suse.cz>
 <20190712143730.au3662g4ua2tjudu@willie-the-truck>
 <20190712150007.GU29483@dhcp22.suse.cz>
 <730368c5-1711-89ae-e3ef-65418b17ddc9@os.amperecomputing.com>
 <20190730081415.GN9330@dhcp22.suse.cz>
 <20190731062420.GC21422@rapoport-lnx>
 <20190731080309.GZ9330@dhcp22.suse.cz>
 <20190731111422.GA14538@rapoport-lnx>
 <20190731114016.GI9330@dhcp22.suse.cz>
 <20190731122631.GB14538@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731122631.GB14538@rapoport-lnx>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Hoan Tran OS <hoan@os.amperecomputing.com>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Oscar Salvador <osalvador@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>, "willy@infradead.org" <willy@infradead.org>

On Wed 31-07-19 15:26:32, Mike Rapoport wrote:
> On Wed, Jul 31, 2019 at 01:40:16PM +0200, Michal Hocko wrote:
> > On Wed 31-07-19 14:14:22, Mike Rapoport wrote:
> > > On Wed, Jul 31, 2019 at 10:03:09AM +0200, Michal Hocko wrote:
> > > > On Wed 31-07-19 09:24:21, Mike Rapoport wrote:
> > > > > [ sorry for a late reply too, somehow I missed this thread before ]
> > > > > 
> > > > > On Tue, Jul 30, 2019 at 10:14:15AM +0200, Michal Hocko wrote:
> > > > > > [Sorry for a late reply]
> > > > > > 
> > > > > > On Mon 15-07-19 17:55:07, Hoan Tran OS wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On 7/12/19 10:00 PM, Michal Hocko wrote:
> > > > > > [...]
> > > > > > > > Hmm, I thought this was selectable. But I am obviously wrong here.
> > > > > > > > Looking more closely, it seems that this is indeed only about
> > > > > > > > __early_pfn_to_nid and as such not something that should add a config
> > > > > > > > symbol. This should have been called out in the changelog though.
> > > > > > > 
> > > > > > > Yes, do you have any other comments about my patch?
> > > > > > 
> > > > > > Not really. Just make sure to explicitly state that
> > > > > > CONFIG_NODES_SPAN_OTHER_NODES is only about __early_pfn_to_nid and that
> > > > > > doesn't really deserve it's own config and can be pulled under NUMA.
> > > > > > 
> > > > > > > > Also while at it, does HAVE_MEMBLOCK_NODE_MAP fall into a similar
> > > > > > > > bucket? Do we have any NUMA architecture that doesn't enable it?
> > > > > > > > 
> > > > > 
> > > > > HAVE_MEMBLOCK_NODE_MAP makes huge difference in node/zone initialization
> > > > > sequence so it's not only about a singe function.
> > > > 
> > > > The question is whether we want to have this a config option or enable
> > > > it unconditionally for each NUMA system.
> > > 
> > > We can make it 'default NUMA', but we can't drop it completely because
> > > microblaze uses sparse_memory_present_with_active_regions() which is
> > > unavailable when HAVE_MEMBLOCK_NODE_MAP=n.
> > 
> > I suppose you mean that microblaze is using
> > sparse_memory_present_with_active_regions even without CONFIG_NUMA,
> > right?
> 
> Yes.
> 
> > I have to confess I do not understand that code. What is the deal
> > with setting node id there?
> 
> The sparse_memory_present_with_active_regions() iterates over
> memblock.memory regions and uses the node id of each region as the
> parameter to memory_present(). The assumption here is that sometime before
> each region was assigned a proper non-negative node id. 
> 
> microblaze uses device tree for memory enumeration and the current FDT code
> does memblock_add() that implicitly sets nid in memblock.memory regions to -1.
> 
> So in order to have proper node id passed to memory_present() microblaze
> has to call memblock_set_node() before it can use
> sparse_memory_present_with_active_regions().

I am sorry, but I still do not follow. Who is consuming that node id
information when NUMA=n. In other words why cannot we simply do

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index a015a951c8b7..3a47e8db8d1c 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -175,14 +175,9 @@ void __init setup_memory(void)
 
 		start_pfn = memblock_region_memory_base_pfn(reg);
 		end_pfn = memblock_region_memory_end_pfn(reg);
-		memblock_set_node(start_pfn << PAGE_SHIFT,
-				  (end_pfn - start_pfn) << PAGE_SHIFT,
-				  &memblock.memory, 0);
+		memory_present(0, start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT);
 	}
 
-	/* XXX need to clip this if using highmem? */
-	sparse_memory_present_with_active_regions(0);
-
 	paging_init();
 }
 
-- 
Michal Hocko
SUSE Labs
