Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgLDQm4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Dec 2020 11:42:56 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC60FC061A51
        for <linux-s390@vger.kernel.org>; Fri,  4 Dec 2020 08:42:10 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id q1so5759469ilt.6
        for <linux-s390@vger.kernel.org>; Fri, 04 Dec 2020 08:42:10 -0800 (PST)
Subject: Re: block tracepoint cleanups v2
References: <20201203162139.2110977-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8859c43f-a1fa-60dc-ea27-4a126f95dc68@kernel.dk>
Date: Fri, 4 Dec 2020 09:42:08 -0700
MIME-Version: 1.0
In-Reply-To: <20201203162139.2110977-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, dm-devel@redhat.com, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org

On 12/3/20 9:21 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up the block layer tracepoints by removing unused
> tracepoints or tracepoint arguments and consolidating the implementation
> of various bio based tracepoints.

Applied, thanks.

-- 
Jens Axboe
