Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-il1-f170.google.com ([209.85.166.170]:43592 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKNOom (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 09:44:42 -0500
Received: by mail-il1-f170.google.com with SMTP id r9so5543474ilq.10
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 06:44:41 -0800 (PST)
Subject: Re: disk revalidation cleanups and fixlets v2
References: <20191114143438.14681-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <10175732-a3f0-510d-e423-f7f7072fef2b@kernel.dk>
Date: Thu, 14 Nov 2019 07:44:38 -0700
MIME-Version: 1.0
In-Reply-To: <20191114143438.14681-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On 11/14/19 7:34 AM, Christoph Hellwig wrote:
> Hi Jens and Jan,
> 
> this series takes the disk size change detection and revalidations
> from Jan a step further and fully integrate the code path for
> partitioned vs non-partitioned devices.  It also fixes up a few
> bits where we have unintentionally differing behavior.
> 
> Changes since v1:
>   - rebased on to of for-5.5/zoned
>   - fixed a commit message
>   - added two new trivial patches

Applied, thanks.

-- 
Jens Axboe
