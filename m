From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [BUG] next-20081231 - S390x kernel panics while bootup at
	init_sched_build_groups()
Date: Wed, 31 Dec 2008 21:33:29 +0530
Message-ID: <20081231160329.GC4268@linux.vnet.ibm.com>
References: <20090101003258.eaa44700.sfr@canb.auug.org.au>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090101003258.eaa44700.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi,

	next-2001231 kernel panic's on S390x box, while boot up

Linux version 2.6.28-next-20081231-autotest (root@lnxabat1) (gcc versio=
n 4.1.0 (
SUSE Linux)) #1 SMP Wed Dec 31 08:43:37 CST 2008
setup: Linux is running as a z/VM guest operating system in 64-bit mode
Zone PFN ranges:
  DMA      0x00000000 -> 0x00080000
  Normal   0x00080000 -> 0x00080000
Movable zone start PFN for each node
early_node_map=C3=9D1=C2=A8 active PFN ranges
    0: 0x00000000 -> 0x00040000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 25=
8560
Kernel command line: root=3D/dev/dasdc1 selinux=3D0 IDENT=3D1230735656 =
BOOT_IMAGE=3D0
PID hash table entries: 4096 (order: 12, 32768 bytes)
console =C3=9DttyS0=C2=A8 enabled
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 1015808k/1048576k available (2483k kernel code, 0k reserved, 13=
72k data,
 196k init)
Write protected kernel read-only data: 0x12000 - 0x382fff
SLUB: Genslabs=3D12, HWalign=3D256, Order=3D0-3, MinObjects=3D0, CPUs=3D=
64, Nodes=3D1
Security Framework initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 256
cpu: 4 configured CPUs, 0 standby CPUs
cpu: Processor 0 started, address 2, identification 20AB8A
cpu: Processor 1 started, address 0, identification 00AB8A
cpu: Processor 2 started, address 1, identification 10AB8A
cpu: Processor 3 started, address 3, identification 30AB8A
Brought up 4 CPUs
Unable to handle kernel pointer dereference at virtual kernel address 0=
000000100
3fa000
Oops: 003b =C3=9D#1=C2=A8 SMP
Modules linked in:
CPU: 0 Not tainted 2.6.28-next-20081231-autotest #1
Process swapper (pid: 1, task: 000000003fe80000, ksp: 000000003fe8ba78)
Krnl PSW : 0704000180000000 0000000000035632 (init_sched_build_groups+0=
xae/0x4a4
)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:0 CC:0 PM:0 EA:3
Krnl GPRS: 00000000003c27b0 00000001003fa278 0000000000000000 000000000=
03c2508
           0000000000000000 000000000026f818 0000000000000000 000000000=
0000000
           0000000000000000 000000003fe8be50 00000000ffffffff 000000003=
fe8bcf0
Krnl Code: 0000000000035626: a7290000           lghi    00: HCPGSP2629I=
 The virt
ual machine is placed in CP mode due to a SIGP stop from
 CPU 02.
01: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP =
stop from
 CPU 02.
03: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP =
stop from
 CPU 02.
02: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 00000000=
 00021416-- 0:conmux-control -- time-stamp -- Dec/31/08  7:04:54 --
-- 0:conmux-control -- time-stamp -- Dec/31/08  7:22:18 --
(bot:conmon-payload) disconnected
--=20
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
