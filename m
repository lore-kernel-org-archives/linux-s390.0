Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B9366834
	for <linux-s390@vger.kernel.org>; Mon,  9 Mar 2026 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041782; cv=pass; b=Ti+q1J4PM7Wd+TGHrJ63NHowrKMk6YDd7jEwUVrnBCiODKFEcdwIP4P3di8Ofpzxus+H/UKp5cpwdYjCPcUyijvnUjHJ0qK4zsDPdxCIM/uRzZyRtSvbOFM/TUm/UXpMCCnL+Kphn4ONPx7JYLL6EkTTkR3UrDbIsZC7VTwhq+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041782; c=relaxed/simple;
	bh=gLdR85XoXK1+V6PspFbqCeowMRNNlR6JeEo4Cy/vyS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAOBO+R+h+cXspKN3bFjRsxg+Cf4CyJu14HmalmyOxzvskT5DFVv7lACulMdt3owsibAUFqAeIIWGJL+rQ3OCJ+v1mQ3/6u48n3S4vJoR4vDXy62Db1SvaCxaUNo6uKEyXVdAXTNUQSDD0n3jwzxxigUkuIiRikvLd5YyyokKP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nsK0VKvM; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsK0VKvM"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899f8c33c11so74742546d6.1
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2026 00:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773041779; cv=none;
        d=google.com; s=arc-20240605;
        b=gWzIeakn2zO9x9mO+e3lZl3G/99CBGPpwLOc+9XLfxufTDXqU/DnSnRbHSCMGSpEt9
         xxD1XhUHe4n+bi0nu9mGoxZpnnOXN45erwdPxwNXi3sXFBguM4PRkhCh5anSpoFjGyoJ
         Mpz+qffCe8sypZkSQ4sApt3YSFTPlxGcgcsXQP9Xv+SsQXsEpUwlj1ifQT3i8B5xDWmJ
         mtKe101S40sVKdele84YprLgbQcfcG6KsMuhMVH10rKBZZBSVk3fgaFl2AHcU65WkY/m
         6Nry9vawcRvxn7VIL4O2vwcCiOJIbCVONpRM5X/HyP4PYs5a0dQfUbzMbqyfG9Tb1Xjw
         VC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FStRxtJV9pnniib6nEIUXEXFXS20x8+8nz4KKWUw55Q=;
        fh=LmArKNUiln3VaZYmUSdPiuhDng+erQLJnhP7supq+4k=;
        b=QFGS2q0YMRGuyo0r2XeTo6azYYyorkYWBJ5spig3t/AITttkxuoP8SamMSSJjvhJFN
         WK7Ukig0jYNRSu5keQ21j5r62qtU+aWRgXA/XqIeoKxAYbVrkr8XqgAYlxstthTfYwHd
         vSQNwjY9Ica6VNU8KVhkw5dku1QZuw/FqZKIgzc9MoDk2ncrinJRocDoETHIooYC6Vld
         PJx1dLR/R9eIihb5GkonSnyUtdaiL5cGPJ0IScJYa7RsNFyBL6I6Bc6As5cyuXm5mGEN
         ipS98l33fgjJCcu8XwCqppVuErBuT6zuVC5UyHQEL1XisiSLoGyksegXmkYv5sTVUbTk
         PJTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773041779; x=1773646579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FStRxtJV9pnniib6nEIUXEXFXS20x8+8nz4KKWUw55Q=;
        b=nsK0VKvMACI4TCX1POcFNh6R4NWzEFM39Q9WSt9KMNHe4TpGkGVMY2NaWa3VaxrJXj
         +qHbtG5Og4+iHhUmLHb47u0Vcv7RWKJo9DvXRY6GutrBPFmqjzr2EcvynzySCrLE4PoD
         TbpJY2ifvRX0KTq4bV/R6rvModr1rtvczgMfL2LPblEBhI4qy8zJfK/ehW99m8MaBhmm
         OH2RK2VBvLJcS5jxYrJZwJApB0Ka/38HN3hBYbdZu+j4XhlAT8DX0hA6zH7bDcWyadUz
         UXPOzKBBxXlGOfgy/binhHlKDRRgdnCFq4igrQsqXma4+LZLoSjmGb4o0aWl4UHEHoV/
         L7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773041779; x=1773646579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FStRxtJV9pnniib6nEIUXEXFXS20x8+8nz4KKWUw55Q=;
        b=aGk5ED5AQy8+2p+2e702RHaCmQCYrsCyWOWzRxP8TPqmkxa/+Oo/r5tdccuTAh0M1F
         UJWdFZThC8XGyEmPilHV8auKnJAfZwKiAS90s5jUkMR/NdzSjwTyqisT54qQq39mQ0nF
         Rz+yUj8oyzC6mPialbS11yh5N+xwkDHQuxsNS1jZsfITptfV6H8fcl7NL5p1ferSyVFE
         eAircJKFM85PBL2ZwaRBo/V/UVmlLg/DhSFnSSJH5PHU8Cb3Y76S8d6tNEvQG7S9rRTt
         NhUBPAm3zlUb+Fuw3h0gwzHVmYjr01NdzH1nTY1By33+q7n2fSzbdl8vXBh4bn1n1dL9
         IdCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoegKm5Ftr3dr++oAHgpk0CXZ7GS5xdsjuol5Dy8FK2rLXmkSvVtIQqsmpnLB9F53WBCi9b+qOHU6Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ANH8Y9A7gJSkleYobdbMy/hPh3VkFe0Y5Xn0xEz+ZzCVNifg
	LZidejYZ9icGMcjsFLg4WUI1IXyJInByTFuN/D1EY1JX+ki92hOgPMbDvoDvBIgx7ICzU7F8miu
	KikO8kbFzU5UC8YSCI2N8il9/QEzRgtqisVZVfb3a
