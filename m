Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKMWwh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 13 Nov 2020 17:52:37 -0500
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] md: dm-writeback: add __noreturn to BUG-ging function
Date: Fri, 13 Nov 2020 14:52:28 -0800
Message-Id: <20201113225228.20563-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

Building on arch/s390/ flags this as an error, so add the
__noreturn attribute modifier to prevent the build error.

cc1: some warnings being treated as errors
../drivers/md/dm-writecache.c: In function 'persistent_memory_claim':
../drivers/md/dm-writecache.c:323:1: error: no return statement in function returning non-void [-Werror=return-type]

Fixes: 48debafe4f2f ("dm: add writecache target")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/md/dm-writecache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201113.orig/drivers/md/dm-writecache.c
+++ linux-next-20201113/drivers/md/dm-writecache.c
@@ -317,7 +317,7 @@ err1:
 	return r;
 }
 #else
-static int persistent_memory_claim(struct dm_writecache *wc)
+static int __noreturn persistent_memory_claim(struct dm_writecache *wc)
 {
 	BUG();
 }
