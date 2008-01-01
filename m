From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: [ANNOUNCE] [LTP] The Linux Test Project has been Released for
	DECEMBER 2007
Date: Tue, 01 Jan 2008 21:10:52 +0530
Message-ID: <1199202052.4417.32.camel@subratamodak.linux.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TY9vN1PYCntUq0wpxm64"
Return-path: <linux-rt-users-owner@vger.kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-rt-users/>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
To: ltp-list <ltp-list@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-rt-users@vger.kernel.org, linux-s390@vger.kernel.org, lxc-dev@googlegroups.com, selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com, James Morris <jmorris@namei.org>, rusty@rustcorp.com.au
List-ID: <linux-s390.vger.kernel.org>


--=-TY9vN1PYCntUq0wpxm64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Dear All,

Happy New Year 2008. The Linux Test Project test suite has been released
for the month of DECEMBER 2007. The latest version of the test-suite
contains 3000+ tests for the Linux OS and can be found at
http://ltp.sourceforge.net/.
Latest happenings in LTP can also be found at:
http://ltp.sourceforge.net/wiki/,
http://ltp.sourceforge.net/wikiArchives.php, and,
IRC: irc.freenode.org #ltp.

Our web site also contains other information such as:
- A Linux test tools matrix
- Technical papers
- How To's on Linux testing
- Code coverage analysis tool.


Release Highlights:

* Real Time Linux Test Cases added,
* PIDNAMESPACE Test Cases added,
* New NUMA Testcases added,
* sendfile05, sendfile06 and sendfile07 for sendfile and sendfile64
syscall new test cases added,
* Se-linux Reference Policy Test Cases Updates, and other fixes.


Note(s) from the Maintainer:
Last month saw huge set of new test cases being added to LTP. Thanks
everybody for your contributions. The trend will continue to be the same
in Jan 2008 with fallocate, CPU controller and probably dlopen() test
cases pouring in. We are also trying to close down the observable Broken
test cases behavior in some test cases by Jan 2008 end, and, some
infrastructural improvements also. LTP will also see getting more
generalized/effective for s390x architecture. Discussion is on with
Rusty Russel for increasing LTP code coverage apart from adding new test
cases.
From this release onwards we will provide a complete patch which can be
applied to the earlier release to arrive at the latest release. Eg: You
can apply ltp-full-20071231.patch on ltp-full-20071130 to create
ltp-full-20071231.
As we move into a new year, we promise to make LTP more effective for
testing our dear Linux.

We would encourage the community to post results to
ltp-results@lists.sf.net,
patches, new tests, bugs or comments/questions to ltp-list@lists.sf.net,
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=103382
(for New Bug(s)),
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=303382
(for New Patch(s)),
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=353382
(for New Feature Request(s))

Please also see the Change Log Attached (DECEMBER 2007):

Happy testing, 
Regards-- 
Subrata,


--=-TY9vN1PYCntUq0wpxm64
Content-Disposition: attachment; filename=Dec-2007_Changelog.txt
Content-Type: text/plain; name="Dec-2007_Changelog.txt"; charset="utf-8"
Content-Transfer-Encoding: 8bit

1)  Log Message: Update CLONE_NEWPID as value changed in 2.6.23-rc3-mm2, submitted by Sukadev Bhattiprolu <sukadev@us.ibm.com>
File(s) Affected:
ltp/testcases/kernel/containers/libclone/libclone.h

2) Log Message: New Test Cases sendfile05 sendfile06 and sendfile07 for sendfile and sendfile64 syscall, by Masatake YAMATO <yamato@redhat.com>
File(s) Affected:
ltp/runtest/syscalls
ltp/testcases/kernel/syscalls/sendfile/sendfile02.c
ltp/testcases/kernel/syscalls/sendfile/sendfile03.c
ltp/testcases/kernel/syscalls/sendfile/sendfile04.c
File(s) Added:
ltp/testcases/kernel/syscalls/sendfile/sendfile05.c
ltp/testcases/kernel/syscalls/sendfile/sendfile06.c
ltp/testcases/kernel/syscalls/sendfile/sendfile07.c

