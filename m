Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228A629ACFD;
	Mon, 19 Oct 2026 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792371994; cv=none; b=kgidKOjdbketQhGJPhkL8Ikoo2aE8nrLZvwyop4mEU4GCSjHGpp5PoTrLiNGUgg7/ZTeDzH7cFvDoVQpgnReIqPzLFDbLJgYchFrpCEJsdOBlN6EQCeSsSaO7U1VylG6qrEwCXu8LEbDPBtSY0gxBfIbzrFFCuE5rXj8YDTQovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792371994; c=relaxed/simple;
	bh=b9O3qjS3MEMdQZQ6wWAiJ6kHBkZeNvprfKQ5jOCCFJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TtcdxTT+FdrWFjvGmv83LdJnM7RGQraVKY6bGjDABoNh/pEifAMIT2pAs7rSgpBNb+0z+jP+dfpVpOu3irhd6Eb+RMoo8p0woOfTXNP+I7bReXWD2Md+kuZG4jnzApS4ZS+sRIAlLL2rb4QDD/rkQK6NE+3ruhRp6qstxevp3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOw3VUDN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOw3VUDN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792371993; x=1823907993;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=b9O3qjS3MEMdQZQ6wWAiJ6kHBkZeNvprfKQ5jOCCFJ0=;
  b=iOw3VUDNgp4HTvdSClFUHLV2aZIGVX5RbkO9JcjCz+fkk59R4OCjFVHB
   0wcKj0BbM2MeP7BJjqfPJCAm3e9G0azJ3x7oNkXUv2IrueDxv+gahaTYz
   YdhzwvqT4Fak+iunqR6cj9N1sMdWIjMnD9kmapT7/bNCNRmCgHkA/YuwS
   A5ca3sj54hElUYQx/JF8Q7tpSVBpMWTHH8q9kt9Aasg5wzD46vhJY26nh
   nhbLz6NnzpQRXJQzYkfND98QaiFyf02hUBwkp/T9NrM6xfFLPOHGlg38e
   BkjnvZnppl0GiCQlTbaafUnDHm5E86JAV9U88kSBmFizuQ8uQwNh8fOtT
   Q==;
X-CSE-ConnectionGUID: F/cSKxc6R8OvGbuiLD/pSg==
X-CSE-MsgGUID: 4KjlQxzuRMaDbCYP3oDWYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="957244"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="957244"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 18:06:32 -0700
X-CSE-ConnectionGUID: qUoc8xwyTraRW04hp7SJDQ==
X-CSE-MsgGUID: RwW62x8nSeuqk1g+ycjMiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="2465662"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 18:06:26 -0700
Date: Mon, 19 Oct 2026 09:06:23 +0800
From: kernel test robot <yi1.lai@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, aubrey.li@linux.intel.com,
	yu.c.chen@intel.com, Peter Zijlstra <peterz@infradead.org>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-mips@vger.kernel.org, loongarch@lists.linux.dev,
	driver-core@lists.linux.dev,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, yi1.lai@intel.com
Subject: Re: [RFC PATCH v3 13/13] sched/fair: Switch nohz.idle_cpus to use sbm
Message-ID: <202610190859.d3459a50-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001192849.74788-14-kprateek.nayak@amd.com>


Hello,

kernel test robot noticed "kernel_BUG_at_kernel/smpboot.c" on:

commit: d7dd59cf6a0f621f224947f960403a747b0836f0 ("[RFC PATCH v3 13/13] sched/fair: Switch nohz.idle_cpus to use sbm")
url: https://github.com/intel-lab-lkp/linux/commits/K-Prateek-Nayak/lib-sbm-Introduce-helpers-for-architectures-to-configure-LLC-properties/20261001-192837
patch link: https://lore.kernel.org/all/20261001192849.74788-14-kprateek.nayak@amd.com/
patch subject: [RFC PATCH v3 13/13] sched/fair: Switch nohz.idle_cpus to use sbm

in testcase: boot

config: i386-randconfig-1006-20261010
compiler: clang-22
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 4 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202610190859.d3459a50-lkp@intel.com



