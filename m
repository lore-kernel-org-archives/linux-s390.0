Return-Path: <linux-kernel-owner+w=401wt.eu-S1754814AbXJXDby@vger.kernel.org>
Message-ID: <471EBC02.5000907@linux.vnet.ibm.com>
Date: Wed, 24 Oct 2007 08:59:06 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [BUG] 2.6.23-git19 - S390x: Kernel panic while bringing up the network
 interface
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-s390.vger.kernel.org>

Hi,

Kernel panic's while bringing up the network interface with the 2.6.23-git19

Setting network parameters:  =DD  OK  =A8
Bringing up loopback interface:  =DD  OK  =A8
Bringing up interface eth0:
 =DD<00000000002e2f72>=A8 inet_ioctl+0xd6/0x110
 =DD<000000000027cae2>=A8 sock_ioctl+0x26e/0x2a0
 =DD<00000000000b4c52>=A8 do_ioctl+0x4a/0xac
 =DD<00000000000b5076>=A8 vfs_ioctl+0x3c2/0x3d8
 =DD<00000000000b50ec>=A8 sys_ioctl+0x60/0x88
 =DD<0000000000021b7e>=A8 sysc_noemu+0x10/0x16
 =DD<00000200001201ca>=A8 0x200001201ca

 <0>Kernel panic - not syncing: Fatal exception in interrupt
00: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop=
 from
 CPU 01.
02: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop=
 from
 CPU 01.
03: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop=
 from
 CPU 01.
01: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 00000000 000=
164DE

--=20
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