3) Log Message: Fixing the problem of the resolution for ADDRESS_OF_MAIN, by Mark Ver <markver@us.ibm.com>
File(s) Affected:
ltp/testcases/kernel/io/direct_io/diotest4.c

4) Log Message: use caps in "generated warning" since people dont read comments, by Mike Frysinger <vapier@users.sourceforge.net>
File(s) Affected:
ltp/testcases/kernel/include/linux_syscall_numbers.h
ltp/testcases/kernel/include/regen.sh

5) Log Message: Se-linux Reference Policy Updates by Stephen Smalley <sds@tycho.nsa.gov>
File(s) Affected:
ltp/testcases/kernel/security/selinux-testsuite/README
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_readlink.te
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_rxdir.te
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_stat.te
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te
ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te

6) Log Message: New NUMA Testcases by psuriset@linux.vnet.ibm.com
File(s) Affected:
ltp/testcases/kernel/numa/Makefile
ltp/testcases/kernel/numa/README
ltp/testcases/kernel/numa/numa01.sh
File(s) Added:
ltp/testcases/kernel/numa/numa_node_size.c
ltp/testcases/kernel/numa/test.sh

7) Log Message: Fixing mincore the way it generates -EFAULT on s390 by setting a stack limit by "ulimit -s <value>" before its execution, by Anoop <anoop.vijayan@in.ibm.com>
File(s) Affected:
ltp/testcases/kernel/syscalls/mincore/mincore01.c

8) Log Message: add syscall list for arm from Riaz Ur Rahaman
File(s) Affected:
ltp/testcases/kernel/include/linux_syscall_numbers.h
ltp/testcases/kernel/include/order

File(s) Added:
ltp/testcases/kernel/include/arm.in

9) Log Message: Test isn't supported in kernel versions before 2.6.16, by Marco Antonio Fernandes Junior <marcoafj@linux.vnet.ibm.com>
File(s) Affected:
ltp/testcases/kernel/syscalls/fadvise/posix_fadvise04.c

10)Log Message: Reverting Back Stephenś Patch and Applying Jeffś Patch for controlling the tty issue. Also a minor change for the ia64 compile failure.
File(s) Affected:
testcases/kernel/security/selinux-testsuite/README
testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_file.te
testcases/kernel/security/selinux-testsuite/refpolicy/test_capable_net.te
testcases/kernel/security/selinux-testsuite/refpolicy/test_file.te
testcases/kernel/security/selinux-testsuite/refpolicy/test_global.te
testcases/kernel/security/selinux-testsuite/refpolicy/test_ioctl.te
testcases/kernel/security/selinux-testsuite/refpolicy/test_setnice.te
testcases/kernel/security/selinux-testsuite/refpolicy/test_sysctl.te
testcases/kernel/security/selinux-testsuite/refpolicy/test_task_create.te
testcases/kernel/security/selinux-testsuite/refpolicy/test_task_setpgid.te
testcases/kernel/security/selinux-testsuite/tests/execshare/selinux_execshare_parent.c
testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh

11) Log Message: A Trivial Fix from Roger Mach <bigmach@us.ibm.com>
File(s) Affected:
ltp/testcases/pounder21/test_scripts/xterm_stress

12) Log Message: tweak config.mk comment to reflect reality, by Mike Frysinger
File(s) Affected:
ltp/Makefile

