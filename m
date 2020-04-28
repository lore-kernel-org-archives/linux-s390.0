Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbgD1WvH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Apr 2020 18:51:07 -0400
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible pages
Date: Wed, 29 Apr 2020 00:50:43 +0200
Message-Id: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc: borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, dave.hansen@intel.com, peterz@infradead.org, sean.j.christopherson@intel.com

If a page is inaccesible and it is used for things like sendfile, then
the content of the page is not always touched, and can be passed
directly to a driver, causing issues.

This patch fixes the issue by adding a call to arch_make_page_accessible
in page_cache_pipe_buf_confirm; this fixes the issue.

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
