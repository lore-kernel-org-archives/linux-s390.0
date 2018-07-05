Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: WARNING in smc_unhash_sk
References: <001a114fa99028d2a10565e33df4@google.com>
 <20180704200139.GB725@sol.localdomain>
From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu, 5 Jul 2018 16:17:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180704200139.GB725@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ee68e1f0-b177-8c84-cb6e-ccfbe1ef9a04@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Eric Biggers <ebiggers3@gmail.com>, linux-s390@vger.kernel.org
Cc: syzbot <syzbot+3a0748c8f2f210c0ef9b@syzkaller.appspotmail.com>, davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-ID: <linux-s390.vger.kernel.org>



On 07/04/2018 10:01 PM, Eric Biggers wrote:
> Hi Ursula,
> 
> On Fri, Feb 23, 2018 at 07:59:01AM -0800, syzbot wrote:
>> Hello,
>>
>> syzbot hit the following crash on upstream commit
>> af3e79d29555b97dd096e2f8e36a0f50213808a8 (Tue Feb 20 18:05:02 2018 +0000)
>> Merge tag 'leds_for-4.16-rc3' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds
>>
>> So far this crash happened 27 times on
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/master,
>> net-next, upstream.
>> C reproducer is attached.
>> syzkaller reproducer is attached.
>> Raw console output is attached.
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+3a0748c8f2f210c0ef9b@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> WARNING: CPU: 1 PID: 9921 at ./include/net/sock.h:638 sk_del_node_init
>> include/net/sock.h:638 [inline]
>> WARNING: CPU: 1 PID: 9921 at ./include/net/sock.h:638
>> smc_unhash_sk+0x335/0x450 net/smc/af_smc.c:90
>> Kernel panic - not syncing: panic_on_warn set ...
> 
> This is still happening and it can be easily reproduced with:
> 
> 	#include <sys/socket.h>
> 
> 	int main()
> 	{
> 		char buf[64] = { 0 };
> 		struct iovec iov  = { .iov_base = buf, .iov_len = sizeof(buf) };
> 		struct msghdr msg = { .msg_iov = &iov, .msg_iovlen = 1 };
> 		int fd;
> 
> 		fd = socket(AF_SMC, SOCK_STREAM, 0);
> 		sendmsg(fd, &msg, MSG_FASTOPEN);
> 	}
> 
> It seems the following sock_put() in smc_release() is done without any previous
> sock_hold(), causing a use-after-free:
> 
>         if (smc->use_fallback) {
>                 sock_put(sk); /* passive closing */
>                 sk->sk_state = SMC_CLOSED;
>                 sk->sk_state_change(sk);
>         }
> 

Sorry for the delay. Now patch is submitted for the net-tree.
