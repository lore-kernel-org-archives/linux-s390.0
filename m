Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgKKQUN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Nov 2020 11:20:13 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F83C0613D1
        for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2020 08:20:12 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id s24so2811544ioj.13
        for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2020 08:20:12 -0800 (PST)
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201012183550.GA12341@imap.linux.ibm.com>
 <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
 <b5038d44-aa46-bbde-7a9f-0de46fed516a@linux.ibm.com>
 <17e1142c-4108-6f74-971a-dee007162786@kernel.dk>
 <ad3caaf7-ed8e-9f21-c3a6-c385139feb7b@linux.ibm.com>
 <6468cfad-e14c-060d-a525-00d75fe66819@kernel.dk>
 <30740ed3-21b9-71cd-b48c-1d6947c6f029@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <be2933c0-4827-ab38-872f-01cb02e44fc4@kernel.dk>
Date: Wed, 11 Nov 2020 09:20:10 -0700
MIME-Version: 1.0
In-Reply-To: <30740ed3-21b9-71cd-b48c-1d6947c6f029@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 11/10/20 8:50 AM, Stefan Haberland wrote:
> Am 14.10.20 um 03:19 schrieb Jens Axboe:
>>
>>> So, instead could you please apply the patches for 5.11 as soon as it is
>>> suitable?
>> I will - I have it queued up, won't create anything public until we
>> get past the merge window.
>>
> 
> Sorry to bother you again with this.
> Is there any outlook when you are going to push the patches to your
> for-next branch?
> 
> Or shall I resend the patches?

I already did apply it, just don't push out next release branches
that early. Pushed out now, so it is in.

-- 
Jens Axboe
