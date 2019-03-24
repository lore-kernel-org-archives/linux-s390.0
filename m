Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 24 Mar 2019 00:20:01 -0700
In-Reply-To: <00000000000060600e057e7748dc@google.com>
Message-ID: <000000000000866e8d0584d1ea10@google.com>
Subject: Re: general protection fault in __smc_diag_dump
From: syzbot <syzbot+5dd1f9327a9ee760048c@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: davem@davemloft.net, eric.dumazet@gmail.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mmarek@suse.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, ubraun@linux.ibm.com, xiyou.wangcong@gmail.com, yamada.masahiro@socionext.com
List-ID: <linux-s390.vger.kernel.org>

syzbot has bisected this bug to:

commit 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Jul 2 23:07:02 2017 +0000

     Linux 4.12

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e319df200000
start commit:   28e8c4bc Merge tag 'rtc-4.21' of git://git.kernel.org/pub/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2ab9708c613a224
dashboard link: https://syzkaller.appspot.com/bug?extid=5dd1f9327a9ee760048c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d17880c00000

Reported-by: syzbot+5dd1f9327a9ee760048c@syzkaller.appspotmail.com
Fixes: 6f7da290413b ("Linux 4.12")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
