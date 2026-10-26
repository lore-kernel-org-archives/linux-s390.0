Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792981500;
	b=LCkGfmW83NqMWJk5jEP4++TN8P0i3c9SgEqqhzvD2WUMi8J3uCSFJgLO5eW+R/j51Usp
	 CXYm+YH5uFUaiir3Av0obhsQ38z83zMA+7X3Ndv11pMLICgmrtMYO93ikLzwFYzlPr6Be
	 aqlBrF6CvK2fiLZtQISz+zaXdALwPZJTLGXdLU5893ok9xjJM8PcFNsFgDFLCGczuINHw
	 awAkERe4yCQ+wFsTJMgAyNvdcPcraeL3puyRtv12SO3CT7pRAylugi3KjTbfvCGs9H0Ob
	 XaRvifVp3ZweyitdZERkY+gMKMKXnZgSpLiVM/aaRfK9FrqVC2LR1r/JruWqdekCeyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792981500;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=YxJ4VVeK9bnbWTaneSho9D6B/EMJ1w2pVfFv/idBt/A=;
	b=FrPlIPGF2XMu81yUyEI/cGxEdo+D8sUZkk5+x8GtG9DQ6HkjkBkCJSLdCd4j+9Z1ZLsg
	 Us3BtFLz2yl0lNBO6kA8XmVU3cyu3wchz/2Qcpos9sEmOpw6Edz088+Nx2GAmVWq6LwZ4
	 cbOOSJ5A1nGJZZc7dKOQ4C35mE1yuoYhJ9FVx3jw2Gxks387Y0YxClJ4QCeGhUdcdu6MV
	 SvKRcu14kMto6VxWnxji7l55qYI7g21eBfCUsKISlroQf2kCIDcjF4kZInm0CcI/MT30q
	 78sj5nbiIn7lzQnM3XTtjO1AVEstSR8COzXBlajO0PX5QF86KHRS5cCuxnyfutmolWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="V2ukv/nl";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB2606A31B;
	Mon, 26 Oct 2026 02:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67BB2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V2ukv/nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792981498; x=1824517498;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p5EF9DrvTI9TWr4SfD0pPKgmrR5yJPb+Hj8Ptw3CoUk=;
  b=V2ukv/nlmNg+fx02O6aVXXjM3rXQDlhbb5yRhwSGdDUrG6MowN8BpxKG
   +mD9f4UFhyHWYpaaIjfs7HEC6/oXhr7zKrSXgCQ+QrmtbQFz1hM9f2Fhf
   OE0HWv0ouFzyF4j+OW7XM1HX1bgkyHDRsKt8o71/fClZaqGxQc9bYoHPC
   g5/BjqSw/lvsP+tDfCWJl4ppFl09FSeWWDZ9VADKwgLmQAuxcwROSEYwF
   xfZLjJdQ3AoDboKMPTwA9e8vbr+zWeLW6yJLq8FaqjXXWnSDsr64Uym/W
   8HaFlxpNNr1zokBbIMOdMqPwilzqRra9ae6A0LtxIn8Uqtdlme3XJl3pc
   Q==;
X-CSE-ConnectionGUID: 89OWNv54QXq4WU64NOfxQw==
X-CSE-MsgGUID: pnjLdFCfTPWwkkwJv9RcfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1530200"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1530200"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 19:24:57 -0700
X-CSE-ConnectionGUID: YLFJw+i3QFKha+6X0nM5mA==
X-CSE-MsgGUID: qhSJhwe5REiQ6PJiIR00FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4122800"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 19:24:54 -0700
Date: Mon, 26 Oct 2026 10:24:50 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@kernel.org>,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
	yi1.lai@intel.com
Subject: [linus:master] [arch]  b36d4b6aa8:
 WARNING:at_fs/nsfs.c:#is_current_namespace
Message-ID: <202610260917.6248e316-lkp@intel.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hello,

kernel test robot noticed "WARNING:at_fs/nsfs.c:#is_current_namespace" on:

commit: b36d4b6aa88ef039647228b98c59a875e92f8c8e ("arch: hookup listns() system call") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 20a33c6b6cbe7e4805dfb6cd68816937443aa148]

Our bisection first flagged commit b36d4b6aa88e ("arch: hookup listns() system call") as the first bad commit, since that is the commit that registers the listns() syscall number, making the warning reachable from userspace/trinity.

We also tested the parent commit, 76b6f5dfb3fd ("nstree: add listns()"), and found that it already reproduces a WARNING of its own (see "Regarding the PARENT" below, via setns() this time). This suggests the nstree/listns() code was already not fully robust before b36d4b6aa88e, and that commit's role may simply be exposing/making reachable an issue that predates it, rather than introducing a new one.

