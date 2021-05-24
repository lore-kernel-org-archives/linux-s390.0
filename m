Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D08DC47084
	for <linux-s390@archiver.kernel.org>; Mon, 24 May 2021 07:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFAF61153
	for <linux-s390@archiver.kernel.org>; Mon, 24 May 2021 07:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhEXH2N (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 May 2021 03:28:13 -0400
Received: from verein.lst.de ([213.95.11.211]:53508 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232353AbhEXH2N (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 May 2021 03:28:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1676267373; Mon, 24 May 2021 09:26:43 +0200 (CEST)
Date:   Mon, 24 May 2021 09:26:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
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
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 14/26] md: convert to blk_alloc_disk/blk_cleanup_disk
Message-ID: <20210524072642.GF23890@lst.de>
References: <20210521055116.1053587-1-hch@lst.de> <20210521055116.1053587-15-hch@lst.de> <e65de9e6-337c-3e41-b5c2-d033ff236582@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e65de9e6-337c-3e41-b5c2-d033ff236582@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, May 23, 2021 at 10:12:49AM +0200, Hannes Reinecke wrote:
>> +	blk_set_stacking_limits(&mddev->queue->limits);
>>   	blk_queue_write_cache(mddev->queue, true, true);
>>   	/* Allow extended partitions.  This makes the
>>   	 * 'mdp' device redundant, but we can't really
>>
> Wouldn't it make sense to introduce a helper 'blk_queue_from_disk()' or 
> somesuch to avoid having to keep an explicit 'queue' pointer?

My rought plan is that a few series from now bio based drivers will
never directly deal with the request_queue at all.
