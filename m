Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgDTRfq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 13:35:46 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5F2C061A0F
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 10:35:46 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z2so7597148iol.11
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 10:35:46 -0700 (PDT)
Subject: Re: more partition handling cleanups v2
References: <20200414072902.324936-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c1c720cb-659c-44ca-1a64-16e08725accd@kernel.dk>
Date: Mon, 20 Apr 2020 11:35:43 -0600
MIME-Version: 1.0
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On 4/14/20 1:28 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up more lose ends in the partitioning code.  It also
> removes a rather annoying use of ioctl_by_bdev in the s390 dasd driver.
> 
> Changes since v1:
>  - fix a brown paperbag typo in blkpg_do_ioctl
>  - fix a commit message typo

Applied for 5.8.

-- 
Jens Axboe
