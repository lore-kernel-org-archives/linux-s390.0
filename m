Return-Path: <linux-arch-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 01/14] seccomp: add tests for ptrace hole
Date: Thu,  9 Jun 2016 14:01:51 -0700
Message-ID: <1465506124-21866-2-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160609210151.wY7r1jw5K8xeUNCEJmr9EUt6_YWJe34oTtadbXudu3c@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

One problem with seccomp was that ptrace could be used to change a
syscall after seccomp filtering had completed. This was a well documented
limitation, and it was recommended to block ptrace when defining a filter
to avoid this problem. This can be quite a limitation for containers or
other places where ptrace is desired even under seccomp filters.

This adds tests for both SECCOMP_RET_TRACE and PTRACE_SYSCALL manipulations.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 176 ++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 2e58549b2f02..03f1fa495d74 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1021,8 +1021,8 @@ void tracer_stop(int sig)
 typedef void tracer_func_t(struct __test_metadata *_metadata,
 			   pid_t tracee, int status, void *args);
 
-void tracer(struct __test_metadata *_metadata, int fd, pid_t tracee,
-	    tracer_func_t tracer_func, void *args)
+void start_tracer(struct __test_metadata *_metadata, int fd, pid_t tracee,
+	    tracer_func_t tracer_func, void *args, bool ptrace_syscall)
 {
 	int ret = -1;
 	struct sigaction action = {
@@ -1042,12 +1042,16 @@ void tracer(struct __test_metadata *_metadata, int fd, pid_t tracee,
 	/* Wait for attach stop */
 	wait(NULL);
 
-	ret = ptrace(PTRACE_SETOPTIONS, tracee, NULL, PTRACE_O_TRACESECCOMP);
+	ret = ptrace(PTRACE_SETOPTIONS, tracee, NULL, ptrace_syscall ?
+						      PTRACE_O_TRACESYSGOOD :
+						      PTRACE_O_TRACESECCOMP);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Failed to set PTRACE_O_TRACESECCOMP");
 		kill(tracee, SIGKILL);
 	}
-	ptrace(PTRACE_CONT, tracee, NULL, 0);
+	ret = ptrace(ptrace_syscall ? PTRACE_SYSCALL : PTRACE_CONT,
+		     tracee, NULL, 0);
+	ASSERT_EQ(0, ret);
 
 	/* Unblock the tracee */
 	ASSERT_EQ(1, write(fd, "A", 1));
@@ -1063,12 +1067,13 @@ void tracer(struct __test_metadata *_metadata, int fd, pid_t tracee,
 			/* Child is dead. Time to go. */
 			return;
 
-		/* Make sure this is a seccomp event. */
-		ASSERT_EQ(true, IS_SECCOMP_EVENT(status));
+		/* Check if this is a seccomp event. */
+		ASSERT_EQ(!ptrace_syscall, IS_SECCOMP_EVENT(status));
 
 		tracer_func(_metadata, tracee, status, args);
 
-		ret = ptrace(PTRACE_CONT, tracee, NULL, NULL);
+		ret = ptrace(ptrace_syscall ? PTRACE_SYSCALL : PTRACE_CONT,
+			     tracee, NULL, 0);
 		ASSERT_EQ(0, ret);
 	}
 	/* Directly report the status of our test harness results. */
@@ -1079,7 +1084,7 @@ void tracer(struct __test_metadata *_metadata, int fd, pid_t tracee,
 void cont_handler(int num)
 { }
 pid_t setup_trace_fixture(struct __test_metadata *_metadata,
-			  tracer_func_t func, void *args)
+			  tracer_func_t func, void *args, bool ptrace_syscall)
 {
 	char sync;
 	int pipefd[2];
@@ -1095,7 +1100,8 @@ pid_t setup_trace_fixture(struct __test_metadata *_metadata,
 	signal(SIGALRM, cont_handler);
 	if (tracer_pid == 0) {
 		close(pipefd[0]);
-		tracer(_metadata, pipefd[1], tracee, func, args);
+		start_tracer(_metadata, pipefd[1], tracee, func, args,
+			     ptrace_syscall);
 		syscall(__NR_exit, 0);
 	}
 	close(pipefd[1]);
@@ -1177,7 +1183,7 @@ FIXTURE_SETUP(TRACE_poke)
 
 	/* Launch tracer. */
 	self->tracer = setup_trace_fixture(_metadata, tracer_poke,
-					   &self->tracer_args);
+					   &self->tracer_args, false);
 }
 
 FIXTURE_TEARDOWN(TRACE_poke)
@@ -1399,6 +1405,29 @@ void tracer_syscall(struct __test_metadata *_metadata, pid_t tracee,
 
 }
 
+void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
+		   int status, void *args)
+{
+	int ret, nr;
+	unsigned long msg;
+	static bool entry;
+
+	/* Make sure we got an empty message. */
+	ret = ptrace(PTRACE_GETEVENTMSG, tracee, NULL, &msg);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, msg);
+
+	/* The only way to tell PTRACE_SYSCALL entry/exit is by counting. */
+	entry = !entry;
+	if (!entry)
+		return;
+
+	nr = get_syscall(_metadata, tracee);
+
+	if (nr == __NR_getpid)
+		change_syscall(_metadata, tracee, __NR_getppid);
+}
+
 FIXTURE_DATA(TRACE_syscall) {
 	struct sock_fprog prog;
 	pid_t tracer, mytid, mypid, parent;
@@ -1440,7 +1469,8 @@ FIXTURE_SETUP(TRACE_syscall)
 	ASSERT_NE(self->parent, self->mypid);
 
 	/* Launch tracer. */
-	self->tracer = setup_trace_fixture(_metadata, tracer_syscall, NULL);
+	self->tracer = setup_trace_fixture(_metadata, tracer_syscall, NULL,
+					   false);
 }
 
 FIXTURE_TEARDOWN(TRACE_syscall)
