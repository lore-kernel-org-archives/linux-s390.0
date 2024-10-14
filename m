Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5616233C9;
	Mon, 14 Oct 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887471; cv=none; b=Go7u3xxSfH32/Clcl2BYY0VKbwubs9nRlUVWRjb9Q+6bztfe/xvMACFkywYmcGaK8Asi2erg9sQ/6FRkR8hCyrEyEyF2LWdjkp1lXhhetiqAHmKDmHYSLpQajNfKbSJy71z6YKs+Uk3vVYpuRvQarr62T9dX4PV4mgLZWiAk6Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887471; c=relaxed/simple;
	bh=2iVA8og+Znq5XoxQN0K0qs/uEy4/poo8Xb+g9fzrF44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5ZFbkyad5OdKj+KEjG4LiNRo8RCHKX1qA7Sf0mRrWFaTl8YEJ/1AUHuckyzlDPBuXjdWxuTYkKiqBRRc1T+DJcxsCoVqNtsZnaG0Jcgurb76w19sOxTm24KECzs7MyKUDiS+Lo46UXXWIoo2NGxfF8ge3dud0WdP8uvTPVZShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD5JQmZ5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD5JQmZ5"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e314136467so33267387b3.0;
        Sun, 13 Oct 2024 23:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728887468; x=1729492268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scvH+wQ9oK4DVljmMl6t02Jt9RrS6mbubZ45OO3GOXw=;
        b=LD5JQmZ5VDSGUcB6ms6mxOrNmVeP0ypX9CjTF9LnHHOiuYyEVeDdByZqHGw3W04+IG
         FUjBvC4S+vfPAHQyMXa05F94NjS8ZFDdPLPsOPLAFYRxILJNLO0aTXBM/lTi3LGhzSHj
         sx8N0WYksBrAQv8+Pk+DF6ohioAGM6bLcT+pveVywPV4bCXbsUteLrsgBgftza57akcm
         4H2qcC5HgjnEPlFnTP8nfCJ34sZOLwqEHJvICuGCShRvCfnoCE01l0/Xg/awnMytLVYp
         gYDICBVRrgPf8W2Kv1LSVCR3LXnDjHoFSQFhnX/fNrh93sZI5SGAvTQNJD6gLER8Zfzf
         mlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728887468; x=1729492268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scvH+wQ9oK4DVljmMl6t02Jt9RrS6mbubZ45OO3GOXw=;
        b=D+Vpx0/A+vM/Qfhw0QDCre5GSg0bFs8P0ag9RdaHTjLR4dDmNWvibdk4I2Is0q5FZJ
         yeR8f4TbN1k724oTbpaxjGn+5yeHiPn3D4Ipy6jJAvOfmOJh3mV5PXslxotrCEvUoL2v
         mL4js1n/HQd2W342xsJgcjrEd03M+YGp+CKTIIbq/sNjJw6WpxJsih5TMQEfljtcrZWP
         0Sy3KFIUwpQKd8G579MmUlP4TPXG5GmH0AIW1chEH1XkeWwSwdiS5zn7L6wfuV8OE8dE
         /FUohCPqEyfujk96pCsz0rifkxmghMG5ze2/okNIIOF6hicwOUZFncN9zKGHj1TnaSOR
         68uQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6jF9SJpwx1FHeL7EAwITRrrH94gJHlnN+W3FY7F7DvNDfmgIleAVUiP2tZdGGxF+Ggomc5vku@vger.kernel.org, AJvYcCVgId2jglKNSx1+3jdbS/klzAuDsF8Lp7mwF1IUZRNdfXnXN5mHjkaoEFG7IcfkyKfqmPZ0w15TXIwt2w==@vger.kernel.org, AJvYcCXENNrV+ZB8sO81F6eKfYv45mEb7W9dn3N+2em86bteY7mnIhLO+1GuqIyI0+nb6YmM0fXiZ3FN7A6y2QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvmDEpChCUKVaAqYDQowSwtR8GVVNgwQLYlUDDXBZ2NtrA6VmV
	HlGtS8JQYBFCQBu8SEBMon0oxysxwinZF2xuocu+w3cVHldJeAHjYh6Rjp3LJk2szhvZYBD00UW
	3vQTDFERZNu7a6h5Zzeq+xOe99Ms=
