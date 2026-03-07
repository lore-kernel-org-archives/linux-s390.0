Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26F3290B4
	for <linux-s390@vger.kernel.org>; Sat,  7 Mar 2026 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772855819; cv=pass; b=ekzCS0R+k8LIvaMUDi7h+M3CA64mVgidvWfIh05n6W9MqQboUskafb027qVN7Ooch4uLJg/qYbxOe1IoYBmHAXyag5ne/rltMSlxUmnIToJGdCLR4i4xjr51873OFHX2pvjsypei0GI5+JqDTIsTrhva/HBhze/r9k+pp0xeF+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772855819; c=relaxed/simple;
	bh=+YqGUeipYWqmWrLE2oeW+THGWpKHPiQu0Eq0PtmykIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCWEtUgmblZLWf1eCbEdclB1Tw/PP636oRQDjvwmHfd0kh0vGg0IlbDr6xMJA+HocRQMhX325yN1+Kr3tjL7LMc1/I1Dzqr9G977faIp/6IBTcA3P/tbG309/0viZUa2FTVplHm6GDHlg2cC9YD9WoDnn9CJQ/b737KAz1ss1f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsIWxnhp; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsIWxnhp"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899fa9610bbso100948326d6.0
        for <linux-s390@vger.kernel.org>; Fri, 06 Mar 2026 19:56:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772855817; cv=none;
        d=google.com; s=arc-20240605;
        b=OLOECEh0pbCsZep743wXTUcW1gYpcyoWPnu1P/ywO3MHuoikmhG/anw0ilbmEx10YS
         4QSJXElqDwaj4h/l3nkdgkHo+RjLCfPkMHOAASCv7H2Twx0lBNWSDJgRIMcOJ7ep6vty
         CTlNwp7lx8h5xUKh4j4/ZlUjmdqkmzwWh4k1VMjB2CrqSs+M2mAxikJtL8aekieiDpfR
         cIJwvtjHSZoWxHFItvPXkxOGCV5k1pIVldaVzbCSdMCxdYMlT6wPIdQUbZ5goVxufEzC
         /v7y+kGk4Nnab7RZxqf5WCI1qbuOKlo+7FaJId534S0GCcPTI1lDuar/5rVTiqyBmuMz
         juyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=37+f+iNxTBvZkkOYj5LNOiKZe8rFt1xADvJtvYfXxU8=;
        fh=EIz4vyMIoU7T54O9bcZGQkWyr4uP24+rtWWYce1LrbY=;
        b=fiuGXSjSfQfb6VOA79kLnnGnvTStwmcSb29nQRwb0x5BDXeCbKvH3RlCNNSYGmwgE6
         IPvA7lIFLv1SJZJVZdodDuVxfDoiZ+l8FcClNh2CSuQ5xqb/XIMBuyYJa2hM/DQiso4T
         1cjg8WMt6AVFPhM3SWCEoifybLjBOf18LZ2Dta1ghyvwoGUGjYRcMH37v0Jm2sy45g3k
         W2809K4swa1SNs8Ndipeo8JH8yB9ZqeJuIj8DtVZf+dqWqcd4YLxFCry6TdSgYVZ47OX
         81cPWs7Y+p1Fpx6iQvN/4AbEtBRfjdpV4s4sWtAaW/KvlMLH6A33g3PPKniIntmAFcyz
         sCuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772855817; x=1773460617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37+f+iNxTBvZkkOYj5LNOiKZe8rFt1xADvJtvYfXxU8=;
        b=dsIWxnhpN0EAXPrukZSZ73phlOmE+r3Qhs2dhlQfOjw7axbBNQDEKaF6iiN3ZJVLSH
         L3EDpZjsmRw9+5R/uWfsrkN+B7K39mZ4Brwi8GsliM3XE4wDicSqf7uiqAno8Fyo91En
         gDJZhgBJYMEmTWGHWd0Ty1Mc1Z/YEg8uDvmmBe2iNCBKjQOWgSQfuFhrQbFANIJpNUXb
         srkPKgsyYVlkk177dc7Wnv4QbGuYMf6lQJ3oxf+6xabFsurrdGXD/CvyCTnf3MSTW5pi
         IO8A1CW6fKVULJhnuq29fDHVLBvDML0tqawGma/1sRK4SpRuGQgxiLfTDDi8CpEHHMJa
         bLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772855817; x=1773460617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37+f+iNxTBvZkkOYj5LNOiKZe8rFt1xADvJtvYfXxU8=;
        b=JUAO24YlLlR8b/gNJbklVAM5NhfCA5VLfCLhKk99H1wq0N1jquyloC3Q8o7kRBLY71
         BYnrbkN4KAK1ef84VOI2hR05V9fzqU6jgjLifCCajmTb2k9BVW9PMjgnix9KazQ9L/Ud
         CEa/lf9uYC/sMYqHi+EJMvUXRSKR/6vAQCk4bps7HcCCSTYmjEK1FFeBR5ofFamMYDJX
         tkkEgRJ/lugDIhbhhGBeK0JqTI+X3KnyMb77fnxF/rBamjHmpUbEFq3AkR7pl2G/qkT6
         vsaB/yFTlNYjRnz1bcMbDp5eWDZnDRrveXS4T2yOYmM3dyRgMhIeZDD17Xn25ypDAU75
         1pDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqT6ur7V+RSBSF6P5KecUajOVnmF40XjhAcnOaCSZblzAJ6ioxomWV5WHHn47GspASjjAaSqGzov/F@vger.kernel.org
