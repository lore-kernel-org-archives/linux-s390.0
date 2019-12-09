Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbfLIQkQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 11:40:16 -0500
Subject: Re: [PATCH 5/5] btrfs: Increase buffer size for zlib functions
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
 <20191126144130.75710-6-zaslonko@linux.ibm.com>
 <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
 <20191127121423.GQ2734@suse.cz>
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Message-ID: <a8dc0941-ee2d-6df7-cb32-c6af26bdc54c@linux.ibm.com>
Date: Mon, 9 Dec 2019 17:39:51 +0100
MIME-Version: 1.0
In-Reply-To: <20191127121423.GQ2734@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: dsterba@suse.cz
Cc: Josef Bacik <josef@toxicpanda.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi David,

On 27.11.2019 13:14, David Sterba wrote:
> On Tue, Nov 26, 2019 at 10:52:49AM -0500, Josef Bacik wrote:
>> On Tue, Nov 26, 2019 at 03:41:30PM +0100, Mikhail Zaslonko wrote:
>>> Due to the small size of zlib buffer (1 page) set in btrfs code, s390
>>> hardware compression is rather limited in terms of performance. Increasing
>>> the buffer size to 4 pages would bring significant benefit for s390
>>> hardware compression (up to 60% better performance compared to the
>>> PAGE_SIZE buffer) and should not bring much overhead in terms of memory
>>> consumption due to order 2 allocations.
>>>
>>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>>
>> We may have to make these allocations under memory pressure in the IO context,
>> order 2 allocations here is going to be not awesome.  If you really want it then
>> you need to at least be able to fall back to single page if you fail to get the
>> allocation.  Thanks,
> 
> The allocation is only for the workspace and it does not happen on the
> IO path for each call. There's the pool and if
> 
> btrfs_get_workspace
>   alloc_workspace
> 
> fails, then there's fallback path to wait for an existing workspace to
> be free.
> 
> The order 2 allocation can put more pressure on the allocator though so
> it's possible to have effects in some corner cases, but not in general.
> I don't think the single page fallback code is needed.
> 
> And of course evaluation of the effects of the larger zlib buffer should
> be done, it could improve compression but probably at the cost of cpu
> time. Also decompression of blocks created on new code (4 pages) must
> work on the old code (1 page).
Regarding 'improve compression but probably at the cost of cpu' ... what would be 
the proper way to evaluate this effect?
As for backward compatibility, I do not see side effects of using larger buffers. 
Data in the compressed state might differ indeed, but it will sill conform to zlib
standard and thus can be decompressed.

BTW, I have sent around V2 of the patch set. I would appreciate if you take a look 
as well.
> 
Thanks,
Mikhail
