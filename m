From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Thu, 14 Jan 2016 18:15:19 +0100
Message-ID: <5697D7A7.9050105@de.ibm.com>
References: <56978452.6010606@de.ibm.com> <5697AAF0.4050802@kyup.com>
 <5697ABDD.2040208@de.ibm.com> <5697B04F.7030102@kyup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5697B04F.7030102@kyup.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Nikolay Borisov <kernel@kyup.com>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 01/14/2016 03:27 PM, Nikolay Borisov wrote:
> 
> 
> On 01/14/2016 04:08 PM, Christian Borntraeger wrote:
>> On 01/14/2016 03:04 PM, Nikolay Borisov wrote:
>>>
>>>
>>> On 01/14/2016 01:19 PM, Christian Borntraeger wrote:
>>>> Folks,
>>>>
>>>> With 4.4 I can easily bring the system into a hang like situation by
>>>> putting stress on the cgroup_threadgroup rwsem. (e.g. starting/stopping
>>>> kvm guests via libvirt and many vCPUs). Here is my preliminary analysis:
>>>>
>>>> When the hang happens, the system is idle for all CPUs. There are some
>>>> processes waiting for the cgroup_thread_rwsem, e.g.
>>>>
>>>> crash> bt 87399
>>>> PID: 87399  TASK: faef084998        CPU: 59  COMMAND: "systemd-udevd"
>>>>  #0 [f9e762fc88] __schedule at 83b2cc
>>>>  #1 [f9e762fcf0] schedule at 83ba26
>>>>  #2 [f9e762fd08] rwsem_down_read_failed at 83fb64
>>>>  #3 [f9e762fd68] percpu_down_read at 1bdf56
>>>>  #4 [f9e762fdd0] exit_signals at 1742ae
>>>>  #5 [f9e762fe00] do_exit at 163be0
>>>>  #6 [f9e762fe60] do_group_exit at 165c62
>>>>  #7 [f9e762fe90] __wake_up_parent at 165d00
>>>>  #8 [f9e762fea8] system_call at 842386
>>>>
>>>> of course, any new process would wait for the same lock during fork.
>>>>
>>>> Looking at the rwsem, while all CPUs are idle, it appears that the lock
>>>> is taken for write:
>>>>
>>>> crash> print /x cgroup_threadgroup_rwsem.rw_sem
>>>> $8 = {
>>>>   count = 0xfffffffe00000001, 
>>>> [..]
>>>>   owner = 0xfabf28c998, 
>>>> }
>>>>
>>>> Looking at the owner field:
>>>>
>>>> crash> bt 0xfabf28c998
>>>> PID: 11867  TASK: fabf28c998        CPU: 42  COMMAND: "libvirtd"
>>>>  #0 [fadeccb5e8] __schedule at 83b2cc
>>>>  #1 [fadeccb650] schedule at 83ba26
>>>>  #2 [fadeccb668] schedule_timeout at 8403c6
>>>>  #3 [fadeccb748] wait_for_common at 83c850
>>>>  #4 [fadeccb7b8] flush_work at 18064a
>>>>  #5 [fadeccb8d8] lru_add_drain_all at 2abd10
>>>>  #6 [fadeccb938] migrate_prep at 309ed2
>>>>  #7 [fadeccb950] do_migrate_pages at 2f7644
>>>>  #8 [fadeccb9f0] cpuset_migrate_mm at 220848
>>>>  #9 [fadeccba58] cpuset_attach at 223248
>>>> #10 [fadeccbaa0] cgroup_taskset_migrate at 21a678
>>>> #11 [fadeccbaf8] cgroup_migrate at 21a942
>>>> #12 [fadeccbba0] cgroup_attach_task at 21ab8a
>>>> #13 [fadeccbc18] __cgroup_procs_write at 21affa
>>>> #14 [fadeccbc98] cgroup_file_write at 216be0
>>>> #15 [fadeccbd08] kernfs_fop_write at 3aa088
>>>> #16 [fadeccbd50] __vfs_write at 319782
>>>> #17 [fadeccbe08] vfs_write at 31a1ac
>>>> #18 [fadeccbe68] sys_write at 31af06
>>>> #19 [fadeccbea8] system_call at 842386
>>>>  PSW:  0705100180000000 000003ff9438f9f0 (user space)
>>>>
>>>> it appears that the write holder scheduled away and waits
>>>> for a completion. Now what happens is, that the write lock
>>>> holder finally calls flush_work for the lru_add_drain_all
>>>> work. 
>>>
>>> So what's happening is that libvirtd wants to move some processes in the
>>> cgroup subtree and it to the respective cgroup file. So
>>> cgroup_threadgroup_rwsem is acquired in __cgroup_procs_write, then as
>>> part of this process the pages for that process have to be migrated,
>>> hence the do_migrate_pages. And this call chain boils down to calling
>>> lru_add_drain_cpu on every cpu.
>>>
>>>
>>>>
>>>> As far as I can see, this work is now tries to create a new kthread
>>>> and waits for that, as the backtrace for the kworker on that cpu has:
>>>>
>>>> PID: 81913  TASK: fab5356220        CPU: 42  COMMAND: "kworker/42:2"
>>>>  #0 [fadd6d7998] __schedule at 83b2cc
>>>>  #1 [fadd6d7a00] schedule at 83ba26
>>>>  #2 [fadd6d7a18] schedule_timeout at 8403c6
>>>>  #3 [fadd6d7af8] wait_for_common at 83c850
>>>>  #4 [fadd6d7b68] wait_for_completion_killable at 83c996
>>>>  #5 [fadd6d7b88] kthread_create_on_node at 1876a4
>>>>  #6 [fadd6d7cc0] create_worker at 17d7fa
>>>>  #7 [fadd6d7d30] worker_thread at 17fff0
>>>>  #8 [fadd6d7da0] kthread at 187884
>>>>  #9 [fadd6d7ea8] kernel_thread_starter at 842552
>>>>
>>>> Problem is that kthreadd then needs the cgroup lock for reading,
>>>> while libvirtd still has the lock for writing.
>>>>
>>>> crash> bt 0xfaf031e220
>>>> PID: 2      TASK: faf031e220        CPU: 40  COMMAND: "kthreadd"
>>>>  #0 [faf034bad8] __schedule at 83b2cc
>>>>  #1 [faf034bb40] schedule at 83ba26
>>>>  #2 [faf034bb58] rwsem_down_read_failed at 83fb64
>>>>  #3 [faf034bbb8] percpu_down_read at 1bdf56
>>>>  #4 [faf034bc20] copy_process at 15eab6
>>>>  #5 [faf034bd08] _do_fork at 160430
>>>>  #6 [faf034bdd0] kernel_thread at 160a82
>>>>  #7 [faf034be30] kthreadd at 188580
>>>>  #8 [faf034bea8] kernel_thread_starter at 842552
>>>>
>>>> BANG.kthreadd waits for the lock that libvirtd hold, and libvirtd waits
>>>> for kthreadd to finish some task
>>>
>>> I don't see percpu_down_read being invoked from copy_process. According
>>> to LXR, this semaphore is used only in __cgroup_procs_write and
>>> cgroup_update_dfl_csses. And cgroup_update_dfl_csses is invoked when
>>> cgroup.subtree_control is written to. And I don't see this happening in
>>> this call chain.
>>
>> The callchain is inlined and as follows:
>>
>>
>> _do_fork
>> copy_process
>> threadgroup_change_begin
>> cgroup_threadgroup_change_begin
> 
> Ah, I see I have missed that one. So essentially what's happening is
> that while migrating processes using a gobal rw semaphore essentially
> "disables" forking, but in this case in order to finish the migration a
> task has to be spawned (the workqueue worker) and this causes the lock.
> Such problems were non-existent before the percpu_rwsem rework since the
> lock used was a per-threadgroup. Bummer...

