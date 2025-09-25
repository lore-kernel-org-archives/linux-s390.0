Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1AB2E1747
	for <linux-s390@vger.kernel.org>; Thu, 25 Sep 2025 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826002; cv=none; b=L8YJdlTdoc/dNODGsTGGmvhlDX2KAq8LcoMSH7zr/lkzQhZCskJRjjq52GS4XSkFoxSyFyuOszicknl8GWmbfgD7EQHv5G/6BNkdWP7Vyj4WfHJbuvn+Qld8AjLgd3QIVr60JUfUrQ1uC74qPGzmhyRtvS79YyUqEOKGY3T1SAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826002; c=relaxed/simple;
	bh=lfgcz3m4LxsJc7fu9Gh6cquree6UlWdW+wi7FdecF+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8adXLvOIhQAPUdNSGX81/QfdyAdcnIz6Sh+3h7IsK9+NIgjMzmBpbhkfOrsP4nbiAxfqfg8UPeMKIiAXX27yWR+d/AVhOxt+7ApUUjEQ0sdMiYGFOWF9BE4ROCRraUgFSneNtbqjvvWOF0orcT8jczbrRscEm0elymmRj80o7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWN9sZeP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWN9sZeP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eceb38eb1so15341325ad.3
        for <linux-s390@vger.kernel.org>; Thu, 25 Sep 2025 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758826000; x=1759430800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLdUuxsUyFeLw5VmYATasRsILS+Z5g1sPWduMjqAJtQ=;
        b=VWN9sZePBfN8PboPgWPiYarkSaQayMFmyL4dwSRNIbNagtH0EkrrbtlQHgrePovVAE
         njAMWChJ5eh2jR25v9pMJkaW+hB8zhRMWNRxf2/QW5aHTjayVyrcI2NL0eZ+Tmp5B0sq
         DBC9YZV5sfFeNFtN4pUj3C4CZO+3A8CxftmQFglqCMrENpNZOpDHgGK6Ay3JLXiY2rfW
         YpL9CnssC6D1ukSvVTNmyt/BnNyL/plYCUhuFP19vx8HpiSHSMOORIHCF8gF+QSb/4in
         5v3GPqIrd3/bdZG/b0/M8vTVk4Mkw3rNRPX59eZ6FLmqANaAjSR8iNSNVQxztCCWwQy2
         aMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758826000; x=1759430800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLdUuxsUyFeLw5VmYATasRsILS+Z5g1sPWduMjqAJtQ=;
        b=MycXG87Vgxe9j3Q2z+GhMwsXFbPXnBcAOE2+WI0pJAZlgRTIkqL1VxayXd9AfGX+6N
         pjjdGNkbP/gSzbvGY+WOhJW6TkjNaZfF2T+WLiMt6lad2iZsYTtPjcrgne5PYi1LqGCH
         T+y5Loe+5tgupfMRZZOe7EPWa3l718nvKsd9JySGL5Jrbv03ejUUiS//l95SgfPOUFHN
         HZwCNrz5wvjPpVLwsQuuXFsghQw96S1ZdSge8c9JzKBCdgC8ZlPqgutbT0aXk5deZlFv
         G/N8FpNAvyE6OPiyMPpu+9Pk490pN0eukScrFC+vDCJN0MoWiy/qWEQ7ZM91+5XXxkqG
         zDPg==
X-Forwarded-Encrypted: i=1; AJvYcCUEzIGe3rn7CG/+C046NkZRNi/ddy0HKHVdCycPl+tEmixjP/k49YSo6BmC/feld+F/714+k4Leiucp@vger.kernel.org
X-Gm-Message-State: AOJu0YzWFdh6eQqZNRK0GgNdjJGGsUXfOeo77aGJ2yElHw5HLCvz2rLy
	9FvI8imW3hTxzSTTgYSzm19EusWVh7UnCB8cGCocgHdlV87S/JPqsp5IW3ZXZv83NLsn5WZEjTN
	a5K3gJdgpynvvfYrGXZFdps3RvFFdgaMISzprn8sk
X-Gm-Gg: ASbGncseMBVevCQh7s+VQs4oy5wMQdO34P0j2s+ebUb2nsRPN9IvDZGyqC6JRcpL/bB
	kXol2/KBKcrQ6N799FwkMz3mfSCyrLRkT2TEhz5LZ10izR55vMpyrlB8JjGoh1MZjY+UgW/APrQ
	YA8hIhoIbGieDhaYTKiwSsY8v5WIlNQjpHOU83yZP+hDa6eKhtWZHdBu1+E3IndFU9KJWUehA5Z
	kZbgr1grQKi5meHeKS5MqayublnA/BPdKhWydLvzjMdRMc0X3sYTtC07A==
