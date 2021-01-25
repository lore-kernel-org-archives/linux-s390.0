Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbhAYRyU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Jan 2021 12:54:20 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260A9C06178C
        for <linux-s390@vger.kernel.org>; Mon, 25 Jan 2021 09:53:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id f63so8820660pfa.13
        for <linux-s390@vger.kernel.org>; Mon, 25 Jan 2021 09:53:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 05/10] block: do not reassig ->bi_bdev when partition
 remapping
References: <20210124100241.1167849-1-hch@lst.de>
 <20210124100241.1167849-6-hch@lst.de>
Message-ID: <dfdff48c-c263-8e7c-cb52-28e7bee00c45@kernel.dk>
Date: Mon, 25 Jan 2021 10:53:36 -0700
MIME-Version: 1.0
In-Reply-To: <20210124100241.1167849-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, device-mapper development <dm-devel@redhat.com>, linux-bcache <linux-bcache@vger.kernel.org>, "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" <linux-raid@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>

On Sun, Jan 24, 2021 at 3:05 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no good reason to reassign ->bi_bdev when remapping the
> partition-relative block number to the device wide one, as all the
> information required by the drivers comes from the gendisk anyway.
>
> Keeping the original ->bi_bdev alive will allow to greatly simplify
> the partition-away I/O accounting.

This one causes boot failures for me on my laptop...

-- 
Jens Axboe
