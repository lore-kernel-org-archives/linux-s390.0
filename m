Return-Path: <linux-arch-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 05/14] seccomp: recheck the syscall after RET_TRACE
Date: Thu,  9 Jun 2016 14:01:55 -0700
Message-ID: <1465506124-21866-6-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160609210155.K_X-rqF7-klzYm1ai2IK7iH182VEO2fxDfEmT3MQEZI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

When RET_TRACE triggers, a tracer may change a syscall into something that
should be filtered by seccomp. This re-runs seccomp after a trace event
to make sure things continue to pass.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
---
 kernel/seccomp.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 14a37d71b612..54d15eb2b701 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -556,7 +556,8 @@ void secure_computing_strict(int this_syscall)
 #else
 
 #ifdef CONFIG_SECCOMP_FILTER
-static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
+static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
+			    const bool recheck_after_trace)
 {
 	u32 filter_ret, action;
 	int data;
@@ -588,6 +589,10 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
 		goto skip;
 
 	case SECCOMP_RET_TRACE:
+		/* We've been put in this state by the ptracer already. */
+		if (recheck_after_trace)
+			return 0;
+
 		/* ENOSYS these calls if there is no tracer attached. */
 		if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
 			syscall_set_return_value(current,
@@ -611,6 +616,15 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
 		if (this_syscall < 0)
 			goto skip;
 
+		/*
+		 * Recheck the syscall, since it may have changed. This
+		 * intentionally uses a NULL struct seccomp_data to force
+		 * a reload of all registers. This does not goto skip since
+		 * a skip would have already been reported.
+		 */
+		if (__seccomp_filter(this_syscall, NULL, true))
+			return -1;
+
 		return 0;
 
 	case SECCOMP_RET_ALLOW:
@@ -629,7 +643,8 @@ skip:
 	return -1;
 }
 #else
-static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
+static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
+			    const bool recheck_after_trace)
 {
 	BUG();
 }
@@ -652,7 +667,7 @@ int __secure_computing(const struct seccomp_data *sd)
 		__secure_computing_strict(this_syscall);  /* may call do_exit */
 		return 0;
 	case SECCOMP_MODE_FILTER:
-		return __seccomp_filter(this_syscall, sd);
+		return __seccomp_filter(this_syscall, sd, false);
 	default:
 		BUG();
 	}
-- 
2.7.4
