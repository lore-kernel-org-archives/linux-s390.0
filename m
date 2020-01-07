Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbgAGObL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 7 Jan 2020 09:31:11 -0500
Date: Tue, 7 Jan 2020 15:30:59 +0100
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v3 6/6] btrfs: Use larger zlib buffer for s390 hardware
 compression
Message-ID: <20200107143058.GU3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20200103223334.20669-1-zaslonko@linux.ibm.com>
 <20200103223334.20669-7-zaslonko@linux.ibm.com>
 <20200106184305.GT3929@suse.cz>
 <664c2bbd-e06f-a4b3-fe21-982954b6330c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <664c2bbd-e06f-a4b3-fe21-982954b6330c@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eduard Shishkin <edward6@linux.ibm.com>
Cc: dsterba@suse.cz, Mikhail Zaslonko <zaslonko@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 01:18:06AM +0100, Eduard Shishkin wrote:
> >> @@ -61,7 +64,17 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
> >>   			zlib_inflate_workspacesize());
> >>   	workspace->strm.workspace = kvmalloc(workspacesize, GFP_KERNEL);
> >>   	workspace->level = level;
> >> -	workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> >> +	workspace->buf = NULL;
> >> +	if (zlib_deflate_dfltcc_enabled()) {
> >> +		workspace->buf = kmalloc(ZLIB_DFLTCC_BUF_SIZE,
> >> +					 __GFP_NOMEMALLOC | __GFP_NORETRY |
> >> +					 __GFP_NOWARN | GFP_NOIO);
> > Why do you use this wild GFP flag combination? I can understand NOWARN,
> > but why the others?
> 
> This addresses the following complaint about order 2 allocation with 
> GFP_KERNEL:
> https://lkml.org/lkml/2019/11/26/417
> 
> Below a fallback to a single page is implemented, as it was suggested.
> So, the initial (more costly) allocation should be made with minimal 
> aggression
> to allow the allocator fail. Otherwise, that fallback simply doesn't 
> make sense.
> Hence, such a combination.

I see, please add a comment explaining that.
