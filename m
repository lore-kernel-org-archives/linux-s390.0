Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgAMKDi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Jan 2020 05:03:38 -0500
Subject: Re: [PATCH v4] btrfs: Use larger zlib buffer for s390 hardware
 compression
References: <20200107143058.GU3929@twin.jikos.cz>
 <20200108105103.29028-1-zaslonko@linux.ibm.com>
 <75a2d45c-fd7b-9542-403d-caea7d977add@toxicpanda.com>
 <94e06859-6174-c80d-3eb6-065f67fbe95d@linux.ibm.com>
 <20200109011025.GM3929@suse.cz>
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Message-ID: <62a53ff3-a515-8801-d58b-b518dbe0c55c@linux.ibm.com>
Date: Mon, 13 Jan 2020 11:03:29 +0100
MIME-Version: 1.0
In-Reply-To: <20200109011025.GM3929@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eduard Shishkin <edward6@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hello David,

On 09.01.2020 02:10, David Sterba wrote:
> On Wed, Jan 08, 2020 at 07:48:31PM +0100, Zaslonko Mikhail wrote:
>>>> +        } else if (workspace->strm.avail_out == 0) {
>>>> +            /* get another page for the stream end */
>>>> +            kunmap(out_page);
>>>> +            if (nr_pages == nr_dest_pages) {
>>>> +                out_page = NULL;
>>>> +                ret = -E2BIG;
>>>> +                goto out;
>>>> +            }
>>>> +            out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>>>> +            if (out_page == NULL) {
>>>> +                ret = -ENOMEM;
>>>> +                goto out;
>>>> +            }
>>>
>>> Do we need zlib_deflateEnd() for the above error cases?  Thanks,
>>
>> The original btrfs code did not call zlib_deflateEnd() for -E2BIG and 
>> -ENOMEM cases, so I stick to the same logic.
>> Unlike userspace zlib where deflateEnd() frees all dynamically allocated 
>> memory, in the kernel it doesn't do much apart from setting the return 
>> code (since all the memory allocations for kernel zlib are performed in advance).
> 
> Agreed, deflateEnd is not necessary in the error cases.

Can I consider this as 'Acked-by' from your side?
Are there any unanswered questions left on this patch?

> 

Thanks,
Mikhail
