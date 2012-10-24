Return-Path: <owner-linux-mm@kvack.org>
Date: Wed, 24 Oct 2012 10:30:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] mm: Fix XFS oops due to dirty pages without buffers on
 s390
Message-ID: <20121024103018.1c9039b9@mschwide>
In-Reply-To: <20121023145636.0a9b9a3e.akpm@linux-foundation.org>
References: <1350918406-11369-1-git-send-email-jack@suse.cz>
	<20121022123852.a4bd5f2a.akpm@linux-foundation.org>
	<20121023102153.GD3064@quack.suse.cz>
	<20121023145636.0a9b9a3e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>, linux-s390@vger.kernel.org, Hugh Dickins <hughd@google.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 23 Oct 2012 14:56:36 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 23 Oct 2012 12:21:53 +0200
> Jan Kara <jack@suse.cz> wrote:
> 
> > > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > 
> > > It's a bit surprising that none of the added comments mention the s390
> > > pte-dirtying oddity.  I don't see an obvious place to mention this, but
> > > I for one didn't know about this and it would be good if we could
> > > capture the info _somewhere_?
> >   As Hugh says, the comment before page_test_and_clear_dirty() is somewhat
> > updated. But do you mean recording somewhere the catch that s390 HW dirty
> > bit gets set also whenever we write to a page from kernel?
> 
> Yes, this.  It's surprising behaviour which we may trip over again, so
> how do we inform developers about it?

That is what I worry about as well. It is not the first time we tripped over
the per-page dirty bit and I guess it won't be the last time. Therefore I
created a patch to switch s390 over to fault based dirty bits, the sneak
performance test are promising. If we do not find any major performance
degradation this would be my preferred way to fix this problem for good.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