I think the problem was not caused by the percpu_rwsem rework,

instead by

commit c9e75f0492b248aeaa7af8991a6fc9a21506bc96
    cgroup: pids: fix race between cgroup_post_fork() and cgroup_migrate()


which did changes like

-       if (clone_flags & CLONE_THREAD)
-               threadgroup_change_begin(current);
+       threadgroup_change_begin(current);


So we now ALWAYS take the lock, even for new kernel threads, while before
spawning kernel threads ignored cgroups.

Maybe something like (untested, incomplete, white space damaged)

--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -21,8 +21,7 @@
 #define CLONE_DETACHED         0x00400000      /* Unused, ignored */
 #define CLONE_UNTRACED         0x00800000      /* set if the tracing process can't force CLONE_PTRACE on this clone */
 #define CLONE_CHILD_SETTID     0x01000000      /* set the TID in the child */
-/* 0x02000000 was previously the unused CLONE_STOPPED (Start in stopped state)
-   and is now available for re-use. */
+#define CLONE_KERNEL           0x02000000      /* Clone kernel thread */
 #define CLONE_NEWUTS           0x04000000      /* New utsname namespace */
 #define CLONE_NEWIPC           0x08000000      /* New ipc namespace */
 #define CLONE_NEWUSER          0x10000000      /* New user namespace */
diff --git a/kernel/fork.c b/kernel/fork.c
index fce002e..c061b5d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1368,7 +1368,8 @@ static struct task_struct *copy_process(unsigned long clone_flags,
        p->real_start_time = ktime_get_boot_ns();
        p->io_context = NULL;
        p->audit_context = NULL;
-       threadgroup_change_begin(current);
+       if (!(clone_flags & CLONE_KERNEL))
+               threadgroup_change_begin(current);
        cgroup_fork(p);
 #ifdef CONFIG_NUMA
        p->mempolicy = mpol_dup(p->mempolicy);


Oleg?
