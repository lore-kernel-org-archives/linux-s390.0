Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B16C04FF3
	for <linux-s390@archiver.kernel.org>; Mon, 24 May 2021 07:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D69611CB
	for <linux-s390@archiver.kernel.org>; Mon, 24 May 2021 07:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhEXH1b (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 May 2021 03:27:31 -0400
Received: from verein.lst.de ([213.95.11.211]:53482 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232266AbhEXH11 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 May 2021 03:27:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C1B4B67373; Mon, 24 May 2021 09:25:57 +0200 (CEST)
Date:   Mon, 24 May 2021 09:25:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jim Paris <jim@jtan.com>,
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
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 13/26] dm: convert to blk_alloc_disk/blk_cleanup_disk
Message-ID: <20210524072557.GE23890@lst.de>
References: <20210521055116.1053587-1-hch@lst.de> <20210521055116.1053587-14-hch@lst.de> <de3b0976-1299-17d8-240a-2ecd8b9fbc2d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3b0976-1299-17d8-240a-2ecd8b9fbc2d@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, May 23, 2021 at 10:10:34AM +0200, Hannes Reinecke wrote:
> Can't these conditionals be merged into a single 'if (md->disk)'?
> Eg like:
>
> 	if (md->disk) {
> 		spin_lock(&_minor_lock);
> 		md->disk->private_data = NULL;
> 		spin_unlock(&_minor_lock);
> 		del_gendisk(md->disk);
> 		dm_queue_destroy_keyslot_manager(md->queue);
> 		blk_cleanup_disk(md->queue);
> 	}
>
> We're now always allocating 'md->disk' and 'md->queue' together,
> so how can we end up in a situation where one is set without the other?

I guess we could do that, not sure it is worth the churn, though.
