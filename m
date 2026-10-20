Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479430;
	b=APnTQz75pGjHmdBRmxqFMYiJu2bwANFlh4c3GKWc0PtQILQYaFYSmFwEL/kQ1D2r+197
	 PORRu7Mn4pZp8hCvJWWnfzgxnFKiEAI0IEcZ+ha8PRDCLBmik1d4Khd8ElXXREqn18m4n
	 5pR3YRBk/ws03fbdn7yyetvs4GVnOKYkcVRyfs+MFoSi/NiX5HXUtKtikFCu6uvlGv5AC
	 /jWnostJedrg3JH77BlIhy7+yS2lmHRNeYznNbhC4pWXhtgBN0XCm33yyiX/Yd160vj+1
	 BCc0sxcirYG+rr23AKFcF//tWyPHmXwhiel1Wx3UB1XjqDffMELKouamSZ4qYQETmGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479430;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9xiLRq/FvSuxEQCUz2mtWUPSsNT9Rp2eWpRdkXKWi3U=;
	b=2Xwj1XAtFJiXOG3DWFz8UL1ORiwTxsi24akTr5AI4DwHnJuLV9OaD3u9EljBpSeGYHcR
	 k/K/7mVftMbvLVifA5oDcDUEaj0lAdq4I8cUXjq0+mTh8FXBsCMD14EZB4UgfZnruV92z
	 GwqYeeGBoPQhzxTqOrTBvX7gLF0dS9zLqQuNF+kIOpxRMkuSm0tdpNHiVgRkQZChGoVHm
	 RlgtyAToOh7GRHWFmfTonbsoFB1SCEOybvUfd7VYRFAkUUPihB8+lDqIyTf55YV+1G/FJ
	 zjlbOwz2FNwKZUpnidoswCF+OI7DcTAo9jp1FnT2tbUOVtDGBgAWXTKUw/wOFL7fG2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=Op8UAR9b;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8763560A2637;
	Tue, 20 Oct 2026 06:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8763560A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=Op8UAR9b
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 7DFAA1C0264;
	Tue, 20 Oct 2026 08:57:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1792479422;
	bh=YLvM5kTZTUZxbiEqEfgYFqvCjYtkBwewpbGRd+sVL+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Op8UAR9bME1DQ3zcNOBnqPTt0xtvm9OYKJjNqRmJH4YSETpj4QGpCdnz4GJSCaa8U
	 TcoDUFzi82p2LP20FhAhvXBEazemHCtxcOycrrt5oqKQ052RNwdy2mzCF/RbYNfjJN
	 NpaKkz2ec7PaR1nOJdpb/5flyJ9Nv0R2lMi0g6zA=
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Renzo Davoli <renzo@cs.unibo.it>,
	Oleg Nesterov <oleg@redhat.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	strace-devel@lists.strace.io
Subject: [PATCH v8 3/3] selftests/ptrace: add a test case for PTRACE_SET_SYSCALL_INFO syscall skipping
Date: Tue, 20 Oct 2026 08:56:33 +0200
Message-ID: <20261020065635.490528-4-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020065635.490528-1-renzo@cs.unibo.it>
References: <20261020065635.490528-1-renzo@cs.unibo.it>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check whether PTRACE_SET_SYSCALL_INFO syscall skipping semantics
implemented in the kernel matches userspace expectations.

Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
[v8: also check an error return value, and that the syscall cannot be
 changed anymore once skipped while its return value still can;
 checkpatch fixes]
Assisted-by: claude-opus-5-5
---
 .../selftests/ptrace/set_syscall_info.c       | 220 +++++++++++++++++-
 1 file changed, 219 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ptrace/set_syscall_info.c b/tools/testing/selftests/ptrace/set_syscall_info.c
index 1cc411a41cd6..e8733c62177a 100644
--- a/tools/testing/selftests/ptrace/set_syscall_info.c
+++ b/tools/testing/selftests/ptrace/set_syscall_info.c
@@ -11,9 +11,15 @@
 #include <err.h>
 #include <fcntl.h>
 #include <signal.h>
+#include <stdlib.h>
+#include <stddef.h>
 #include <asm/unistd.h>
