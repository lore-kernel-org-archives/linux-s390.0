Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FB1C433FE
	for <linux-s390@archiver.kernel.org>; Mon, 28 Mar 2022 20:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiC1VBN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Mar 2022 17:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiC1VBM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Mar 2022 17:01:12 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB496E4C4
        for <linux-s390@vger.kernel.org>; Mon, 28 Mar 2022 13:59:27 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id y3-20020a056602178300b00645d25c30c1so11142467iox.6
        for <linux-s390@vger.kernel.org>; Mon, 28 Mar 2022 13:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8b0H5vvD2VnHQ7WB0PvUTrDqYnbmClQRRtRxaJNMcQs=;
        b=1cNRm8aafuieOCRRExo8xK9Twk89ycopL7jXZwszrA+j2iP3oOzjLqxUv9r0MGyFOt
         nIU4CfeGnZ9yy3nR4PD6Ox0YJkMi0OWV3kVJHDqgCXNUw5AqhATaYo8tn+VemwzzckHw
         s2jvaOtbdwBSfrUYh1YcnFimEbwpuVzlZYQ2RNvH4ajyqOMBOnTzhtEio0d8GKwNS7A9
         KW0PdPORLeP/nwW9A+JusH9Az/KK4w0Vbg6DD9Zd3URh+fq9Wnjl6s1MUh0uWSsUa03P
         oH2Yf0VSA+aezLoIe9tcu7z3dBJfgzBWHSjmxllCexf1embx/SG5yxv6P+l+0F7OcSAO
         NSJA==
X-Gm-Message-State: AOAM530QNDPc+gc+6CPz3X/sdhhRYSa6qKrv51KlnFktZixl7VrEUBBg
        xUTFEoV8qgvGM/M9sRPSOe2wHLpNVuXYp69hq6ai9VdMbFzA
X-Google-Smtp-Source: ABdhPJx3jL1kXv2KYtl8WquCdr03cvCiSymt2HZ053TYRUZs1f+gPVc9KaFGmbepBUcZjRQBQfb5ljUX/ZJKj+1WbA98/z4Docc9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1585:b0:2c2:5b2c:e3e5 with SMTP id
 m5-20020a056e02158500b002c25b2ce3e5mr6883558ilu.76.1648501166487; Mon, 28 Mar
 2022 13:59:26 -0700 (PDT)
Date:   Mon, 28 Mar 2022 13:59:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070bc9405db4d96b8@google.com>
Subject: [syzbot] memory leak in smc_create (2)
From:   syzbot <syzbot+6e29a053eb165bd50de5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kgraul@linux.ibm.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ed4643521e6a Merge tag 'arm-dt-5.18' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d17b99700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8414405fa34d7154
dashboard link: https://syzkaller.appspot.com/bug?extid=6e29a053eb165bd50de5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16431151700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f44cdb700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e29a053eb165bd50de5@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881158a5840 (size 1504):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 40.640s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888114575d80 (size 32):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 40.640s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d880 (size 1504):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 39.860s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888115827920 (size 32):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 39.860s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d280 (size 1504):
  comm "syz-executor131", pid 3753, jiffies 4294957955 (age 39.860s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff8881158a5840 (size 1504):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 40.700s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888114575d80 (size 32):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 40.700s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d880 (size 1504):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 39.920s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888115827920 (size 32):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 39.920s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d280 (size 1504):
  comm "syz-executor131", pid 3753, jiffies 4294957955 (age 39.920s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff8881158a5840 (size 1504):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 40.770s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888114575d80 (size 32):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 40.770s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d880 (size 1504):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 39.990s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888115827920 (size 32):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 39.990s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d280 (size 1504):
  comm "syz-executor131", pid 3753, jiffies 4294957955 (age 39.990s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff8881158a5840 (size 1504):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 40.830s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888114575d80 (size 32):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 40.830s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d880 (size 1504):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 40.050s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888115827920 (size 32):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 40.050s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d280 (size 1504):
  comm "syz-executor131", pid 3753, jiffies 4294957955 (age 40.050s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff8881158a5840 (size 1504):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 40.890s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888114575d80 (size 32):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 40.890s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d880 (size 1504):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 40.110s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888115827920 (size 32):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 40.110s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d280 (size 1504):
  comm "syz-executor131", pid 3753, jiffies 4294957955 (age 40.110s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff8881158a5840 (size 1504):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 40.960s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888114575d80 (size 32):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 40.960s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d880 (size 1504):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 40.180s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888115827920 (size 32):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 40.180s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d280 (size 1504):
  comm "syz-executor131", pid 3753, jiffies 4294957955 (age 40.180s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff8881158a5840 (size 1504):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 41.020s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888114575d80 (size 32):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 41.020s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d880 (size 1504):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 40.250s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888115827920 (size 32):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 40.250s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d280 (size 1504):
  comm "syz-executor131", pid 3753, jiffies 4294957955 (age 40.250s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff8881158a5840 (size 1504):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 41.090s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888114575d80 (size 32):
  comm "syz-executor131", pid 3746, jiffies 4294957877 (age 41.090s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d880 (size 1504):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 40.310s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888115827920 (size 32):
  comm "syz-executor131", pid 3754, jiffies 4294957955 (age 40.310s)
  hex dump (first 32 bytes):
    b0 2e 04 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff821fb4e3>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff821fb4e3>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff821fb4e3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:792
    [<ffffffff821c1091>] security_sk_alloc+0x31/0x70 security/security.c:2279
    [<ffffffff837cc0f5>] sk_prot_alloc+0x95/0x1b0 net/core/sock.c:1926
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811569d280 (size 1504):
  comm "syz-executor131", pid 3753, jiffies 4294957955 (age 40.310s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2b 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  +..@............
  backtrace:
    [<ffffffff837cc09e>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:1917
    [<ffffffff837cfcf2>] sk_alloc+0x32/0x2e0 net/core/sock.c:1976
    [<ffffffff84173e61>] smc_sock_alloc+0x51/0x1a0 net/smc/af_smc.c:246
    [<ffffffff84174e89>] __smc_create net/smc/af_smc.c:2879 [inline]
    [<ffffffff84174e89>] smc_create+0x89/0x180 net/smc/af_smc.c:2910
    [<ffffffff837c49cb>] __sock_create+0x1ab/0x2b0 net/socket.c:1468
    [<ffffffff837c794f>] sock_create net/socket.c:1519 [inline]
    [<ffffffff837c794f>] __sys_socket+0x6f/0x140 net/socket.c:1561
    [<ffffffff837c7a3a>] __do_sys_socket net/socket.c:1570 [inline]
    [<ffffffff837c7a3a>] __se_sys_socket net/socket.c:1568 [inline]
    [<ffffffff837c7a3a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1568
    [<ffffffff844f9695>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff844f9695>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