X-Google-Smtp-Source: AGHT+IEwjFpe3Nw6Ev4sqyc5/u+WpT76m4BnTAmhvDkxzoKZiqPG/k5DwmBK5Ulu80FSHLUqW55giftKWPPw17D80Nc=
X-Received: by 2002:a05:690c:3010:b0:64b:1eb2:3dd4 with SMTP id
 00721157ae682-6e344c2978dmr52922357b3.8.1728887468194; Sun, 13 Oct 2024
 23:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005045411.118720-1-danielyangkang@gmail.com>
 <CANn89iKk8TOvzD4cAanACtD0-x2pciEoSJbk9mF97wxNzxmUCg@mail.gmail.com>
 <CAGiJo8RCXp8MqTPcPY4vyQAJCMhOStSApZzA5RcTq5BJgzXoeQ@mail.gmail.com> <36b455d7-a743-47c7-928c-e62146a12b9c@linux.alibaba.com>
In-Reply-To: <36b455d7-a743-47c7-928c-e62146a12b9c@linux.alibaba.com>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Sun, 13 Oct 2024 23:30:32 -0700
Message-ID: <CAGiJo8Qv6xbBDZSCmMs=o11Lbxfi0ni1JB5Jx_bxqaYV1cP2Uw@mail.gmail.com>
Subject: Re: [PATCH v2] resolve gtp possible deadlock warning
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Eric Dumazet <edumazet@google.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Jan Karcher <jaka@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 12:20=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
>
>
> On 10/7/24 2:54 PM, Daniel Yang wrote:
> > On Sat, Oct 5, 2024 at 12:25=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> >>
> >> On Sat, Oct 5, 2024 at 6:54=E2=80=AFAM Daniel Yang <danielyangkang@gma=
il.com> wrote:
> >>>
> >>> Fixes deadlock described in this bug:
> >>> https://syzkaller.appspot.com/bug?extid=3De953a8f3071f5c0a28fd.
> >>> Specific crash report here:
> >>> https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D14670e079800=
00.
> >>>
> >>> This bug is a false positive lockdep warning since gtp and smc use
> >>> completely different socket protocols.
> >>>
> >>> Lockdep thinks that lock_sock() in smc will deadlock with gtp's
> >>> lock_sock() acquisition. Adding a function that initializes lockdep
> >>> labels for smc socks resolved the false positives in lockdep upon
> >>> testing. Since smc uses AF_SMC and SOCKSTREAM, two labels are created=
 to