@@ -1500,6 +1530,130 @@ TEST_F(TRACE_syscall, syscall_dropped)
 	EXPECT_NE(self->mytid, syscall(__NR_gettid));
 }
 
+TEST_F(TRACE_syscall, skip_after_RET_TRACE)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO | EPERM),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* Install fixture filter. */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* Install "errno on getppid" filter. */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* Tracer will redirect getpid to getppid, and we should see EPERM. */
+	EXPECT_EQ(-1, syscall(__NR_getpid));
+	EXPECT_EQ(EPERM, errno);
+}
+
+TEST_F_SIGNAL(TRACE_syscall, kill_after_RET_TRACE, SIGSYS)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* Install fixture filter. */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* Install "death on getppid" filter. */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* Tracer will redirect getpid to getppid, and we should die. */
+	EXPECT_NE(self->mypid, syscall(__NR_getpid));
+}
+
+TEST_F(TRACE_syscall, skip_after_ptrace)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO | EPERM),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	long ret;
+
+	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
+	teardown_trace_fixture(_metadata, self->tracer);
+	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
+					   true);
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* Install "errno on getppid" filter. */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* Tracer will redirect getpid to getppid, and we should see EPERM. */
+	EXPECT_EQ(-1, syscall(__NR_getpid));
+	EXPECT_EQ(EPERM, errno);
+}
+
+TEST_F_SIGNAL(TRACE_syscall, kill_after_ptrace, SIGSYS)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	long ret;
+
+	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
+	teardown_trace_fixture(_metadata, self->tracer);
+	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
+					   true);
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* Install "death on getppid" filter. */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* Tracer will redirect getpid to getppid, and we should die. */
+	EXPECT_NE(self->mypid, syscall(__NR_getpid));
+}
+
 #ifndef __NR_seccomp
 # if defined(__i386__)
 #  define __NR_seccomp 354
-- 
2.7.4
