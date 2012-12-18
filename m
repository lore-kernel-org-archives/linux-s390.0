Return-Path: <owner-linux-mm@kvack.org>
Date: Tue, 18 Dec 2012 08:30:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] mm: Fix XFS oops due to dirty pages without buffers on
 s390
Message-ID: <20121218083041.06f80d17@mschwide>
In-Reply-To: <alpine.LNX.2.00.1212171459090.26086@eggly.anvils>
References: <1350918406-11369-1-git-send-email-jack@suse.cz>
	<20121022123852.a4bd5f2a.akpm@linux-foundation.org>
	<20121023102153.GD3064@quack.suse.cz>
	<20121023145636.0a9b9a3e.akpm@linux-foundation.org>
	<20121025200141.GF3262@quack.suse.cz>
	<20121214094505.0163bda6@mschwide>
	<alpine.LNX.2.00.1212171459090.26086@eggly.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Hugh Dickins <hughd@google.com>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 17 Dec 2012 15:31:47 -0800 (PST)
Hugh Dickins <hughd@google.com> wrote:

> On Fri, 14 Dec 2012, Martin Schwidefsky wrote:
> > 
> > The patch got delayed a bit,
> 
> Thanks a lot for finding the time to do this:
> I never expected it to get priority.
> 
> > the main issue is to get conclusive performance
> > measurements about the effects of the patch. I am pretty sure that the patch
> > works and will not cause any major degradation so it is time to ask for your
> > opinion. Here we go:
> 
> If if works reliably and efficiently for you on s390, then I'm strongly in
> favour of it; and I cannot imagine who would not be - it removes several
> hunks of surprising and poorly understood code from the generic mm end.
> 
> I'm slightly disappointed to be reminded of page_test_and_clear_young(),
> and find it still there; but it's been an order of magnitude less
> troubling than the _dirty, so not worth more effort I guess.

To remove the dependency on the referenced-bit in the storage key would
require to set the invalid bit on the pte until the first access has been
done. Then the referenced bit would have to be set and a valid pte can
be established. That would be costly, because we would get a lot more
program checks on the invalid, old ptes. So the page_test_and_clear_young
needs to stay. The situation for the referenced bits is much more relaxed
though, we can afford to loose the one of the other referenced bit
without ill effect. I would not worry about page_test_and_clear_young
too much.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
