Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f169.google.com ([209.85.215.169]:33315 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXI0N (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Aug 2020 04:26:13 -0400
Subject: Re: [PATCH 3/3] nvme: don't call revalidate_disk from
 nvme_set_queue_dying
References: <20200823091043.2600261-1-hch@lst.de>
 <20200823091043.2600261-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b5422c22-7f68-e2a5-ec53-e1457d11f3ad@grimberg.me>
Date: Mon, 24 Aug 2020 01:26:10 -0700
MIME-Version: 1.0
In-Reply-To: <20200823091043.2600261-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, Justin Sanders <justin@coraid.com>, linux-nvme@lists.infradead.org, Josef Bacik <josef@toxicpanda.com>, Xianting Tian <xianting_tian@126.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com, Stefan Haberland <sth@linux.ibm.com>, nbd@other.debian.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
