Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37338 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXI0B (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Aug 2020 04:26:01 -0400
Subject: Re: [PATCH 1/3] block: replace bd_set_size with bd_set_nr_sectors
References: <20200823091043.2600261-1-hch@lst.de>
 <20200823091043.2600261-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f31bb1a9-2f2c-2002-c7ce-29aa43feeafb@grimberg.me>
Date: Mon, 24 Aug 2020 01:25:58 -0700
MIME-Version: 1.0
In-Reply-To: <20200823091043.2600261-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, Justin Sanders <justin@coraid.com>, linux-nvme@lists.infradead.org, Josef Bacik <josef@toxicpanda.com>, Xianting Tian <xianting_tian@126.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com, Stefan Haberland <sth@linux.ibm.com>, nbd@other.debian.org, Hannes Reinecke <hare@suse.de>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
