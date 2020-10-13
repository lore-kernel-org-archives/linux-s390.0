Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727436AbgJMUPT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 13 Oct 2020 16:15:19 -0400
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201012183550.GA12341@imap.linux.ibm.com>
 <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
 <b5038d44-aa46-bbde-7a9f-0de46fed516a@linux.ibm.com>
 <17e1142c-4108-6f74-971a-dee007162786@kernel.dk>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
Message-ID: <ad3caaf7-ed8e-9f21-c3a6-c385139feb7b@linux.ibm.com>
Date: Tue, 13 Oct 2020 22:15:11 +0200
MIME-Version: 1.0
In-Reply-To: <17e1142c-4108-6f74-971a-dee007162786@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Am 13.10.20 um 21:40 schrieb Jens Axboe:
> On 10/12/20 1:50 PM, Stefan Haberland wrote:
>> Am 12.10.20 um 21:33 schrieb Jens Axboe:
>>> On 10/12/20 1:06 PM, Stefan Haberland wrote:
>>>> Hi Jens,
>>>>
>>>> quick ping. Are you going to apply this for 5.10?
>>> I actually wasn't planning on it - it arrived a bit late, and
>>> it seemed like one of those things that needed a bit more review
>>> talk before being able to be applied.
>>>
>> OK, too bad. I had hoped that this was still OK.
>> The patches have been tested and reviewed internally for quite a while=
=2E
>> Which actually was the reason for the late submission. Cornelia also
>> gave her RB last week.
> I'm not worried about the stability of it as much as whether the specia=
l
> feature is warranted. From the former point of view, it's probably fine=

> to go in now.
>> But OK, if you think this needs some more review we will have to wait
>> for 5.11.
> I'd definitely feel more comfortable with that.
>

OK, I will take care that features will be sent earlier next time.

So, instead could you please apply the patches for 5.11 as soon as it is
suitable?
