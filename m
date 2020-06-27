Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgF0H1p (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 27 Jun 2020 03:27:45 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/5] exec: cleanup the count() function
Date: Sat, 27 Jun 2020 09:27:02 +0200
Message-Id: <20200627072704.2447163-4-hch@lst.de>
In-Reply-To: <20200627072704.2447163-1-hch@lst.de>
References: <20200627072704.2447163-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Remove the max argument as it is hard wired to MAX_ARG_STRINGS, and
give the function a slightly less generic name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 4e5db0e35797a5..a5d91f8b1341d5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -407,9 +407,9 @@ get_user_arg_ptr(const char __user *const __user *argv, int nr)
 }
 
 /*
- * count() counts the number of strings in array ARGV.
+ * count_strings() counts the number of strings in array ARGV.
  */
-static int count(const char __user *const __user *argv, int max)
+static int count_strings(const char __user *const __user *argv)
 {
 	int i = 0;
 
@@ -423,7 +423,7 @@ static int count(const char __user *const __user *argv, int max)
 			if (IS_ERR(p))
 				return -EFAULT;
 
-			if (i >= max)
+			if (i >= MAX_ARG_STRINGS)
 				return -E2BIG;
 			++i;
 
@@ -441,11 +441,11 @@ static int prepare_arg_pages(struct linux_binprm *bprm,
 {
 	unsigned long limit, ptr_size;
 
-	bprm->argc = count(argv, MAX_ARG_STRINGS);
+	bprm->argc = count_strings(argv);
 	if (bprm->argc < 0)
 		return bprm->argc;
 
-	bprm->envc = count(envp, MAX_ARG_STRINGS);
+	bprm->envc = count_strings(envp);
 	if (bprm->envc < 0)
 		return bprm->envc;
 
-- 
2.26.2
