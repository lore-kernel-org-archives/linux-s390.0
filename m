Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55687 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGTYf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Apr 2020 15:24:35 -0400
Received: by mail-pj1-f68.google.com with SMTP id fh8so162799pjb.5
        for <linux-s390@vger.kernel.org>; Tue, 07 Apr 2020 12:24:33 -0700 (PDT)
Subject: Re: [PATCH 1/1] s390: Cleanup removed IOSCHED_DEADLINE
References: <20200406074118.86849-1-sth@linux.ibm.com>
 <20200406074118.86849-2-sth@linux.ibm.com>
 <0efad2a5-90f5-8ccf-169e-9715a64a4bb0@kernel.dk>
 <c7ac9c3c-3a1f-3ce3-acbd-422bc4206288@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4a51ce19-7827-5ee6-8b06-5b814bdf503a@kernel.dk>
Date: Tue, 7 Apr 2020 12:24:31 -0700
MIME-Version: 1.0
In-Reply-To: <c7ac9c3c-3a1f-3ce3-acbd-422bc4206288@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 4/7/20 3:01 AM, Stefan Haberland wrote:
> Am 06.04.20 um 17:32 schrieb Jens Axboe:
>> On 4/6/20 1:41 AM, Stefan Haberland wrote:
>>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>>
>>> CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
>>> remove legacy IO schedulers").
>> Isn't this a leftover thing from when dasd selected deadline
>> internally? I don't think we need this anymore, just kill the
>> select completely.
>>
> 
> Basically yes.
> We still have the recommendation to use deadline and there are some udev
> rules in place which select it.
> So I thought it might be a good idea to keep the line. But I am also
> fine to drop it completely if you prefer this.

I don't feel super strongly about it, but at the same time I don't
think there's a reason for it. Besides, I think everyone has deadline
enabled. So I guess we should just kill it.

-- 
Jens Axboe
