Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2895272AbgDOJSz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Apr 2020 05:18:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03F94dNj065598
        for <linux-s390@vger.kernel.org>; Wed, 15 Apr 2020 05:18:53 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30dnn3exfu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 15 Apr 2020 05:18:53 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Wed, 15 Apr 2020 10:18:23 +0100
Subject: Re: [PATCH 1/1] s390: Cleanup removed IOSCHED_DEADLINE
References: <20200406074118.86849-1-sth@linux.ibm.com>
 <20200406074118.86849-2-sth@linux.ibm.com>
 <0efad2a5-90f5-8ccf-169e-9715a64a4bb0@kernel.dk>
 <c7ac9c3c-3a1f-3ce3-acbd-422bc4206288@linux.ibm.com>
 <4a51ce19-7827-5ee6-8b06-5b814bdf503a@kernel.dk>
From: Stefan Haberland <sth@linux.ibm.com>
Date: Wed, 15 Apr 2020 11:18:45 +0200
MIME-Version: 1.0
In-Reply-To: <4a51ce19-7827-5ee6-8b06-5b814bdf503a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <57392f59-725d-654e-81dd-532c19b7702f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

Am 07.04.20 um 21:24 schrieb Jens Axboe:
> On 4/7/20 3:01 AM, Stefan Haberland wrote:
>> Am 06.04.20 um 17:32 schrieb Jens Axboe:
>>> On 4/6/20 1:41 AM, Stefan Haberland wrote:
>>>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>>>
>>>> CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
>>>> remove legacy IO schedulers").
>>> Isn't this a leftover thing from when dasd selected deadline
>>> internally? I don't think we need this anymore, just kill the
>>> select completely.
>>>
>> Basically yes.
>> We still have the recommendation to use deadline and there are some udev
>> rules in place which select it.
>> So I thought it might be a good idea to keep the line. But I am also
>> fine to drop it completely if you prefer this.
> I don't feel super strongly about it, but at the same time I don't
> think there's a reason for it. Besides, I think everyone has deadline
> enabled. So I guess we should just kill it.
>

OK, thanks for your opinion. I will remove the line and come up with a
different patch.
