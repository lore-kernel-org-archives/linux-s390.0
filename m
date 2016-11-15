Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 15 Nov 2016 07:35:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: next: s390 crash due to 's390: move sys_call_table and last_break
 from thread_info to thread_struct'
Message-ID: <20161115153554.GA22064@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Martin,

my s390 qemu boot test crashes in -next as follows.

Kernel stack overflow.
CPU: 0 PID: 923 Comm: modprobe Not tainted 4.9.0-rc5-next-20161115 #1
Hardware name: QEMU             QEMU                  QEMU             (KVM)
task: 000000001d805100 task.stack: 000000001d898000
Krnl PSW : 0404e00180000000 0000000000ac2b42 (pgm_check_handler+0xd6/0x1b4)
           R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000000020 0000000000000000 0000000000000004 0000000000000000
           0000000000400034 0000000000000000 000000007ff3b350 0000000000000001
           0404e00180000000 0000000000ac2b42 0000000000ac2ad0 000000007ff38178
           000000001d805100 0000000000ac335e 0000000000000200 000000007ff380d8
Krnl Code: 0000000000ac2b34: a7840005		brc	8,ac2b3e
           0000000000ac2b38: d2ffe0e8d000	mvc	232(256,%r14),0(%r13)
          #0000000000ac2b3e: 41b0f0a0		la	%r11,160(%r15)
          >0000000000ac2b42: eb07b0180024	stmg	%r0,%r7,24(%r11)
           0000000000ac2b48: d23fb0580200	mvc	88(64,%r11),512
           0000000000ac2b4e: eb89b0080024	stmg	%r8,%r9,8(%r11)
           0000000000ac2b54: d203b0a0008c	mvc	160(4,%r11),140
           0000000000ac2b5a: d207b0a800a8	mvc	168(8,%r11),168
Call Trace:
no locks held by modprobe/923.
Last Breaking-Event-Address:
 [<0000000000000000>]           (null)
 Kernel panic - not syncing: Corrupt kernel stack, can't continue.

Bisect points to commit 1914608db9 ("s390: move sys_call_table and last_break
from thread_info to thread_struct"). Reverting that patch fixes the problem.

Configuration is s390:defconfig with CONFIG_MARCH_Z900=y.

Bisect log is attached.
A complete log is at:
http://kerneltests.org/builders/qemu-s390-next/builds/252/steps/qemubuildcommand/logs/stdio

Guenter

---
# bad: [88a2ced28ffe354132353af73f9429f299b12e4c] Add linux-next specific files for 20161115
# good: [a25f0944ba9b1d8a6813fd6f1a86f1bd59ac25a6] Linux 4.9-rc5
git bisect start 'HEAD' 'v4.9-rc5'
# bad: [4fa7a32011ff952305f571c60384e907915e551c] Merge remote-tracking branch 'drm/drm-next'
git bisect bad 4fa7a32011ff952305f571c60384e907915e551c
# bad: [e3c8127151053b1561287d9f70ad07e45321d5a9] Merge remote-tracking branch 'dlm/next'
git bisect bad e3c8127151053b1561287d9f70ad07e45321d5a9
# good: [0956c4cfc46e3c572990366ad99592a93d0ae450] Merge remote-tracking branch 'renesas/next'
git bisect good 0956c4cfc46e3c572990366ad99592a93d0ae450
# bad: [833cac18bcdd53af7578cfdded58638ffef11be5] Merge remote-tracking branch 'ext4/dev'
git bisect bad 833cac18bcdd53af7578cfdded58638ffef11be5
# good: [f06b259941a664c5d3f388c42d8aea555fa65e9f] Merge remote-tracking branch 'arm64/for-next/core'
git bisect good f06b259941a664c5d3f388c42d8aea555fa65e9f
# bad: [b8e4c75a03709e8509640625efc506c69432a8b2] Merge remote-tracking branch 'tile/master'
git bisect bad b8e4c75a03709e8509640625efc506c69432a8b2
# good: [e56732ed80f07b8bfa7e9e95cb46e9faee3420bc] Merge remote-tracking branch 'powerpc/next'
git bisect good e56732ed80f07b8bfa7e9e95cb46e9faee3420bc
# good: [0729dcf248325db600f232d7b96e76441ea450dd] s390: hotplug: make pci_hpc explicitly non-modular
git bisect good 0729dcf248325db600f232d7b96e76441ea450dd
# good: [f8fc82b47149e3449d23e94d6ecf30af2ffcebff] s390: move system_call field from thread_info to thread_struct
git bisect good f8fc82b47149e3449d23e94d6ecf30af2ffcebff
# good: [ecc8bebe29f5c36e3b7b37f52946f318654a29cb] tile: remove #pragma unroll from finv_buffer_remote()
git bisect good ecc8bebe29f5c36e3b7b37f52946f318654a29cb
# bad: [1914608db9e8974ac9f53efdcf0f00f331f4c0e8] s390: move sys_call_table and last_break from thread_info to thread_struct
git bisect bad 1914608db9e8974ac9f53efdcf0f00f331f4c0e8
# good: [90c53e65806323382e8bff212cc993700a4a62d9] s390: move cputime accounting fields from thread_info to thread_struct
git bisect good 90c53e65806323382e8bff212cc993700a4a62d9
# first bad commit: [1914608db9e8974ac9f53efdcf0f00f331f4c0e8] s390: move sys_call_table and last_break from thread_info to thread_struct
