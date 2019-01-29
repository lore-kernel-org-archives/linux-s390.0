Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 29 Jan 2019 18:16:53 +0100
From: Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
Message-ID: <20190129171653.ycl64psq2liy5o5c@linutronix.de>
References: <20190128134410.GA28485@hirez.programming.kicks-ass.net>
 <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
 <20190129090108.GA26906@osiris>
 <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de>
 <20190129102409.GB26906@osiris>
 <20190129103557.GF28485@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de>
 <20190129132303.GE26906@osiris>
 <20190129151058.GG26906@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129151058.GG26906@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 2019-01-29 16:10:58 [+0100], Heiko Carstens wrote:
> Finally... the trace output is quite large with 26 MB... Therefore an
> xz compressed attachment. Hope that's ok.
> 
> The kernel used was linux-next 20190129 + your patch.
|        ld64.so.1-10237 [006] .... 14232.031726: sys_futex(uaddr: 3ff88e80618, op: 7, val: 3ff00000007, utime: 3ff88e7f910, uaddr2: 3ff88e7f910, val3: 3ffc167e8d7)
FUTEX_UNLOCK_PI | SHARED

|        ld64.so.1-10237 [006] .... 14232.031726: sys_futex -> 0x0
…
|        ld64.so.1-10237 [006] .... 14232.051751: sched_process_exit: comm=ld64.so.1 pid=10237 prio=120
…
|        ld64.so.1-10148 [006] .... 14232.061826: sys_futex(uaddr: 3ff88e80618, op: 6, val: 1, utime: 0, uaddr2: 2, val3: 0)
FUTEX_LOCK_PI | SHARED

|        ld64.so.1-10148 [006] .... 14232.061826: sys_futex -> 0xfffffffffffffffd

So there got to be another task that acquired the lock in userland and
left since the last in kernel-user unlocked it. This might bring more
light to it:

diff --git a/kernel/futex.c b/kernel/futex.c
index 599da35c2768..aaa782a8a115 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1209,6 +1209,9 @@ static int handle_exit_race(u32 __user *uaddr, u32 uval,
 	 * corrupted or the user space value in *uaddr is simply bogus.
 	 * Give up and tell user space.
 	 */
+	trace_printk("uval2 vs uval %08x vs %08x (%d)\n", uval2, uval,
+		     tsk ? tsk->pid : -1);
+	__WARN();
 	return -ESRCH;
 }
 
@@ -1233,8 +1236,10 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 	if (!pid)
 		return -EAGAIN;
 	p = find_get_task_by_vpid(pid);
-	if (!p)
+	if (!p) {
+		trace_printk("Missing pid %d\n", pid);
 		return handle_exit_race(uaddr, uval, NULL);
+	}
 
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		put_task_struct(p);

---

I am not sure, but isn't this the "known" issue where the kernel drops
ESRCH in a valid case and glibc upstream does not recognize it because
it is not a valid /POSIX-defined error code? (I *think* same is true for
-ENOMEM) If it is, the following C snippet is a small tc:

---->8------
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>
#include <stdio.h>

static char nothing[4096];

int main(void)
{
	int fd;
	ssize_t wn;
	void *lockm;
	pid_t child;
	pthread_mutex_t *the_lock;
	pthread_mutexattr_t mutexattr;
	int ret;

	fd = open("/dev/shm/futex-test-lock", O_RDWR | O_CREAT | O_TRUNC, 0644);
	if (fd < 0) {
		printf("Failed to create lock file: %m\n");
		return 1;
	}
	wn = write(fd, nothing, sizeof(nothing));
	if (wn != sizeof(nothing)) {
		printf("Failed to write to file: %m\n");
		goto out_unlink;
	}

	lockm = mmap(NULL, sizeof(nothing), PROT_READ | PROT_WRITE, MAP_SHARED,
		     fd, 0);
	if (lockm == MAP_FAILED) {
		printf("mmap() failed: %m\n");
		goto out_unlink;
	}
	close(fd);
	unlink("/dev/shm/futex-test-lock");
	the_lock = lockm;

	ret = pthread_mutexattr_init(&mutexattr);
	ret |= pthread_mutexattr_setpshared(&mutexattr, PTHREAD_PROCESS_SHARED);
	ret |= pthread_mutexattr_setprotocol(&mutexattr, PTHREAD_PRIO_INHERIT);

	if (ret) {
		printf("Something went wrong during init\n");
		return 1;
	}

	ret = pthread_mutex_init(the_lock, &mutexattr);
	if (ret) {
		printf("Failed to init the lock\n");
		return 1;
	}
	child = fork();
	if (child < 0) {
		printf("fork(): %m\n");
		return 1;
	}

	if (!child) {
		pthread_mutex_lock(the_lock);
		exit(2);
	}

	sleep(2);
	ret = pthread_mutex_lock(the_lock);

	printf("-> %x\n", ret);
	return 0;

out_unlink:
	unlink("/dev/shm/futex-test-lock");
	return 1;
}

---------------8<-----------------------

strace gives this:
|openat(AT_FDCWD, "/dev/shm/futex-test-lock", O_RDWR|O_CREAT|O_TRUNC, 0644) = 3
|write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
|mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x7f5e23e37000
|close(3)                                = 0
|unlink("/dev/shm/futex-test-lock")      = 0
…
|clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f5e23c1da10) = 25777
|strace: Process 25777 attached
|[pid 25776] nanosleep({tv_sec=2, tv_nsec=0},  <unfinished ...>
|[pid 25777] set_robust_list(0x7f5e23c1da20, 24) = 0
|[pid 25777] exit_group(2)               = ?
|[pid 25777] +++ exited with 2 +++
|<... nanosleep resumed> {tv_sec=1, tv_nsec=999821679}) = ? ERESTART_RESTARTBLOCK (Interrupted by signal)
|--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=25777, si_uid=1000, si_status=2, si_utime=0, si_stime=0} ---
|restart_syscall(<... resuming interrupted nanosleep ...>) = 0
|futex(0x7f5e23e37000, FUTEX_LOCK_PI, NULL) = -1 ESRCH (No such process)
|pause(^Cstrace: Process 25776 detached

and if I remember correctly, if asserts are not enabled we end up with a
pause loop instead.

Sebastian
