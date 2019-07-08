Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 8 --> bootup failure on s390x (bisected)
References: <20190708224238.60bd0aff@canb.auug.org.au>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 8 Jul 2019 18:52:14 +0200
MIME-Version: 1.0
In-Reply-To: <20190708224238.60bd0aff@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <0be7464d-f8ed-0567-b0ff-a6d31ecfd7a8@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, markward@linux.ibm.com

Al,

linux-next July 8th fails to bootup on s390x (linux-next from July 4th did still work)

[...]
smp: Brought up 1 node, 1 CPU
Unable to handle kernel pointer dereference in virtual kernel address space
Failing address: 000000003a070000 TEID: 000000003a070407
Fault in home space mode while using kernel ASCE.
AS:000000003a780007 R3:000000007ffd0007 S:000000007ffd4800 P:000000003a07021d 
Oops: 0004 ilc:2 [#1] SMP 
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc5-00101-gcb8f0b366109 #14
Hardware name: IBM 2964 NC9 712 (KVM/Linux)
Krnl PSW : 0704e00180000000 000000003974b580 (shmem_parse_monolithic+0x88/0x100)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000000000 000000000000003d 000000003a07040e 000000000000003d
           000000003a07040f 000000000000006d 0000000000000001 0000000000000000
           000000007f7c1c00 0000000000000000 000000003a07040a 0000000000000000
           000000007f7e4000 000000003a190d78 000000003974b56c 000003e00031fd38
Krnl Code: 000000003974b574: b920002a		cgr	%r2,%r10
           000000003974b578: a784001b		brc	8,3974b5ae
          #000000003974b57c: 41402001		la	%r4,1(%r2)
          >000000003974b580: 92002000		mvi	0(%r2),0
           000000003974b584: a7090000		lghi	%r0,0
           000000003974b588: b9040014		lgr	%r1,%r4
           000000003974b58c: b25e0001		srst	%r0,%r1
           000000003974b590: a714fffe		brc	1,3974b58c
Call Trace:
([<000003e00031fd80>] 0x3e00031fd80)
 [<0000000039811662>] vfs_kern_mount.part.0+0x9a/0xc8 
 [<000000003a302fc0>] devtmpfs_init+0x38/0x140 
 [<000000003a302e0a>] driver_init+0x22/0x60 
 [<000000003a2beff8>] kernel_init_freeable+0x298/0x4f0 
 [<0000000039e7b53a>] kernel_init+0x22/0x148 
 [<0000000039e87b70>] ret_from_fork+0x30/0x34 
 [<0000000039e87b74>] kernel_thread_starter+0x0/0xc 
INFO: lockdep is turned off.
[...]

bisect points to


f6ab6e953ab3b37b10646aabede8d8731f54cc61 is the first bad commit
commit f6ab6e953ab3b37b10646aabede8d8731f54cc61
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Jun 1 18:43:09 2019 -0400

    devtmpfs: don't mix {ramfs,shmem}_fill_super() with mount_single()
    
    Create an internal-only type matching the current devtmpfs, never
    register it and have one kernel-internal mount done.  That thing
    gets mounted only once, so it is free to use mount_nodev().
    
    The "public" devtmpfs (the one we do register, and only after
    the internal mount of the real thing is done) simply gets and
    returns an extra reference to the internal superblock.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

:040000 040000 4874d86e78685322401d6284d458ae323620573c e3c5780581792df416a4c272b583f76b98321080 M	drivers



I can confirm that 
f6ab6e953ab3b37b10646aabede8d8731f54cc61
has the issue and 
f6ab6e953ab3b37b10646aabede8d8731f54cc61^
has not.
