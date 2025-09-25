Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3030E31D74E
	for <linux-s390@vger.kernel.org>; Thu, 25 Sep 2025 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829910; cv=none; b=pVtcnxhK6fbyqzPxijVTrc//Gcc5rE7TVQ5Ig371rgoV9peJQbua8Qp+aoB3hoEmFv+tp54gaIX+4h1FVQhmDJPALIBkT4ritqkGvX8gGT2jM7c51+mmVRA1BCOoCgoaeibVW+0NIbf2n8ECKNWXCHMBBY/VOzT5SzWAa8SQZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829910; c=relaxed/simple;
	bh=pDmPi+nDsdkh16sS4XOo0WoQjsIHhChrThGhNMoNGts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0hDuDPw/vjpIr/hTqz102o1+9oRI5I11i2vh7kCCVDY2BgKPl43cUiQTYR/JkNiYruuNRaxJ8VwZGOCZOaQsrdaCr/O40+g6u7R17YTpGTzdMV6ghWQqkmWB1CF5Mzm6D+AurK5N4vGmA6YpOQMwVWxuKgi7Aaj7dAxOS/hdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bu5IOrYA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bu5IOrYA"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so983684a12.0
        for <linux-s390@vger.kernel.org>; Thu, 25 Sep 2025 12:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758829908; x=1759434708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rv55ZBu/vAaRJGHC+Hl6bbjlGFEjsrTGV6fFQSN2diA=;
        b=bu5IOrYAfwwd0gBoEQuyrx6KpejnDrdlGyJJU4POKe9xTdOXiJo6QSqSnAQF+15WA5
         0cFnwVO5cf+/svgZjt7f1Iz9WIURZ+eoZOmqOQO5k+cGS2OvGvCnmqVdpQ7hdeTqKnvo
         uihS8GkDh6bZIg5AxHgBpqPKThopmENjNc0x414jMD+mI/0jy+DT53xKdw3BLKlEP3d0
         iV2hf60X0k8yR2KtNDXXOYR+npWGsr81VKEW+rgAAN/SsE6jYo9ZEoTZ2nkLNqEP582H
         /P/bjG3MHGguN4Q2s0JCLg70azje9+G2eV2yw0Dr2JnIx/Bsf3Ws86ZaXOyxLCT+ovU+
         0Pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829908; x=1759434708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rv55ZBu/vAaRJGHC+Hl6bbjlGFEjsrTGV6fFQSN2diA=;
        b=KFS9kkpO51ruDoo4x6ZZTgvM9s8mQ1+qorU9aW6o1VOGC4guydpD6DsPTO7ht/5L1b
         BLcDgpUJACfsnTObAWg6gFm2jN3RvG8eI3+rYBxYGFKVHmyBjpE5PsHM00ELZEAoBkHi
         pvlPS1SO4xS58ATaZPdnlY/MIAcC9uc0GTl9P1Jp47IdrEpMDK359CHe05ybBi7Q7lHB
         vkcJrPi+kGwBb8AjvpJyqy1tNNx+gsfnr7Y81PtZCfFCLRjWtI4lT6wjFKNzx5xxDWEx
         Xiyi6+NKutqGkndWEnuxvnRhpaZY5rKtAbqv88kHSLvRJPV3zxb93j0is5KqWyqNIfLX
         kDKA==
X-Forwarded-Encrypted: i=1; AJvYcCWTUxC/BetxLpllUJPLgXBFuPwv9n1GTu9+rXrsW9wabqFMKYTQ1vDKconarniOI/LEbLOICtzhZqGN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6G3o5QzS9ovAxUv3z00hV1rqKxa6zRSXVyR6WofsWs8RDXmP0
	R5S6g6XXv3I3xkB+qlnh9BJjQPo3VQXpkq+Y/Scc0j+QZ6ORMigKSsBadaPwlCDoPRjkB9nPlTE
	IltSru9VI8P/UqKM5FTFVg6Ad+5P+oh2aoFJaAfxiqu5jNZYdwBK5r0G1Nak=
