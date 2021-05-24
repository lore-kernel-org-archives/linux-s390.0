Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB09C47088
	for <linux-s390@archiver.kernel.org>; Mon, 24 May 2021 07:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D5D61151
	for <linux-s390@archiver.kernel.org>; Mon, 24 May 2021 07:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhEXHVq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 May 2021 03:21:46 -0400
Received: from verein.lst.de ([213.95.11.211]:53368 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232128AbhEXHVq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 May 2021 03:21:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A686B67373; Mon, 24 May 2021 09:20:13 +0200 (CEST)
Date:   Mon, 24 May 2021 09:20:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jim Paris <jim@jtan.com>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-xtensa@linux-xtensa.org, linux-m68k@vger.kernel.org,
        linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-bcache@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@tron.linbit.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [dm-devel] [PATCH 01/26] block: refactor device number setup
 in __device_add_disk
Message-ID: <20210524072013.GA23890@lst.de>
References: <20210521055116.1053587-1-hch@lst.de> <20210521055116.1053587-2-hch@lst.de> <20210521171646.GA25017@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521171646.GA25017@42.do-not-panic.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 21, 2021 at 05:16:46PM +0000, Luis Chamberlain wrote:
> > -	/* in consecutive minor range? */
> > -	if (bdev->bd_partno < disk->minors) {
> > -		*devt = MKDEV(disk->major, disk->first_minor + bdev->bd_partno);
> > -		return 0;
> > -	}
> > -
> 
> It is not obviously clear to me, why this was part of add_disk()
> path, and ...
> 
> > diff --git a/block/partitions/core.c b/block/partitions/core.c
> > index dc60ecf46fe6..504297bdc8bf 100644
> > --- a/block/partitions/core.c
> > +++ b/block/partitions/core.c
> > @@ -379,9 +380,15 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
> >  	pdev->type = &part_type;
> >  	pdev->parent = ddev;
> >  
> > -	err = blk_alloc_devt(bdev, &devt);
> > -	if (err)
> > -		goto out_put;
> > +	/* in consecutive minor range? */
> > +	if (bdev->bd_partno < disk->minors) {
> > +		devt = MKDEV(disk->major, disk->first_minor + bdev->bd_partno);
> > +	} else {
> > +		err = blk_alloc_ext_minor();
> > +		if (err < 0)
> > +			goto out_put;
> > +		devt = MKDEV(BLOCK_EXT_MAJOR, err);
> > +	}
> >  	pdev->devt = devt;
> >  
> >  	/* delay uevent until 'holders' subdir is created */
> 
> ... and why we only add this here now.

For the genhd minors == 0 (aka GENHD_FL_EXT_DEVT) implies having to
allocate a dynamic dev_t, so it can be folded into another conditional.
