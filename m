Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730743AbhAYQYq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Jan 2021 11:24:46 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57393C061788
        for <linux-s390@vger.kernel.org>; Mon, 25 Jan 2021 08:24:06 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b17so1391761plz.6
        for <linux-s390@vger.kernel.org>; Mon, 25 Jan 2021 08:24:06 -0800 (PST)
Subject: Re: store a pointer to the block_device in struct bio (again) v2
References: <20210124100241.1167849-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <86dd18e9-43e9-efe5-8445-88952a95b5d8@kernel.dk>
Date: Mon, 25 Jan 2021 09:24:03 -0700
MIME-Version: 1.0
In-Reply-To: <20210124100241.1167849-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

On 1/24/21 3:02 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series switches back from storing the gendisk + partno to storing
> a block_device pointer in struct bio.  The reason is two fold:  for one
> the new struct block_device actually is always available, removing the
> need to avoid originally.  Second the merge struct block_device is much
> more useful than the old one, as storing it avoids the need for looking
> up what used to be hd_struct during partition remapping and I/O
> accounting.

Applied for 5.12, thanks.

-- 
Jens Axboe
