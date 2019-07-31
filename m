Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728879AbfGaRPa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Jul 2019 13:15:30 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VH7lsQ062274
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2019 13:15:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u3ekj1v1c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2019 13:15:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 31 Jul 2019 18:15:26 +0100
Date: Wed, 31 Jul 2019 20:15:11 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: microblaze HAVE_MEMBLOCK_NODE_MAP dependency (was Re: [PATCH v2
 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA)
References: <730368c5-1711-89ae-e3ef-65418b17ddc9@os.amperecomputing.com>
 <20190730081415.GN9330@dhcp22.suse.cz>
 <20190731062420.GC21422@rapoport-lnx>
 <20190731080309.GZ9330@dhcp22.suse.cz>
 <20190731111422.GA14538@rapoport-lnx>
 <20190731114016.GI9330@dhcp22.suse.cz>
 <20190731122631.GB14538@rapoport-lnx>
 <20190731130037.GN9330@dhcp22.suse.cz>
 <20190731142129.GA24998@rapoport-lnx>
 <20190731144114.GY9330@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731144114.GY9330@dhcp22.suse.cz>
Message-Id: <20190731171510.GB24998@rapoport-lnx>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Hoan Tran OS <hoan@os.amperecomputing.com>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Oscar Salvador <osalvador@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>, "willy@infradead.org" <willy@infradead.org>

On Wed, Jul 31, 2019 at 04:41:14PM +0200, Michal Hocko wrote:
> On Wed 31-07-19 17:21:29, Mike Rapoport wrote:
> > On Wed, Jul 31, 2019 at 03:00:37PM +0200, Michal Hocko wrote:
> > > 
> > > I am sorry, but I still do not follow. Who is consuming that node id
> > > information when NUMA=n. In other words why cannot we simply do
> >  
> > We can, I think nobody cared to change it.
> 
> It would be great if somebody with the actual HW could try it out.
> I can throw a patch but I do not even have a cross compiler in my
> toolbox.

Well, it compiles :)
 
> > > diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> > > index a015a951c8b7..3a47e8db8d1c 100644
> > > --- a/arch/microblaze/mm/init.c
> > > +++ b/arch/microblaze/mm/init.c
> > > @@ -175,14 +175,9 @@ void __init setup_memory(void)
> > >  
> > >  		start_pfn = memblock_region_memory_base_pfn(reg);
> > >  		end_pfn = memblock_region_memory_end_pfn(reg);
> > > -		memblock_set_node(start_pfn << PAGE_SHIFT,
> > > -				  (end_pfn - start_pfn) << PAGE_SHIFT,
> > > -				  &memblock.memory, 0);
> > > +		memory_present(0, start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT);
> > 
> > memory_present() expects pfns, the shift is not needed.
> 
> Right.
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.
