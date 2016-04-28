Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 00/18] livepatch: hybrid consistency model
Date: Thu, 28 Apr 2016 15:44:31 -0500
Message-Id: <cover.1461875890.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

This is v2 of the livepatch hybrid consistency model, based on
linux-next/master.

v1 of this patch set was posted over a year ago:

  https://lkml.kernel.org/r/cover.1423499826.git.jpoimboe@redhat.com

The biggest complaint at that time was that stack traces are unreliable.
Since CONFIG_STACK_VALIDATION was merged, that issue has been addressed.
I've also tried to address all other outstanding complaints and issues.

Ingo and Peter, note that I'm using task_rq_lock() in patch 17/18 to
make sure a task stays asleep while its stack gets checked.  I'm not
sure if there's a better way to achieve that goal -- any suggestions
there would be greatly appreciated.

Patches 1-7 create a mechanism for detecting whether a given stack trace
can be deemed reliable.

Patches 8-18 add the consistency model.  See patch 17/18 for more
details about the consistency model itself.

Remaining TODOs:
- how to patch kthreads without RELIABLE_STACKTRACE?
- safe patch module removal
- fake signal facility
- allow user to force a task to the patched state
- enable the patching of kthreads which are sleeping on affected
  functions, via the livepatch ftrace handler
- WARN on certain stack error conditions

v2:
- "universe" -> "patch state"
- rename klp_update_task_universe() -> klp_patch_task()
- add preempt IRQ tracking (TF_PREEMPT_IRQ)
- fix print_context_stack_reliable() bug
- improve print_context_stack_reliable() comments
- klp_ftrace_handler comment fixes
- add "patch_state" proc file to tid_base_stuff
- schedule work even for !RELIABLE_STACKTRACE
- forked child inherits patch state from parent
- add detailed comment to livepatch.h klp_func definition about the
  klp_func patched/transition state transitions
- update exit_to_usermode_loop() comment
- clear all TIF_KLP_NEED_UPDATE flags in klp_complete_transition()
- remove unnecessary function externs
- add livepatch documentation, sysfs documentation, /proc documentation
- /proc/pid/patch_state: -1 means no patch is currently being applied/reverted
- "TIF_KLP_NEED_UPDATE" -> "TIF_PATCH_PENDING"
- support for s390 and powerpc-le
- don't assume stacks with dynamic ftrace trampolines are reliable
- add _TIF_ALLWORK_MASK info to commit log

v1.9:
- revive from the dead and rebased
- reliable stacks!
- add support for immediate consistency model
- add a ton of comments
- fix up memory barriers
- remove "allow patch modules to be removed" patch for now, it still 
  needs more discussion and thought - it can be done with something
- "proc/pid/universe" -> "proc/pid/patch_status"
- remove WARN_ON_ONCE from !func condition in ftrace handler -- can
  happen because of RCU
- keep klp_mutex private by putting the work_fn in core.c
- convert states from int to boolean
- remove obsolete '@state' comments
- several header file and include improvements suggested by Jiri S
- change kallsyms_lookup_size_offset() errors from EINVAL -> ENOENT
- change proc file permissions S_IRUGO -> USR
- use klp_for_each_object/func helpers


Jiri Slaby (1):
  livepatch/s390: reorganize TIF thread flag bits

Josh Poimboeuf (16):
  x86/asm/head: clean up initial stack variable
  x86/asm/head: use a common function for starting CPUs
  x86/asm/head: standardize the bottom of the stack for idle tasks
  x86: move _stext marker before head code
  sched: add task flag for preempt IRQ tracking
  x86: dump_trace() error handling
  stacktrace/x86: function for detecting reliable stack traces
  livepatch: temporary stubs for klp_patch_pending() and
    klp_patch_task()
  livepatch/x86: add TIF_PATCH_PENDING thread flag
  livepatch/powerpc: add TIF_PATCH_PENDING thread flag
  livepatch: separate enabled and patched states
  livepatch: remove unnecessary object loaded check
  livepatch: move patching functions into patch.c
  livepatch: store function sizes
  livepatch: change to a per-task consistency model
  livepatch: add /proc/<pid>/patch_state

Miroslav Benes (1):
  livepatch/s390: add TIF_PATCH_PENDING thread flag

 Documentation/ABI/testing/sysfs-kernel-livepatch |   8 +
 Documentation/filesystems/proc.txt               |  18 +
 Documentation/livepatch/livepatch.txt            | 132 ++++++-
 arch/Kconfig                                     |   6 +
 arch/powerpc/include/asm/thread_info.h           |   4 +-
 arch/powerpc/kernel/signal.c                     |   4 +
 arch/s390/include/asm/thread_info.h              |  24 +-
 arch/s390/kernel/entry.S                         |  31 +-
 arch/x86/Kconfig                                 |   1 +
 arch/x86/entry/common.c                          |   9 +-
 arch/x86/include/asm/realmode.h                  |   2 +-
 arch/x86/include/asm/smp.h                       |   3 -
 arch/x86/include/asm/stacktrace.h                |  36 +-
 arch/x86/include/asm/thread_info.h               |   2 +
 arch/x86/kernel/acpi/sleep.c                     |   2 +-
 arch/x86/kernel/dumpstack.c                      | 108 +++++-
 arch/x86/kernel/dumpstack_32.c                   |  22 +-
 arch/x86/kernel/dumpstack_64.c                   |  53 ++-
 arch/x86/kernel/head_32.S                        |   8 +-
 arch/x86/kernel/head_64.S                        |  34 +-
 arch/x86/kernel/smpboot.c                        |   2 +-
 arch/x86/kernel/stacktrace.c                     |  24 ++
 arch/x86/kernel/vmlinux.lds.S                    |   2 +-
 fs/proc/base.c                                   |  15 +
 include/linux/init_task.h                        |   9 +
 include/linux/kernel.h                           |   1 +
 include/linux/livepatch.h                        |  57 ++-
 include/linux/sched.h                            |   4 +
 include/linux/stacktrace.h                       |  20 +-
 kernel/extable.c                                 |   2 +-
 kernel/fork.c                                    |   5 +-
 kernel/livepatch/Makefile                        |   2 +-
 kernel/livepatch/core.c                          | 342 +++++-----------
 kernel/livepatch/patch.c                         | 254 ++++++++++++
 kernel/livepatch/patch.h                         |  33 ++
 kernel/livepatch/transition.c                    | 474 +++++++++++++++++++++++
 kernel/livepatch/transition.h                    |  14 +
 kernel/sched/core.c                              |   4 +
 kernel/sched/idle.c                              |   4 +
 kernel/stacktrace.c                              |   4 +-
 lib/Kconfig.debug                                |   6 +
 41 files changed, 1413 insertions(+), 372 deletions(-)
 create mode 100644 kernel/livepatch/patch.c
 create mode 100644 kernel/livepatch/patch.h
 create mode 100644 kernel/livepatch/transition.c
 create mode 100644 kernel/livepatch/transition.h

-- 
2.4.11
