From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 19:24:44 +0000
Subject: [CRIU][PATCH v2 16/17] zdtm/static/fdt_shared: Fix buffer size
Message-Id: <20170629192445.55580-17-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The TEST_STRING "Hello World!" has 13 bytes size. Therefore the 10 bytes
used for the buffer size are not sufficient.

Fix this and use sizeof() to be on the safe side.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 test/zdtm/static/fdt_shared.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/zdtm/static/fdt_shared.c b/test/zdtm/static/fdt_shared.c
index b1c74d0..2111356 100644
--- a/test/zdtm/static/fdt_shared.c
+++ b/test/zdtm/static/fdt_shared.c
@@ -62,7 +62,7 @@ static pid_t clone_child(int (*fn)(void *), int flags)
 
 static int child2(void *_arg)
 {
-	char buf[10];
+	char buf[sizeof(TEST_STRING)];
 
 	forked();
 	test_waitsig();
@@ -90,7 +90,7 @@ static int child3(void *_arg)
 
 static int child(void *_arg)
 {
-	char buf[10];
+	char buf[sizeof(TEST_STRING)];
 	pid_t pid, pid2;
 	int status;
 
-- 
2.7.4
