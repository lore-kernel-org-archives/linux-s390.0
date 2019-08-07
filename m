Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35546 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbfHGRIV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Aug 2019 13:08:21 -0400
Subject: Re: [PATCH 0/2] scsi: core: regression fixes for request batching
References: <20190807144948.28265-1-maier@linux.ibm.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <33a8afce-91a4-2a9d-d822-b12376fd0aa3@acm.org>
Date: Wed, 7 Aug 2019 10:08:17 -0700
MIME-Version: 1.0
In-Reply-To: <20190807144948.28265-1-maier@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>, "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-next@vger.kernel.org, linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>, "Ewan D . Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>

On 8/7/19 7:49 AM, Steffen Maier wrote:
> Hi James, Martin, Paolo, Ming,
> 
> multipathing with linux-next is broken since 20190723 in our CI.
> The patches fix a memleak and a severe dh/multipath functional regression.
> It would be nice if we could get them to 5.4/scsi-queue and also next.
 >
> I would have preferred if such a new feature had used its own
> new copy scsi_mq_ops_batching instead of changing the use case and
> semantics of the existing scsi_mq_ops, because this would likely
> cause less regressions for all the other users not using the new feature.

For both patches:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

BTW, these two patches fix several nvmeof-mp blktests regressions.

Bart.
