Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150406135134.GG14217@redhat.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
	<1428218688-4092-6-git-send-email-ming.lei@canonical.com>
	<20150406134655.GE14217@redhat.com>
	<20150406135134.GG14217@redhat.com>
Date: Tue, 7 Apr 2015 09:59:46 +0800
Message-ID: <CACVXFVP24TLjg6VJ0HJc7pXTU0K1x+7Ez2xzKWDQqO73gCLxQQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] block: dasd_genhd: convert to blkdev_reread_part
From: Ming Lei <ming.lei@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jarod Wilson <jarod@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 6, 2015 at 9:51 PM, Jarod Wilson <jarod@redhat.com> wrote:
>>
>> Note: patch 6/6 in the series makes this whole while() loops pointless,
>> since the possibility of the -EBUSY return goes away.
>
> Minor clarification: the -EBUSY due to the trylock, which is why that
> retry loop exists, goes away. You *could* still get an -EBUSY through
> blkdev_reread_part()->rescan_partitions()->drop_partitions() if
> bdev->bd_part_count is non-zero.

Not like trylock(&bd_mutex), Inside kernel, it should be driver's
responsibility to avoid that before rescanning partitions, that said
retry may not be needed for this case.

Thanks,