> >>> distinguish between proper smc socks and non smc socks incorrectly
> >>> input into the function.
> >>>
> >>> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> >>> Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
> >>> ---
> >>> v1->v2: Add lockdep annotations instead of changing locking order
> >>>   net/smc/af_smc.c | 21 +++++++++++++++++++++
> >>>   1 file changed, 21 insertions(+)
> >>>
> >>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> >>> index 0316217b7..4de70bfd5 100644
> >>> --- a/net/smc/af_smc.c
> >>> +++ b/net/smc/af_smc.c
> >>> @@ -16,6 +16,8 @@
> >>>    *              based on prototype from Frank Blaschka
> >>>    */
> >>>
> >>> +#include "linux/lockdep_types.h"
> >>> +#include "linux/socket.h"
> >>>   #define KMSG_COMPONENT "smc"
> >>>   #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> >>>
> >>> @@ -2755,6 +2757,24 @@ int smc_getname(struct socket *sock, struct so=
ckaddr *addr,
> >>>          return smc->clcsock->ops->getname(smc->clcsock, addr, peer);
> >>>   }
> >>>
> >>> +static struct lock_class_key smc_slock_key[2];
> >>> +static struct lock_class_key smc_key[2];
> >>> +
> >>> +static inline void smc_sock_lock_init(struct sock *sk)
> >>> +{
> >>> +       bool is_smc =3D (sk->sk_family =3D=3D AF_SMC) && sk_is_tcp(sk=
);
> >>> +
> >>> +       sock_lock_init_class_and_name(sk,
> >>> +                                     is_smc ?
> >>> +                                     "smc_lock-AF_SMC_SOCKSTREAM" :
> >>> +                                     "smc_lock-INVALID",
> >>> +                                     &smc_slock_key[is_smc],
> >>> +                                     is_smc ?
> >>> +                                     "smc_sk_lock-AF_SMC_SOCKSTREAM"=
 :
> >>> +                                     "smc_sk_lock-INVALID",
> >>> +                                     &smc_key[is_smc]);
> >>> +}
> >>> +
> >>>   int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len=
)
> >>>   {
> >>>          struct sock *sk =3D sock->sk;
> >>> @@ -2762,6 +2782,7 @@ int smc_sendmsg(struct socket *sock, struct msg=
hdr *msg, size_t len)
> >>>          int rc;
> >>>
> >>>          smc =3D smc_sk(sk);
> >>> +       smc_sock_lock_init(sk);
> >>>          lock_sock(sk);
> >>>
> >>>          /* SMC does not support connect with fastopen */
> >>> --
> >>> 2.39.2
> >>>
> >>
> >> sock_lock_init_class_and_name() is not meant to be repeatedly called,
> >> from sendmsg()
> >>
> >> Find a way to do this once, perhaps in smc_create_clcsk(), but I will
> >> let SMC experts chime in.
> >
> > So I tried putting the lockdep annotations in smc_create_clcsk() as
> > well as smc_sock_alloc() and they both fail to remove the false
> > positive but putting the annotations in smc_sendmsg() gets rid of
> > them. I put some print statements in the functions to see the
> > addresses of the socks.
> >
> > [   78.121827][ T8326] smc: smc_create_clcsk clcsk_addr: ffffc90007f0fd=
20
> > [   78.122436][ T8326] smc: sendmsg sk_addr: ffffc90007f0fa88
> > [   78.126907][ T8326] smc: __smc_create input_param clcsock: 000000000=
0000000
> > [   78.134395][ T8326] smc: smc_sock_alloc sk_addr: ffffc90007f0fd70
> > [   78.136679][ T8326] smc: smc_create_clcsk clcsk_clcsk: ffffc90007f0f=
d70
> >
> > It appears that none of the smc allocation methods are called, so
> > where else exactly could the sock used in sendmsg be created?
>
>
> I think the problem you described can be solved through
> https://lore.kernel.org/netdev/20240912000446.1025844-1-xiyou.wangcong@gm=
ail.com/, but Cong Wang
> seems to have given up on following up at the moment. If you are interest=
ed, you can try take on
> this problem.
>
>
> Additionally, if you want to make sock_lock_init_class_and_name as a solu=
tion, the correct approach
> might be (But I do not recommend doing so. I still hope to maintain consi=
stency between IPPROTO_SMC
> and other inet implementations as much as possible.)
>
>
> +static struct lock_class_key smc_slock_keys[2];
> +static struct lock_class_key smc_keys[2];
> +
>   static int smc_inet_init_sock(struct sock *sk)
>   {
>          struct net *net =3D sock_net(sk);
> +       int rc;
>
>          /* init common smc sock */
>          smc_sk_init(net, sk, IPPROTO_SMC);
>          /* create clcsock */
> -       return smc_create_clcsk(net, sk, sk->sk_family);
> +       rc =3D smc_create_clcsk(net, sk, sk->sk_family);
> +       if (rc)
> +               return rc;
> +
> +       switch (sk->sk_family) {
> +       case AF_INET:
> +               sock_lock_init_class_and_name(sk, "slock-AF_INET-SMC",
> +                                             &smc_slock_keys[0],
> +                                             "sk_lock-AF_INET-SMC",
> +                                             &smc_keys[0]);
> +               break;
> +       case AF_INET6:
> +               sock_lock_init_class_and_name(sk, "slock-AF_INET6-SMC",
> +                                             &smc_slock_keys[1],
> +                                             "sk_lock-AF_INET6-SMC",
> +                                             &smc_keys[1]);
> +               break;
> +       default:
> +               WARN_ON_ONCE(1);
> +       }
> +
> +       return 0;
>   }
>
>

I took a look at Cong Wang's patches and it seems that switching from
rtnl to rcu is unfeasible since gtp_encap_enable_socket is called by
rtnl_newlink_create through a function pointer and the rtnl_mutex
acquisition happens somewhere up the call stack. Since many other
newlink() functions rely on the assumption of rtnl lock being
acquired, it seems quite unfeasible to use this approach in this case.
I tried your suggested solution and it got rid of the bug. I made
small changes to it for readability and will resend it. Should lockdep
annotations also be added to smc_sock_alloc since smc_sk_init() is
also called there as well or is it guaranteed to have non-conflicting
lockdep labels?
