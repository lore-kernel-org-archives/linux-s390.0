Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B29C4743D
	for <linux-s390@archiver.kernel.org>; Sat,  5 Jun 2021 14:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30139611AE
	for <linux-s390@archiver.kernel.org>; Sat,  5 Jun 2021 14:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFEOEv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 5 Jun 2021 10:04:51 -0400
Received: from verein.lst.de ([213.95.11.211]:40749 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFEOEu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 5 Jun 2021 10:04:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8575C6736F; Sat,  5 Jun 2021 16:02:57 +0200 (CEST)
Date:   Sat, 5 Jun 2021 16:02:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, jgross@suse.com,
        Jens Axboe <axboe@kernel.dk>,
        Justin Sanders <justin@coraid.com>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Tim Waugh <tim@cyberelk.net>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: simplify gendisk and request_queue allocation for blk-mq based
 drivers
Message-ID: <20210605140257.GA13166@lst.de>
References: <20210602065345.355274-1-hch@lst.de> <YLpNqiw0LMkYWUyN@0xbeefdead.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLpNqiw0LMkYWUyN@0xbeefdead.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 04, 2021 at 11:58:34AM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Jun 02, 2021 at 09:53:15AM +0300, Christoph Hellwig wrote:
> > Hi all,
> 
> Hi!
> 
> You wouldn't have a nice git repo to pull so one can test it easily?

git://git.infradead.org/users/hch/block.git alloc_disk-part2
