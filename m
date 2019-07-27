Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 27 Jul 2019 03:16:00 -0700
In-Reply-To: <000000000000111cbe058dc7754d@google.com>
Message-ID: <0000000000000dc874058ea6f261@google.com>
Subject: Re: memory leak in new_inode_pseudo (2)
From: syzbot <syzbot+e682cca30bc101a4d9d9@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@fb.com, axboe@kernel.dk, catalin.marinas@arm.com, davem@davemloft.net, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, michaelcallahan@fb.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit a21f2a3ec62abe2e06500d6550659a0ff5624fbb
Author: Michael Callahan <michaelcallahan@fb.com>
Date:   Tue May 3 15:12:49 2016 +0000

     block: Minor blk_account_io_start usage cleanup

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13565e92600000
start commit:   be8454af Merge tag 'drm-next-2019-07-16' of git://anongit...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10d65e92600000
console output: https://syzkaller.appspot.com/x/log.txt?x=17565e92600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d23a1a7bf85c5250
dashboard link: https://syzkaller.appspot.com/bug?extid=e682cca30bc101a4d9d9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155c5800600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1738f800600000

Reported-by: syzbot+e682cca30bc101a4d9d9@syzkaller.appspotmail.com
Fixes: a21f2a3ec62a ("block: Minor blk_account_io_start usage cleanup")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
