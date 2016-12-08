Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v3 00/15] livepatch: hybrid consistency model
Date: Thu,  8 Dec 2016 12:08:25 -0600
Message-Id: <cover.1481220077.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Dusting the cobwebs off the consistency model again.  This is based on
linux-next/master.

v1 was posted on 2015-02-09:

  https://lkml.kernel.org/r/cover.1423499826.git.jpoimboe@redhat.com

v2 was posted on 2016-04-28:

  https://lkml.kernel.org/r/cover.1461875890.git.jpoimboe@redhat.com

The biggest issue from v2 was finding a decent way to detect preemption
and page faults on the stack of a sleeping task.  That problem was
solved by rewriting the x86 stack unwinder.  The new unwinder helps
detect such cases by finding all pt_regs on the stack.  When
preemption/page faults are detected, the stack is considered unreliable
and the patching of the task is deferred.

For more details about the consistency model, see patch 13/15.

---

v3:
- rebase on new x86 unwinder
- force !HAVE_RELIABLE_STACKTRACE arches to use patch->immediate for
  now, because we don't have a way to transition kthreads otherwise
- rebase s390 TIF_PATCH_PENDING patch onto latest entry code
- update barrier comments and move barrier from the end of
  klp_init_transition() to its callers
- "klp_work" -> "klp_transition_work"
- "klp_patch_task()" -> "klp_update_patch_state()"
- explicit _TIF_ALLWORK_MASK
- change klp_reverse_transition() to not try to complete transition.
  instead modify the work queue delay to zero.
- get rid of klp_schedule_work() in favor of calling
  schedule_delayed_work() directly with a KLP_TRANSITION_DELAY
- initialize klp_target_state to KLP_UNDEFINED
- move klp_target_state assignment to before patch->immediate check in
  klp_init_transition()
- rcu_read_lock() in klp_update_patch_state(), test the thread flag in
  patch task, synchronize_rcu() in klp_complete_transition()
- use kstrtobool() in enabled_store()
- change task_rq_lock() argument type to struct rq_flags
- add several WARN_ON_ONCE assertions for klp_target_state and
  task->patch_state

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

---

Jiri Slaby (1):
  livepatch/s390: reorganize TIF thread flag bits

Josh Poimboeuf (12):
  stacktrace/x86: add function for detecting reliable stack traces
  x86/entry: define _TIF_ALLWORK_MASK flags explicitly
  livepatch: temporary stubs for klp_patch_pending() and
    klp_update_patch_state()
  livepatch/x86: add TIF_PATCH_PENDING thread flag
  livepatch/powerpc: add TIF_PATCH_PENDING thread flag
  livepatch: separate enabled and patched states
  livepatch: remove unnecessary object loaded check
  livepatch: move patching functions into patch.c
  livepatch: use kstrtobool() in enabled_store()
  livepatch: store function sizes
  livepatch: change to a per-task consistency model
  livepatch: add /proc/<pid>/patch_state

Miroslav Benes (2):
  livepatch/s390: add TIF_PATCH_PENDING thread flag
  livepatch: allow removal of a disabled patch

 Documentation/ABI/testing/sysfs-kernel-livepatch |   8 +
 Documentation/filesystems/proc.txt               |  18 +
 Documentation/livepatch/livepatch.txt            | 156 ++++++--
 arch/Kconfig                                     |   6 +
 arch/powerpc/include/asm/thread_info.h           |   4 +-
 arch/powerpc/kernel/signal.c                     |   4 +
 arch/s390/include/asm/thread_info.h              |  24 +-
 arch/s390/kernel/entry.S                         |  31 +-
 arch/x86/Kconfig                                 |   1 +
 arch/x86/entry/common.c                          |   9 +-
 arch/x86/include/asm/thread_info.h               |  11 +-
 arch/x86/include/asm/unwind.h                    |   6 +
 arch/x86/kernel/stacktrace.c                     |  59 ++-
 arch/x86/kernel/unwind_frame.c                   |   1 +
 fs/proc/base.c                                   |  15 +
 include/linux/init_task.h                        |   9 +
 include/linux/livepatch.h                        |  66 ++-
 include/linux/sched.h                            |   3 +
 include/linux/stacktrace.h                       |   8 +-
 kernel/fork.c                                    |   3 +
 kernel/livepatch/Makefile                        |   2 +-
 kernel/livepatch/core.c                          | 446 +++++++++------------
 kernel/livepatch/patch.c                         | 261 ++++++++++++
 kernel/livepatch/patch.h                         |  33 ++
 kernel/livepatch/transition.c                    | 487 +++++++++++++++++++++++
 kernel/livepatch/transition.h                    |  14 +
 kernel/sched/idle.c                              |   4 +
 kernel/stacktrace.c                              |  12 +-
 samples/livepatch/livepatch-sample.c             |   8 +-
 29 files changed, 1367 insertions(+), 342 deletions(-)
 create mode 100644 kernel/livepatch/patch.c
 create mode 100644 kernel/livepatch/patch.h
 create mode 100644 kernel/livepatch/transition.c
 create mode 100644 kernel/livepatch/transition.h

-- 
2.7.4
