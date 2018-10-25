From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Oct 2018 14:20:11 +0000
Subject: Re: [PATCH] dasd: remove dead code
Message-Id: <62e695aa-5e97-67a6-a40c-2b6bf2edcf2a@kernel.dk>
In-Reply-To: <20181025090757.43024-1-sth@linux.ibm.com>
References: <20181025090757.43024-1-sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 10/25/18 3:07 AM, Stefan Haberland wrote:
>> Great that you want to fix it. Since this is holding up a patch queue,
>> I'd appreciate if I can carry it in my tree to avoid having dependencies
>> on external trees for the legacy IO path removal for 4.21.
>>
> 
> OK, here is the patch. 

Thanks!

>> Note that the entire block has been unreachable since the conversion
>> went in May 2017, and nobody noticed.
> 
> I know. The code in the ifdef was not used for years. So this can be
> removed.
> The chanq counter may be useful for debugging purposes so I would
> like to keep it.

Fair enough, I'll queue up the revised versions. Thanks again.


-- 
Jens Axboe
