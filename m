Return-Path: <linux-kernel-owner+w=401wt.eu-S1760908AbXK1MYS@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: [s390] networking related oops during boot on Hercules (was: build failure)
Date: Wed, 28 Nov 2007 13:24:02 +0100
References: <200711281127.30051.elendil@planet.nl> <200711281151.58236.borntraeger@de.ibm.com>
In-Reply-To: <200711281151.58236.borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711281324.02748.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wednesday 28 November 2007, Christian Borntraeger wrote:
> > arch/s390/kernel/built-in.o: In function `cleanup_io_leave_insn':
> > diag.c:(.text+0xc29a): undefined reference to `preempt_schedule_irq'
> > make[2]: *** [.tmp_vmlinux1] Error 1
>
> We have a patch for that in our repository.

That fixed it. Next issue ;-)

During boot I get the following oops in the Hercules emulator.
2.6.22 runs fine on Hercules; I've not tried .23 on it.

[...]
Synthesizing the initial hotplug events...
done.
Waiting for /dev to be fully populated...
dasd(eckd): 0.0.0121: 3390/02(CU:3990/01) Cyl:1113 Head:15 Sec:224
dasd(eckd): 0.0.0121: (4kB blks): 801360kB at 48kB/trk compatible disk layout
 dasdb:VOL1/  0X0121: dasdb1 dasdb2
TAPE_CHAR: tape gets major 254 for character devices
TAPE_BLOCK: tape gets major 253 for block device
TAPE_CORE: tape device 0.0.0581 found
HHCCP014I CPU0001: Operation exception CODE=0001 ILC=2
CPU0001:  PSW=070C0000 8019D0DA INST=0001         ????? ,                      ?
CPU0001: GR00=00132700  GR01=00000000  GR02=0F398800  GR03=0F398800
CPU0001: GR04=00000000  GR05=80132796  GR06=0F305D7A  GR07=00000002
CPU0001: GR08=0F1ADA00  GR09=0F3C1F08  GR10=0F3C1F00  GR11=0F398800
CPU0001: GR12=0F398800  GR13=8019D0C2  GR14=0F305CA0  GR15=0F305C30
CPU0001: CR00=14B54E12  CR01=0031907F  CR02=00011180  CR03=00000000
CPU0001: CR04=000003DE  CR05=00011180  CR06=10000000  CR07=8FB301FF
CPU0001: CR08=00000000  CR09=00000000  CR10=00000000  CR11=00000000
CPU0001: CR12=00000000  CR13=8FB301FF  CR14=FB000000  CR15=00000000
CTC driver initialized
------------  cut here !------------
kernel BUG at net/core/dev.c:852                                                               +
illegal operation: 0001  #1!
Modules linked in: ctc fsm tape_34xx cu3088 tape ccwgroup tape_class dm_mirror d
m_snapshot dm_mod dasd_eckd_mod dasd_mod
CPU:    1    Not tainted
Process hwup (pid: 990, task: 0f034c00, ksp: 0f305be0)
Krnl PSW : 070c0000 8019d0da (dev_alloc_name+0x1e/0x58)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:0 CC:0 PM:0
Krnl GPRS: 00132700 00000000 0f398800 0f398800
           00000000 80132796 0f305d7a 00000002
           0f1ada00 0f3c1f08 0f3c1f00 0f398800
           0f398800 8019d0c2 0f305ca0 0f305c30
Krnl Code: 8019d0cc: f000bf1f2460       srp     3871(1,%r11),1120(%r2),0
           8019d0d2: a7740004           brc     7,8019d0da
           8019d0d6: a7f40001           brc     15,8019d0d8
          >8019d0da: 5810d04e           l       %r1,78(%r13)
           8019d0de: 41a0f060           la      %r10,96(%r15)
           8019d0e2: 5820c460           l       %r2,1120(%r12)
           8019d0e6: 184a               lr      %r4,%r10
           8019d0e8: 0de1               basr    %r14,%r1
Call Trace:
( <0000000000000000>! _ehead+0xfffee000/0x80)
  <000000000019d710>! register_netdev+0x34/0x6c
  <00000000108a561e>! ctc_new_device+0x3ee/0x590  ctc!
  <0000000010861398>! ccwgroup_online_store+0xb0/0x13c  ccwgroup!
  <00000000000c962a>! sysfs_write_file+0xca/0x130
  <00000000000840e6>! vfs_write+0x92/0x128                                                     +
  <00000000000847e8>! sys_write+0x40/0x70
  <000000000002098a>! sysc_do_restart+0x12/0x16
  <0000000077f0abaa>! 0x77f0abaa


udevd-event 949!: run_program: '/sbin/hwup' abnormal exit
done.
[...]
Setting up networking...
.
Configuring network interfaces...
<loops endlessly>
