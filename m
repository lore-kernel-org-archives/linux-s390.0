Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728469AbgJGODw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 10:03:52 -0400
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
References: <20201007124009.1438269-1-hch@lst.de>
 <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
 <20201007135411.GA1000@lst.de>
 <874c518d-7c15-d08a-61a2-116f605c4b5a@kernel.dk>
 <20201007140109.GA1042@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <14283127-1c99-525e-9abd-14b4ca1e0681@de.ibm.com>
Date: Wed, 7 Oct 2020 16:02:13 +0200
MIME-Version: 1.0
In-Reply-To: <20201007140109.GA1042@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, sth@linux.ibm.com, linux-s390@vger.kernel.org



On 07.10.20 16:01, Christoph Hellwig wrote:
> On Wed, Oct 07, 2020 at 07:54:45AM -0600, Jens Axboe wrote:
>> On 10/7/20 7:54 AM, Christoph Hellwig wrote:
>>> On Wed, Oct 07, 2020 at 07:53:27AM -0600, Jens Axboe wrote:
>>>> On 10/7/20 6:40 AM, Christoph Hellwig wrote:
>>>>> Don't error out if the dasd_biodasdinfo symbol is not available.
>>>>
>>>> Should this be marked for 5.8-stable?
>>>
>>> The Fixes tag should automatically take care of that.
>>
>> Not if it's not marked for stable. Maybe auto-selection will pick it
>> up, but it's not a given.
> 
> Yes, trivial patches with a fixes tag get reliably picked out.  But
> if you don't trust the system feel free to add a stable tag.

Yes, we want to have it for 5.8 stable, so a stable tag certainly does not hurt. 