13) Log Message: Initial Set of Real Time Linux Test Cases, by Nivedita Singhvi <niv@us.ibm.com> & sudhanshu Singh <sudhanshusingh@in.ibm.com>
File(s) Added:
ltp/testcases/realtime/COPYING 
ltp/testcases/realtime/GNUmakefile.am 
ltp/testcases/realtime/GNUmakefile.in 
ltp/testcases/realtime/OO_DESCRIPTION.txt 
ltp/testcases/realtime/README 
ltp/testcases/realtime/aclocal.m4 
ltp/testcases/realtime/autogen.sh 
ltp/testcases/realtime/configure 
ltp/testcases/realtime/configure.ac 
ltp/testcases/realtime/run.sh 
ltp/testcases/realtime/autom4te.cache/output.0 
ltp/testcases/realtime/autom4te.cache/output.1 
ltp/testcases/realtime/autom4te.cache/requests 
ltp/testcases/realtime/autom4te.cache/traces.0 
ltp/testcases/realtime/autom4te.cache/traces.1 
ltp/testcases/realtime/config/GNUmakefile.am 
ltp/testcases/realtime/config/GNUmakefile.in 
ltp/testcases/realtime/config/autoconf/compile 
ltp/testcases/realtime/config/autoconf/config.guess
ltp/testcases/realtime/config/autoconf/config.sub
ltp/testcases/realtime/config/autoconf/depcomp 
ltp/testcases/realtime/config/autoconf/install-sh
ltp/testcases/realtime/config/autoconf/missing 
ltp/testcases/realtime/doc/HOWTO_ADD_TESTS 
ltp/testcases/realtime/doc/TODO 
ltp/testcases/realtime/func/GNUmakefile.am 
ltp/testcases/realtime/func/GNUmakefile.in 
ltp/testcases/realtime/func/async_handler/GNUmakefile.am
ltp/testcases/realtime/func/async_handler/GNUmakefile.in
ltp/testcases/realtime/func/async_handler/async_handler.c
ltp/testcases/realtime/func/async_handler/async_handler_jk.c
ltp/testcases/realtime/func/async_handler/async_handler_tsc.c
ltp/testcases/realtime/func/async_handler/run_auto.sh
ltp/testcases/realtime/func/gtod_latency/GNUmakefile.am
ltp/testcases/realtime/func/gtod_latency/GNUmakefile.in
ltp/testcases/realtime/func/gtod_latency/gtod_infinite.c 
ltp/testcases/realtime/func/gtod_latency/gtod_latency.c 
ltp/testcases/realtime/func/gtod_latency/run_auto.sh 
ltp/testcases/realtime/func/hrtimer-prio/GNUmakefile.am 
ltp/testcases/realtime/func/hrtimer-prio/GNUmakefile.in 
ltp/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c 
ltp/testcases/realtime/func/hrtimer-prio/run.sh 
ltp/testcases/realtime/func/matrix_mult/GNUmakefile.am 
ltp/testcases/realtime/func/matrix_mult/GNUmakefile.in 
ltp/testcases/realtime/func/matrix_mult/matrix_mult.c
ltp/testcases/realtime/func/matrix_mult/run_auto.sh
ltp/testcases/realtime/func/measurement/GNUmakefile.am
ltp/testcases/realtime/func/measurement/GNUmakefile.in
ltp/testcases/realtime/func/measurement/README
ltp/testcases/realtime/func/measurement/preempt_timing.c
ltp/testcases/realtime/func/measurement/rdtsc-latency.c
ltp/testcases/realtime/func/measurement/run.sh
ltp/testcases/realtime/func/periodic_cpu_load/GNUmakefile.am
ltp/testcases/realtime/func/periodic_cpu_load/GNUmakefile.in
ltp/testcases/realtime/func/periodic_cpu_load/mixed_load.sh
ltp/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load.c
ltp/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load_single.c
ltp/testcases/realtime/func/periodic_cpu_load/run_auto.sh
ltp/testcases/realtime/func/pi-tests/GNUmakefile.am
ltp/testcases/realtime/func/pi-tests/GNUmakefile.in
ltp/testcases/realtime/func/pi-tests/parse-testpi1.py
ltp/testcases/realtime/func/pi-tests/parse-testpi2.py
ltp/testcases/realtime/func/pi-tests/run_auto.sh
ltp/testcases/realtime/func/pi-tests/sbrk_mutex.c
ltp/testcases/realtime/func/pi-tests/test-skeleton.c
ltp/testcases/realtime/func/pi-tests/testpi-0.c
ltp/testcases/realtime/func/pi-tests/testpi-1.c
ltp/testcases/realtime/func/pi-tests/testpi-2.c
ltp/testcases/realtime/func/pi-tests/testpi-4.c
ltp/testcases/realtime/func/pi-tests/testpi-5.c
ltp/testcases/realtime/func/pi-tests/testpi-6.c
ltp/testcases/realtime/func/pi-tests/testpi-7.c
ltp/testcases/realtime/func/pi_perf/GNUmakefile.am
ltp/testcases/realtime/func/pi_perf/GNUmakefile.in
ltp/testcases/realtime/func/pi_perf/pi_perf.c
ltp/testcases/realtime/func/pi_perf/run_auto.sh
ltp/testcases/realtime/func/prio-preempt/GNUmakefile.am
ltp/testcases/realtime/func/prio-preempt/GNUmakefile.in
ltp/testcases/realtime/func/prio-preempt/prio-preempt.c
ltp/testcases/realtime/func/prio-preempt/run_auto.sh
ltp/testcases/realtime/func/prio-wake/GNUmakefile.am
ltp/testcases/realtime/func/prio-wake/GNUmakefile.in
ltp/testcases/realtime/func/prio-wake/prio-wake.c
ltp/testcases/realtime/func/prio-wake/run_auto.sh
ltp/testcases/realtime/func/pthread_kill_latency/GNUmakefile.am
ltp/testcases/realtime/func/pthread_kill_latency/GNUmakefile.in
ltp/testcases/realtime/func/pthread_kill_latency/pthread_kill_latency.c
ltp/testcases/realtime/func/sched_football/GNUmakefile.am
ltp/testcases/realtime/func/sched_football/GNUmakefile.in
ltp/testcases/realtime/func/sched_football/parse-football.py
ltp/testcases/realtime/func/sched_football/run_auto.sh
ltp/testcases/realtime/func/sched_football/sched_football.c
ltp/testcases/realtime/func/sched_jitter/GNUmakefile.am
ltp/testcases/realtime/func/sched_jitter/GNUmakefile.in
ltp/testcases/realtime/func/sched_jitter/README
ltp/testcases/realtime/func/sched_jitter/run_auto.sh
ltp/testcases/realtime/func/sched_jitter/sched_jitter.c
ltp/testcases/realtime/func/sched_latency/GNUmakefile.am
ltp/testcases/realtime/func/sched_latency/GNUmakefile.in
ltp/testcases/realtime/func/sched_latency/run_auto.sh
ltp/testcases/realtime/func/sched_latency/sched_latency.c
ltp/testcases/realtime/func/thread_clock/GNUmakefile.am
ltp/testcases/realtime/func/thread_clock/GNUmakefile.in
ltp/testcases/realtime/func/thread_clock/run_auto.sh
ltp/testcases/realtime/func/thread_clock/tc-2.c
ltp/testcases/realtime/include/GNUmakefile.am
ltp/testcases/realtime/include/GNUmakefile.in
ltp/testcases/realtime/include/libjvmsim.h
ltp/testcases/realtime/include/librttest.h
ltp/testcases/realtime/include/libstats.h
ltp/testcases/realtime/include/list.h
ltp/testcases/realtime/include/rttests_config.h.in
ltp/testcases/realtime/lib/GNUmakefile.am
ltp/testcases/realtime/lib/GNUmakefile.in
ltp/testcases/realtime/lib/libjvmsim.c
ltp/testcases/realtime/lib/librttest.c
ltp/testcases/realtime/lib/libstats.c
ltp/testcases/realtime/perf/GNUmakefile.am
ltp/testcases/realtime/perf/GNUmakefile.in
ltp/testcases/realtime/perf/latency/GNUmakefile.am
ltp/testcases/realtime/perf/latency/GNUmakefile.in
ltp/testcases/realtime/perf/latency/cpunoise.sh
ltp/testcases/realtime/perf/latency/cpunoise2000.sh
ltp/testcases/realtime/perf/latency/disknoise.sh
ltp/testcases/realtime/perf/latency/pthread_cond_latency.c
ltp/testcases/realtime/perf/latency/pthread_cond_many.c
ltp/testcases/realtime/perf/latency/pthread_cond_many_histogram.sh
ltp/testcases/realtime/perf/latency/run.sh
ltp/testcases/realtime/scripts/__init__.py
ltp/testcases/realtime/scripts/parser.py
ltp/testcases/realtime/scripts/run_c_files.sh
ltp/testcases/realtime/scripts/setenv.sh
ltp/testcases/realtime/stress/GNUmakefile.am
ltp/testcases/realtime/stress/GNUmakefile.in
ltp/testcases/realtime/stress/pi-tests/GNUmakefile.am
ltp/testcases/realtime/stress/pi-tests/GNUmakefile.in
ltp/testcases/realtime/stress/pi-tests/lookup_pi_state.c
ltp/testcases/realtime/stress/pi-tests/testpi-3.c
ltp/testcases/realtime/tools/ftqviz.py
ltp/testscripts/realtime.sh

