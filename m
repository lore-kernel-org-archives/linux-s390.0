From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 16:12:05 +0000
Subject: [CRIU][PATCH 7/7] zdtm/static/sem: Use "union semun" instead of int
Message-Id: <20170628161205.37787-8-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Alice Frosi <alice@inux.vnet.ibm.com>

Use "union semun" for semctl() to make testcase also work on s390x.

Signed-off-by: Alice Frosi <alice@linux.vnet.ibm.com>
---
 test/zdtm/static/sem.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/test/zdtm/static/sem.c b/test/zdtm/static/sem.c
index 6e459a8..1db8f00 100644
--- a/test/zdtm/static/sem.c
+++ b/test/zdtm/static/sem.c
@@ -110,7 +110,13 @@ int main(int argc, char **argv)
 {
 	int id, key;
 	int i;
-	int val[NSEMS];
+	/* See man semctl */
+	union semun {
+		int		val;
+		struct		semid_ds *buf;
+		unsigned short	*array;
+		struct seminfo	*__buf;
+	} val[NSEMS];
 	int ret, fail_count = 0;
 
 	test_init(argc, argv);
@@ -129,7 +135,7 @@ int main(int argc, char **argv)
 	}
 
 	for (i = 0; i < NSEMS; i++) {
-		val[i] = lrand48() & 0x7;
+		val[i].val = lrand48() & 0x7;
 
 		if (semctl(id, i, SETVAL, val[i]) == -1) {
 			fail_count++;
@@ -142,7 +148,7 @@ int main(int argc, char **argv)
 	test_waitsig();
 
 	for (i = 0; i < NSEMS; i++) {
-		ret = check_sem_by_id(id, i, val[i]);
+		ret = check_sem_by_id(id, i, val[i].val);
 		if (ret < 0) {
 			fail_count++;
 			fail("Check sem %d by id failed", i);
@@ -155,14 +161,14 @@ int main(int argc, char **argv)
 			goto out_destroy;
 		}
 
-		val[i] = semctl(id, 0, GETVAL);
-		if (val[i] < 0) {
+		val[i].val = semctl(id, 0, GETVAL);
+		if (val[i].val < 0) {
 			fail("Failed to get sem %d value", i);
 			fail_count++;
 			goto out_destroy;
 		}
-		if (val[i] != 0) {
-			fail("Non-zero sem %d value: %d", i, val[i]);
+		if (val[i].val != 0) {
+			fail("Non-zero sem %d value: %d", i, val[i].val);
 			fail_count++;
 		}
 	}
-- 
2.7.4
