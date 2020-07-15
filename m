Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgGOOra (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Jul 2020 10:47:30 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A03C08C5DB
        for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2020 07:47:30 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q74so2533493iod.1
        for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2020 07:47:29 -0700 (PDT)
Subject: Re: [PATCH 0/2] DASD DIAG patches
References: <20200714200327.40927-1-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e45950a7-a452-e7f0-f066-e1465cd97a4d@kernel.dk>
Date: Wed, 15 Jul 2020 08:47:27 -0600
MIME-Version: 1.0
In-Reply-To: <20200714200327.40927-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 7/14/20 2:03 PM, Stefan Haberland wrote:
> Hi Jens,
> 
> please see the following two patches that fix and improve the DASD DIAG driver.
> 
> Regards,
> Stefan
> 
> Gustavo A. R. Silva (1):
>   s390/dasd: Use struct_size() helper
> 
> Stefan Haberland (1):
>   s390/dasd: fix inability to use DASD with DIAG driver
> 
>  drivers/s390/block/dasd_diag.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)

Applied, thanks.

-- 
Jens Axboe
