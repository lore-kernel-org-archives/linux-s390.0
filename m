Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38979 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfHBC40 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Aug 2019 22:56:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so33087394pls.6
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 19:56:26 -0700 (PDT)
Subject: Re: [PATCH 1/1] s390/dasd: fix endless loop after read unit address
 configuration
References: <20190801110630.82432-1-sth@linux.ibm.com>
 <20190801110630.82432-2-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <20c4971d-68cd-b4d0-fb40-deef771602b1@kernel.dk>
Date: Thu, 1 Aug 2019 20:47:51 -0600
MIME-Version: 1.0
In-Reply-To: <20190801110630.82432-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org, hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, gor@linux.ibm.com

On 8/1/19 5:06 AM, Stefan Haberland wrote:
> After getting a storage server event that causes the DASD device driver
> to update its unit address configuration during a device shutdown there is
> the possibility of an endless loop in the device driver.
> 
> In the system log there will be ongoing DASD error messages with RC: -19.
> 
> The reason is that the loop starting the ruac request only terminates when
> the retry counter is decreased to 0. But in the sleep_on function there are
> early exit paths that do not decrease the retry counter.
> 
> Prevent an endless loop by handling those cases separately.
> 
> Remove the unnecessary do..while loop since the sleep_on function takes
> care of retries by itself.

Applied for 5.3, thanks.

-- 
Jens Axboe
