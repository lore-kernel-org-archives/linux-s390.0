Return-Path: <owner-linux-mm@kvack.org>
Date: Tue, 16 May 2017 10:36:02 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
Message-ID: <20170516083601.GB2481@dhcp22.suse.cz>
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
 <20170509181234.GA4397@dhcp22.suse.cz>
 <e19b241d-be27-3c9a-8984-2fb20211e2e1@oracle.com>
 <20170515193817.GC7551@dhcp22.suse.cz>
 <9b3d68aa-d2b6-2b02-4e75-f8372cbeb041@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b3d68aa-d2b6-2b02-4e75-f8372cbeb041@oracle.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com, davem@davemloft.net
List-ID: <linux-s390.vger.kernel.org>

On Mon 15-05-17 16:44:26, Pasha Tatashin wrote:
> On 05/15/2017 03:38 PM, Michal Hocko wrote:
> >I do not think this is the right approach. Your measurements just show
> >that sparc could have a more optimized memset for small sizes. If you
> >keep the same memset only for the parallel initialization then you
> >just hide this fact. I wouldn't worry about other architectures. All
> >sane architectures should simply work reasonably well when touching a
> >single or only few cache lines at the same time. If some arches really
> >suffer from small memsets then the initialization should be driven by a
> >specific ARCH_WANT_LARGE_PAGEBLOCK_INIT rather than making this depend
> >on DEFERRED_INIT. Or if you are too worried then make it opt-in and make
> >it depend on ARCH_WANT_PER_PAGE_INIT and make it enabled for x86 and
> >sparc after memset optimization.
> 
> OK, I will think about this.
> 
> I do not really like adding new configs because they tend to clutter the
> code. This is why,

Yes I hate adding new (arch) config options as well. And I still believe
we do not need any here either...

> I wanted to rely on already existing config that I know benefits all
> platforms that use it.

I wouldn't be so sure about this. If any other platform has a similar
issues with small memset as sparc then the overhead is just papered over
by parallel initialization.

> Eventually,
> "CONFIG_DEFERRED_STRUCT_PAGE_INIT" is going to become the default
> everywhere, as there should not be a drawback of using it even on small
> machines.

Maybe and I would highly appreciate that.
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
