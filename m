Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061C9158D9B
	for <linux-s390@vger.kernel.org>; Thu,  1 Feb 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782347; cv=none; b=p86HAR4vC/nveC5M9fwcB3TXbsPsmpQss00+AAjJMxsMIlStOmp8QwqulZjFy0ebdWTzb+zHouYj3SFGV/a0GquSf9h56vE9sGduFm95Bu47YuQiE2PGAKr1gsyfSOmiM9vD3Zwkpkbuj+Ui2GYSkF47qG3mfhfz6Dc/Cse7ewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782347; c=relaxed/simple;
	bh=0hkGTq+IfUCvwYmNvyoNZ0aTtPEQahj/pe57w9qIgMk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cUiypNH9sR1e0HJhACbSjmmiO936zMPFUey3mlR9Q2JJJfsh9lAzHaNbHe5/kly50ojcquTJP9QTBbFmsqNDbA8QLB9h/dbGmusgocNhLSSA5jT1IcoY5bt00KhUziLe1lX//1731j7R2Rz+vPbNkVN2vXXHw1jHd8KMGFlcbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf48e0f513so66517439f.0
        for <linux-s390@vger.kernel.org>; Thu, 01 Feb 2024 02:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706782345; x=1707387145;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Asvm9Ng9v04fcnG9TARg/mgu5KJMM7tuU6wye4lAsNY=;
        b=DJ/zp4nCYe9b5TogsBJ8zq6c2BrdolvQT322sCCLYwEhFWYOsE2LUUZ3xLoxk+ET67
         wDZuN53MiCsugVbm23aievAtJeIis9n/fgoLBZiWTzrkqElEvh+u9jqEilo3xAwv9eM0
         qMNshVAKAPs6Ri4IxRqzC+F0tWGT6t3Rn5idmS1o1TfWL2MM4Oih4X69OVo0QZRgv4eI
         BQEyfGJsnFiM5/csi2+pfon/eopr+OOSMPVdRaqtDGqSD8Go7MlF9YFlDQpAnmZxCTV3
         o41C+jaCRsBs6W6qF0Ld08nbuvMpQZ4w25to+yeDGZppEaVDu3rg3DP8JBo7F1VxXIj7
         r2cg==
X-Gm-Message-State: AOJu0Ywen1t8h6JQCAv4+nCbrIQ8kAPGCF6dMXr+/p/meb+aQVKgLzSp
	eTlmm27D9euozgqEfnxhT+XE/DN/psWqqcpqXWKCh9WMi42rUWzFValyig58J05s0yGtClbafOb
	hu926jdVOX1utzlrgJJ2lw0D6kzniWJg0dGFC4vlgJ9hw+hDbdLPYeUE=
X-Google-Smtp-Source: AGHT+IHPOwfpLUsGJ/kYBOjvVxEPaanltLISeaZxKkJShYH6tg0o8LqNJReL0ZqbXA22eXjJF9PUJevPkLA+oEfj6Q05uMppTIZz
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:363:9211:a723 with SMTP id
 i12-20020a056e021b0c00b003639211a723mr377330ilv.2.1706782345179; Thu, 01 Feb
 2024 02:12:25 -0800 (PST)
Date: Thu, 01 Feb 2024 02:12:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064b78606104f3b91@google.com>
Subject: [syzbot] [net?] [s390?] KCSAN: data-race in __sys_connect / smc_switch_to_fallback
From: syzbot <syzbot+ab2213db98841b6ead07@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, jaka@linux.ibm.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4854cf9c61d0 Merge tag 'mips-fixes_6.8_1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149d01efe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1bd33f45956bbc2
dashboard link: https://syzkaller.appspot.com/bug?extid=ab2213db98841b6ead07
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e44f160651d1/disk-4854cf9c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f6a2062d07e6/vmlinux-4854cf9c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d179908ef3c/bzImage-4854cf9c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab2213db98841b6ead07@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __sys_connect / smc_switch_to_fallback

write to 0xffff88812a230bc8 of 8 bytes by task 1831 on cpu 1:
 smc_switch_to_fallback+0x453/0x740 net/smc/af_smc.c:924
 smc_sendmsg+0xd6/0x330 net/smc/af_smc.c:2772
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x1e9/0x270 net/socket.c:2667
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x59/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

read to 0xffff88812a230bc8 of 8 bytes by task 1833 on cpu 0:
 sock_from_file net/socket.c:514 [inline]
 __sys_connect_file net/socket.c:2037 [inline]
 __sys_connect+0x11d/0x1b0 net/socket.c:2065
 __do_sys_connect net/socket.c:2075 [inline]
 __se_sys_connect net/socket.c:2072 [inline]
 __x64_sys_connect+0x41/0x50 net/socket.c:2072
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x59/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

value changed: 0xffff8881293bc000 -> 0xffff8881293bf400

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 1833 Comm: syz-executor.0 Not tainted 6.8.0-rc1-syzkaller-00385-g4854cf9c61d0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