in testcase: trinity
version: trinity-x86_64-d4c26f234-1_20261018
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5


config: x86_64-randconfig-015-20251114
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu Icelake-Server-noTSX,enforce -smp 4 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202610260917.6248e316-lkp@intel.com


[   44.455278][  T526] ------------[ cut here ]------------
[   44.456351][  T526] WARNING: CPU: 0 PID: 526 at fs/nsfs.c:508 is_current_namespace+0x12f/0x440
[   44.458109][  T526] Modules linked in:
[   44.459285][  T526] CPU: 0 UID: 65534 PID: 526 Comm: trinity-c2 Tainted: G                T   6.18.0-rc2-00023-gb36d4b6aa88e #1 VOLUNTARY  e2643480911518fe6c6e798d49763b0f8bc0c2cc
[   44.464118][  T526] Tainted: [T]=RANDSTRUCT
[   44.465362][  T526] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   44.468577][  T526] RIP: 0010:is_current_namespace+0x12f/0x440
[   44.470566][  T526] Code: 48 c1 e8 03 80 3c 10 00 0f 85 5f 02 00 00 48 8b 3d 7e 55 6c 08 48 83 eb 70 e8 9d 04 78 ff 48 39 c3 5b 41 5c 0f 94 c0 5d c3 90 <0f> 0b 90 31 c0 5b 41 5c 5d c3 e8 c2 b7 2a 06 48 c7 c0 18 10 a3 8a
[   44.476790][  T526] RSP: 0018:ffa000000184fce0 EFLAGS: 00010206
[   44.478622][  T526] RAX: 0000000040000000 RBX: ffffffff8e0d4bc0 RCX: 0000000000000015
[   44.481098][  T526] RDX: 1ffffffff1c1a978 RSI: ffffffff8ab98ec0 RDI: ffffffff8e0d4bc0
[   44.483561][  T526] RBP: ffa000000184fcf0 R08: 0000000000000001 R09: fff3fc0000309fa6
[   44.485976][  T526] R10: 0000000000000003 R11: 0000000000000200 R12: ffffffff8e0d4c78
[   44.488478][  T526] R13: 1ff4000000309fa2 R14: ffffffff8e0d4bdc R15: ffffffff8e0d4bc0
[   44.490935][  T526] FS:  00007f9b05b17900(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[   44.493641][  T526] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.495638][  T526] CR2: 00007f9b05742e10 CR3: 0000000134aca003 CR4: 0000000000771eb0
[   44.498129][  T526] PKRU: 55555554
[   44.499291][  T526] Call Trace:
[   44.500271][  T526]  <TASK>
[   44.501134][  T526]  legitimize_ns+0x25f/0x4c0
[   44.502577][  T526]  ? lookup_ns_owner_at+0x400/0x400
[   44.504165][  T526]  do_listns+0x185/0x5c0
[   44.505452][  T526]  __do_sys_listns+0x13b/0x300
[   44.506941][  T526]  ? do_listns_userns+0x580/0x580
[   44.508435][  T526]  ? up_read+0x22/0x40
[   44.509723][  T526]  __x64_sys_listns+0x97/0x100
[   44.510619][  T526]  ? trace_hardirqs_on+0x21/0xc0
[   44.511530][  T526]  x64_sys_call+0x21/0xa40
[   44.512340][  T526]  do_syscall_64+0xb3/0x800
[   44.513186][  T526]  entry_SYSCALL_64_after_hwframe+0x50/0x58
[   44.514303][  T526] RIP: 0033:0x7f9b05c28779
[   44.515114][  T526] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[   44.518758][  T526] RSP: 002b:00007ffe8c345bb8 EFLAGS: 00000246 ORIG_RAX: 00000000000001d6
[   44.520321][  T526] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f9b05c28779
[   44.521798][  T526] RDX: 0000000000000008 RSI: 00007f9b05740e10 RDI: 00007f9b05742e10
[   44.523292][  T526] RBP: 00007f9b05912000 R08: 0000000000000000 R09: 0000000000000000
[   44.524772][  T526] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9b05912000
[   44.526247][  T526] R13: 00007f9b05b0f560 R14: 00007f9b05917050 R15: 00007f9b05b176c8
[   44.527731][  T526]  </TASK>
[   44.528282][  T526] irq event stamp: 54199
[   44.529054][  T526] hardirqs last  enabled at (54211): [<ffffffff81bdc218>] __up_console_sem+0x58/0x80
[   44.530820][  T526] hardirqs last disabled at (54224): [<ffffffff81bdc1fd>] __up_console_sem+0x3d/0x80
[   44.532559][  T526] softirqs last  enabled at (54144): [<ffffffff81a83670>] handle_softirqs+0x470/0x900
[   44.534358][  T526] softirqs last disabled at (54133): [<ffffffff81a846fe>] irq_exit_rcu+0xfe/0x140
[   44.536055][  T526] ---[ end trace 0000000000000000 ]---