X-Gm-Message-State: AOJu0YwB82LbZvPRKUKqwBkJ5m3PDCTj2xs9a/fIGAF5vn5MJn8+WoSW
	MVGHec1TLpxCuMf1+Ms0mfYRLxnqgzJ7XxQhAybxcnwNFk+R+7eXOYLsaQym7Oili8pNqLBtPKe
	77hmzqW+pfArCkX8m8wwOXph7cn6pbKVGjoqC99n2
X-Gm-Gg: ATEYQzzBEheRy+ms8hinwgNfb5hFOyLt+mcoxDP6icqEGFQK/XMuzJMou3YFpUufRmO
	vcqr6Y/KmDy5IQIF7MlMhr2FUu3FUOdibOq7oZaV5ImH0Vy09nlzl85pgWwReo2GkIgvOu56wWG
	DxCjxba2MAtDRPijJsRRGcXbZcICOai7ZcwZNOBGP2Av5VjNoSFm6rBja6sUlhEuZr09/GC+mDk
	X1M7heenL4RxGBTh89KreGPe5qP2kKLHNPHm4cdvBFkioZdRJsJnfsuYpcfWAZj+DTbe68XFVBC
	kInq8fbj
X-Received: by 2002:a05:6214:c6d:b0:899:f6a0:7a6e with SMTP id
 6a1803df08f44-89a30a1751dmr64828556d6.9.1772855816216; Fri, 06 Mar 2026
 19:56:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307032158.372165-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260307032158.372165-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 7 Mar 2026 04:56:45 +0100
X-Gm-Features: AaiRm51ElVeY3JClqi6sIJpTbU0I15M_lz5ZJaTnV56OEn-A2dcPlGYd14B54AI
Message-ID: <CANn89iJ0V6un1un7zjG-J9d4EJQOjTO37s3EQUKTodwPWsXhFQ@mail.gmail.com>
Subject: Re: [PATCH net v1] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, 
	syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 4:22=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> Syzkaller reported a panic in smc_tcp_syn_recv_sock() [1].
>
> smc_tcp_syn_recv_sock() is called in the TCP receive path
> (softirq) via icsk_af_ops->syn_recv_sock on the clcsock (TCP
> listening socket). It reads sk_user_data to get the smc_sock
> pointer. However, when the SMC listen socket is being closed
> concurrently, smc_close_active() sets clcsock->sk_user_data
> to NULL under sk_callback_lock, and then the smc_sock itself
> can be freed via sock_put() in smc_release().
>
> This leads to two issues:
>
> 1) NULL pointer dereference: sk_user_data is NULL when
>    accessed.
> 2) Use-after-free: sk_user_data is read as non-NULL, but the
>    smc_sock is freed before its fields (e.g., queued_smc_hs,
>    ori_af_ops) are accessed.
>
> The race window looks like this:
>
>   CPU A (softirq)              CPU B (process ctx)
>
>   tcp_v4_rcv()
>     TCP_NEW_SYN_RECV:
>     sk =3D req->rsk_listener
>     sock_hold(sk)
>     /* No lock on listener */
>                                smc_close_active():
>                                  write_lock_bh(cb_lock)
>                                  sk_user_data =3D NULL
>                                  write_unlock_bh(cb_lock)
>                                  ...
>                                  smc_clcsock_release()
>                                  sock_put(smc->sk) x2
>                                    -> smc_sock freed!
>     tcp_check_req()
>       smc_tcp_syn_recv_sock():
>         smc =3D user_data(sk)
>           -> NULL or dangling
>         smc->queued_smc_hs
>           -> crash!
>
> Note that the clcsock and smc_sock are two independent objects
> with separate refcounts. TCP stack holds a reference on the
> clcsock, which keeps it alive, but this does NOT prevent the
> smc_sock from being freed.
>
> Fix this by taking sk_callback_lock to read sk_user_data and
> then sock_hold(&smc->sk) under the lock to pin the smc_sock.
> The lock is released immediately after sock_hold(), rather
> than being held for the entire function, to avoid holding it
> across ori_af_ops->syn_recv_sock() which creates child
> sockets and could risk deadlocks with nested lock ordering.
> sock_put(&smc->sk) is called on all exit paths after the
> hold.
>
> [1] https://syzkaller.appspot.com/bug?extid=3D827ae2bfb3a3529333e9
>
> Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@goo=
gle.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/smc/af_smc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index d0119afcc6a1..21218b9b0f9a 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -131,7 +131,14 @@ static struct sock *smc_tcp_syn_recv_sock(const stru=
ct sock *sk,
>         struct smc_sock *smc;
>         struct sock *child;
>
> +       read_lock_bh(&((struct sock *)sk)->sk_callback_lock);

This will not survive a SYN flood attack.

Please use RCU instead.

>         smc =3D smc_clcsock_user_data(sk);
> +       if (!smc) {
> +               read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
> +               return NULL;
> +       }
> +       sock_hold(&smc->sk);

If you must take a refcount, use

if (!refcount_inc_not_zero(&smc->sk->sk_refcnt)) {
  rcu_read_unlock();
   return NULL;
}


> +       read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
>
>         if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_=
hs) >
>                                 sk->sk_max_ack_backlog)
> @@ -153,11 +160,13 @@ static struct sock *smc_tcp_syn_recv_sock(const str=
uct sock *sk,
>                 if (inet_csk(child)->icsk_af_ops =3D=3D inet_csk(sk)->ics=
k_af_ops)
>                         inet_csk(child)->icsk_af_ops =3D smc->ori_af_ops;
>         }
> +       sock_put(&smc->sk);
>         return child;
>
>  drop:
>         dst_release(dst);
>         tcp_listendrop(sk);
> +       sock_put(&smc->sk);
>         return NULL;
>  }
>
> --
> 2.43.0
>