X-Gm-Gg: ATEYQzx58Yg63psT3mtfuqpWS5qNgY5S4ESV8QNNdjmPaZIyBxsd7tjz0/YNOrKTvW3
	mqP9vkh4WJQm20SR5ANAUNpGmwhrUQ4vEwqgFa5uuzXb/Vx9OHhA9KAG1c1Td8RUE3YezMVrB7R
	ic5C/AVO3U4zefLxaUkTnJeTWccy56ZDJnEJ1nyWpaMOWhNIKteIOOLtCc5na4xkGVEmFrYmWWp
	uN2OtD/bRZk/xp39VQ6r6k7VKxkEjyAdsbvYmod2L8N9TisGM2D4UCdnrf4tVgNYgZHPiPvyY6/
	5qamf90=
X-Received: by 2002:a05:6214:5096:b0:89a:9f9:246e with SMTP id
 6a1803df08f44-89a30af16d8mr149648356d6.45.1773041778736; Mon, 09 Mar 2026
 00:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309023846.18516-1-jiayuan.chen@linux.dev> <CANn89i+H1vuKLMrSy7M4o_=gEKroQLSz9S5pKB2DJYSdPc_BcQ@mail.gmail.com>
In-Reply-To: <CANn89i+H1vuKLMrSy7M4o_=gEKroQLSz9S5pKB2DJYSdPc_BcQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 08:36:07 +0100
X-Gm-Features: AaiRm50tYUA2hHcgBtFj8-LfrpmhaFVmNtJKvZNcOrXthEiN65UptVLRtBVFszs
Message-ID: <CANn89iJawS4rcitF77D=YXAw8SY8TrPtKz6xVfwm_xZ5sBHPcw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
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

