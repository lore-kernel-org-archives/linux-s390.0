Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:57282 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbgB0RzM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 12:55:12 -0500
References: <20200221182503.28317-1-logang@deltatee.com>
 <20200227171704.GK31668@ziepe.ca>
 <e8781f85-3fc7-b9ce-c751-606803cbdc77@deltatee.com>
 <20200227174311.GL31668@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7e573498-81c1-7f00-c1ff-ed16e12a5b96@deltatee.com>
Date: Thu, 27 Feb 2020 10:54:40 -0700
MIME-Version: 1.0
In-Reply-To: <20200227174311.GL31668@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/7] Allow setting caching mode in arch_add_memory()
 for P2PDMA
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Eric Badger <ebadger@gigaio.com>



On 2020-02-27 10:43 a.m., Jason Gunthorpe wrote:
> Hm, AFAIK WC memory is not compatible with the spinlocks/mutexs/etc in
> Linux, so while it is true the memory has no side effects, there would
> be surprising concurrency risks if anything in the kernel tried to
> write to it.
> 
> Not compatible means the locks don't contain stores to WC memory the
> way you would expect. AFAIK on many CPUs extra barriers are required
> to keep WC stores ordered, the same way ARM already has extra barriers
> to keep UC stores ordered with locking..
> 
> The spinlocks are defined to contain UC stores though.
> 
> If there is no actual need today for WC I would suggest using UC as
> the default.

Ok, that sounds sensible. I'll do that in the next revision.

Thanks,

Logan