X-Google-Smtp-Source: AGHT+IFHjpr/efSIGkSFc5aOwJwEJU/g3ib8aCrwbTfnR8LYDmx3PXaFp3wa4hoCDt63NVnjWqyIsHdEpL7XBgbkxZg=
X-Received: by 2002:a17:902:d490:b0:277:71e6:b04d with SMTP id
 d9443c01a7336-27ed4a29e5dmr46669715ad.3.1758825999931; Thu, 25 Sep 2025
 11:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922121818.654011-1-wangliang74@huawei.com> <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
In-Reply-To: <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 11:46:28 -0700
X-Gm-Features: AS18NWCbS5gc66qTtEBpXFcEyjAbYBGY7oQ_xwB_xqs7eGxR4FmmvHj2dUmJMhQ
Message-ID: <CAAVpQUBxoWW_4U2an4CZNoSi95OduUhArezHnzKgpV3oOYs5Jg@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix general protection fault in __smc_diag_dump
To: Wang Liang <wangliang74@huawei.com>
Cc: Eric Dumazet <edumazet@google.com>, alibuda@linux.alibaba.com, 
	dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Eric for CCing me.

On Thu, Sep 25, 2025 at 7:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 22, 2025 at 4:57=E2=80=AFAM Wang Liang <wangliang74@huawei.co=
m> wrote:
> >
> > The syzbot report a crash:
> >
> >   Oops: general protection fault, probably for non-canonical address 0x=
fbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4e=
ad0000001f]
> >   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREE=
MPT(full)
> >   Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 08/18/2025
> >   RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
> >   RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c=
:89
> >   Call Trace:
> >    <TASK>
> >    smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
> >    smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
> >    netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
> >    __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
> >    netlink_dump_start include/linux/netlink.h:341 [inline]
> >    smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
> >    __sock_diag_cmd net/core/sock_diag.c:249 [inline]
> >    sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
> >    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
> >    netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
> >    netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
> >    netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
> >    sock_sendmsg_nosec net/socket.c:714 [inline]
> >    __sock_sendmsg net/socket.c:729 [inline]
> >    ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
> >    ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
> >    __sys_sendmsg+0x16d/0x220 net/socket.c:2700
> >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >    do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >    </TASK>
> >
> > The process like this:
> >
> >                (CPU1)              |             (CPU2)
> >   ---------------------------------|-------------------------------
> >   inet_create()                    |
> >     // init clcsock to NULL        |
> >     sk =3D sk_alloc()                |
> >                                    |
> >     // unexpectedly change clcsock |
> >     inet_init_csk_locks()          |
> >                                    |
> >     // add sk to hash table        |
> >     smc_inet_init_sock()           |
> >       smc_sk_init()                |
> >         smc_hash_sk()              |
> >                                    | // traverse the hash table
> >                                    | smc_diag_dump_proto
> >                                    |   __smc_diag_dump()
> >                                    |     // visit wrong clcsock
> >                                    |     smc_diag_msg_common_fill()
> >     // alloc clcsock               |
> >     smc_create_clcsk               |
> >       sock_create_kern             |
> >
> > With CONFIG_DEBUG_LOCK_ALLOC=3Dy, the smc->clcsock is unexpectedly chan=
ged
> > in inet_init_csk_locks(), because the struct smc_sock does not have str=
uct
> > inet_connection_sock as the first member.
> >
> > Previous commit 60ada4fe644e ("smc: Fix various oops due to inet_sock t=
ype
> > confusion.") add inet_sock as the first member of smc_sock. For protoco=
l
> > with INET_PROTOSW_ICSK, use inet_connection_sock instead of inet_sock i=
s
> > more appropriate.

Why is INET_PROTOSW_ICSK necessary in the first place ?

I don't see a clear reason because smc_clcsock_accept() allocates
a new sock by smc_sock_alloc() and does not use inet_accept().

Or is there any other path where smc_sock is cast to
inet_connection_sock ?


> >
> > Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Df775be4458668f7d220e
> > Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> > Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> > Signed-off-by: Wang Liang <wangliang74@huawei.com>
> > ---
> >  net/smc/smc.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/smc/smc.h b/net/smc/smc.h
> > index 2c9084963739..1b20f0c927d3 100644
> > --- a/net/smc/smc.h
> > +++ b/net/smc/smc.h
> > @@ -285,7 +285,7 @@ struct smc_connection {
> >  struct smc_sock {                              /* smc sock container *=
/
> >         union {
> >                 struct sock             sk;
> > -               struct inet_sock        icsk_inet;
> > +               struct inet_connection_sock     inet_conn;
> >         };
> >         struct socket           *clcsock;       /* internal tcp socket =
*/
> >         void                    (*clcsk_state_change)(struct sock *sk);
> > --
> > 2.34.1
> >
>
> Kuniyuki, can you please review, I think you had a related fix recently.
>
> Thanks.
>
> commit 60ada4fe644edaa6c2da97364184b0425e8aeaf5
> Author: Kuniyuki Iwashima <kuniyu@google.com>
> Date:   Fri Jul 11 06:07:52 2025 +0000
>
>     smc: Fix various oops due to inet_sock type confusion.