X-Gm-Gg: ASbGncu3bdfQGlLDhcDsMW9hYuoW8q5Xg16VafMYktKUqexOPQfQEJnf3zuKhab2paS
	KanaK5sKy/HB88vGejK4d3UGz0kRRebz5pq2zEnil+LuupcXJfx975z22KpE56jMelv5wfijLbP
	k5i68zqs6x0YamNsjzOmjHZP+JaWPeOJSj3tvYenPLMOV8Mk2diO4tvgCDWxbwZw9KhDqC1syUC
	Cp/rqUhI7h/20T/XqGLSjL46DLgHNLTWc12uImLm2lUffg=
X-Google-Smtp-Source: AGHT+IEMxPfUQjoBcfANKqp9Vkg+WQJ3eu9qIHeIMZROEVNo7FCgnZHJoaajMVV6jRvi1vvmnFYYvC7eSgqUM5vPToY=
X-Received: by 2002:a17:903:3d0e:b0:271:5bde:697e with SMTP id
 d9443c01a7336-27ed49b9e58mr48033525ad.3.1758829908255; Thu, 25 Sep 2025
 12:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922121818.654011-1-wangliang74@huawei.com>
 <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
 <CAAVpQUBxoWW_4U2an4CZNoSi95OduUhArezHnzKgpV3oOYs5Jg@mail.gmail.com>
 <CANn89i+V847kRTTFW43ouZXXuaBs177fKv5_bqfbvRutpg+s6g@mail.gmail.com>
 <CAAVpQUBriJFUhq2MpfwFTBLkF0rJfaVp1gaJ3wdhZuD7NWOaXw@mail.gmail.com> <CANn89i+Ntwzm2A=NSHbKdFuGVR6kar00AjrJE91Lu0e5BUsVow@mail.gmail.com>
In-Reply-To: <CANn89i+Ntwzm2A=NSHbKdFuGVR6kar00AjrJE91Lu0e5BUsVow@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 12:51:37 -0700
X-Gm-Features: AS18NWAA2SBIe4o1ksv9NLao6qJzvr8CVNGLCgq5DU2m2sX7IFSITs6B-eWQNdo
Message-ID: <CAAVpQUAd1oba6cy-hSub-iS0cnh7WH=HXgVnUwj8MXZLyU=a+w@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix general protection fault in __smc_diag_dump
To: Eric Dumazet <edumazet@google.com>, Wang Liang <wangliang74@huawei.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 12:37=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Sep 25, 2025 at 12:25=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > On Thu, Sep 25, 2025 at 11:54=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Thu, Sep 25, 2025 at 11:46=E2=80=AFAM Kuniyuki Iwashima <kuniyu@go=
ogle.com> wrote:
> > > >
> > > > Thanks Eric for CCing me.
> > > >
> > > > On Thu, Sep 25, 2025 at 7:32=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Mon, Sep 22, 2025 at 4:57=E2=80=AFAM Wang Liang <wangliang74@h=
uawei.com> wrote:
> > > > > >
> > > > > > The syzbot report a crash:
> > > > > >
> > > > > >   Oops: general protection fault, probably for non-canonical ad=
dress 0xfbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
> > > > > >   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-=
0xdead4ead0000001f]
> > > > > >   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller=
 #0 PREEMPT(full)
