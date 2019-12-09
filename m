Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbfLIP37 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 10:29:59 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9FSkoH075916
        for <linux-s390@vger.kernel.org>; Mon, 9 Dec 2019 10:29:59 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsrdm9gks-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 10:29:58 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Mon, 9 Dec 2019 15:29:56 -0000
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH v2 6/6] btrfs: Use larger zlib buffer for s390 hardware compression
Date: Mon,  9 Dec 2019 16:29:48 +0100
In-Reply-To: <20191209152948.37080-1-zaslonko@linux.ibm.com>
References: <20191209152948.37080-1-zaslonko@linux.ibm.com>
Message-Id: <20191209152948.37080-7-zaslonko@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eduard Shishkin <edward6@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, zaslonko@linux.ibm.com

Due to the small size of zlib buffer (1 page) set in btrfs code, s390
hardware compression is rather limited in terms of performance. Increasing
the buffer size to 4 pages when s390 zlib hardware support is enabled
would bring significant benefit to btrfs zlib (up to 60% better performance
compared to the PAGE_SIZE buffer). In case of memory pressure we fall back
to a single page buffer during workspace allocation.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 fs/btrfs/compression.c |   2 +-
 fs/btrfs/zlib.c        | 118 +++++++++++++++++++++++++++--------------
 2 files changed, 80 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b05b361e2062..f789b356fd8b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1158,7 +1158,7 @@ int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
 	/* copy bytes from the working buffer into the pages */
 	while (working_bytes > 0) {
 		bytes = min_t(unsigned long, bvec.bv_len,
-				PAGE_SIZE - buf_offset);
+				PAGE_SIZE - (buf_offset % PAGE_SIZE));
 		bytes = min(bytes, working_bytes);
 
 		kaddr = kmap_atomic(bvec.bv_page);
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index df1aace5df50..0bc0d57ba233 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -20,9 +20,12 @@
 #include <linux/refcount.h>
 #include "compression.h"
 
+#define ZLIB_DFLTCC_BUF_SIZE    (4 * PAGE_SIZE)
+
 struct workspace {
 	z_stream strm;
 	char *buf;
+	unsigned long buf_size;
 	struct list_head list;
 	int level;
 };
@@ -76,7 +79,17 @@ static struct list_head *zlib_alloc_workspace(unsigned int level)
 			zlib_inflate_workspacesize());
 	workspace->strm.workspace = kvmalloc(workspacesize, GFP_KERNEL);
 	workspace->level = level;
-	workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	workspace->buf = NULL;
+	if (zlib_deflate_dfltcc_enabled()) {
+		workspace->buf = kmalloc(ZLIB_DFLTCC_BUF_SIZE,
+					 __GFP_NOMEMALLOC | __GFP_NORETRY |
+					 __GFP_NOWARN | GFP_NOIO);
+		workspace->buf_size = ZLIB_DFLTCC_BUF_SIZE;
+	}
+	if (!workspace->buf) {
+		workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		workspace->buf_size = PAGE_SIZE;
+	}
 	if (!workspace->strm.workspace || !workspace->buf)
 		goto fail;
 
