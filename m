Return-Path: <netdev-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Date: Fri, 18 Sep 2020 14:45:25 +0200
Message-Id: <20200918124533.3487701-2-hch@lst.de>
In-Reply-To: <20200918124533.3487701-1-hch@lst.de>
References: <20200918124533.3487701-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

Add a flag to force processing a syscall as a compat syscall.  This is
required so that in_compat_syscall() works for I/O submitted by io_uring
helper threads on behalf of compat syscalls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/include/asm/compat.h | 3 ++-
 arch/x86/include/asm/compat.h   | 2 +-
 fs/io_uring.c                   | 9 +++++++++
 include/linux/compat.h          | 5 ++++-
 include/linux/sched.h           | 1 +
 5 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 40a267b3bd5208..fee6c51d36e869 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -211,7 +211,8 @@ static inline int is_compat_task(void)
 static inline bool in_compat_syscall(void)
 {
 	/* Vector 0x110 is LINUX_32BIT_SYSCALL_TRAP */
-	return pt_regs_trap_type(current_pt_regs()) == 0x110;
+	return pt_regs_trap_type(current_pt_regs()) == 0x110 ||
+		(current->flags & PF_FORCE_COMPAT);
 }
 #define in_compat_syscall in_compat_syscall
 #endif
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index d4edf281fff49d..fbab072d4e5b31 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -208,7 +208,7 @@ static inline bool in_32bit_syscall(void)
 #ifdef CONFIG_COMPAT
 static inline bool in_compat_syscall(void)
 {
-	return in_32bit_syscall();
+	return in_32bit_syscall() || (current->flags & PF_FORCE_COMPAT);
 }
 #define in_compat_syscall in_compat_syscall	/* override the generic impl */
 #endif
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3790c7fe9fee22..5755d557c3f7bc 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5449,6 +5449,9 @@ static int io_req_defer_prep(struct io_kiocb *req,
 	if (unlikely(ret))
 		return ret;
 
+	if (req->ctx->compat)
+		current->flags |= PF_FORCE_COMPAT;
+
 	switch (req->opcode) {
 	case IORING_OP_NOP:
 		break;
@@ -5546,6 +5549,7 @@ static int io_req_defer_prep(struct io_kiocb *req,
 		break;
 	}
 
+	current->flags &= ~PF_FORCE_COMPAT;
 	return ret;
 }
 
@@ -5669,6 +5673,9 @@ static int io_issue_sqe(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
 
+	if (ctx->compat)
+		current->flags |= PF_FORCE_COMPAT;
+
 	switch (req->opcode) {
 	case IORING_OP_NOP:
 		ret = io_nop(req, cs);
@@ -5898,6 +5905,8 @@ static int io_issue_sqe(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		break;
 	}
 
+	current->flags &= ~PF_FORCE_COMPAT;
+
 	if (ret)
 		return ret;
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index b354ce58966e2d..685066f7ad325f 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -891,7 +891,10 @@ asmlinkage long compat_sys_socketcall(int call, u32 __user *args);
  */
 
 #ifndef in_compat_syscall
-static inline bool in_compat_syscall(void) { return is_compat_task(); }
+static inline bool in_compat_syscall(void)
+{
+	return is_compat_task() || (current->flags & PF_FORCE_COMPAT);
+}
 #endif
 
 /**
diff --git a/include/linux/sched.h b/include/linux/sched.h
index afe01e232935fa..c8b183b5655a1e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1491,6 +1491,7 @@ extern struct pid *cad_pid;
  */
 #define PF_IDLE			0x00000002	/* I am an IDLE thread */
 #define PF_EXITING		0x00000004	/* Getting shut down */
+#define PF_FORCE_COMPAT		0x00000008	/* acting as compat task */
 #define PF_VCPU			0x00000010	/* I'm a virtual CPU */
 #define PF_WQ_WORKER		0x00000020	/* I'm a workqueue worker */
 #define PF_FORKNOEXEC		0x00000040	/* Forked but didn't exec */
-- 
2.28.0
