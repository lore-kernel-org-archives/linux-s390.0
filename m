Return-Path: <linux-arch-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/6] exec: cleanup the count() function
Date: Mon, 15 Jun 2020 15:00:29 +0200
Message-Id: <20200615130032.931285-4-hch@lst.de>
In-Reply-To: <20200615130032.931285-1-hch@lst.de>
References: <20200615130032.931285-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Remove the max argument as it is hard wired to MAX_ARG_STRINGS, and
give the function a slightly less generic name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 94107eceda8a67..6e4d9d1ffa35fa 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -411,9 +411,9 @@ get_user_arg_ptr(const char __user *const __user *argv, int nr)
 }
 
 /*
- * count() counts the number of strings in array ARGV.
+ * count_strings() counts the number of strings in array ARGV.
  */
-static int count(const char __user *const __user *argv, int max)
+static int count_strings(const char __user *const __user *argv)
 {
 	int i = 0;
 
@@ -427,7 +427,7 @@ static int count(const char __user *const __user *argv, int max)
 			if (IS_ERR(p))
 				return -EFAULT;
 
-			if (i >= max)
+			if (i >= MAX_ARG_STRINGS)
 				return -E2BIG;
 			++i;
 
@@ -445,11 +445,11 @@ static int prepare_arg_pages(struct linux_binprm *bprm,
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
