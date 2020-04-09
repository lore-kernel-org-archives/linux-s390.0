Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qk1-f177.google.com ([209.85.222.177]:42565 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgDIXd3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Apr 2020 19:33:29 -0400
Received: by mail-qk1-f177.google.com with SMTP id x66so583812qkd.9
        for <linux-s390@vger.kernel.org>; Thu, 09 Apr 2020 16:33:29 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: s390 boot woe due to "block: fix busy device checking in
 blk_drop_partitions"
Message-Id: <AD16A450-794F-4EEA-A7BF-42452F18294A@lca.pw>
Date: Thu, 9 Apr 2020 19:33:25 -0400
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Reverted the linux-next commit on today=E2=80=99s tree,

d3ef5536274f (=E2=80=9Cblock: fix busy device checking in =
blk_drop_partitions=E2=80=9D)

makes IBM partition to be recognized again on s390 rootfs,

01: [   83.443963]  dasda:VOL1/  0X0121: dasda1                          =
      =20
01: [   85.124667] qeth 0.0.8000 enc8000: renamed from eth0              =
      =20
01: [   85.731860] dasd-eckd 0.0.0120: DASD with 4 KB/block, 72122400 KB =
total s
01: ize, 48 KB/track, compatible disk layout                             =
      =20
01: [   86.076722]  dasdb:VOL1/  0X0120: dasdb1 dasdb2

Otherwise, it is DOA,

00:          Starting Show Plymouth Boot Screen...                       =
      =20
00: [   37.202263] qeth 0.0.8000: portname is deprecated and is ignored  =
      =20
00: [   37.677993] qdio: 0.0.8002 OSA on SC 4 using AI:1 QEBSM:0 PRI:1 =
TDD:1 SIG
00: A:RW A                                                               =
      =20
00: [   37.770970] qeth 0.0.8000: MAC address 02:de:ad:be:ef:87 =
successfully reg
00: istered                                                              =
      =20
00: [   37.771547] qeth 0.0.8000: Device is a Virtual NIC QDIO card =
(level: V642
00: )                                                                    =
      =20
00: [   37.771547] with link type Virt.NIC QDIO.                         =
      =20
00: [   38.036231] ccw_init (415) used greatest stack depth: 56496 bytes =
left  =20
00:          Starting dracut initqueue hook...                           =
      =20
00: [   39.176304] dasd-eckd 0.0.0120: A channel path to the device has =
become o
00: perational                                                           =
      =20
00: [   39.453273] dasd-eckd 0.0.0120: New DASD 3390/0E (CU 3990/01) =
with 100170
00:  cylinders, 15 heads, 224 sectors                                    =
      =20
00: [   39.655564] dasd-eckd 0.0.0121: A channel path to the device has =
become o
00: perational                                                           =
      =20
00: [   39.722706] dasd-eckd 0.0.0121: New DASD 3390/0E (CU 3990/01) =
with 100170
00:  cylinders, 15 heads, 224 sectors                                    =
      =20
01: [   41.133963] dasd-eckd 0.0.0121: DASD with 4 KB/block, 72122400 KB =
total s
01: ize, 48 KB/track, compatible disk layout                             =
      =20
01: [   41.145510] dasd-eckd 0.0.0120: DASD with 4 KB/block, 72122400 KB =
total s
01: ize, 48 KB/track, compatible disk layout                             =
      =20
01: [   41.609625] qeth 0.0.8000 enc8000: renamed from eth0 =20
01: [   41.609625] qeth 0.0.8000 enc8000: renamed from eth0              =
      =20
01: Warning: /dev/mapper/rhel_ibm--z--135-root does not exist            =
      =20
01: Warning: /dev/rhel_ibm-z-135/root does not exist                     =
      =20
01: Warning: /dev/rhel_ibm-z-135/swap does not exist                     =
      =20
01:                                                                      =
      =20
01: Generating "/run/initramfs/rdsosreport.txt"                          =
      =20
01:                                                                      =
      =20
01:                                                                      =
      =20
01: Entering emergency mode. Exit the shell to continue.                 =
      =20
01: Type "journalctl" to view system logs.                               =
      =20
01: You might want to save "/run/initramfs/rdsosreport.txt" to a USB =
stick or /b
01: oot                                                                  =
      =20
01: after mounting them and attach it to a bug report.                   =
      =20
01:                                                                      =
      =20
01:                                                                      =
      =20
00: dracut:/#=20
