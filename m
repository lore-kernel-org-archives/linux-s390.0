Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgGOOqw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Jul 2020 10:46:52 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA19C08C5DB
        for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2020 07:46:52 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q3so2177849ilt.8
        for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2020 07:46:52 -0700 (PDT)
Subject: Re: [PATCH 1/2] s390/dasd: fix inability to use DASD with DIAG driver
References: <20200714200327.40927-1-sth@linux.ibm.com>
 <20200714200327.40927-2-sth@linux.ibm.com>
 <c368fa07-4a7d-3eae-6143-a2db298c204e@kernel.dk>
 <20200715064854.GA5409@infradead.org>
 <88f32826-4bd2-27c1-c9e0-204aa556b0a6@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <85ea2f21-64e3-aae6-b069-013bb929045a@kernel.dk>
Date: Wed, 15 Jul 2020 08:46:50 -0600
MIME-Version: 1.0
In-Reply-To: <88f32826-4bd2-27c1-c9e0-204aa556b0a6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 7/15/20 7:32 AM, Stefan Haberland wrote:
> Am 15.07.20 um 08:48 schrieb Christoph Hellwig:
>> On Tue, Jul 14, 2020 at 02:12:27PM -0600, Jens Axboe wrote:
>>> Just curious, any reason this isn't just using bio_alloc()?
>> The dasd_diag_bio doesn't seem to have anything to do with the
>> block layer struct bio..
> 
> exactly, that's a struct dasd_diag_bio.

Duh, guess I should have looked a bit more closely...

-- 
Jens Axboe
