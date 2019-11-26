Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33670 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfKZPwy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 Nov 2019 10:52:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id c124so12091684qkg.0
        for <linux-s390@vger.kernel.org>; Tue, 26 Nov 2019 07:52:52 -0800 (PST)
Date: Tue, 26 Nov 2019 10:52:49 -0500
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 5/5] btrfs: Increase buffer size for zlib functions
Message-ID: <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
 <20191126144130.75710-6-zaslonko@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126144130.75710-6-zaslonko@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 03:41:30PM +0100, Mikhail Zaslonko wrote:
> Due to the small size of zlib buffer (1 page) set in btrfs code, s390
> hardware compression is rather limited in terms of performance. Increasing
> the buffer size to 4 pages would bring significant benefit for s390
> hardware compression (up to 60% better performance compared to the
> PAGE_SIZE buffer) and should not bring much overhead in terms of memory
> consumption due to order 2 allocations.
> 
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

We may have to make these allocations under memory pressure in the IO context,
order 2 allocations here is going to be not awesome.  If you really want it then
you need to at least be able to fall back to single page if you fail to get the
allocation.  Thanks,

josef
