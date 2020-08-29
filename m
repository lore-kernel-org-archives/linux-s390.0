Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgH2QrS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 29 Aug 2020 12:47:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A529C061236
        for <linux-s390@vger.kernel.org>; Sat, 29 Aug 2020 09:47:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ds1so976108pjb.1
        for <linux-s390@vger.kernel.org>; Sat, 29 Aug 2020 09:47:17 -0700 (PDT)
Subject: Re: fix block device size update serialization v2
References: <20200823091043.2600261-1-hch@lst.de>
 <20200827074758.GA8009@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b1960016-c265-1e1d-cfd7-de2330bc5eac@kernel.dk>
Date: Sat, 29 Aug 2020 10:47:11 -0600
MIME-Version: 1.0
In-Reply-To: <20200827074758.GA8009@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Justin Sanders <justin@coraid.com>, Josef Bacik <josef@toxicpanda.com>, Xianting Tian <xianting_tian@126.com>, linux-block@vger.kernel.org, dm-devel@redhat.com, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-kernel@vger.kernel.org, nbd@other.debian.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org

On 8/27/20 1:47 AM, Christoph Hellwig wrote:
> Jens, can you consider this for 5.9?  It reliably fixes the reported
> hangs with nvme hotremoval that we've had for a few releases.

I've queued this up for 5.10. I think it's too late for 5.9 at this
point, and it's not a regression in this release.

-- 
Jens Axboe
