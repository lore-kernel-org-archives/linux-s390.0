Return-Path: <linux-arch-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/6] exec: split prepare_arg_pages
Date: Mon, 15 Jun 2020 15:00:30 +0200
Message-Id: <20200615130032.931285-5-hch@lst.de>
In-Reply-To: <20200615130032.931285-1-hch@lst.de>
References: <20200615130032.931285-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Move counting the arguments and enviroment variables out of
prepare_arg_pages and rename the rest of the function to check_arg_limit.
This prepares for a version of do_execvat that takes kernel pointers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6e4d9d1ffa35fa..696b1e8180d7d8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -439,20 +439,10 @@ static int count_strings(const char __user *const __user *argv)
 	return i;
 }
 
-static int prepare_arg_pages(struct linux_binprm *bprm,
-		const char __user *const __user *argv,
-		const char __user *const __user *envp)
+static int check_arg_limit(struct linux_binprm *bprm)
 {
 	unsigned long limit, ptr_size;
 
-	bprm->argc = count_strings(argv);
-	if (bprm->argc < 0)
-		return bprm->argc;
-
-	bprm->envc = count_strings(envp);
-	if (bprm->envc < 0)
-		return bprm->envc;
-
 	/*
 	 * Limit to 1/4 of the max stack size or 3/4 of _STK_LIM
 	 * (whichever is smaller) for the argv+env strings.
@@ -1890,7 +1880,19 @@ int do_execveat(int fd, struct filename *filename,
 	if (retval)
 		goto out_unmark;
 
-	retval = prepare_arg_pages(bprm, argv, envp);
+	bprm->argc = count_strings(argv);
+	if (bprm->argc < 0) {
+		retval = bprm->argc;
+		goto out;
+	}
+
+	bprm->envc = count_strings(envp);
+	if (bprm->envc < 0) {
+		retval = bprm->envc;
+		goto out;
+	}
+
+	retval = check_arg_limit(bprm);
 	if (retval < 0)
 		goto out;
 
-- 
2.26.2
