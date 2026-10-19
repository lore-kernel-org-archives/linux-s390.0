Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C002D3225;
	Mon, 19 Oct 2026 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792374411; cv=none; b=Wgy41LW0Q1W15UCa8gCIZB1VA3kxD0mSsComuyW7MTxUTQNLx2GirD0GVXszq64Xp9jHOm/hgUkcfwa236ZpLEdOih84ro/yUeI/Gqt1JE8QdRPrxr0aBMozvczPwnAh0MMOQ4o3ob6JO2RTpspWiAQU0/bxK+U3v1ph69x8T1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792374411; c=relaxed/simple;
	bh=ckzKS7iuX7W5E8c0lmSt7bjM0+s1Xs9r99Ub8ETvmss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rf5NvYKSt6QNNS2OlQiwsyv6RnX5A52GzNfWuXax4ZvyfSxn+oIXooKTa9+OlScR1pMqbNG6HSCQn2n4RGpDjyA5I3x2eAb08dWMaXoUJYSAynifLUS/8SrZNKptXTw2Ely7HYv7/cOlmpixs1Phf+1UasjuZ1eGIYODkNzcbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKOJmAxR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKOJmAxR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792374408; x=1823910408;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ckzKS7iuX7W5E8c0lmSt7bjM0+s1Xs9r99Ub8ETvmss=;
  b=DKOJmAxRAupk1j+yT+fDP3V3evm8Y+L/OYDLO8el+TFpvdzaVUiuJQdi
   HIa7IX3pZ4JPEpwyyVUiPJu8MIoTd8loQVHnkfxRbyl2Rb18IeBezMwWT
   9AtS0O/CSGNMhxZt1wLC/C7TMwpTc4MnufN9S62IZ/q4YBYismZeMrd+k
   UTryIssge35KpTvwwVHnbmAocBW4cTYxZA/7pZ7agz2mmal8lAz20rHHU
   wJQtgyqsM7rft4owynbrAEw18fnPEbMrOPWDTItpYBcbvwDu4sv+VaGc4
   MHziLGzXzoXDV60Huut6jfEAeYdEh0UvrXUmNBdBp1s0c0uvvJOlLWi2a
   g==;
X-CSE-ConnectionGUID: XQLr/+62QOqaeMarHDB3Gw==
X-CSE-MsgGUID: +P8UxhfATHa4GSTAh0/G+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1064644"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="1064644"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 18:46:48 -0700
X-CSE-ConnectionGUID: 1O9VSXP9RLSIdBWQeoBOkg==
X-CSE-MsgGUID: 53HnK4lFQLyLzufCtY6bjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="2300209"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 18:46:43 -0700
Date: Mon, 19 Oct 2026 09:46:38 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	wireguard@lists.zx2c4.com, yi1.lai@intel.com, achender@kernel.org
Subject: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
Message-ID: <202610190310.9737b2e3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map" on:

commit: 8d75c338f0bcecaa6c9af67f86c176b67b6acf3e ("sysctl: remove CONFIG_PROC_SYSCTL, it just mirrors CONFIG_SYSCTL") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master b810335a0699d1810683796b0e3ffe8827ddfe6c]

in testcase: boot

config: x86_64-randconfig-2300-20261014
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu Haswell-noTSX,enforce -smp 4 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202610190310.9737b2e3-lkp@intel.com


