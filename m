Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgJMTko (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Oct 2020 15:40:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3CFC0613D0
        for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2020 12:40:43 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id az3so525491pjb.4
        for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2020 12:40:43 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201012183550.GA12341@imap.linux.ibm.com>
 <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
 <b5038d44-aa46-bbde-7a9f-0de46fed516a@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <17e1142c-4108-6f74-971a-dee007162786@kernel.dk>
Date: Tue, 13 Oct 2020 13:40:41 -0600
MIME-Version: 1.0
In-Reply-To: <b5038d44-aa46-bbde-7a9f-0de46fed516a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 10/12/20 1:50 PM, Stefan Haberland wrote:
> Am 12.10.20 um 21:33 schrieb Jens Axboe:
>> On 10/12/20 1:06 PM, Stefan Haberland wrote:
>>> Hi Jens,
>>>
>>> quick ping. Are you going to apply this for 5.10?
>> I actually wasn't planning on it - it arrived a bit late, and
>> it seemed like one of those things that needed a bit more review
>> talk before being able to be applied.
>>
> 
> OK, too bad. I had hoped that this was still OK.
> The patches have been tested and reviewed internally for quite a while.
> Which actually was the reason for the late submission. Cornelia also
> gave her RB last week.

I'm not worried about the stability of it as much as whether the special
feature is warranted. From the former point of view, it's probably fine
to go in now.

> But OK, if you think this needs some more review we will have to wait
> for 5.11.
I'd definitely feel more comfortable with that.

-- 
Jens Axboe