14) Log Message: Updates for Some Copyright and License Declarations
File(s) Affected:
ltp/testcases/realtime/GNUmakefile.am
ltp/testcases/realtime/OO_DESCRIPTION.txt
ltp/testcases/realtime/README
ltp/testcases/realtime/autogen.sh
ltp/testcases/realtime/configure.ac
ltp/testcases/realtime/run.sh

15) Log Message: Initial set of PID Namespace testcase contributed by "Rishikesh K. Rajak" <risrajak@linux.vnet.ibm.com>
File(s) Added:
ltp/testcases/kernel/containers/pidns/Makefile
ltp/testcases/kernel/containers/pidns/README
ltp/testcases/kernel/containers/pidns/check_pidns_enabled.c
ltp/testcases/kernel/containers/pidns/pidns01.c
ltp/testcases/kernel/containers/pidns/pidns02.c
ltp/testcases/kernel/containers/pidns/pidns03.c
ltp/testcases/kernel/containers/pidns/runpidnstest.sh
ltp/testcases/kernel/containers/pidns/runtests_noltp.sh

File(s) Affected:
ltp/testcases/kernel/containers/Makefile
ltp/testcases/kernel/containers/container_test.sh

16) Log Message: Changed the way Copyrights and License agreements are declared
File(s) Affected:
ltp/testcases/kernel/containers/README
ltp/testcases/kernel/containers/TEST_PLAN.txt
ltp/testcases/kernel/containers/check_for_unshare.c
ltp/testcases/kernel/containers/libclone/Makefile
ltp/testcases/kernel/containers/libclone/libclone.c
ltp/testcases/kernel/containers/libclone/libclone.h
ltp/testcases/kernel/containers/sysvipc/Makefile
ltp/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c
ltp/testcases/kernel/containers/sysvipc/runipcnstest.sh
ltp/testcases/kernel/containers/sysvipc/runtests_noltp.sh
ltp/testcases/kernel/containers/sysvipc/shmnstest.c
ltp/testcases/kernel/containers/utsname/Makefile
ltp/testcases/kernel/containers/utsname/README
ltp/testcases/kernel/containers/utsname/check_utsns_enabled.c
ltp/testcases/kernel/containers/utsname/runtests_noltp.sh
ltp/testcases/kernel/containers/utsname/runutstest.sh
ltp/testcases/kernel/containers/utsname/utstest.c

--=-TY9vN1PYCntUq0wpxm64--
