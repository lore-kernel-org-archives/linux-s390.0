Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGNxb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 09:53:31 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4462C061755
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 06:53:29 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id o9so2369942ilo.0
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 06:53:29 -0700 (PDT)
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
References: <20201007124009.1438269-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
Date: Wed, 7 Oct 2020 07:53:27 -0600
MIME-Version: 1.0
In-Reply-To: <20201007124009.1438269-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, sth@linux.ibm.com, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>

On 10/7/20 6:40 AM, Christoph Hellwig wrote:
> Don't error out if the dasd_biodasdinfo symbol is not available.

Should this be marked for 5.8-stable?

-- 
Jens Axboe
