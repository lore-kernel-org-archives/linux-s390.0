Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 sock_poll
References: <00000000000080d9a6056e3aeb35@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <1250334f-7220-2bff-5d87-b87573758d81@I-love.SAKURA.ne.jp>
Date: Sun, 10 Jun 2018 10:38:20 +0900
MIME-Version: 1.0
In-Reply-To: <00000000000080d9a6056e3aeb35@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: syzbot <syzbot+344bb0f46d7719cd9483@syzkaller.appspotmail.com>, ubraun@linux.ibm.com, linux-s390@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-ID: <linux-s390.vger.kernel.org>

On 2018/06/10 4:57, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1188a05f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f04d8d0a2afb789a
> dashboard link: https://syzkaller.appspot.com/bug?extid=344bb0f46d7719cd9483
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12b5841f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f4005f800000

This is a same report except s/epoll/poll/ .

----------
#include <sys/socket.h>
#include <sys/poll.h>
#define PF_SMC 43

int main(int argc, char *argv[])
{
	int sfd = socket(PF_SMC, SOCK_STREAM, 0);
	struct pollfd pfd = { .fd = sfd };
	poll(&pfd, 1, 0);
	return 0;
}
----------

#syz dup: BUG: unable to handle kernel NULL pointer dereference in corrupted
