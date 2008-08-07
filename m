Return-Path: <linux-kernel-owner+w=401wt.eu-S1754772AbYHGNmn@vger.kernel.org>
From: Julien Brunel <brunel@diku.dk>
Subject: [PATCH] drivers/s390: Use an IS_ERR test rather than a NULL test
Date: Thu, 7 Aug 2008 15:42:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808071542.22880.brunel@diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julien Brunel <brunel@diku.dk>

In case of error, functions dasd_kmalloc_request and idal_buffer_alloc
return an ERR pointer, but never return the NULL pointer. So after a
call to one of these functions, a NULL test should be replaced by an
IS_ERR test.

A simplified version of the semantic patch that makes this change is
as follows: 
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@correct_null_test@
expression x,E;
statement S1, S2;
@@
x = 
(
  dasd_kmalloc_request(...)
|
  idal_buffer_alloc(...)
)
<... when != x = E
if (
(
- x@p2 != NULL
+ ! IS_ERR ( x )
|
- x@p2 == NULL
+ IS_ERR( x )
)
 )
S1
else S2
...>
? x = E;
// </smpl>

Signed-off-by:  Julien Brunel <brunel@diku.dk>
Signed-off-by:  Julia Lawall <julia@diku.dk>

---
 drivers/s390/block/dasd_eer.c |    3 ++-
 drivers/s390/char/tape_char.c |    2 +-
 drivers/s390/char/tape_std.c  |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff -u -p a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -16,6 +16,7 @@
 #include <linux/poll.h>
 #include <linux/mutex.h>
 #include <linux/smp_lock.h>
+#include <linux/err.h>
 
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
@@ -457,7 +458,7 @@ int dasd_eer_enable(struct dasd_device *
 
 	cqr = dasd_kmalloc_request("ECKD", 1 /* SNSS */,
 				   SNSS_DATA_SIZE, device);
-	if (!cqr)
+	if (IS_ERR(cqr))
 		return -ENOMEM;
 
 	cqr->startdev = device;
diff -u -p a/drivers/s390/char/tape_char.c b/drivers/s390/char/tape_char.c
--- a/drivers/s390/char/tape_char.c
+++ b/drivers/s390/char/tape_char.c
@@ -109,7 +109,7 @@ tapechar_check_idalbuffer(struct tape_de
 
 	/* The current idal buffer is not correct. Allocate a new one. */
 	new = idal_buffer_alloc(block_size, 0);
-	if (new == NULL)
+	if (IS_ERR(new))
 		return -ENOMEM;
 
 	if (device->char_data.idal_buf != NULL)
diff -u -p a/drivers/s390/char/tape_std.c b/drivers/s390/char/tape_std.c
--- a/drivers/s390/char/tape_std.c
+++ b/drivers/s390/char/tape_std.c
@@ -248,7 +248,7 @@ tape_std_mtsetblk(struct tape_device *de
 
 	/* Allocate a new idal buffer. */
 	new = idal_buffer_alloc(count, 0);
-	if (new == NULL)
+	if (IS_ERR(new))
 		return -ENOMEM;
 	if (device->char_data.idal_buf != NULL)
 		idal_buffer_free(device->char_data.idal_buf);