On Mon, Mar 9, 2026 at 8:26=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Mar 9, 2026 at 3:38=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
> >
> > Syzkaller reported a panic in smc_tcp_syn_recv_sock() [1].
> >
> > smc_tcp_syn_recv_sock() is called in the TCP receive path
> > (softirq) via icsk_af_ops->syn_recv_sock on the clcsock (TCP
> > listening socket). It reads sk_user_data to get the smc_sock
> > pointer. However, when the SMC listen socket is being closed
> > concurrently, smc_close_active() sets clcsock->sk_user_data
> > to NULL under sk_callback_lock, and then the smc_sock itself
> > can be freed via sock_put() in smc_release().
> >
> > This leads to two issues:
> >
> > 1) NULL pointer dereference: sk_user_data is NULL when
> >    accessed.
> > 2) Use-after-free: sk_user_data is read as non-NULL, but the
> >    smc_sock is freed before its fields (e.g., queued_smc_hs,
> >    ori_af_ops) are accessed.
> >
> > The race window looks like this:
> >
> >   CPU A (softirq)              CPU B (process ctx)
> >
> >   tcp_v4_rcv()
> >     TCP_NEW_SYN_RECV:
> >     sk =3D req->rsk_listener
> >     sock_hold(sk)
> >     /* No lock on listener */
> >                                smc_close_active():
> >                                  write_lock_bh(cb_lock)
> >                                  sk_user_data =3D NULL
> >                                  write_unlock_bh(cb_lock)
> >                                  ...
> >                                  smc_clcsock_release()
> >                                  sock_put(smc->sk) x2
> >                                    -> smc_sock freed!
> >     tcp_check_req()
> >       smc_tcp_syn_recv_sock():
> >         smc =3D user_data(sk)
> >           -> NULL or dangling
> >         smc->queued_smc_hs
> >           -> crash!
> >
> > Note that the clcsock and smc_sock are two independent objects
> > with separate refcounts. TCP stack holds a reference on the
> > clcsock, which keeps it alive, but this does NOT prevent the
> > smc_sock from being freed.
> >
> > Fix this by using RCU and refcount_inc_not_zero() to safely
> > access smc_sock. Since smc_tcp_syn_recv_sock() is called in
> > the TCP three-way handshake path, taking read_lock_bh on
> > sk_callback_lock is too heavy and would not survive a SYN
> > flood attack. Using rcu_read_lock() is much more lightweight.
> >
> > - Set SOCK_RCU_FREE on the SMC listen socket so that
> >   smc_sock freeing is deferred until after the RCU grace
> >   period. This guarantees the memory is still valid when
> >   accessed inside rcu_read_lock().
> > - Use rcu_read_lock() to protect reading sk_user_data.
> > - Use refcount_inc_not_zero(&smc->sk.sk_refcnt) to pin the
> >   smc_sock. If the refcount has already reached zero (close
> >   path completed), it returns false and we bail out safely.
> >
> > Note: smc_hs_congested() has a similar lockless read of
> > sk_user_data without rcu_read_lock(), but it only checks for
> > NULL and accesses the global smc_hs_wq, never dereferencing
> > any smc_sock field, so it is not affected.
> >
> > Reproducer was verified with mdelay injection and smc_run,
> > the issue no longer occurs with this patch applied.
> >
> > [1] https://syzkaller.appspot.com/bug?extid=3D827ae2bfb3a3529333e9
> >
> > Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> > Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@g=
oogle.com/T/
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > ---
> > v2:
> > - Use rcu_read_lock() + refcount_inc_not_zero() instead of
> >   read_lock_bh(sk_callback_lock) + sock_hold(), since this
> >   is the TCP handshake hot path and read_lock_bh is too
> >   expensive under SYN flood.
> > - Set SOCK_RCU_FREE on SMC listen socket to ensure
> >   RCU-deferred freeing.
>
> This looks better, but please note there is something missing in your
> RCU implementation.
>
> You still need to ensure s->sk_user_data is read / written with
> load/store tearing prevention.
> Standard rcu_dereference()/rcu_assign() are dealing with this aspect.
>
> For instance, the following helper is assuming a lock was held :
>
> static inline struct smc_sock *smc_clcsock_user_data(const struct sock *c=
lcsk)
> {
> return (struct smc_sock *)
>        ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
> }
>
>
> One possible way is to use
> rcu_dereference_sk_user_data()/rcu_assign_sk_user_data() or similar
> helpers.
>

More context in this old commit

commit 559835ea7292e2f09304d81eda16f4209433245e
Author: Pravin B Shelar <pshelar@nicira.com>
Date:   Tue Sep 24 10:25:40 2013 -0700

    vxlan: Use RCU apis to access sk_user_data.

    Use of RCU api makes vxlan code easier to understand.  It also
    fixes bug due to missing ACCESS_ONCE() on sk_user_data dereference.
    In rare case without ACCESS_ONCE() compiler might omit vs on
    sk_user_data dereference.
    Compiler can use vs as alias for sk->sk_user_data, resulting in
    multiple sk_user_data dereference in rcu read context which
    could change.

    CC: Jesse Gross <jesse@nicira.com>
    Signed-off-by: Pravin B Shelar <pshelar@nicira.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>