> > > > > >   Hardware name: Google Google Compute Engine/Google Compute En=
gine, BIOS Google 08/18/2025
> > > > > >   RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inl=
ine]
> > > > > >   RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/sm=
c_diag.c:89
> > > > > >   Call Trace:
> > > > > >    <TASK>
> > > > > >    smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
> > > > > >    smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
> > > > > >    netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
> > > > > >    __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:24=
42
> > > > > >    netlink_dump_start include/linux/netlink.h:341 [inline]
> > > > > >    smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
> > > > > >    __sock_diag_cmd net/core/sock_diag.c:249 [inline]
> > > > > >    sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
> > > > > >    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
> > > > > >    netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline=
]
> > > > > >    netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
> > > > > >    netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
> > > > > >    sock_sendmsg_nosec net/socket.c:714 [inline]
> > > > > >    __sock_sendmsg net/socket.c:729 [inline]
> > > > > >    ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
> > > > > >    ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
> > > > > >    __sys_sendmsg+0x16d/0x220 net/socket.c:2700
> > > > > >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > > > >    do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
> > > > > >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > >    </TASK>
> > > > > >
> > > > > > The process like this:
> > > > > >
> > > > > >                (CPU1)              |             (CPU2)
> > > > > >   ---------------------------------|---------------------------=
----
> > > > > >   inet_create()                    |
> > > > > >     // init clcsock to NULL        |
> > > > > >     sk =3D sk_alloc()                |
> > > > > >                                    |
> > > > > >     // unexpectedly change clcsock |
> > > > > >     inet_init_csk_locks()          |
> > > > > >                                    |
> > > > > >     // add sk to hash table        |
> > > > > >     smc_inet_init_sock()           |
> > > > > >       smc_sk_init()                |
> > > > > >         smc_hash_sk()              |
> > > > > >                                    | // traverse the hash table
> > > > > >                                    | smc_diag_dump_proto
> > > > > >                                    |   __smc_diag_dump()
> > > > > >                                    |     // visit wrong clcsock
> > > > > >                                    |     smc_diag_msg_common_fi=
ll()
> > > > > >     // alloc clcsock               |
> > > > > >     smc_create_clcsk               |
> > > > > >       sock_create_kern             |
> > > > > >
> > > > > > With CONFIG_DEBUG_LOCK_ALLOC=3Dy, the smc->clcsock is unexpecte=
dly changed
> > > > > > in inet_init_csk_locks(), because the struct smc_sock does not =
have struct
> > > > > > inet_connection_sock as the first member.
> > > > > >
> > > > > > Previous commit 60ada4fe644e ("smc: Fix various oops due to ine=
t_sock type
> > > > > > confusion.") add inet_sock as the first member of smc_sock. For=
 protocol
> > > > > > with INET_PROTOSW_ICSK, use inet_connection_sock instead of ine=
t_sock is
> > > > > > more appropriate.
> > > >
> > > > Why is INET_PROTOSW_ICSK necessary in the first place ?
> > > >
> > > > I don't see a clear reason because smc_clcsock_accept() allocates
> > > > a new sock by smc_sock_alloc() and does not use inet_accept().
> > > >
> > > > Or is there any other path where smc_sock is cast to
> > > > inet_connection_sock ?
> > >
> > > What I saw in this code was a missing protection.
> > >
> > > smc_diag_msg_common_fill() runs without socket lock being held.
> > >
> > > I was thinking of this fix, but apparently syzbot still got crashes.
> >
> > Looking at the test result,
> >
> > https://syzkaller.appspot.com/x/report.txt?x=3D15944c7c580000
> > KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead=
0000001f]
> >
> > the top half of the address is SPINLOCK_MAGIC (0xdead4ead),
> > so the type confusion mentioned in the commit message makes
> > sense to me.
> >
> > $ pahole -C inet_connection_sock vmlinux
> > struct inet_connection_sock {
> > ...
> >     struct request_sock_queue  icsk_accept_queue;    /*   992    80 */
> >
> > $ pahole -C smc_sock vmlinux
> > struct smc_sock {
> > ...
> >     struct socket *            clcsock;              /*   992     8 */
> >
> > The option is 1) let inet_init_csk_locks() init inet_connection_sock
> > or 2) avoid inet_init_csk_locks(), and I guess 2) could be better to
> > avoid potential issues in IS_ICSK branches.
> >
>
> I definitely vote to remove INET_PROTOSW_ICSK from smc.
>
> We want to reserve inet_connection_sock to TCP only, so that we can
> move fields to better
> cache friendly locations in tcp_sock hopefully for linux-6.19

Fully agreed.

Wang: please squash the revert of 6fd27ea183c2 for
INET_PROTOSW_ICSK removal.  This is for one of
IS_ICSK branches.
