Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50336 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbfGLPAL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 11:00:11 -0400
Date: Fri, 12 Jul 2019 17:00:07 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Message-ID: <20190712150007.GU29483@dhcp22.suse.cz>
References: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
 <20190712070247.GM29483@dhcp22.suse.cz>
 <586ae736-a429-cf94-1520-1a94ffadad88@os.amperecomputing.com>
 <20190712121223.GR29483@dhcp22.suse.cz>
 <20190712143730.au3662g4ua2tjudu@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712143730.au3662g4ua2tjudu@willie-the-truck>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Hoan Tran OS <hoan@os.amperecomputing.com>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Oscar Salvador <osalvador@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>, willy@infradead.org

On Fri 12-07-19 15:37:30, Will Deacon wrote:
> Hi all,
> 
> On Fri, Jul 12, 2019 at 02:12:23PM +0200, Michal Hocko wrote:
> > On Fri 12-07-19 10:56:47, Hoan Tran OS wrote:
> > [...]
> > > It would be good if we can enable it by-default. Otherwise, let arch 
> > > enables it by them-self. Do you have any suggestions?
> > 
> > I can hardly make any suggestions when it is not really clear _why_ you
> > want to remove this config option in the first place. Please explain
> > what motivated you to make this change.
> 
> Sorry, I think this confusion might actually be my fault and Hoan has just
> been implementing my vague suggestion here:
> 
> https://lore.kernel.org/linux-arm-kernel/20190625101245.s4vxfosoop52gl4e@willie-the-truck/
> 
> If the preference of the mm folks is to leave CONFIG_NODES_SPAN_OTHER_NODES
> as it is, then we can define it for arm64. I just find it a bit weird that
> the majority of NUMA-capable architectures have to add a symbol in the arch
> Kconfig file, for what appears to be a performance optimisation applicable
> only to ia64, mips and sh.
> 
> At the very least we could make the thing selectable.

Hmm, I thought this was selectable. But I am obviously wrong here.
Looking more closely, it seems that this is indeed only about
__early_pfn_to_nid and as such not something that should add a config
symbol. This should have been called out in the changelog though.

Also while at it, does HAVE_MEMBLOCK_NODE_MAP fall into a similar
bucket? Do we have any NUMA architecture that doesn't enable it?

Thanks!
-- 
Michal Hocko
SUSE Labs
