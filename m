Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E71ACE79A9
	for <linux-s390@archiver.kernel.org>; Wed, 20 Sep 2023 00:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjITAMp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Sep 2023 20:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjITAMo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Sep 2023 20:12:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F3595
        for <linux-s390@vger.kernel.org>; Tue, 19 Sep 2023 17:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695168757; x=1726704757;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=94qp9IrobOWmSrBzI137PRIjqt4vvamPJjVL/zPgL48=;
  b=Py5BD+fECCcYyS1JjrdOenTCoPYOPaXcvC3qiV+Ni9wWWKfTZxK54UXJ
   6+J35uFtwFe/wk5a8SKAowa3BVLekSvliGqZnC52gFFHj3uMtgVAKdEt8
   8iRJ/drDbxRobiDLW9/w8V9+sxgi3tk8Pi1Gyl1DIjXN40KYaFvlDtYGB
   4N3EiWhHElnrUeLLdVZ5AwUXTwkcAjJt1XpVNlGsbY4YHLdpDQBMvoRTb
   DPXyqf8l5v0KoRBegdVa0AqFGyr5azZBdPu5p6ywdcT2DKErEhO5BKTMU
   rTlCP+bCG97V4k1AXsfCFSfZELp8Nee8ho+ZOrtQDqQkHGnPpQTxF1n2z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="377400569"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="377400569"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 17:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="749678608"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="749678608"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 19 Sep 2023 17:12:35 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qikpV-000862-1D;
        Wed, 20 Sep 2023 00:12:33 +0000
Date:   Wed, 20 Sep 2023 08:11:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [s390:features 15/24] arch/s390/include/asm/ctlreg.h:80:9: warning:
 array subscript 0 is outside array bounds of 'struct ctlreg[0]'
Message-ID: <202309200800.w8cCwbsF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
head:   99441a38c391b1115e405d1f47ede237fca37f1b
commit: 527618abb92793b9d4dba548d55822dcebd95317 [15/24] s390/ctlreg: add struct ctlreg
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20230920/202309200800.w8cCwbsF-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309200800.w8cCwbsF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309200800.w8cCwbsF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/s390/include/asm/lowcore.h:14,
                    from arch/s390/include/asm/current.h:13,
                    from arch/s390/include/asm/preempt.h:5,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from kernel/kthread.c:11:
   In function 'local_ctl_load',
       inlined from 'finish_arch_post_lock_switch' at arch/s390/include/asm/mmu_context.h:114:2,
       inlined from 'kthread_use_mm' at kernel/kthread.c:1436:2:
>> arch/s390/include/asm/ctlreg.h:80:9: warning: array subscript 0 is outside array bounds of 'struct ctlreg[0]' [-Warray-bounds=]
      80 |         asm volatile(
         |         ^~~
   In function 'kthread_use_mm':
   cc1: note: source object is likely at address zero
--
   In file included from arch/s390/include/asm/lowcore.h:14,
                    from arch/s390/include/asm/current.h:13,
                    from arch/s390/include/asm/preempt.h:5,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from fs/exec.c:27:
   In function 'local_ctl_load',
       inlined from 'activate_mm' at arch/s390/include/asm/mmu_context.h:123:2,
       inlined from 'exec_mmap' at fs/exec.c:1026:2:
>> arch/s390/include/asm/ctlreg.h:80:9: warning: array subscript 0 is outside array bounds of 'struct ctlreg[0]' [-Warray-bounds=]
      80 |         asm volatile(
         |         ^~~
   In function 'exec_mmap':
   cc1: note: source object is likely at address zero
--
   In file included from arch/s390/include/asm/lowcore.h:14,
                    from arch/s390/include/asm/current.h:13,
                    from arch/s390/include/asm/preempt.h:5,
                    from include/linux/preempt.h:79,
                    from arch/s390/include/asm/percpu.h:5,
                    from include/linux/irqflags.h:18,
                    from include/linux/rcupdate.h:26,
                    from include/linux/sysctl.h:26,
                    from arch/s390/mm/pgalloc.c:9:
   In function 'local_ctl_load',
       inlined from '__crst_table_upgrade' at arch/s390/mm/pgalloc.c:66:3:
>> arch/s390/include/asm/ctlreg.h:80:9: warning: array subscript 0 is outside array bounds of 'struct ctlreg[0]' [-Warray-bounds=]
      80 |         asm volatile(
         |         ^~~
   In function '__crst_table_upgrade':
   cc1: note: source object is likely at address zero
   In file included from arch/s390/include/asm/atomic.h:14,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25:
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:59:2,
       inlined from '__local_bh_disable_ip' at include/linux/bottom_half.h:13:2,
       inlined from '__raw_spin_lock_bh' at include/linux/spinlock_api_smp.h:125:2,
       inlined from 'spin_lock_bh' at include/linux/spinlock.h:356:2,
       inlined from 'crst_table_upgrade' at arch/s390/mm/pgalloc.c:95:2:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function 'crst_table_upgrade':
   cc1: note: source object is likely at address zero
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:59:2,
       inlined from '__local_bh_disable_ip' at include/linux/bottom_half.h:13:2,
       inlined from '__raw_spin_lock_bh' at include/linux/spinlock_api_smp.h:125:2,
       inlined from 'spin_lock_bh' at include/linux/spinlock.h:356:2,
       inlined from 'crst_table_upgrade' at arch/s390/mm/pgalloc.c:95:2:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function 'crst_table_upgrade':
   cc1: note: source object is likely at address zero
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:59:2,
       inlined from '__local_bh_disable_ip' at include/linux/bottom_half.h:13:2,
       inlined from '__raw_spin_lock_bh' at include/linux/spinlock_api_smp.h:125:2,
       inlined from 'spin_lock_bh' at include/linux/spinlock.h:356:2,
       inlined from 'page_table_alloc' at arch/s390/mm/pgalloc.c:251:3:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function 'page_table_alloc':
   cc1: note: source object is likely at address zero
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:59:2,
       inlined from '__local_bh_disable_ip' at include/linux/bottom_half.h:13:2,
       inlined from '__raw_spin_lock_bh' at include/linux/spinlock_api_smp.h:125:2,
       inlined from 'spin_lock_bh' at include/linux/spinlock.h:356:2,
       inlined from 'page_table_alloc' at arch/s390/mm/pgalloc.c:251:3:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function 'page_table_alloc':
   cc1: note: source object is likely at address zero
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:59:2,
       inlined from '__local_bh_disable_ip' at include/linux/bottom_half.h:13:2,
       inlined from '__raw_spin_lock_bh' at include/linux/spinlock_api_smp.h:125:2,
       inlined from 'spin_lock_bh' at include/linux/spinlock.h:356:2,
       inlined from 'page_table_alloc' at arch/s390/mm/pgalloc.c:301:3:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function 'page_table_alloc':
   cc1: note: source object is likely at address zero
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:59:2,
       inlined from '__local_bh_disable_ip' at include/linux/bottom_half.h:13:2,
       inlined from '__raw_spin_lock_bh' at include/linux/spinlock_api_smp.h:125:2,
       inlined from 'spin_lock_bh' at include/linux/spinlock.h:356:2,
       inlined from 'page_table_alloc' at arch/s390/mm/pgalloc.c:301:3:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      52 |         asm volatile(                                                   \
--
   In file included from arch/s390/include/asm/rwonce.h:29,
                    from include/linux/compiler.h:246,
                    from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from include/linux/fs.h:5,
                    from include/linux/highmem.h:5,
                    from kernel/sched/core.c:9:
   In function 'preempt_count',
       inlined from '__schedule_bug' at kernel/sched/core.c:5912:2:
   include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds=]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function '__schedule_bug':
   cc1: note: source object is likely at address zero
   In function 'preempt_count',
       inlined from 'finish_task_switch.isra' at kernel/sched/core.c:5229:6:
   include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds=]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'finish_task_switch.isra':
   cc1: note: source object is likely at address zero
   In function 'preempt_count',
       inlined from 'finish_task_switch.isra' at kernel/sched/core.c:5229:6:
   include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds=]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'finish_task_switch.isra':
   cc1: note: source object is likely at address zero
   In function 'preempt_count_set',
       inlined from 'finish_task_switch.isra' at kernel/sched/core.c:5232:3:
   include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds=]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:25:23: note: in expansion of macro 'READ_ONCE'
      25 |                 old = READ_ONCE(S390_lowcore.preempt_count);
         |                       ^~~~~~~~~
   In function 'finish_task_switch.isra':
   cc1: note: source object is likely at address zero
   In file included from arch/s390/include/asm/atomic.h:14,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:255,
                    from arch/s390/include/asm/cpu.h:15,
                    from arch/s390/include/asm/lowcore.h:15,
                    from arch/s390/include/asm/current.h:13,
                    from arch/s390/include/asm/preempt.h:5,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6:
   In function '__atomic_cmpxchg',
       inlined from 'preempt_count_set' at arch/s390/include/asm/preempt.h:28:11,
       inlined from 'finish_task_switch.isra' at kernel/sched/core.c:5232:3:
   arch/s390/include/asm/atomic_ops.h:159:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
     159 |         asm volatile(
         |         ^~~
   In function 'finish_task_switch.isra':
   cc1: note: source object is likely at address zero
   In function '__atomic_cmpxchg',
       inlined from 'preempt_count_set' at arch/s390/include/asm/preempt.h:28:11,
       inlined from 'finish_task_switch.isra' at kernel/sched/core.c:5232:3:
   arch/s390/include/asm/atomic_ops.h:159:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
   In function 'finish_task_switch.isra':
   cc1: note: source object is likely at address zero
   In file included from arch/s390/include/asm/lowcore.h:14:
   In function 'local_ctl_load',
       inlined from 'finish_arch_post_lock_switch' at arch/s390/include/asm/mmu_context.h:114:2,
       inlined from 'finish_task_switch.isra' at kernel/sched/core.c:5253:2:
>> arch/s390/include/asm/ctlreg.h:80:9: warning: array subscript 0 is outside array bounds of 'struct ctlreg[0]' [-Warray-bounds=]
      80 |         asm volatile(
         |         ^~~
   In function 'finish_task_switch.isra':
   cc1: note: source object is likely at address zero
   In function 'preempt_count',
       inlined from 'schedule_debug' at kernel/sched/core.c:5952:6,
       inlined from '__schedule' at kernel/sched/core.c:6589:2:
   include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds=]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function '__schedule':
   cc1: note: source object is likely at address zero
   In function 'preempt_count_set',
       inlined from 'schedule_debug' at kernel/sched/core.c:5954:3,
       inlined from '__schedule' at kernel/sched/core.c:6589:2:
   include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds=]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:25:23: note: in expansion of macro 'READ_ONCE'
      25 |                 old = READ_ONCE(S390_lowcore.preempt_count);
         |                       ^~~~~~~~~
   In function '__schedule':
   cc1: note: source object is likely at address zero
   In function '__atomic_cmpxchg',
       inlined from 'preempt_count_set' at arch/s390/include/asm/preempt.h:28:11,
       inlined from 'schedule_debug' at kernel/sched/core.c:5954:3,
       inlined from '__schedule' at kernel/sched/core.c:6589:2:
   arch/s390/include/asm/atomic_ops.h:159:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
     159 |         asm volatile(
         |         ^~~
   In function '__schedule':
   cc1: note: source object is likely at address zero
   In function '__atomic_cmpxchg',
       inlined from 'preempt_count_set' at arch/s390/include/asm/preempt.h:28:11,
       inlined from 'schedule_debug' at kernel/sched/core.c:5954:3,
       inlined from '__schedule' at kernel/sched/core.c:6589:2:
   arch/s390/include/asm/atomic_ops.h:159:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
   In function '__schedule':
   cc1: note: source object is likely at address zero
   In function '__atomic_or',
       inlined from 'clear_preempt_need_resched' at arch/s390/include/asm/preempt.h:39:2,
       inlined from '__schedule' at kernel/sched/core.c:6661:2:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:66:1: note: in expansion of macro '__ATOMIC_OPS'
      66 | __ATOMIC_OPS(__atomic_or,  int, "lao")
         | ^~~~~~~~~~~~
   In function '__schedule':
   cc1: note: source object is likely at address zero
   In function '__atomic_or',
       inlined from 'clear_preempt_need_resched' at arch/s390/include/asm/preempt.h:39:2,
       inlined from '__schedule' at kernel/sched/core.c:6661:2:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:66:1: note: in expansion of macro '__ATOMIC_OPS'
      66 | __ATOMIC_OPS(__atomic_or,  int, "lao")
         | ^~~~~~~~~~~~
   In function '__schedule':
   cc1: note: source object is likely at address zero
   In function 'should_resched',
       inlined from '__cond_resched' at kernel/sched/core.c:8562:6:
   include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds=]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:74:25: note: in expansion of macro 'READ_ONCE'
      74 |         return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
         |                         ^~~~~~~~~
   In function '__cond_resched':
   cc1: note: source object is likely at address zero
   In function 'should_resched',
       inlined from '__cond_resched_lock' at kernel/sched/core.c:8628:16:
   include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds=]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
