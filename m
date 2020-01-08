Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727427AbgAHSsr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jan 2020 13:48:47 -0500
Subject: Re: [PATCH v4] btrfs: Use larger zlib buffer for s390 hardware
 compression
References: <20200107143058.GU3929@twin.jikos.cz>
 <20200108105103.29028-1-zaslonko@linux.ibm.com>
 <75a2d45c-fd7b-9542-403d-caea7d977add@toxicpanda.com>
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Message-ID: <94e06859-6174-c80d-3eb6-065f67fbe95d@linux.ibm.com>
Date: Wed, 8 Jan 2020 19:48:31 +0100
MIME-Version: 1.0
In-Reply-To: <75a2d45c-fd7b-9542-403d-caea7d977add@toxicpanda.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eduard Shishkin <edward6@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On 08.01.2020 16:08, Josef Bacik wrote:
> On 1/8/20 5:51 AM, Mikhail Zaslonko wrote:
>> In order to benefit from s390 zlib hardware compression support,
>> increase the btrfs zlib workspace buffer size from 1 to 4 pages (if
>> s390 zlib hardware support is enabled on the machine). This brings up
>> to 60% better performance in hardware on s390 compared to the PAGE_SIZE
>> buffer and much more compared to the software zlib processing in btrfs.
>> In case of memory pressure, fall back to a single page buffer during
>> workspace allocation.
>> The data compressed with larger input buffers will still conform to zlib
>> standard and thus can be decompressed also on a systems that uses only
>> PAGE_SIZE buffer for btrfs zlib.
>>
>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> 
> 
>> ---
>>   fs/btrfs/compression.c |   2 +-
>>   fs/btrfs/zlib.c        | 135 ++++++++++++++++++++++++++++++-----------
>>   2 files changed, 101 insertions(+), 36 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index ee834ef7beb4..6bd0e75a822c 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -1285,7 +1285,7 @@ int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
>>       /* copy bytes from the working buffer into the pages */
>>       while (working_bytes > 0) {
>>           bytes = min_t(unsigned long, bvec.bv_len,
>> -                PAGE_SIZE - buf_offset);
>> +                PAGE_SIZE - (buf_offset % PAGE_SIZE));
>>           bytes = min(bytes, working_bytes);
>>             kaddr = kmap_atomic(bvec.bv_page);
>> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
>> index a6c90a003c12..05615a1099db 100644
>> --- a/fs/btrfs/zlib.c
>> +++ b/fs/btrfs/zlib.c
>> @@ -20,9 +20,13 @@
>>   #include <linux/refcount.h>
>>   #include "compression.h"
>>   +/* workspace buffer size for s390 zlib hardware support */
>> +#define ZLIB_DFLTCC_BUF_SIZE    (4 * PAGE_SIZE)
>> +
>>   struct workspace {
>>       z_stream strm;
>>       char *buf;
>> +    unsigned int buf_size;
>>       struct list_head list;
>>       int level;
>>   };
>> @@ -61,7 +65,21 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
>>               zlib_inflate_workspacesize());
>>       workspace->strm.workspace = kvmalloc(workspacesize, GFP_KERNEL);
>>       workspace->level = level;
>> -    workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>> +    workspace->buf = NULL;
>> +    /*
>> +     * In case of s390 zlib hardware support, allocate lager workspace
>> +     * buffer. If allocator fails, fall back to a single page buffer.
>> +     */
>> +    if (zlib_deflate_dfltcc_enabled()) {
>> +        workspace->buf = kmalloc(ZLIB_DFLTCC_BUF_SIZE,
>> +                     __GFP_NOMEMALLOC | __GFP_NORETRY |
>> +                     __GFP_NOWARN | GFP_NOIO);
>> +        workspace->buf_size = ZLIB_DFLTCC_BUF_SIZE;
>> +    }
>> +    if (!workspace->buf) {
>> +        workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>> +        workspace->buf_size = PAGE_SIZE;
>> +    }
>>       if (!workspace->strm.workspace || !workspace->buf)
>>           goto fail;
>>   @@ -85,6 +103,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>       struct page *in_page = NULL;
>>       struct page *out_page = NULL;
>>       unsigned long bytes_left;
>> +    unsigned int in_buf_pages;
>>       unsigned long len = *total_out;
>>       unsigned long nr_dest_pages = *out_pages;
>>       const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
>> @@ -102,9 +121,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>       workspace->strm.total_in = 0;
>>       workspace->strm.total_out = 0;
>>   -    in_page = find_get_page(mapping, start >> PAGE_SHIFT);
>> -    data_in = kmap(in_page);
>> -
>>       out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>>       if (out_page == NULL) {
>>           ret = -ENOMEM;
>> @@ -114,12 +130,51 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>       pages[0] = out_page;
>>       nr_pages = 1;
>>   -    workspace->strm.next_in = data_in;
>> +    workspace->strm.next_in = workspace->buf;
>> +    workspace->strm.avail_in = 0;
>>       workspace->strm.next_out = cpage_out;
>>       workspace->strm.avail_out = PAGE_SIZE;
>> -    workspace->strm.avail_in = min(len, PAGE_SIZE);
>>         while (workspace->strm.total_in < len) {
>> +        /*
>> +         * Get next input pages and copy the contents to
>> +         * the workspace buffer if required.
>> +         */
>> +        if (workspace->strm.avail_in == 0) {
>> +            bytes_left = len - workspace->strm.total_in;
>> +            in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
>> +                       workspace->buf_size / PAGE_SIZE);
>> +            if (in_buf_pages > 1) {
>> +                int i;
>> +
>> +                for (i = 0; i < in_buf_pages; i++) {
>> +                    if (in_page) {
>> +                        kunmap(in_page);
>> +                        put_page(in_page);
>> +                    }
>> +                    in_page = find_get_page(mapping,
>> +                                start >> PAGE_SHIFT);
>> +                    data_in = kmap(in_page);
>> +                    memcpy(workspace->buf + i * PAGE_SIZE,
>> +                           data_in, PAGE_SIZE);
>> +                    start += PAGE_SIZE;
>> +                }
>> +                workspace->strm.next_in = workspace->buf;
>> +            } else {
>> +                if (in_page) {
>> +                    kunmap(in_page);
>> +                    put_page(in_page);
>> +                }
>> +                in_page = find_get_page(mapping,
>> +                            start >> PAGE_SHIFT);
>> +                data_in = kmap(in_page);
>> +                start += PAGE_SIZE;
>> +                workspace->strm.next_in = data_in;
>> +            }
>> +            workspace->strm.avail_in = min(bytes_left,
>> +                               (unsigned long) workspace->buf_size);
>> +        }
>> +
>>           ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
>>           if (ret != Z_OK) {
>>               pr_debug("BTRFS: deflate in loop returned %d\n",
>> @@ -161,33 +216,43 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>           /* we're all done */
>>           if (workspace->strm.total_in >= len)
>>               break;
>> -
>> -        /* we've read in a full page, get a new one */
>> -        if (workspace->strm.avail_in == 0) {
>> -            if (workspace->strm.total_out > max_out)
>> -                break;
>> -
>> -            bytes_left = len - workspace->strm.total_in;
>> -            kunmap(in_page);
>> -            put_page(in_page);
>> -
>> -            start += PAGE_SIZE;
>> -            in_page = find_get_page(mapping,
>> -                        start >> PAGE_SHIFT);
>> -            data_in = kmap(in_page);
>> -            workspace->strm.avail_in = min(bytes_left,
>> -                               PAGE_SIZE);
>> -            workspace->strm.next_in = data_in;
>> -        }
>> +        if (workspace->strm.total_out > max_out)
>> +            break;
>>       }
>>       workspace->strm.avail_in = 0;
>> -    ret = zlib_deflate(&workspace->strm, Z_FINISH);
>> -    zlib_deflateEnd(&workspace->strm);
>> -
>> -    if (ret != Z_STREAM_END) {
>> -        ret = -EIO;
>> -        goto out;
>> +    /*
>> +     * Call deflate with Z_FINISH flush parameter providing more output
>> +     * space but no more input data, until it returns with Z_STREAM_END.
>> +     */
>> +    while (ret != Z_STREAM_END) {
>> +        ret = zlib_deflate(&workspace->strm, Z_FINISH);
>> +        if (ret == Z_STREAM_END)
>> +            break;
>> +        if (ret != Z_OK && ret != Z_BUF_ERROR) {
>> +            zlib_deflateEnd(&workspace->strm);
>> +            ret = -EIO;
>> +            goto out;
>> +        } else if (workspace->strm.avail_out == 0) {
>> +            /* get another page for the stream end */
>> +            kunmap(out_page);
>> +            if (nr_pages == nr_dest_pages) {
>> +                out_page = NULL;
>> +                ret = -E2BIG;
>> +                goto out;
>> +            }
>> +            out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>> +            if (out_page == NULL) {
>> +                ret = -ENOMEM;
>> +                goto out;
>> +            }
> 
> Do we need zlib_deflateEnd() for the above error cases?  Thanks,

The original btrfs code did not call zlib_deflateEnd() for -E2BIG and 
-ENOMEM cases, so I stick to the same logic.
Unlike userspace zlib where deflateEnd() frees all dynamically allocated 
memory, in the kernel it doesn't do much apart from setting the return 
code (since all the memory allocations for kernel zlib are performed in advance).

> 
> Josef
