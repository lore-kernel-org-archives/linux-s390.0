Return-Path: <owner-linux-mm@kvack.org>
Date: Wed, 18 Apr 2012 20:29:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC PATCH] s390: mm: rmap: Transfer storage key to struct page
 under the page lock
Message-ID: <20120418202949.13c484f1@de.ibm.com>
In-Reply-To: <20120418152831.GK2359@suse.de>
References: <20120416141423.GD2359@suse.de>
	<alpine.LSU.2.00.1204161332120.1675@eggly.anvils>
	<20120417122202.GF2359@suse.de>
	<alpine.LSU.2.00.1204172023390.1609@eggly.anvils>
	<20120418152831.GK2359@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Mel Gorman <mgorman@suse.de>
Cc: Hugh Dickins <hughd@google.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rik van Riel <riel@redhat.com>, Ken Chen <kenchen@google.com>, Linux-MM <linux-mm@kvack.org>, Linux-S390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 18 Apr 2012 16:28:31 +0100
Mel Gorman <mgorman@suse.de> wrote:

> > <SNIP>
> >
> > [PATCH] mm: fix s390 BUG by using __set_page_dirty_no_writeback on swap
> > 
> > Mel reports a BUG_ON(slot == NULL) in radix_tree_tag_set() on s390 3.0.13:
> > called from __set_page_dirty_nobuffers() when page_remove_rmap() tries to
> > transfer dirty flag from s390 storage key to struct page and radix_tree.
> > 
> > That would be because of reclaim's shrink_page_list() calling add_to_swap()
> > on this page at the same time: first PageSwapCache is set (causing
> > page_mapping(page) to appear as &swapper_space), then page->private set,
> > then tree_lock taken, then page inserted into radix_tree - so there's
> > an interval before taking the lock when the radix_tree slot is empty.
> > 
> 
> Yes, makes sense.
> 
> > We could fix this by moving __add_to_swap_cache()'s spin_lock_irq up
> > before SetPageSwapCache, with error case ClearPageSwapCache moved up
> > under tree_lock too.
> > 
> 
> This can be done if/when swapper_space can make proper use of the dirty
> tag information.
> 
> > But a better fix is just to do what's five years overdue.  Ken Chen
> > added __set_page_dirty_no_writeback() (if !PageDirty TestSetPageDirty)
> > for tmpfs to skip all that radix_tree overhead, and swap is just the same:
> > it ignores the radix_tree tag, and does not participate in dirty page
> > accounting, so should be using __set_page_dirty_no_writeback() too.
> > 
> > Reported-by: Mel Gorman <mgorman@suse.de>
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> Acked-by: Mel Gorman <mgorman@suse.de>
> 
> I've sent a kernel based on this patch to the s390 folk that originally
> reported the bug. Hopefully they'll test and get back to me in a few
> days.
> 
> Thanks Hugh.

Indeed, thanks Hugh. The patches so far were not pretty at all.. 


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
