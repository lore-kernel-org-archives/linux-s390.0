Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] btrfs: Use larger zlib buffer for s390 hardware
 compression
References: <20191209152948.37080-1-zaslonko@linux.ibm.com>
 <20191209152948.37080-7-zaslonko@linux.ibm.com>
 <97b3a11d-2e52-c710-ee25-157e562eb3d0@linux.ibm.com>
 <20191213173526.GC3929@twin.jikos.cz>
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Message-ID: <9068869f-1ec2-f8c1-c2e2-4d38e62572cf@linux.ibm.com>
Date: Mon, 16 Dec 2019 17:31:19 +0100
MIME-Version: 1.0
In-Reply-To: <20191213173526.GC3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: dsterba@suse.cz, Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eduard Shishkin <edward6@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>

Hi David,

On 13.12.2019 18:35, David Sterba wrote:
> On Fri, Dec 13, 2019 at 05:10:10PM +0100, Zaslonko Mikhail wrote:
>> Hello,
>>
>> Could you please review the patch for btrfs below.
>>
>> Apart from falling back to 1 page, I have set the condition to allocate 
>> 4-pages zlib workspace buffer only if s390 Deflate-Conversion facility
>> is installed and enabled. Thus, it will take effect on s390 architecture
>> only.
>>
>> Currently in zlib_compress_pages() I always copy input pages to the workspace
>> buffer prior to zlib_deflate call. Would that make sense, to pass the page
>> itself, as before, based on the workspace buf_size (for 1-page buffer)?
> 
> Doesn't the copy back and forth kill the improvements brought by the
> hw supported decompression?

Well, I'm not sure how to avoid this copy step here. As far as I understand
the input data in btrfs_compress_pages() doesn't always represent continuous 
pages, so I copy input pages to a continuous buffer prior to a compression call.   
But even with this memcpy in place, the hw supported compression shows
significant improvements.
What I can definitely do is to skip the copy if no s390 hardware compression
support enabled.

> 
>> As for calling zlib_deflate with Z_FINISH flush parameter in a loop until
>> Z_STREAM_END is returned, that comes in agreement with the zlib manual.
> 
> The concerns are about zlib stream that take 4 pages on input and on the
> decompression side only 1 page is available for the output. Ie. as if
> the filesystem was created on s390 with dflcc then opened on x86 host.

I'm not sure I fully understand the concern here. If we talk of backward 
compatibility, I do not see side effects of using larger buffers. Data in 
the compressed state might differ indeed, but it will sill conform to zlib
standard and thus can be decompressed. The smaller out buffer would just 
take more zlib calls to flush the output.


> The zlib_deflate(Z_FINISH) happens on the compresission side.
> 