..


vim +80 arch/s390/include/asm/ctlreg.h

a0616cdebcfd57 arch/s390/include/asm/ctl_reg.h David Howells  2012-03-28  77  
527618abb92793 arch/s390/include/asm/ctlreg.h  Heiko Carstens 2023-09-11  78  static __always_inline void local_ctl_load(unsigned int cr, struct ctlreg *reg)
dfa33ce1245a4b arch/s390/include/asm/ctlreg.h  Heiko Carstens 2023-09-11  79  {
dfa33ce1245a4b arch/s390/include/asm/ctlreg.h  Heiko Carstens 2023-09-11 @80  	asm volatile(
dfa33ce1245a4b arch/s390/include/asm/ctlreg.h  Heiko Carstens 2023-09-11  81  		"	lctlg	%[cr],%[cr],%[reg]\n"
dfa33ce1245a4b arch/s390/include/asm/ctlreg.h  Heiko Carstens 2023-09-11  82  		:
dfa33ce1245a4b arch/s390/include/asm/ctlreg.h  Heiko Carstens 2023-09-11  83  		: [reg] "Q" (*reg), [cr] "i" (cr)
dfa33ce1245a4b arch/s390/include/asm/ctlreg.h  Heiko Carstens 2023-09-11  84  		: "memory");
dfa33ce1245a4b arch/s390/include/asm/ctlreg.h  Heiko Carstens 2023-09-11  85  }
dfa33ce1245a4b arch/s390/include/asm/ctlreg.h  Heiko Carstens 2023-09-11  86  

:::::: The code at line 80 was first introduced by commit
:::::: dfa33ce1245a4b88402947fa0a847e179044d2fc s390/ctlreg: add local_ctl_load() and local_ctl_store()

:::::: TO: Heiko Carstens <hca@linux.ibm.com>
:::::: CC: Vasily Gorbik <gor@linux.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