[   35.688893][    T1] BUG: KASAN: slab-use-after-free in touch_wq_lockdep_map (workqueue.c:4031 (discriminator 1))
[   35.688893][    T1] Read of size 8 at addr ffff8881259a2968 by task swapper/0/1
[   35.688893][    T1]
[   35.688893][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.2.0-rc2-00010-g8d75c338f0bc #1 PREEMPT
[   35.688893][    T1] Call Trace:
[   35.688893][    T1]  <TASK>
[   35.688893][    T1]  dump_stack_lvl (dump_stack.c:94 dump_stack.c:120)
[   35.688893][    T1]  ? touch_wq_lockdep_map (workqueue.c:4031 (discriminator 1))
[   35.688893][    T1]  print_address_description+0x51/0x300
[   35.688893][    T1]  ? rcu_is_watching (rcu/tree.c:753 (discriminator 3))
[   35.688893][    T1]  ? touch_wq_lockdep_map (workqueue.c:4031 (discriminator 1))
[   35.688893][    T1]  print_report (kasan/report.c:482)
[   35.688893][    T1]  ? kmem_cache_debug_flags (slab.h:503)
[   35.688893][    T1]  ? fixup_red_left (slub.c:250)
[   35.688893][    T1]  ? touch_wq_lockdep_map (workqueue.c:4031 (discriminator 1))
[   35.688893][    T1]  kasan_report (kasan/report.c:595)
[   35.688893][    T1]  ? touch_wq_lockdep_map (workqueue.c:4031 (discriminator 1))
[   35.688893][    T1]  touch_wq_lockdep_map (workqueue.c:4031 (discriminator 1))
[   35.688893][    T1]  __flush_workqueue (workqueue.c:4079)
[   35.688893][    T1]  ? xa_load (xarray.c:1621)
[   35.688893][    T1]  ? tracer_preempt_on (trace/trace_irqsoff.c:686 (discriminator 1))
[   35.688893][    T1]  ? preempt_count_sub (sched/core.c:6019)
[   35.688893][    T1]  ? rcu_is_watching (rcu/tree.c:753 (discriminator 3))
[   35.688893][    T1]  ? preempt_count_sub (sched/core.c:6019)
[   35.688893][    T1]  ? touch_wq_lockdep_map (workqueue.c:4043)
[   35.688893][    T1]  ? __up_write (locking/rwsem.c:1422 (discriminator 4))
[   35.688893][    T1]  rds_ib_init (rds/ib.c:618)
[   35.688893][    T1]  rds_rdma_init (rds/rdma_transport.c:300)
[   35.688893][    T1]  ? rds_init (af_rds.c:?)
[   35.688893][    T1]  ? __raw_spin_unlock_irqrestore (linux/spinlock_api_smp.h:179 (discriminator 4))
[   35.688893][    T1]  ? add_device_randomness (linux/spinlock.h:408 char/random.c:936)
[   35.688893][    T1]  ? random_get_entropy (x86/include/asm/timex.h:11)
[   35.688893][    T1]  ? sctp_diag_init (diag.c:?)
[   35.688893][    T1]  ? rds_init (rds/af_rds.c:977)
[   35.688893][    T1]  ? rcu_is_watching (rcu/tree.c:753 (discriminator 3))
[   35.688893][    T1]  ? rds_init (af_rds.c:?)
[   35.688893][    T1]  do_one_initcall (main.c:1347)
[   35.688893][    T1]  ? trace_initcall_finish_cb (main.c:1289 (discriminator 1))
[   35.688893][    T1]  ? __kmalloc_noprof (slub.c:5363 slub.c:5387)
[   35.688893][    T1]  ? do_initcalls (linux/slab.h:973 linux/slab.h:1290 main.c:1418)
[   35.688893][    T1]  do_initcalls (main.c:1409 (discriminator 1) main.c:1425 (discriminator 1))
[   35.688893][    T1]  kernel_init_freeable (main.c:1445 main.c:1658)
[   35.688893][    T1]  ? rest_init (main.c:717)
[   35.688893][    T1]  kernel_init (main.c:1548)
[   35.688893][    T1]  ? rest_init (main.c:717)
[   35.688893][    T1]  ret_from_fork (x86/kernel/process.c:158)
[   35.688893][    T1]  ? exit_thread (x86/kernel/process.c:138)
[   35.688893][    T1]  ? __switch_to (x86/kernel/process_64.c:674)
[   35.688893][    T1]  ? rest_init (main.c:717)
[   35.688893][    T1]  ret_from_fork_asm (x86/entry/entry_64.S:245)
[   35.688893][    T1]  </TASK>
[   35.688893][    T1]
[   35.688893][    T1] Allocated by task 1 on cpu 1 at 35.661878s:
[   35.688893][    T1]  stack_trace_save (stacktrace.c:122 (discriminator 1))
[   35.688893][    T1]  kasan_save_stack (kasan/common.c:57)
[   35.688893][    T1]  kasan_save_track (kasan/common.c:78)
[   35.688893][    T1]  __kasan_kmalloc (kasan/common.c:415)
[   35.688893][    T1]  __kmalloc_noprof (linux/kasan.h:263 slub.c:5362 slub.c:5387)
[   35.688893][    T1]  __alloc_workqueue (workqueue.c:5827)
[   35.688893][    T1]  alloc_workqueue_va (workqueue.c:5946)
[   35.688893][    T1]  alloc_workqueue_noprof (workqueue.c:5962)
[   35.688893][    T1]  rds_threads_init (rds/threads.c:259 (discriminator 2))
[   35.688893][    T1]  rds_init (rds/af_rds.c:961)
[   35.688893][    T1]  do_one_initcall (main.c:1347)
[   35.688893][    T1]  do_initcalls (main.c:1409 (discriminator 1) main.c:1425 (discriminator 1))
[   35.688893][    T1]  kernel_init_freeable (main.c:1445 main.c:1658)
[   35.688893][    T1]  kernel_init (main.c:1548)
[   35.688893][    T1]  ret_from_fork (x86/kernel/process.c:158)
[   35.688893][    T1]  ret_from_fork_asm (x86/entry/entry_64.S:245)
[   35.688893][    T1]
[   35.688893][    T1] Freed by task 0 on cpu 3 at 35.674112s:
[   35.688893][    T1]  stack_trace_save (stacktrace.c:122 (discriminator 1))
[   35.688893][    T1]  kasan_save_stack (kasan/common.c:57)
[   35.688893][    T1]  kasan_save_track (kasan/common.c:78)
[   35.688893][    T1]  kasan_save_free_info (kasan/generic.c:584)
[   35.688893][    T1]  __kasan_slab_free (kasan/common.c:285)
[   35.688893][    T1]  kfree (linux/kasan.h:235 slub.c:2705 slub.c:6405 slub.c:6720)
[   35.688893][    T1]  rcu_do_batch (rcu/tree.c:2645)
[   35.688893][    T1]  rcu_core (rcu/tree.c:2897)
[   35.688893][    T1]  handle_softirqs (softirq.c:622)
[   35.688893][    T1]  __irq_exit_rcu (softirq.c:496 softirq.c:735)
[   35.688893][    T1]  irq_exit_rcu (softirq.c:752)
[   35.688893][    T1]  sysvec_apic_timer_interrupt (x86/kernel/apic/apic.c:1062 (discriminator 35) x86/kernel/apic/apic.c:1062 (discriminator 35))
[   35.688893][    T1]  asm_sysvec_apic_timer_interrupt (x86/include/asm/idtentry.h:546)
[   35.688893][    T1]
[   35.688893][    T1] Last potentially related work creation:
[   35.688893][    T1]  stack_trace_save (stacktrace.c:122 (discriminator 1))
[   35.688893][    T1]  kasan_save_stack (kasan/common.c:57)
[   35.688893][    T1]  kasan_record_aux_stack (kasan/generic.c:556)
[   35.688893][    T1]  __call_rcu_common+0xe6/0x480
[   35.688893][    T1]  kthread_worker_fn (kthread.c:1025)
[   35.688893][    T1]  kthread (kthread.c:436)
[   35.688893][    T1]  ret_from_fork (x86/kernel/process.c:158)
[   35.688893][    T1]  ret_from_fork_asm (x86/entry/entry_64.S:245)
[   35.688893][    T1]
[   35.688893][    T1] The buggy address belongs to the object at ffff8881259a2800
[   35.688893][    T1]  which belongs to the cache kmalloc-1k of size 1024
[   35.688893][    T1] The buggy address belongs to the object at ffff8881259a2800
[   35.688893][    T1]  which belongs to the cache kmalloc-1k of size 1024
[   35.688893][    T1] The buggy address belongs to the object at ffff8881259a2800
[   35.688893][    T1]  which belongs to the cache kmalloc-1k of size 1024
[   35.688893][    T1] The buggy address is located 360 bytes inside of
[   35.688893][    T1]  freed 1024-byte region [ffff8881259a2800, ffff8881259a2c00)
[   35.688893][    T1] The buggy address is located 360 bytes inside of
[   35.688893][    T1]  freed 1024-byte region [ffff8881259a2800, ffff8881259a2c00)
[   35.688893][    T1] The buggy address is located 360 bytes inside of
[   35.688893][    T1]  freed 1024-byte region [ffff8881259a2800, ffff8881259a2c00)
[   35.688893][    T1]
[   35.688893][    T1] The buggy address belongs to the physical page:
[   35.688893][    T1] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1259a0
[   35.688893][    T1] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   35.688893][    T1] flags: 0x4000000000000040(head|zone=2)
[   35.688893][    T1] page_type: f5(slab)
[   35.688893][    T1] raw: 4000000000000040 ffff888100042dc0 dead000000000100 dead000000000122
[   35.688893][    T1] raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
[   35.688893][    T1] head: 4000000000000040 ffff888100042dc0 dead000000000100 dead000000000122
[   35.688893][    T1] head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
[   35.688893][    T1] head: 4000000000000003 ffffea0004966801 00000000ffffffff 00000000ffffffff
[   35.688893][    T1] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[   35.688893][    T1] page dumped because: kasan: bad access detected
[   35.688893][    T1]
[   35.688893][    T1] Memory state around the buggy address:
[   35.688893][    T1]  ffff8881259a2800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   35.688893][    T1]  ffff8881259a2880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   35.688893][    T1] >ffff8881259a2900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   35.688893][    T1]                                                           ^
[   35.688893][    T1]  ffff8881259a2980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   35.688893][    T1]  ffff8881259a2a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   35.688893][    T1] ==================================================================
[   35.984299][    T1] Disabling lock debugging due to kernel taint
[   35.987548][    T1] Oops: general protection fault, probably for non-canonical address 0xe0a07c0ec0000008: 0000 [#1] SMP KASAN
[   35.988482][    T1] KASAN: maybe wild-memory-access in range [0x0504007600000040-0x0504007600000047]
[   35.988482][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G    B               7.2.0-rc2-00010-g8d75c338f0bc #1 PREEMPT
[   35.988482][    T1] Tainted: [B]=BAD_PAGE
[   35.988482][    T1] RIP: 0010:do_raw_spin_lock (locking/spinlock_debug.c:86 (discriminator 2) locking/spinlock_debug.c:115 (discriminator 2))
[   35.988482][    T1] Code: 3b 58 81 49 8d 14 04 c7 02 f1 f1 f1 f1 c7 42 04 04 f3 f3 f3 65 48 8b 15 f0 53 f7 08 48 89 54 24 60 31 d2 48 89 fa 48 c1 ea 03 <8a> 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 39
All code
========
   0:	3b 58 81             	cmp    -0x7f(%rax),%ebx
   3:	49 8d 14 04          	lea    (%r12,%rax,1),%rdx
   7:	c7 02 f1 f1 f1 f1    	movl   $0xf1f1f1f1,(%rdx)
   d:	c7 42 04 04 f3 f3 f3 	movl   $0xf3f3f304,0x4(%rdx)
  14:	65 48 8b 15 f0 53 f7 	mov    %gs:0x8f753f0(%rip),%rdx        # 0x8f7540c
  1b:	08 
  1c:	48 89 54 24 60       	mov    %rdx,0x60(%rsp)
  21:	31 d2                	xor    %edx,%edx
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	8a 14 02             	mov    (%rdx,%rax,1),%dl		<-- trapping instruction
  2d:	48 89 f8             	mov    %rdi,%rax
  30:	83 e0 07             	and    $0x7,%eax


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261019/202610190310.9737b2e3-lkp@intel.com



--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


