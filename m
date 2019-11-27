Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36036 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0NyK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 27 Nov 2019 08:54:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id y10so25400259qto.3
        for <linux-s390@vger.kernel.org>; Wed, 27 Nov 2019 05:54:08 -0800 (PST)
Date: Wed, 27 Nov 2019 08:54:05 -0500
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 5/5] btrfs: Increase buffer size for zlib functions
Message-ID: <20191127135405.326hmnja2sv3k2kh@macbook-pro-91.dhcp.thefacebook.com>
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
 <20191126144130.75710-6-zaslonko@linux.ibm.com>
 <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
 <20191127121423.GQ2734@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127121423.GQ2734@suse.cz>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Mikhail Zaslonko <zaslonko@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 01:14:23PM +0100, David Sterba wrote:
> On Tue, Nov 26, 2019 at 10:52:49AM -0500, Josef Bacik wrote:
> > On Tue, Nov 26, 2019 at 03:41:30PM +0100, Mikhail Zaslonko wrote:
> > > Due to the small size of zlib buffer (1 page) set in btrfs code, s390
> > > hardware compression is rather limited in terms of performance. Increasing
> > > the buffer size to 4 pages would bring significant benefit for s390
> > > hardware compression (up to 60% better performance compared to the
> > > PAGE_SIZE buffer) and should not bring much overhead in terms of memory
> > > consumption due to order 2 allocations.
> > > 
> > > Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> > 
> > We may have to make these allocations under memory pressure in the IO context,
> > order 2 allocations here is going to be not awesome.  If you really want it then
> > you need to at least be able to fall back to single page if you fail to get the
> > allocation.  Thanks,
> 
> The allocation is only for the workspace and it does not happen on the
> IO path for each call. There's the pool and if
> 
> btrfs_get_workspace
>   alloc_workspace
> 
> fails, then there's fallback path to wait for an existing workspace to
> be free.

Only if we are maxed out, otherwise it tries to allocate.  If it can happen it
will happen, and I'll be the guy swearing in the middle of the night trying to
deal with this making boxes fall over in production.  I'm ok if we pre-allocate
them first and only do 1 page on-demand, but having it always this way will bite
us in the ass in production.  Thanks,

Josef