@@ -97,6 +110,7 @@ static int zlib_compress_pages(struct list_head *ws,
 			       unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	int i;
 	int ret;
 	char *data_in;
 	char *cpage_out;
@@ -104,6 +118,7 @@ static int zlib_compress_pages(struct list_head *ws,
 	struct page *in_page = NULL;
 	struct page *out_page = NULL;
 	unsigned long bytes_left;
+	unsigned long in_buf_pages;
 	unsigned long len = *total_out;
 	unsigned long nr_dest_pages = *out_pages;
 	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
@@ -121,9 +136,6 @@ static int zlib_compress_pages(struct list_head *ws,
 	workspace->strm.total_in = 0;
 	workspace->strm.total_out = 0;
 
-	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-	data_in = kmap(in_page);
-
 	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
 	if (out_page == NULL) {
 		ret = -ENOMEM;
@@ -133,12 +145,34 @@ static int zlib_compress_pages(struct list_head *ws,
 	pages[0] = out_page;
 	nr_pages = 1;
 
-	workspace->strm.next_in = data_in;
+	workspace->strm.next_in = workspace->buf;
+	workspace->strm.avail_in = 0;
 	workspace->strm.next_out = cpage_out;
 	workspace->strm.avail_out = PAGE_SIZE;
-	workspace->strm.avail_in = min(len, PAGE_SIZE);
 
 	while (workspace->strm.total_in < len) {
+		/* get next set of pages and copy their contents to
+		 * the input buffer for the following deflate call
+		 */
+		if (workspace->strm.avail_in == 0) {
+			bytes_left = len - workspace->strm.total_in;
+			in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
+					   workspace->buf_size / PAGE_SIZE);
+			for (i = 0; i < in_buf_pages; i++) {
+				in_page = find_get_page(mapping,
+							start >> PAGE_SHIFT);
+				data_in = kmap(in_page);
+				memcpy(workspace->buf + i*PAGE_SIZE, data_in,
+				       PAGE_SIZE);
+				kunmap(in_page);
+				put_page(in_page);
+				start += PAGE_SIZE;
+			}
+			workspace->strm.avail_in = min(bytes_left,
+						       workspace->buf_size);
+			workspace->strm.next_in = workspace->buf;
+		}
+
 		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
 		if (ret != Z_OK) {
 			pr_debug("BTRFS: deflate in loop returned %d\n",
@@ -155,6 +189,7 @@ static int zlib_compress_pages(struct list_head *ws,
 			ret = -E2BIG;
 			goto out;
 		}
+
 		/* we need another page for writing out.  Test this
 		 * before the total_in so we will pull in a new page for
 		 * the stream end if required
@@ -180,33 +215,42 @@ static int zlib_compress_pages(struct list_head *ws,
 		/* we're all done */
 		if (workspace->strm.total_in >= len)
 			break;
-
-		/* we've read in a full page, get a new one */
-		if (workspace->strm.avail_in == 0) {
-			if (workspace->strm.total_out > max_out)
-				break;
-
-			bytes_left = len - workspace->strm.total_in;
-			kunmap(in_page);
-			put_page(in_page);
-
-			start += PAGE_SIZE;
-			in_page = find_get_page(mapping,
-						start >> PAGE_SHIFT);
-			data_in = kmap(in_page);
-			workspace->strm.avail_in = min(bytes_left,
-							   PAGE_SIZE);
-			workspace->strm.next_in = data_in;
-		}
+		if (workspace->strm.total_out > max_out)
+			break;
 	}
 	workspace->strm.avail_in = 0;
-	ret = zlib_deflate(&workspace->strm, Z_FINISH);
-	zlib_deflateEnd(&workspace->strm);
-
-	if (ret != Z_STREAM_END) {
-		ret = -EIO;
-		goto out;
+	/* call deflate with Z_FINISH flush parameter providing more output
+	 * space but no more input data, until it returns with Z_STREAM_END
+	 */
+	while (ret != Z_STREAM_END) {
+		ret = zlib_deflate(&workspace->strm, Z_FINISH);
+		if (ret == Z_STREAM_END)
+			break;
+		if (ret != Z_OK && ret != Z_BUF_ERROR) {
+			zlib_deflateEnd(&workspace->strm);
+			ret = -EIO;
+			goto out;
+		} else if (workspace->strm.avail_out == 0) {
+			/* get another page for the stream end */
+			kunmap(out_page);
+			if (nr_pages == nr_dest_pages) {
+				out_page = NULL;
+				ret = -E2BIG;
+				goto out;
+			}
+			out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+			if (out_page == NULL) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			cpage_out = kmap(out_page);
+			pages[nr_pages] = out_page;
+			nr_pages++;
+			workspace->strm.avail_out = PAGE_SIZE;
+			workspace->strm.next_out = cpage_out;
+		}
 	}
+	zlib_deflateEnd(&workspace->strm);
 
 	if (workspace->strm.total_out >= workspace->strm.total_in) {
 		ret = -E2BIG;
@@ -221,10 +265,6 @@ static int zlib_compress_pages(struct list_head *ws,
 	if (out_page)
 		kunmap(out_page);
 
-	if (in_page) {
-		kunmap(in_page);
-		put_page(in_page);
-	}
 	return ret;
 }
 
@@ -250,7 +290,7 @@ static int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	workspace->strm.total_out = 0;
 	workspace->strm.next_out = workspace->buf;
-	workspace->strm.avail_out = PAGE_SIZE;
+	workspace->strm.avail_out = workspace->buf_size;
 
 	/* If it's deflate, and it's got no preset dictionary, then
 	   we can tell zlib to skip the adler32 check. */
@@ -289,7 +329,7 @@ static int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		}
 
 		workspace->strm.next_out = workspace->buf;
-		workspace->strm.avail_out = PAGE_SIZE;
+		workspace->strm.avail_out = workspace->buf_size;
 
 		if (workspace->strm.avail_in == 0) {
 			unsigned long tmp;
@@ -340,7 +380,7 @@ static int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 	workspace->strm.total_in = 0;
 
 	workspace->strm.next_out = workspace->buf;
-	workspace->strm.avail_out = PAGE_SIZE;
+	workspace->strm.avail_out = workspace->buf_size;
 	workspace->strm.total_out = 0;
 	/* If it's deflate, and it's got no preset dictionary, then
 	   we can tell zlib to skip the adler32 check. */
@@ -384,7 +424,7 @@ static int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 			buf_offset = 0;
 
 		bytes = min(PAGE_SIZE - pg_offset,
-			    PAGE_SIZE - buf_offset);
+			    PAGE_SIZE - (buf_offset % PAGE_SIZE));
 		bytes = min(bytes, bytes_left);
 
 		kaddr = kmap_atomic(dest_page);
@@ -395,7 +435,7 @@ static int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 		bytes_left -= bytes;
 next:
 		workspace->strm.next_out = workspace->buf;
-		workspace->strm.avail_out = PAGE_SIZE;
+		workspace->strm.avail_out = workspace->buf_size;
 	}
 
 	if (ret != Z_STREAM_END && bytes_left != 0)
-- 
2.17.1
