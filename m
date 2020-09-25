Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgIYOTL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Sep 2020 10:19:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F67CC0613CE
        for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2020 07:19:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id k133so2701088pgc.7
        for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2020 07:19:11 -0700 (PDT)
Subject: Re: clean up is partition checks
References: <20200903054104.228829-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7a0600d8-d886-c546-378c-5298a16e979c@kernel.dk>
Date: Fri, 25 Sep 2020 08:19:08 -0600
MIME-Version: 1.0
In-Reply-To: <20200903054104.228829-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: dm-devel@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org

On 9/2/20 11:40 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series add a new helepr to check if a struct block_device represents
> a parition, and removes most direct access to ->bd_contained from
> drivers.

Applied, thanks.

-- 
Jens Axboe
