Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33883 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0Nuq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 27 Nov 2019 08:50:46 -0500
Received: by mail-qt1-f193.google.com with SMTP id i17so25407011qtq.1
        for <linux-s390@vger.kernel.org>; Wed, 27 Nov 2019 05:50:46 -0800 (PST)
Date: Wed, 27 Nov 2019 08:50:43 -0500
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 5/5] btrfs: Increase buffer size for zlib functions
Message-ID: <20191127135043.6hqadevwkfeqyv2p@macbook-pro-91.dhcp.thefacebook.com>
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
 <20191126144130.75710-6-zaslonko@linux.ibm.com>
 <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
 <11377b99-b66c-fdc3-5c8f-0bae34c92c03@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11377b99-b66c-fdc3-5c8f-0bae34c92c03@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 02:42:20PM +0100, Zaslonko Mikhail wrote:
> Hello,
> 
> On 26.11.2019 16:52, Josef Bacik wrote:
> > On Tue, Nov 26, 2019 at 03:41:30PM +0100, Mikhail Zaslonko wrote:
> >> Due to the small size of zlib buffer (1 page) set in btrfs code, s390
> >> hardware compression is rather limited in terms of performance. Increasing
> >> the buffer size to 4 pages would bring significant benefit for s390
> >> hardware compression (up to 60% better performance compared to the
> >> PAGE_SIZE buffer) and should not bring much overhead in terms of memory
> >> consumption due to order 2 allocations.
> >>
> >> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> > 
> > We may have to make these allocations under memory pressure in the IO context,
> > order 2 allocations here is going to be not awesome.  If you really want it then
> > you need to at least be able to fall back to single page if you fail to get the
> > allocation.  Thanks,
> > 
> 
> As far as I understand GFP_KERNEL allocations would never fail for the order <= 
> PAGE_ALLOC_COSTLY_ORDER. How else can the memory pressure condition be identified
> here?
> 

Except these can be done under NOFS, and just because GFP_KERNEL probably won't
fail doesn't mean it won't cause problems accross the system at alloc time.
Half of our rebase time at Facebook is spent finding all the fun ways people
have abused memory allocations not thinking about how the system behaves under
memory pressure.  Thanks,

Josef
