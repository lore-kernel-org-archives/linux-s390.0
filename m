Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 19/22] s390/cio: Replace strnicmp with strncasecmp
Date: Tue, 16 Sep 2014 22:51:33 +0200
Message-Id: <1410900696-6481-20-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1410900696-6481-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1410900696-6481-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The kernel used to contain two functions for length-delimited,
case-insensitive string comparison, strnicmp with correct semantics
and a slightly buggy strncasecmp. The latter is the POSIX name, so
strnicmp was renamed to strncasecmp, and strnicmp made into a wrapper
for the new strncasecmp to avoid breaking existing users.

To allow the compat wrapper strnicmp to be removed at some point in
the future, and to avoid the extra indirection cost, do
s/strnicmp/strncasecmp/g.

Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/s390/cio/chp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index d497aa0..c692dfe 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -257,11 +257,11 @@ static ssize_t chp_status_write(struct device *dev,
 	if (!num_args)
 		return count;
 
-	if (!strnicmp(cmd, "on", 2) || !strcmp(cmd, "1")) {
+	if (!strncasecmp(cmd, "on", 2) || !strcmp(cmd, "1")) {
 		mutex_lock(&cp->lock);
 		error = s390_vary_chpid(cp->chpid, 1);
 		mutex_unlock(&cp->lock);
-	} else if (!strnicmp(cmd, "off", 3) || !strcmp(cmd, "0")) {
+	} else if (!strncasecmp(cmd, "off", 3) || !strcmp(cmd, "0")) {
 		mutex_lock(&cp->lock);
 		error = s390_vary_chpid(cp->chpid, 0);
 		mutex_unlock(&cp->lock);
-- 
2.0.4
