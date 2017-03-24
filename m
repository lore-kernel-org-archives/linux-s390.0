Return-Path: <owner-linux-mm@kvack.org>
Date: Fri, 24 Mar 2017 10:35:55 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [v1 0/5] parallelized "struct page" zeroing
References: <1490310113-824438-1-git-send-email-pasha.tatashin@oracle.com>
 <341568c3-0473-860f-aa20-63723aa40b87@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <341568c3-0473-860f-aa20-63723aa40b87@de.ibm.com>
Message-Id: <20170324093555.GB5891@osiris>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Mar 24, 2017 at 09:51:09AM +0100, Christian Borntraeger wrote:
> On 03/24/2017 12:01 AM, Pavel Tatashin wrote:
> > When deferred struct page initialization feature is enabled, we get a
> > performance gain of initializing vmemmap in parallel after other CPUs are
> > started. However, we still zero the memory for vmemmap using one boot CPU.
> > This patch-set fixes the memset-zeroing limitation by deferring it as well.
> > 
> > Here is example performance gain on SPARC with 32T:
> > base
> > https://hastebin.com/ozanelatat.go
> > 
> > fix
> > https://hastebin.com/utonawukof.go
> > 
> > As you can see without the fix it takes: 97.89s to boot
> > With the fix it takes: 46.91 to boot.
> > 
> > On x86 time saving is going to be even greater (proportionally to memory size)
> > because there are twice as many "struct page"es for the same amount of memory,
> > as base pages are twice smaller.
> 
> Fixing the linux-s390 mailing list email.
> This might be useful for s390 as well.

Unfortunately only for the fake numa case, since as far as I understand it,
parallelization happens only on a node granularity. And since we are
usually only having one node...

But anyway, it won't hurt to set ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT on
s390 also. I'll do some testing and then we'll see.

Pavel, could you please change your patch 5 so it also converts the s390
call sites of vmemmap_alloc_block() so they use VMEMMAP_ZERO instead of
'true' as argument?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
