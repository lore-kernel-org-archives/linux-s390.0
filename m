Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD3Ois (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 10:38:48 -0400
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible pages
Date: Thu, 30 Apr 2020 16:38:25 +0200
Message-Id: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: viro@zeniv.linux.org.uk
Cc: borntraeger@de.ibm.com, david@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, jack@suse.cz, kirill@shutemov.name, dave.hansen@intel.com, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com

Inaccessible pages are pages that should not be accessed by any device,
and belong to a protected VM. If any such pages are passed to a
device, there will be I/O errors, which will not always be recoverable,
depending on the architecture and on the specific device.

CPU accesses to inaccessible pages are less problematic, since they are
always recoverable.

Page cache and direct I/O were fixed in a previous patch, in which a
architecture hook is provided to make the page accessible by I/O
devices.

One possible remaining path to sneak a protected page directly to a
device is sendfile and similar syscalls. Those syscalls take a page
directly from the page cache and give them directly to the device with
zero-copy. This bypasses both existing hooks in gup and in writeback.

This patch fixes the issue by adding a call to arch_make_page_accessible
in page_cache_pipe_buf_confirm, thus fixing the issue.

Notice that we only need to make sure the source is accessible, since
zero-copy only works in one direction, and CPU accesses to inaccessible
pages are not a problem. Pagecache-to-pagecache is also not a problem
since that is done by the CPU.

The hook has no overhead for architectures that do not need to deal
with inaccessible pages.

Fixes: f28d43636d6f ("mm/gup/writeback: add callbacks for inaccessible pages")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 fs/splice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 4735defc46ee..f026e0ce9acd 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -106,6 +106,9 @@ static int page_cache_pipe_buf_confirm(struct pipe_inode_info *pipe,
 	struct page *page = buf->page;
 	int err;
 
+	if (arch_make_page_accessible(page))
+		return -EIO;
+
 	if (!PageUptodate(page)) {
 		lock_page(page);
 
-- 
2.25.4