+#include <sys/prctl.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
+#include <linux/filter.h>
+#include <linux/seccomp.h>
+#include <linux/prctl.h>
 
 #if defined(_MIPS_SIM) && _MIPS_SIM == _MIPS_SIM_NABI32
 /*
@@ -36,6 +42,7 @@ struct si_exit {
 
 static unsigned int ptrace_stop;
 static pid_t tracee_pid;
+static pid_t tracer_pid;
 
 static int
 kill_tracee(pid_t pid)
@@ -64,6 +71,25 @@ sys_ptrace(int request, pid_t pid, unsigned long addr, unsigned long data)
 		       ptrace_stop, ##__VA_ARGS__);		\
 	} while (0)
 
+static int sys_seccomp(unsigned int operation, unsigned int flags, void *args)
+{
+	return syscall(__NR_seccomp, operation, flags, args);
+}
+
+static struct sock_filter seccomp_filter[] = {
+	BPF_STMT(BPF_LD+BPF_W+BPF_ABS, offsetof(struct seccomp_data, nr)),
+
+	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, __NR_restart_syscall, 0, 1),
+	BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
+
+	BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_TRACE),
+};
+
+static struct sock_fprog seccomp_prog = {
+	.filter = seccomp_filter,
+	.len = ARRAY_SIZE(seccomp_filter)
+};
+
 static void
 check_psi_entry(struct __test_metadata *_metadata,
 		const struct ptrace_syscall_info *info,
@@ -128,7 +154,6 @@ check_psi_exit(struct __test_metadata *_metadata,
 
 TEST(set_syscall_info)
 {
-	const pid_t tracer_pid = getpid();
 	const kernel_ulong_t dummy[] = {
 		(kernel_ulong_t) 0xdad0bef0bad0fed0ULL,
 		(kernel_ulong_t) 0xdad1bef1bad1fed1ULL,
@@ -138,6 +163,7 @@ TEST(set_syscall_info)
 		(kernel_ulong_t) 0xdad5bef5bad5fed5ULL,
 	};
 	int splice_in[2], splice_out[2];
+	tracer_pid = getpid();
 
 	ASSERT_EQ(0, pipe(splice_in));
 	ASSERT_EQ(0, pipe(splice_out));
@@ -516,4 +542,196 @@ TEST(set_syscall_info)
 	ASSERT_EQ(ptrace_stop, ARRAY_SIZE(si) * 2);
 }
 
+TEST(set_syscall_info_seccomp)
+{
+	tracer_pid = getpid();
+	tracee_pid = fork();
+
+	ASSERT_LE(0, tracee_pid) {
+		TH_LOG("fork: %m");
+	}
+
+	/* tracee */
+	if (tracee_pid == 0) {
+		tracee_pid = getpid();
+		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+			TH_LOG("PTRACE_TRACEME: %m");
+		}
+		ASSERT_EQ(0, kill(tracee_pid, SIGSTOP)) {
+			/* cannot happen */
+			TH_LOG("kill SIGSTOP: %m");
+		}
+
+		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+			TH_LOG("prctl: %m");
+		}
+		ASSERT_EQ(0, sys_seccomp(SECCOMP_SET_MODE_FILTER, 0,
+					(void *) &seccomp_prog)) {
+			TH_LOG("seccomp: %m");
+		}
+
+		/* run getpid unmodified */
+		ASSERT_EQ(tracee_pid, getpid()) {
+			_exit(1);
+		}
+
+		/* run getppid instead of getpid */
+		ASSERT_EQ(tracer_pid, getpid()) {
+			_exit(1);
+		}
+
+		/* skip getpid and return 42 */
+		ASSERT_EQ(42, getpid()) {
+			_exit(1);
+		}
+
+		/* skip getpid and fail with ESRCH */
+		errno = 0;
+		ASSERT_EQ(-1, syscall(__NR_getpid)) {
+			_exit(1);
+		}
+		ASSERT_EQ(ESRCH, errno) {
+			_exit(1);
+		}
+		_exit(0);
+	}
+
+	int status;
+
+	/* tracer */
+	ASSERT_LE(0, waitpid(-1, &status, 0)) {
+		LOG_KILL_TRACEE("waitpid: %m");
+	}
+
+	ASSERT_EQ(0, sys_ptrace(PTRACE_SETOPTIONS, tracee_pid, 0,
+			(PTRACE_O_TRACESECCOMP | PTRACE_O_TRACESYSGOOD)))
+		LOG_KILL_TRACEE("PTRACE_SETOPTIONS: %m");
+
+	ASSERT_EQ(0, sys_ptrace(PTRACE_CONT, tracee_pid, 0, 0)) {
+		LOG_KILL_TRACEE("PTRACE_CONT: %m");
+	}
+
+	static const char * const testname[] = {
+		"unknown error",
+		"getpid seccomp unchanged",
+		"getpid seccomp nr change: getppid",
+		"getpid seccomp skip+set retvalue",
+		"getpid seccomp skip+set error"
+	};
+
+	static const unsigned int expected_nr[] = {
+		__NR_getpid,
+		__NR_getpid,
+		__NR_getpid,
+		__NR_getpid,
+		__NR_exit_group
+	};
+
+	for (ptrace_stop = 0; ; ++ptrace_stop) {
+		ASSERT_EQ(tracee_pid, wait(&status)) {
+			/* cannot happen */
+			LOG_KILL_TRACEE("wait: %m");
+		}
+
+		if (WIFEXITED(status)) {
+			tracee_pid = 0; /* the tracee is no more */
+			ASSERT_EQ(0, WEXITSTATUS(status)) {
+				LOG_KILL_TRACEE("unexpected exit status %u",
+						WEXITSTATUS(status));
+			}
+			break;
+		}
+		ASSERT_FALSE(WIFSIGNALED(status)) {
+			tracee_pid = 0; /* the tracee is no more */
+			LOG_KILL_TRACEE("unexpected signal %u",
+					WTERMSIG(status));
+		}
+		ASSERT_TRUE(WIFSTOPPED(status)) {
+			LOG_KILL_TRACEE("unexpected wait status %#x", status);
+		}
+
+		ASSERT_EQ(status >> 8, SIGTRAP | (PTRACE_EVENT_SECCOMP << 8)) {
+			LOG_KILL_TRACEE("unexpected stop, wait status %#x", status);
+		}
+
+		struct ptrace_syscall_info info = {
+			.op = 0xff  /* invalid PTRACE_SYSCALL_INFO_* op */
+		};
+		size_t info_size = sizeof(info);
+
+		ASSERT_LT(0, sys_ptrace(PTRACE_GET_SYSCALL_INFO, tracee_pid,
+					info_size, (uintptr_t) &info)) {
+			LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO: %m");
+		}
+		ASSERT_EQ(PTRACE_SYSCALL_INFO_SECCOMP, info.op) {
+			LOG_KILL_TRACEE("entry op mismatch: %m");
+		}
+		ASSERT_TRUE(info.arch) {
+			LOG_KILL_TRACEE("entry arch mismatch: %m");
+		}
+		ASSERT_TRUE(info.instruction_pointer) {
+			LOG_KILL_TRACEE("entry instruction_pointer mismatch: %m");
+		}
+		ASSERT_TRUE(info.stack_pointer) {
+			LOG_KILL_TRACEE("entry stack_pointer mismatch: %m");
+		}
+
+		ASSERT_LT(ptrace_stop, ARRAY_SIZE(expected_nr)) {
+			LOG_KILL_TRACEE("ptrace stop overflow");
+		}
+		ASSERT_FALSE(info.seccomp.nr == __NR_exit_group && info.seccomp.args[0] == 1) {
+			LOG_KILL_TRACEE("tracee error: %s",
+					testname[ptrace_stop]);
+		}
+		ASSERT_EQ(info.seccomp.nr, expected_nr[ptrace_stop]) {
+			LOG_KILL_TRACEE("syscall nr mismatch");
+		}
+		const struct ptrace_syscall_info seccomp_info = info;
+
+		switch (ptrace_stop) {
+		case 0:
+		case 4:
+			break;
+		case 1:
+			info.seccomp.nr = __NR_getppid;
+			break;
+		case 2:
+			info.op = PTRACE_SYSCALL_INFO_EXIT;
+			info.exit.rval = 41;
+			info.exit.is_error = 0;
+			ASSERT_EQ(0, sys_ptrace(PTRACE_SET_SYSCALL_INFO,
+						tracee_pid, info_size,
+						(uintptr_t) &info)) {
+				LOG_KILL_TRACEE("PTRACE_SET_SYSCALL_INFO: %m");
+			}
+			/* the syscall cannot be changed anymore once skipped */
+			ASSERT_EQ(-1, sys_ptrace(PTRACE_SET_SYSCALL_INFO,
+						 tracee_pid, info_size,
+						 (uintptr_t) &seccomp_info)) {
+				LOG_KILL_TRACEE("PTRACE_SET_SYSCALL_INFO after skip succeeded");
+			}
+			ASSERT_EQ(EINVAL, errno) {
+				LOG_KILL_TRACEE("PTRACE_SET_SYSCALL_INFO after skip: %m");
+			}
+			/* but its return value can */
+			info.exit.rval = 42;
+			break;
+		case 3:
+			info.op = PTRACE_SYSCALL_INFO_EXIT;
+			info.exit.rval = -ESRCH;
+			info.exit.is_error = 1;
+			break;
+		}
+
+		ASSERT_EQ(0, sys_ptrace(PTRACE_SET_SYSCALL_INFO, tracee_pid,
+					info_size, (uintptr_t) &info)) {
+			LOG_KILL_TRACEE("PTRACE_SET_SYSCALL_INFO: %m");
+		}
+
+		ASSERT_EQ(0, sys_ptrace(PTRACE_CONT, tracee_pid, 0, 0)) {
+			LOG_KILL_TRACEE("PTRACE_CONT: %m");
+		}
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.55.0

