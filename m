Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51686 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgHWJJT (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 23 Aug 2020 05:09:19 -0400
Date: Sun, 23 Aug 2020 11:09:15 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] block: fix locking for struct block_device size
 updates
Message-ID: <20200823090915.GA2764@lst.de>
References: <20200821085600.2395666-1-hch@lst.de> <20200821085600.2395666-3-hch@lst.de> <4df016bc-570c-d166-47dd-36a9f21fad13@suse.de> <133efc8b.1649.17410784734.Coremail.xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <133efc8b.1649.17410784734.Coremail.xianting_tian@126.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: =?utf-8?B?55Sw?= <xianting_tian@126.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>, Josef Bacik <josef@toxicpanda.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>

On Fri, Aug 21, 2020 at 06:02:32PM +0800, 田 wrote:
> thanks Hellwig for your kindly reply and your fix and add report by me :)

I found an issue with the patch, and will send a new version in a bit.
If this works for your reproducer, can you add a Tested-by: tag?
