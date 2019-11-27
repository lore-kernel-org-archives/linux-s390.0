Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbfK0Nnk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Nov 2019 08:43:40 -0500
Subject: Re: [PATCH 5/5] btrfs: Increase buffer size for zlib functions
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
 <20191126144130.75710-6-zaslonko@linux.ibm.com>
 <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Message-ID: <11377b99-b66c-fdc3-5c8f-0bae34c92c03@linux.ibm.com>
Date: Wed, 27 Nov 2019 14:42:20 +0100
MIME-Version: 1.0
In-Reply-To: <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On 26.11.2019 16:52, Josef Bacik wrote:
> On Tue, Nov 26, 2019 at 03:41:30PM +0100, Mikhail Zaslonko wrote:
>> Due to the small size of zlib buffer (1 page) set in btrfs code, s390
>> hardware compression is rather limited in terms of performance. Increasing
>> the buffer size to 4 pages would bring significant benefit for s390
>> hardware compression (up to 60% better performance compared to the
>> PAGE_SIZE buffer) and should not bring much overhead in terms of memory
>> consumption due to order 2 allocations.
>>
>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> 
> We may have to make these allocations under memory pressure in the IO context,
> order 2 allocations here is going to be not awesome.  If you really want it then
> you need to at least be able to fall back to single page if you fail to get the
> allocation.  Thanks,
> 

As far as I understand GFP_KERNEL allocations would never fail for the order <= 
PAGE_ALLOC_COSTLY_ORDER. How else can the memory pressure condition be identified
here?

> josef
> 
