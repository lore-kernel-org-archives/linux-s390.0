From: Andy Lutomirski <luto@kernel.org>
Subject: Is THREAD_INFO_IN_TASK appropriate for -mm for 4.8?
Date: Mon, 18 Jul 2016 16:47:39 -0700
Message-ID: <CALCETrUf_7=Tr4JrDj+3UPT5kUT1MsRtypvfqkOg_MVHAJu=PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, x86 <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Hi all-

There are four core patches needed for the THREAD_INFO_IN_TASK thing,
and they apply cleanly to -mm now.  The x86 patch to flip the feature
on does not apply cleanly anywhere because it depends on changes in
-tip *and* in -mm.  I'd like to get all of this as well as the rest of
the vmap-stacks stuff in by 4.9, but I'm wondering if it might make
sense to get the core THREAD_INFO_IN_TASK stuff into -mm for 4.8
instead.

Pros:
 - It reduces the amount of core code that -tip will have to carry until 4.9.
 - It may benefit other architectures.  Christian Borntraeger
expressed an interest in enabling the feature for s390, but it'll be
awkward for him until the core bit landed.  Similarly, arm64 seems to
be interested.

Cons: It's a bit odd to merge code that can't be enabled as-is.  OTOH
x86 could plausibly enable it for 4.8 if Ingo is okay with applying
"x86/dumpstack: Pin the target stack in save_stack_trace_tsk()" and
"x86: Move thread_info into task_struct" during the merge window after
the -mm patchbomb lands.

The core changes are:

sched: Allow putting thread_info into task_struct
sched: Add try_get_task_stack() and put_task_stack()
kthread: to_live_kthread() needs try_get_task_stack()
sched: Free the stack early if CONFIG_THREAD_INFO_IN_TASK

They're also sitting here against mmots:

https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=mmots_ti_in_task

It looks like this:

 include/linux/init_task.h   | 11 ++++++++
 include/linux/sched.h       | 66 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/thread_info.h | 15 +++++++++++
 init/Kconfig                | 10 +++++++
 init/init_task.c            |  7 +++--
 kernel/fork.c               | 35 +++++++++++++++++++++++-
 kernel/kthread.c            |  8 ++++--
 kernel/sched/core.c         |  4 +++
 kernel/sched/sched.h        |  4 +++
 9 files changed, 153 insertions(+), 7 deletions(-)

So... should I send it out against -mm or should I wait until 4.8-rc1.
