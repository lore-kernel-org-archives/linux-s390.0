Return-Path: <owner-linux-mm@kvack.org>
Date: Thu, 1 Jun 2017 10:46:09 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
Message-ID: <20170601084609.GF32677@dhcp22.suse.cz>
References: <20170509181234.GA4397@dhcp22.suse.cz>
 <e19b241d-be27-3c9a-8984-2fb20211e2e1@oracle.com>
 <20170515193817.GC7551@dhcp22.suse.cz>
 <9b3d68aa-d2b6-2b02-4e75-f8372cbeb041@oracle.com>
 <20170516083601.GB2481@dhcp22.suse.cz>
 <07a6772b-711d-4fdc-f688-db76f1ec4c45@oracle.com>
 <20170529115358.GJ19725@dhcp22.suse.cz>
 <ae992f21-3edf-1ae7-41db-641052e411c7@oracle.com>
 <20170531163131.GY27783@dhcp22.suse.cz>
 <2fa60098-d9be-f57d-cb86-3b55cfe915b7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fa60098-d9be-f57d-cb86-3b55cfe915b7@oracle.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com, davem@davemloft.net
List-ID: <linux-s390.vger.kernel.org>

On Wed 31-05-17 23:35:48, Pasha Tatashin wrote:
> >OK, so why cannot we make zero_struct_page 8x 8B stores, other arches
> >would do memset. You said it would be slower but would that be
> >measurable? I am sorry to be so persistent here but I would be really
> >happier if this didn't depend on the deferred initialization. If this is
> >absolutely a no-go then I can live with that of course.
> 
> Hi Michal,
> 
> This is actually a very good idea. I just did some measurements, and it
> looks like performance is very good.
> 
> Here is data from SPARC-M7 with 3312G memory with single thread performance:
> 
> Current:
> memset() in memblock allocator takes: 8.83s
> __init_single_page() take: 8.63s
> 
> Option 1:
> memset() in __init_single_page() takes: 61.09s (as we discussed because of
> membar overhead, memset should really be optimized to do STBI only when size
> is 1 page or bigger).
> 
> Option 2:
> 
> 8 stores (stx) in __init_single_page(): 8.525s!
> 
> So, even for single thread performance we can double the initialization
> speed of "struct page" on SPARC by removing memset() from memblock, and
> using 8 stx in __init_single_page(). It appears we never miss L1 in
> __init_single_page() after the initial 8 stx.

OK, that is good to hear and it actually matches my understanding that
writes to a single cacheline should add an overhead.

Thanks!
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
