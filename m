Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbfGaLOk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Jul 2019 07:14:40 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VBCxL8081628
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2019 07:14:40 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u36wrgxyy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2019 07:14:39 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 31 Jul 2019 12:14:36 +0100
Date: Wed, 31 Jul 2019 14:14:22 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
References: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
 <20190712070247.GM29483@dhcp22.suse.cz>
 <586ae736-a429-cf94-1520-1a94ffadad88@os.amperecomputing.com>
 <20190712121223.GR29483@dhcp22.suse.cz>
 <20190712143730.au3662g4ua2tjudu@willie-the-truck>
 <20190712150007.GU29483@dhcp22.suse.cz>
 <730368c5-1711-89ae-e3ef-65418b17ddc9@os.amperecomputing.com>
 <20190730081415.GN9330@dhcp22.suse.cz>
 <20190731062420.GC21422@rapoport-lnx>
 <20190731080309.GZ9330@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731080309.GZ9330@dhcp22.suse.cz>
Message-Id: <20190731111422.GA14538@rapoport-lnx>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Hoan Tran OS <hoan@os.amperecomputing.com>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Oscar Salvador <osalvador@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>, "willy@infradead.org" <willy@infradead.org>

On Wed, Jul 31, 2019 at 10:03:09AM +0200, Michal Hocko wrote:
> On Wed 31-07-19 09:24:21, Mike Rapoport wrote:
> > [ sorry for a late reply too, somehow I missed this thread before ]
> > 
> > On Tue, Jul 30, 2019 at 10:14:15AM +0200, Michal Hocko wrote:
> > > [Sorry for a late reply]
> > > 
> > > On Mon 15-07-19 17:55:07, Hoan Tran OS wrote:
> > > > Hi,
> > > > 
> > > > On 7/12/19 10:00 PM, Michal Hocko wrote:
> > > [...]
> > > > > Hmm, I thought this was selectable. But I am obviously wrong here.
> > > > > Looking more closely, it seems that this is indeed only about
> > > > > __early_pfn_to_nid and as such not something that should add a config
> > > > > symbol. This should have been called out in the changelog though.
> > > > 
> > > > Yes, do you have any other comments about my patch?
> > > 
> > > Not really. Just make sure to explicitly state that
> > > CONFIG_NODES_SPAN_OTHER_NODES is only about __early_pfn_to_nid and that
> > > doesn't really deserve it's own config and can be pulled under NUMA.
> > > 
> > > > > Also while at it, does HAVE_MEMBLOCK_NODE_MAP fall into a similar
> > > > > bucket? Do we have any NUMA architecture that doesn't enable it?
> > > > > 
> > 
> > HAVE_MEMBLOCK_NODE_MAP makes huge difference in node/zone initialization
> > sequence so it's not only about a singe function.
> 
> The question is whether we want to have this a config option or enable
> it unconditionally for each NUMA system.

We can make it 'default NUMA', but we can't drop it completely because
microblaze uses sparse_memory_present_with_active_regions() which is
unavailable when HAVE_MEMBLOCK_NODE_MAP=n.

> > > > As I checked with arch Kconfig files, there are 2 architectures, riscv 
> > > > and microblaze, do not support NUMA but enable this config.
> > 
> > My take would be that riscv will support NUMA some day.
> >  
> > > > And 1 architecture, alpha, supports NUMA but does not enable this config.
> > 
> > alpha's NUMA support is BROKEN for more than a decade now, I doubt it'll
> > ever get fixed.
> 
> I can see Al has marked it BROKEN in 2005. Maybe time to rip it out?
> Although it doesn't seem to be a lot of code in arch/alpha at first
> glance so maybe not worth an effort.
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.
