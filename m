Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727025AbgAGASP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Jan 2020 19:18:15 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0070H8eK087791
        for <linux-s390@vger.kernel.org>; Mon, 6 Jan 2020 19:18:15 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb924um4t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Jan 2020 19:18:15 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <edward6@linux.ibm.com>;
        Tue, 7 Jan 2020 00:18:12 -0000
Subject: Re: [PATCH v3 6/6] btrfs: Use larger zlib buffer for s390 hardware
 compression
References: <20200103223334.20669-1-zaslonko@linux.ibm.com>
 <20200103223334.20669-7-zaslonko@linux.ibm.com>
 <20200106184305.GT3929@suse.cz>
From: Eduard Shishkin <edward6@linux.ibm.com>
Date: Tue, 7 Jan 2020 01:18:06 +0100
MIME-Version: 1.0
In-Reply-To: <20200106184305.GT3929@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <664c2bbd-e06f-a4b3-fe21-982954b6330c@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: dsterba@suse.cz, Mikhail Zaslonko <zaslonko@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 1/6/20 7:43 PM, David Sterba wrote:
> On Fri, Jan 03, 2020 at 11:33:34PM +0100, Mikhail Zaslonko wrote:
>> In order to benefit from s390 zlib hardware compression support,
>> increase the btrfs zlib workspace buffer size from 1 to 4 pages (if
>> s390 zlib hardware support is enabled on the machine). This brings up
>> to 60% better performance in hardware on s390 compared to the PAGE_SIZE
>> buffer and much more compared to the software zlib processing in btrfs.
>> In case of memory pressure fall back to a single page buffer during
>> workspace allocation.
> You could also summarize the previous discussion eg. the question
> whether zlib will decommpress the stream produced on larger input
> buffers on system that has only one page available for each
> decompression round.
>
>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>> ---
>>   fs/btrfs/compression.c |   2 +-
>>   fs/btrfs/zlib.c        | 128 ++++++++++++++++++++++++++++++-----------
>>   2 files changed, 94 insertions(+), 36 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index ee834ef7beb4..6bd0e75a822c 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -1285,7 +1285,7 @@ int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
>>   	/* copy bytes from the working buffer into the pages */
>>   	while (working_bytes > 0) {
>>   		bytes = min_t(unsigned long, bvec.bv_len,
>> -				PAGE_SIZE - buf_offset);
>> +				PAGE_SIZE - (buf_offset % PAGE_SIZE));
>>   		bytes = min(bytes, working_bytes);
>>   
>>   		kaddr = kmap_atomic(bvec.bv_page);
>> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
>> index a6c90a003c12..159486801631 100644
>> --- a/fs/btrfs/zlib.c
>> +++ b/fs/btrfs/zlib.c
>> @@ -20,9 +20,12 @@
>>   #include <linux/refcount.h>
>>   #include "compression.h"
>>   
>> +#define ZLIB_DFLTCC_BUF_SIZE    (4 * PAGE_SIZE)
> Please add a comment what's this constant for
>
>> +
>>   struct workspace {
>>   	z_stream strm;
>>   	char *buf;
>> +	unsigned long buf_size;
> int should be enough here
>
>>   	struct list_head list;
>>   	int level;
>>   };
>> @@ -61,7 +64,17 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
>>   			zlib_inflate_workspacesize());
>>   	workspace->strm.workspace = kvmalloc(workspacesize, GFP_KERNEL);
>>   	workspace->level = level;
>> -	workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>> +	workspace->buf = NULL;
>> +	if (zlib_deflate_dfltcc_enabled()) {
>> +		workspace->buf = kmalloc(ZLIB_DFLTCC_BUF_SIZE,
>> +					 __GFP_NOMEMALLOC | __GFP_NORETRY |
>> +					 __GFP_NOWARN | GFP_NOIO);
> Why do you use this wild GFP flag combination? I can understand NOWARN,
> but why the others?

This addresses the following complaint about order 2 allocation with 
GFP_KERNEL:
https://lkml.org/lkml/2019/11/26/417

Below a fallback to a single page is implemented, as it was suggested.
So, the initial (more costly) allocation should be made with minimal 
aggression
to allow the allocator fail. Otherwise, that fallback simply doesn't 
make sense.
Hence, such a combination.

Thanks,
Eduard.

>> +		workspace->buf_size = ZLIB_DFLTCC_BUF_SIZE;
>> +	}
>> +	if (!workspace->buf) {
>> +		workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>> +		workspace->buf_size = PAGE_SIZE;
>> +	}
>>   	if (!workspace->strm.workspace || !workspace->buf)
>>   		goto fail;
>>   
>> @@ -78,6 +91,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>   		unsigned long *total_in, unsigned long *total_out)
>>   {
>>   	struct workspace *workspace = list_entry(ws, struct workspace, list);
>> +	int i;
> This should be declared in the inner most scope of use
>
>>   	int ret;
>>   	char *data_in;
>>   	char *cpage_out;
>> @@ -85,6 +99,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>   	struct page *in_page = NULL;
>>   	struct page *out_page = NULL;
>>   	unsigned long bytes_left;
>> +	unsigned long in_buf_pages;
> long does not seem to be necessary, int
>
>>   	unsigned long len = *total_out;
>>   	unsigned long nr_dest_pages = *out_pages;
>>   	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
>> @@ -102,9 +117,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>   	workspace->strm.total_in = 0;
>>   	workspace->strm.total_out = 0;
>>   
>> -	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
>> -	data_in = kmap(in_page);
>> -
>>   	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>>   	if (out_page == NULL) {
>>   		ret = -ENOMEM;
>> @@ -114,12 +126,48 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>   	pages[0] = out_page;
>>   	nr_pages = 1;
>>   
>> -	workspace->strm.next_in = data_in;
>> +	workspace->strm.next_in = workspace->buf;
>> +	workspace->strm.avail_in = 0;
>>   	workspace->strm.next_out = cpage_out;
>>   	workspace->strm.avail_out = PAGE_SIZE;
>> -	workspace->strm.avail_in = min(len, PAGE_SIZE);
>>   
>>   	while (workspace->strm.total_in < len) {
>> +		/* get next input pages and copy the contents to
>> +		 * the workspace buffer if required
>> +		 */
> Please format the comment properly
>
>> +		if (workspace->strm.avail_in == 0) {
>> +			bytes_left = len - workspace->strm.total_in;
>> +			in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
>> +					   workspace->buf_size / PAGE_SIZE);
>> +			if (in_buf_pages > 1) {
> 				int i;
>
>> +				for (i = 0; i < in_buf_pages; i++) {
>> +					if (in_page) {
>> +						kunmap(in_page);
>> +						put_page(in_page);
>> +					}
>> +					in_page = find_get_page(mapping,
>> +								start >> PAGE_SHIFT);
>> +					data_in = kmap(in_page);
>> +					memcpy(workspace->buf + i*PAGE_SIZE,
> 					spaces around '*': i * PAGE_SIZE
>
>> +					       data_in, PAGE_SIZE);
>> +					start += PAGE_SIZE;
>> +				}
>> +				workspace->strm.next_in = workspace->buf;
>> +			} else {
>> +				if (in_page) {
>> +					kunmap(in_page);
>> +					put_page(in_page);
>> +				}
>> +				in_page = find_get_page(mapping,
>> +							start >> PAGE_SHIFT);
>> +				data_in = kmap(in_page);
>> +				start += PAGE_SIZE;
>> +				workspace->strm.next_in = data_in;
>> +			}
>> +			workspace->strm.avail_in = min(bytes_left,
>> +						       workspace->buf_size);
>> +		}
>> +
>>   		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
>>   		if (ret != Z_OK) {
>>   			pr_debug("BTRFS: deflate in loop returned %d\n",
>> @@ -136,6 +184,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>   			ret = -E2BIG;
>>   			goto out;
>>   		}
>> +
>>   		/* we need another page for writing out.  Test this
>>   		 * before the total_in so we will pull in a new page for
>>   		 * the stream end if required
>> @@ -161,33 +210,42 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>   		/* we're all done */
>>   		if (workspace->strm.total_in >= len)
>>   			break;
>> -
>> -		/* we've read in a full page, get a new one */
>> -		if (workspace->strm.avail_in == 0) {
>> -			if (workspace->strm.total_out > max_out)
>> -				break;
>> -
>> -			bytes_left = len - workspace->strm.total_in;
>> -			kunmap(in_page);
>> -			put_page(in_page);
>> -
>> -			start += PAGE_SIZE;
>> -			in_page = find_get_page(mapping,
>> -						start >> PAGE_SHIFT);
>> -			data_in = kmap(in_page);
>> -			workspace->strm.avail_in = min(bytes_left,
>> -							   PAGE_SIZE);
>> -			workspace->strm.next_in = data_in;
>> -		}
>> +		if (workspace->strm.total_out > max_out)
>> +			break;
>>   	}
>>   	workspace->strm.avail_in = 0;
>> -	ret = zlib_deflate(&workspace->strm, Z_FINISH);
>> -	zlib_deflateEnd(&workspace->strm);
>> -
>> -	if (ret != Z_STREAM_END) {
>> -		ret = -EIO;
>> -		goto out;
>> +	/* call deflate with Z_FINISH flush parameter providing more output
>> +	 * space but no more input data, until it returns with Z_STREAM_END
>> +	 */
> Comment formatting
>
>> +	while (ret != Z_STREAM_END) {
>> +		ret = zlib_deflate(&workspace->strm, Z_FINISH);
>> +		if (ret == Z_STREAM_END)
>> +			break;
>> +		if (ret != Z_OK && ret != Z_BUF_ERROR) {
>> +			zlib_deflateEnd(&workspace->strm);
>> +			ret = -EIO;
>> +			goto out;
>> +		} else if (workspace->strm.avail_out == 0) {
>> +			/* get another page for the stream end */
>> +			kunmap(out_page);
>> +			if (nr_pages == nr_dest_pages) {
>> +				out_page = NULL;
>> +				ret = -E2BIG;
>> +				goto out;
>> +			}
>> +			out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>> +			if (out_page == NULL) {
>> +				ret = -ENOMEM;
>> +				goto out;
>> +			}
>> +			cpage_out = kmap(out_page);
>> +			pages[nr_pages] = out_page;
>> +			nr_pages++;
>> +			workspace->strm.avail_out = PAGE_SIZE;
>> +			workspace->strm.next_out = cpage_out;
>> +		}
>>   	}
>> +	zlib_deflateEnd(&workspace->strm);
>>   
>>   	if (workspace->strm.total_out >= workspace->strm.total_in) {
>>   		ret = -E2BIG;
>> @@ -231,7 +289,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>>   
>>   	workspace->strm.total_out = 0;
>>   	workspace->strm.next_out = workspace->buf;
>> -	workspace->strm.avail_out = PAGE_SIZE;
>> +	workspace->strm.avail_out = workspace->buf_size;
>>   
>>   	/* If it's deflate, and it's got no preset dictionary, then
>>   	   we can tell zlib to skip the adler32 check. */
>> @@ -270,7 +328,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>>   		}
>>   
>>   		workspace->strm.next_out = workspace->buf;
>> -		workspace->strm.avail_out = PAGE_SIZE;
>> +		workspace->strm.avail_out = workspace->buf_size;
>>   
>>   		if (workspace->strm.avail_in == 0) {
>>   			unsigned long tmp;
>> @@ -320,7 +378,7 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
>>   	workspace->strm.total_in = 0;
>>   
>>   	workspace->strm.next_out = workspace->buf;
>> -	workspace->strm.avail_out = PAGE_SIZE;
>> +	workspace->strm.avail_out = workspace->buf_size;
>>   	workspace->strm.total_out = 0;
>>   	/* If it's deflate, and it's got no preset dictionary, then
>>   	   we can tell zlib to skip the adler32 check. */
>> @@ -364,7 +422,7 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
>>   			buf_offset = 0;
>>   
>>   		bytes = min(PAGE_SIZE - pg_offset,
>> -			    PAGE_SIZE - buf_offset);
>> +			    PAGE_SIZE - (buf_offset % PAGE_SIZE));
>>   		bytes = min(bytes, bytes_left);
>>   
>>   		kaddr = kmap_atomic(dest_page);
>> @@ -375,7 +433,7 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
>>   		bytes_left -= bytes;
>>   next:
>>   		workspace->strm.next_out = workspace->buf;
>> -		workspace->strm.avail_out = PAGE_SIZE;
>> +		workspace->strm.avail_out = workspace->buf_size;
>>   	}
>>   
>>   	if (ret != Z_STREAM_END && bytes_left != 0)
>> -- 
>> 2.17.1
>>
