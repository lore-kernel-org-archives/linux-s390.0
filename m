Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:45049 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729837AbhAYR4W (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 Jan 2021 12:56:22 -0500
Date: Mon, 25 Jan 2021 18:55:28 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/10] block: do not reassig ->bi_bdev when partition
 remapping
Message-ID: <20210125175528.GA13451@lst.de>
References: <20210124100241.1167849-1-hch@lst.de> <20210124100241.1167849-6-hch@lst.de> <dfdff48c-c263-8e7c-cb52-28e7bee00c45@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfdff48c-c263-8e7c-cb52-28e7bee00c45@kernel.dk>
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, device-mapper development <dm-devel@redhat.com>, linux-bcache <linux-bcache@vger.kernel.org>, "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" <linux-raid@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>

On Mon, Jan 25, 2021 at 10:53:36AM -0700, Jens Axboe wrote:
> On Sun, Jan 24, 2021 at 3:05 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > There is no good reason to reassign ->bi_bdev when remapping the
> > partition-relative block number to the device wide one, as all the
> > information required by the drivers comes from the gendisk anyway.
> >
> > Keeping the original ->bi_bdev alive will allow to greatly simplify
> > the partition-away I/O accounting.
> 
> This one causes boot failures for me on my laptop...

Any output to share?  Details of the config?
