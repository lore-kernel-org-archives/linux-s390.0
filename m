Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgJGOCS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 10:02:18 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96337C0613D2
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 07:02:16 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q7so2349890ile.8
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 07:02:16 -0700 (PDT)
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
References: <20201007124009.1438269-1-hch@lst.de>
 <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
 <20201007135411.GA1000@lst.de>
 <874c518d-7c15-d08a-61a2-116f605c4b5a@kernel.dk>
 <20201007140109.GA1042@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <55d92fb3-acd7-d62c-093b-4f716d98ac52@kernel.dk>
Date: Wed, 7 Oct 2020 08:02:13 -0600
MIME-Version: 1.0
In-Reply-To: <20201007140109.GA1042@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, sth@linux.ibm.com, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>

On 10/7/20 8:01 AM, Christoph Hellwig wrote:
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

I prefer being explicit instead of assuming it'll get picked up.
I applied it for 5.9, added the tag.

-- 
Jens Axboe
