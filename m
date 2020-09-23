Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgIWQn7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Sep 2020 12:43:59 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4234C0613D1
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2020 09:43:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f2so59837pgd.3
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2020 09:43:59 -0700 (PDT)
Subject: Re: remove blkdev_get as a public API v2
References: <20200921071958.307589-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d23e5bd4-4d69-f909-eb8b-10c489b67f8b@kernel.dk>
Date: Wed, 23 Sep 2020 10:43:57 -0600
MIME-Version: 1.0
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <josef@toxicpanda.com>, Minchan Kim <minchan@kernel.org>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, nbd@other.debian.org, linux-ide@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org

On 9/21/20 1:19 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes blkdev_get as a public API, leaving it as just an
> implementation detail of blkdev_get_by_path and blkdev_get_by_dev.  The
> reason for that is that blkdev_get is a very confusing API that requires
> a struct block_device to be fed in, but then actually consumes the
> reference.  And it turns out just using the two above mentioned APIs
> actually significantly simplifies the code as well.
> 
> Changes since v1:
>  - fix a mismerged that left a stray bdget_disk around
>  - factour the partition scan at registration time code into a new
>    helper.

Applied for 5.10, thanks.

-- 
Jens Axboe
