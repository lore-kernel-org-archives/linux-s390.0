Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Jun 2019 02:47:00 -0700
In-Reply-To: <00000000000090ae7a058bc12946@google.com>
Message-ID: <000000000000c1cb06058bfa9371@google.com>
Subject: Re: WARNING in debug_check_no_obj_freed
From: syzbot <syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: alexander.h.duyck@intel.com, amritha.nambiar@intel.com, andriy.shevchenko@linux.intel.com, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, dmitry.torokhov@gmail.com, f.fainelli@gmail.com, idosch@mellanox.com, jeffrey.t.kirsher@intel.com, jiri@mellanox.com, kafai@fb.com, kgraul@linux.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, songliubraving@fb.com, syzkaller-bugs@googlegroups.com, tyhicks@canonical.com, ubraun@linux.ibm.com, wanghai26@huawei.com, yhs@fb.com, yuehaibing@huawei.com

syzbot has bisected this bug to:

commit 99182beed858a1bde22f60046602b9b223225f73
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Tue Apr 2 21:17:19 2019 +0000

     Merge branch 'bpf-selftest-clang-fixes'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12faf81aa00000
start commit:   bed3c0d8 Merge tag 'for-5.2-rc5-tag' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11faf81aa00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16faf81aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=b972214bb803a343f4fe
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fcf0b2a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a22ad6a00000

Reported-by: syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com
Fixes: 99182beed858 ("Merge branch 'bpf-selftest-clang-fixes'")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
