From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 19:24:41 +0000
Subject: [CRIU][PATCH v2 13/17] criu/files: Fix wait_fds_event() for 64 bit platforms
Message-Id: <20170629192445.55580-14-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The htole64() function returns a 64 bit value. This is stored in
a 32 bit integer in wait_fds_event() which results in 0 for big-endian
64 bit platforms. The fuxtex() system call also requires 32 bit values.

Fix this and use htole32() also for 64 bit platforms.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 criu/files.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/criu/files.c b/criu/files.c
index a36eb36..bad6069 100644
--- a/criu/files.c
+++ b/criu/files.c
@@ -193,11 +193,8 @@ void wait_fds_event(void)
 {
 	futex_t *f = &current->task_st;
 	int value;
-#if BITS_PER_LONG == 64
-	value = htole64(FDS_EVENT);
-#else
+
 	value = htole32(FDS_EVENT);
-#endif
 	futex_wait_if_cond(f, value, &);
 	clear_fds_event();
 }
-- 
2.7.4