[    2.426107][   T37] ------------[ cut here ]------------
[    2.430168][   T37] kernel BUG at kernel/smpboot.c:133!
[    2.433726][   T37] Oops: invalid opcode: 0000 [#1] SMP PTI
[    2.436546][   T37] CPU: 3 UID: 0 PID: 37 Comm: ksoftirqd/3 Tainted: G                T   7.3.0-rc1+ #1 PREEMPTLAZY
[    2.436546][   T37] Tainted: [T]=RANDSTRUCT
[    2.436546][   T37] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    2.436546][   T37] EIP: smpboot_thread_fn (smpboot.c:117)
[    2.436546][   T37] Code: 83 7e 04 00 74 13 8b 06 31 d2 0f a3 05 6c 07 59 84 0f 92 c2 e8 12 65 b7 01 89 f0 e8 4b e9 2e 00 31 c0 83 c4 08 5e 5f 5b 5d c3 <0f> 0b b8 08 52 f5 83 e8 75 85 e6 ff 0f 0b b8 f8 51 f5 83 e8 69 85
All code
========
   0:	83 7e 04 00          	cmpl   $0x0,0x4(%rsi)
   4:	74 13                	je     0x19
   6:	8b 06                	mov    (%rsi),%eax
   8:	31 d2                	xor    %edx,%edx
   a:	0f a3 05 6c 07 59 84 	bt     %eax,-0x7ba6f894(%rip)        # 0xffffffff8459077d
  11:	0f 92 c2             	setb   %dl
  14:	e8 12 65 b7 01       	call   0x1b7652b
  19:	89 f0                	mov    %esi,%eax
  1b:	e8 4b e9 2e 00       	call   0x2ee96b
  20:	31 c0                	xor    %eax,%eax
  22:	83 c4 08             	add    $0x8,%esp
  25:	5e                   	pop    %rsi
  26:	5f                   	pop    %rdi
  27:	5b                   	pop    %rbx
  28:	5d                   	pop    %rbp
  29:	c3                   	ret
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 08 52 f5 83       	mov    $0x83f55208,%eax
  31:	e8 75 85 e6 ff       	call   0xffffffffffe685ab
  36:	0f 0b                	ud2
  38:	b8 f8 51 f5 83       	mov    $0x83f551f8,%eax
  3d:	e8                   	.byte 0xe8
  3e:	69                   	.byte 0x69
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction ===========================================
   0:	0f 0b                	ud2
   2:	b8 08 52 f5 83       	mov    $0x83f55208,%eax
   7:	e8 75 85 e6 ff       	call   0xffffffffffe68581
   c:	0f 0b                	ud2
   e:	b8 f8 51 f5 83       	mov    $0x83f551f8,%eax
  13:	e8                   	.byte 0xe8
  14:	69                   	.byte 0x69
  15:	85                   	.byte 0x85
[    2.436546][   T37] EAX: 00000003 EBX: 858ac510 ECX: 83e26f98 EDX: 83c50f80
[    2.436546][   T37] ESI: 8500dfb0 EDI: 00000000 EBP: 858e1f68 ESP: 858e1f54
[    2.436546][   T37] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010293
[    2.436546][   T37] CR0: 80050033 CR2: 00000000 CR3: 047ae000 CR4: 000006b0
[    2.436546][   T37] Call Trace:
[    2.436546][   T37]  kthread (kthread.c:436)
[    2.436546][   T37]  ? smpboot_unregister_percpu_thread (linux/list.h:261)
[    2.436546][   T37]  ? __do_trace_sched_kthread_stop_ret (trace/events/sched.h:38 (discriminator 13))
[    2.436546][   T37]  ret_from_fork (x86/kernel/process.c:158)
[    2.436546][   T37]  ? __do_trace_sched_kthread_stop_ret (trace/events/sched.h:38 (discriminator 13))
[    2.436546][   T37]  ret_from_fork_asm (x86/entry/entry_32.S:736)
[    2.436546][   T37]  entry_INT80_32 (x86/entry/entry_32.S:940)
[    2.436546][   T37] Modules linked in:
[    2.493945][   T37] ---[ end trace 0000000000000000 ]---
[    2.496265][   T37] EIP: smpboot_thread_fn (smpboot.c:117)
[    2.498528][   T37] Code: 83 7e 04 00 74 13 8b 06 31 d2 0f a3 05 6c 07 59 84 0f 92 c2 e8 12 65 b7 01 89 f0 e8 4b e9 2e 00 31 c0 83 c4 08 5e 5f 5b 5d c3 <0f> 0b b8 08 52 f5 83 e8 75 85 e6 ff 0f 0b b8 f8 51 f5 83 e8 69 85
All code
========
   0:	83 7e 04 00          	cmpl   $0x0,0x4(%rsi)
   4:	74 13                	je     0x19
   6:	8b 06                	mov    (%rsi),%eax
   8:	31 d2                	xor    %edx,%edx
   a:	0f a3 05 6c 07 59 84 	bt     %eax,-0x7ba6f894(%rip)        # 0xffffffff8459077d
  11:	0f 92 c2             	setb   %dl
  14:	e8 12 65 b7 01       	call   0x1b7652b
  19:	89 f0                	mov    %esi,%eax
  1b:	e8 4b e9 2e 00       	call   0x2ee96b
  20:	31 c0                	xor    %eax,%eax
  22:	83 c4 08             	add    $0x8,%esp
  25:	5e                   	pop    %rsi
  26:	5f                   	pop    %rdi
  27:	5b                   	pop    %rbx
  28:	5d                   	pop    %rbp
  29:	c3                   	ret
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 08 52 f5 83       	mov    $0x83f55208,%eax
  31:	e8 75 85 e6 ff       	call   0xffffffffffe685ab
  36:	0f 0b                	ud2
  38:	b8 f8 51 f5 83       	mov    $0x83f551f8,%eax
  3d:	e8                   	.byte 0xe8
  3e:	69                   	.byte 0x69
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction ===========================================
   0:	0f 0b                	ud2
   2:	b8 08 52 f5 83       	mov    $0x83f55208,%eax
   7:	e8 75 85 e6 ff       	call   0xffffffffffe68581
   c:	0f 0b                	ud2
   e:	b8 f8 51 f5 83       	mov    $0x83f551f8,%eax
  13:	e8                   	.byte 0xe8
  14:	69                   	.byte 0x69
  15:	85                   	.byte 0x85


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261019/202610190859.d3459a50-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


