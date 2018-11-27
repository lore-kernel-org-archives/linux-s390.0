Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 27 Nov 2018 09:11:15 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
MIME-Version: 1.0
Message-Id: <20181127081115.GB3625@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello,

with the glibc self-tests I was able to trigger the "this should not
happen" warning ;) below on s390 (with panic_on_warn=1 set). It looks
like it is hardly reproducible.

This one happened with commit d146194f31c9 for compiling the kernel.
Config can be re-created with "make ARCH=s390 performance_defconfig".

[  649.596938] WARNING: CPU: 0 PID: 58886 at kernel/futex.c:1418 do_futex+0xa9a/0xc50
[  649.596946] Kernel panic - not syncing: panic_on_warn set ...
[  649.596951] CPU: 0 PID: 58886 Comm: ld64.so.1 Not tainted 4.20.0-20181125.rc3.git0.d146194f31c9.300.fc29.s390x+git #1
[  649.596953] Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0)
[  649.596956] Call Trace:
[  649.596963] ([<0000000000113050>] show_stack+0x58/0x70)
[  649.596970]  [<0000000000a62a92>] dump_stack+0x7a/0xa8
[  649.596975]  [<0000000000144012>] panic+0x11a/0x258
[  649.596978]  [<0000000000143e70>] __warn+0xf8/0x118
[  649.596981]  [<0000000000a61c20>] report_bug+0xd8/0x150
[  649.596985]  [<00000000001014ac>] do_report_trap+0xc4/0xe0
[  649.596988]  [<0000000000101680>] illegal_op+0x138/0x150
[  649.596994]  [<0000000000a82bec>] pgm_check_handler+0x1cc/0x220
[  649.596998]  [<00000000001e89b2>] do_futex+0xa9a/0xc50
[  649.597002] ([<00000000001e8b16>] do_futex+0xbfe/0xc50)
[  649.597006]  [<00000000001e8c4c>] sys_futex+0xe4/0x170
[  649.597010]  [<0000000000a82800>] system_call+0xdc/0x2c8

Thanks,
Heiko
