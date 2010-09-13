From: Nikanth Karthikesan <knikanth@suse.de>
Date: Mon, 13 Sep 2010 10:44:47 +0000
Subject: Re: Why S390 SetPageUptodate() unconditionally clears page dirty state?
Message-Id: <201009131602.47810.knikanth@suse.de>
In-Reply-To: <20100913093817.715b89be@mschwide.boeblingen.de.ibm.com>
References: <20100913093817.715b89be@mschwide.boeblingen.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Monday 13 September 2010 13:08:17 Martin Schwidefsky wrote:
> On Mon, 13 Sep 2010 12:13:47 +0530
> 
> Nikanth Karthikesan <knikanth@suse.de> wrote:
> > On S390, the SetPageUptodate() clears the page dirty state, if page was
> > not PG_uptodate before. This seems to mark dirty pages read back from
> > swap to be marked as clean. Shouldn't page_clear_dirty() be called, only
> > if page is not flagged as dirty?
> 
> To call page_clear_dirty() only if the page is not dirty would be wrong.
> s390 keeps the dirty bit in the per-page storage key. The I/O to read a
>  page will set the per-page dirty bit. The PG_dirty bit of a page may or
>  may not be set when SetPageUptodate is called. To clear the hardware dirty
>  bit only if the software PG_dirty bit is set would result in lots of pages
>  that still have the hardware dirty bit set. Please not that on x86 the
>  dirty-bit is kept in the pte. Since a not up-to-date page can not have any
>  mapper this means that the page won't have any hardware dirty-bits set
>  (that says nothing about the software dirty bit PG_dirty). To create the
>  same state for s390 we clear the storage key unconditionally.
> 

Got it. Thanks for the explanation.

Thanks
Nikanth
