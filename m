Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730890AbgLDQnm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Dec 2020 11:43:42 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D0BC061A55
        for <linux-s390@vger.kernel.org>; Fri,  4 Dec 2020 08:43:02 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id z14so5747523ilm.10
        for <linux-s390@vger.kernel.org>; Fri, 04 Dec 2020 08:43:02 -0800 (PST)
Subject: Re: store a pointer to the block_device in struct bio (again)
References: <20201201165424.2030647-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <285e5e82-2e9c-a1db-b9b6-b82ec95aea6d@kernel.dk>
Date: Fri, 4 Dec 2020 09:43:00 -0700
MIME-Version: 1.0
In-Reply-To: <20201201165424.2030647-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

On 12/1/20 9:54 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series switches back from storing the gendisk + partno to storing
> a block_device pointer in struct bio.  The reason is two fold:  for one
> the new struct block_device actually is always available, removing the
> need to avoid originally.  Second the merge struct block_device is much
> more useful than the old one, as storing it avoids the need for looking
> up what used to be hd_struct during partition remapping and I/O
> accounting.
> 
> Note that this series depends on the posted but not merged
> "block tracepoint cleanups" series.

Applied, thanks.

-- 
Jens Axboe
