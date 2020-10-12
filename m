Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbgJLTuq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 12 Oct 2020 15:50:46 -0400
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201012183550.GA12341@imap.linux.ibm.com>
 <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
Message-ID: <b5038d44-aa46-bbde-7a9f-0de46fed516a@linux.ibm.com>
Date: Mon, 12 Oct 2020 21:50:39 +0200
MIME-Version: 1.0
In-Reply-To: <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Am 12.10.20 um 21:33 schrieb Jens Axboe:
> On 10/12/20 1:06 PM, Stefan Haberland wrote:
>> Hi Jens,
>>
>> quick ping. Are you going to apply this for 5.10?
> I actually wasn't planning on it - it arrived a bit late, and
> it seemed like one of those things that needed a bit more review
> talk before being able to be applied.
>

OK, too bad. I had hoped that this was still OK.
The patches have been tested and reviewed internally for quite a while.
Which actually was the reason for the late submission. Cornelia also
gave her RB last week.

But OK, if you think this needs some more review we will have to wait
for 5.11.
