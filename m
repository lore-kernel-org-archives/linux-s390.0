Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Amanieu d'Antras" <amanieu@gmail.com>
Subject: [PATCH v2 11/20] s390: Use generic compat_siginfo_t
Date: Thu,  5 Nov 2015 00:50:30 +0000
Message-Id: <1446684640-4112-12-git-send-email-amanieu@gmail.com>
In-Reply-To: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
References: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amanieu d'Antras <amanieu@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
---
 arch/s390/include/asm/compat.h | 52 ------------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 497af62..fbb6365 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -192,61 +192,9 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
-#define HAVE_ARCH_COMPAT_SIGINFO_T
 #define HAVE_ARCH_COPY_SIGINFO_TO_USER32
 #define HAVE_ARCH_COPY_SIGINFO_FROM_USER32
 
-typedef struct compat_siginfo {
-	int	si_signo;
-	int	si_errno;
-	int	si_code;
-
-	union {
-		int _pad[128/sizeof(int) - 3];
-
-		/* kill() */
-		struct {
-			pid_t	_pid;	/* sender's pid */
-			uid_t	_uid;	/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;		/* timer id */
-			int _overrun;			/* overrun count */
-			compat_sigval_t _sigval;	/* same as below */
-			int _sys_private;	/* not to be passed to user */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			pid_t			_pid;	/* sender's pid */
-			uid_t			_uid;	/* sender's uid */
-			compat_sigval_t		_sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			pid_t			_pid;	/* which child */
-			uid_t			_uid;	/* sender's uid */
-			int			_status;/* exit code */
-			compat_clock_t		_utime;
-			compat_clock_t		_stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-		struct {
-			__u32	_addr;	/* faulting insn/memory ref. - pointer */
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int	_band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int	_fd;
-		} _sigpoll;
-	} _sifields;
-} compat_siginfo_t;
-
 /*
  * How these fields are to be accessed.
  */
-- 
2.6.2
