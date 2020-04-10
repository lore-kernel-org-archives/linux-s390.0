Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41778 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725858AbgDJGuy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Apr 2020 02:50:54 -0400
Date: Fri, 10 Apr 2020 14:50:39 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Message-ID: <20200410065039.GG2129@MiWiFi-R3L-srv>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200330074246.GA14243@dhcp22.suse.cz>
 <20200330175100.GD30942@linux.ibm.com>
 <20200330182301.GM14243@dhcp22.suse.cz>
 <20200331081423.GE30942@linux.ibm.com>
 <20200331085513.GE30449@dhcp22.suse.cz>
 <20200331140332.GA2129@MiWiFi-R3L-srv>
 <20200331142138.GL30449@dhcp22.suse.cz>
 <20200409162741.GA9387@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409162741.GA9387@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Michal Hocko <mhocko@kernel.org>, Hoan Tran <Hoan@os.amperecomputing.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, lho@amperecomputing.com, mmorana@amperecomputing.com

On 04/09/20 at 07:27pm, Mike Rapoport wrote:
> On Tue, Mar 31, 2020 at 04:21:38PM +0200, Michal Hocko wrote:
> > On Tue 31-03-20 22:03:32, Baoquan He wrote:
> > > Hi Michal,
> > > 
> > > On 03/31/20 at 10:55am, Michal Hocko wrote:
> > > > On Tue 31-03-20 11:14:23, Mike Rapoport wrote:
> > > > > Maybe I mis-read the code, but I don't see how this could happen. In the
> > > > > HAVE_MEMBLOCK_NODE_MAP=y case, free_area_init_node() calls
> > > > > calculate_node_totalpages() that ensures that node->node_zones are entirely
> > > > > within the node because this is checked in zone_spanned_pages_in_node().
> > > > 
> > > > zone_spanned_pages_in_node does chech the zone boundaries are within the
> > > > node boundaries. But that doesn't really tell anything about other
> > > > potential zones interleaving with the physical memory range.
> > > > zone->spanned_pages simply gives the physical range for the zone
> > > > including holes. Interleaving nodes are essentially a hole
> > > > (__absent_pages_in_range is going to skip those).
> > > > 
> > > > That means that when free_area_init_core simply goes over the whole
> > > > physical zone range including holes and that is why we need to check
> > > > both for physical and logical holes (aka other nodes).
> > > > 
> > > > The life would be so much easier if the whole thing would simply iterate
> > > > over memblocks...
> > > 
> > > The memblock iterating sounds a great idea. I tried with putting the
> > > memblock iterating in the upper layer, memmap_init(), which is used for
> > > boot mem only anyway. Do you think it's doable and OK? It yes, I can
> > > work out a formal patch to make this simpler as you said. The draft code
> > > is as below. Like this it uses the existing code and involves little change.
> > 
> > Doing this would be a step in the right direction! I haven't checked the
> > code very closely though. The below sounds way too simple to be truth I
> > am afraid. First for_each_mem_pfn_range is available only for
> > CONFIG_HAVE_MEMBLOCK_NODE_MAP (which is one of the reasons why I keep
> > saying that I really hate that being conditional). Also I haven't really
> > checked the deferred initialization path - I have a very vague
> > recollection that it has been converted to the memblock api but I have
> > happilly dropped all that memory.
> 
> The Baoquan's patch almost did it, at least for simple case of qemu with 2
> nodes. It's only missing the adjustment to the size passed to
> memmap_init_zone() as it may change because of clamping.

Right, the size need be adjusted after start and end clamping.

> 
> I've drafted something that removes HAVE_MEMBLOCK_NODE_MAP and added this
> patch there [1]. For several memory configurations I could emulate with
> qemu it worked.
> I'm going to wait a bit to see of kbuild is happy and then I'll send the
> patches.
> 
> Baoquan, I took liberty to add your SoB, hope you don't mind.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=memblock/all-have-node-map 

Of course not. Thanks for doing this, and look forward to seeing your
formal patchset posting when it's ready.

>   
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 138a56c0f48f..558d421f294b 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -6007,14 +6007,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> > >  		 * function.  They do not exist on hotplugged memory.
> > >  		 */
> > >  		if (context == MEMMAP_EARLY) {
> > > -			if (!early_pfn_valid(pfn)) {
> > > -				pfn = next_pfn(pfn);
> > > -				continue;
> > > -			}
> > > -			if (!early_pfn_in_nid(pfn, nid)) {
> > > -				pfn++;
> > > -				continue;
> > > -			}
> > >  			if (overlap_memmap_init(zone, &pfn))
> > >  				continue;
> > >  			if (defer_init(nid, pfn, end_pfn))
> > > @@ -6130,9 +6122,17 @@ static void __meminit zone_init_free_lists(struct zone *zone)
> > >  }
> > >  
> > >  void __meminit __weak memmap_init(unsigned long size, int nid,
> > > -				  unsigned long zone, unsigned long start_pfn)
> > > +				  unsigned long zone, unsigned long range_start_pfn)
> > >  {
> > > -	memmap_init_zone(size, nid, zone, start_pfn, MEMMAP_EARLY, NULL);
> > > +	unsigned long start_pfn, end_pfn;
> > > +	unsigned long range_end_pfn = range_start_pfn + size;
> > > +	int i;
> > > +	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> > > +		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
> > > +		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
> > > +		if (end_pfn > start_pfn)
> > > +			memmap_init_zone(size, nid, zone, start_pfn, MEMMAP_EARLY, NULL);
> > > +	}
> > >  }
> > >  
> > >  static int zone_batchsize(struct zone *zone)
> > 
> > -- 
> > Michal Hocko
> > SUSE Labs
> 
> -- 
> Sincerely yours,
> Mike.
> 
> 