Regarding the PARENT (76b6f5dfb3fd), which our bisection marked as the last known-good commit, we observed the following separate WARNING,
indicating the nstree/listns() area already had an unrelated issue before b36d4b6aa88e landed:
[   94.367090][  T535] ------------[ cut here ]------------
[   94.370167][  T535] WARNING: CPU: 0 PID: 535 at include/linux/ns_common.h:311 nsproxy_ns_active_put+0x8cd/0x940
[   94.375575][  T535] Modules linked in:
[   94.377666][  T535] CPU: 0 UID: 65534 PID: 535 Comm: trinity-c3 Tainted: G                T   6.18.0-rc2-00022-g76b6f5dfb3fd #1 VOLUNTARY  cb1b9fe02910ecdede8a35f9462ebcf918b6f4e2
[   94.384602][  T535] Tainted: [T]=RANDSTRUCT
[   94.386182][  T535] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   94.389939][  T535] RIP: 0010:nsproxy_ns_active_put+0x8cd/0x940
[   94.392205][  T535] Code: e9 fc fd ff ff 90 0f 0b 90 e9 97 fe ff ff 90 0f 0b 90 e9 d6 f9 ff ff 90 0f 0b 90 e9 ad fa ff ff 90 0f 0b 90 e9 fa fa ff ff 90 <0f> 0b 90 e9 28 fe ff ff 90 0f 0b 90 e9 b2 f9 ff ff 90 0f 0b 90 e9
[   94.399343][  T535] RSP: 0018:ffa000000188fda8 EFLAGS: 00010297
[   94.401546][  T535] RAX: 0000000000000000 RBX: ff110001008d93a8 RCX: ffffffff8236dccb
[   94.404421][  T535] RDX: 1ffffffff1657494 RSI: 0000000000000004 RDI: ffffffff8b2ba4a0
[   94.407439][  T535] RBP: ffa000000188fdc0 R08: 0000000000000001 R09: fffffbfff16574a8
[   94.410390][  T535] R10: ffffffff8b2ba543 R11: ffffffff810000ae R12: ffffffff8b2ba400
[   94.413332][  T535] R13: ff1100013598c540 R14: ff11000122132440 R15: ff1100013598c540
[   94.416277][  T535] FS:  00007fa7c6e86900(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[   94.419588][  T535] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.422023][  T535] CR2: 00007fa7c6b5f020 CR3: 00000001337f8005 CR4: 0000000000771eb0
[   94.425020][  T535] PKRU: 55555564
[   94.426319][  T535] Call Trace:
[   94.427494][  T535]  <TASK>
[   94.428612][  T535]  free_nsproxy+0x16/0x380
[   94.430265][  T535]  put_nsset+0xa9/0x1c0
[   94.431822][  T535]  __do_sys_setns+0x2d0/0x700
[   94.433519][  T535]  ? switch_task_namespaces+0x100/0x100
[   94.435616][  T535]  __x64_sys_setns+0x53/0x80
[   94.437263][  T535]  ? trace_hardirqs_on+0x21/0xc0
[   94.439158][  T535]  x64_sys_call+0x227/0xa40
[   94.440781][  T535]  do_syscall_64+0xb3/0x700
[   94.442581][  T535]  entry_SYSCALL_64_after_hwframe+0x50/0x58
[   94.445676][  T535] RIP: 0033:0x7fa7c6f97779
[   94.447948][  T535] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[   94.459415][  T535] RSP: 002b:00007ffc93f4e248 EFLAGS: 00000246 ORIG_RAX: 0000000000000134
[   94.464265][  T535] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa7c6f97779
[   94.469222][  T535] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000001ac
[   94.473612][  T535] RBP: 00007fa7c6c71000 R08: 0000000000000000 R09: 0000000000000000
[   94.476937][  T535] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa7c6c71000
[   94.479999][  T535] R13: 00007fa7c6e78440 R14: 00007fa7c6c76050 R15: 00007fa7c6e866c8
[   94.483046][  T535]  </TASK>
[   94.484138][  T535] irq event stamp: 47371
[   94.485745][  T535] hardirqs last  enabled at (47395): [<ffffffff81bdc798>] __up_console_sem+0x58/0x80
[   94.489275][  T535] hardirqs last disabled at (47408): [<ffffffff81bdc77d>] __up_console_sem+0x3d/0x80
[   94.492766][  T535] softirqs last  enabled at (47392): [<ffffffff81a83570>] handle_softirqs+0x470/0x900


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261026/202610260917.6248e316-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

