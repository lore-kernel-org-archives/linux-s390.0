Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730721AbgJHO4X (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 10:56:23 -0400
Subject: Re: [PATCH v2 10/10] s390/dasd: Process FCES path event notification
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201008131336.61100-11-sth@linux.ibm.com>
 <20201008165428.40044398.cohuck@redhat.com>
From: =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
Message-ID: <7d2ac903-5750-79f5-df04-952161bc0f0f@linux.ibm.com>
Date: Thu, 8 Oct 2020 16:56:15 +0200
MIME-Version: 1.0
In-Reply-To: <20201008165428.40044398.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Stefan Haberland <sth@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 10/8/20 4:54 PM, Cornelia Huck wrote:
> On Thu,  8 Oct 2020 15:13:36 +0200
> Stefan Haberland <sth@linux.ibm.com> wrote:
> 
>> From: Jan Höppner <hoeppner@linux.ibm.com>
>>
>> If the Fibre Channel Endpoint-Security status of a path changes, a
>> corresponding path event is received from the CIO layer.
>>
>> Process this event by re-reading the FCES information.
>>
>> As the information is retrieved for all paths on a single CU in one
>> call, the internal status can also be updated for all paths and no
>> processing per path is necessary.
>>
>> Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
>> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
>> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
>> ---
>>  drivers/s390/block/dasd.c      | 19 +++++++++++----
>>  drivers/s390/block/dasd_eckd.c | 12 +++++++---
>>  drivers/s390/block/dasd_int.h  | 42 +++++++++++++++++++++++++++++++++-
>>  3 files changed, 64 insertions(+), 9 deletions(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks a lot for reviewing the whole set, much appreciated!

regards,
Jan
