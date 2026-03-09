Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D8F364936
	for <linux-s390@vger.kernel.org>; Mon,  9 Mar 2026 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041185; cv=pass; b=mwWXaEf0NbVuQB2NoDCmyUEnif0TETNz5+pJfFRJg5j6O+pZiFGRajP2+0U5uEP/WE/cwqSmS6pTt5JeIybVw5teaze/y8+7TU1KGOF8UxUq38AiQWrWC/Q6pstPF1LLqDlR/Squ7ShPZSM6HiQXkj44i7eQi94/3btC8QcpD5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041185; c=relaxed/simple;
	bh=M0URNz+sYkeBXVx2U9Q0KCsD6TVHTuFPnbncyRSfgHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvv1PdR8tkTbRABits0logumOFlkj2qofz+CIsNGK/CN8NGmVFcMfgDeGQx3rVrpng3bD3QQiI9cQoyZ2oxrwc5L/puViKSXJvF2Lp04api7Hs/LfCucTJ7xoWPgHAlqpyx8y9ZXgCsSEbp/2cHL5F8DNNou+EY7bBhc4hXfyNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8gA2hRD; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8gA2hRD"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a0d53f3d1so68063806d6.3
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2026 00:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773041183; cv=none;
        d=google.com; s=arc-20240605;
        b=CGYqQf3qY9D4RAbw7iGJgFvOIi7ACJ8/TXR6kw4XH3Ge3VigiCVs7Rg37gpttJ0MD/
         qJG2HonFbZAzBU6IbPo+8CWNwA+Cg5OkeKhLW2nDBZ+SmP4eYkoPZO1g/Kcjr70/BiDv
         6F/9R6QLsTV0F5nZ3T9NlM5hnQlcyz9kwwIZ+/VT2RX/fYmTa44GNXSTWdx27/vC3Sin
         b6etdl5CyGH9KZmoYMhxLY0OQV06qyKswysb5kKzq34SlkuwAxWTJZ2Wk4aKjyV9LLNw
         e/AGzGLStKEqC7v1+xRvJvhJRMtK0lyLcXy2hceVp6CNcFn9PlKL6wG+vQTJgmsJxcC4
         Ea2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u1ty6hSqFnrzRB3XG88cC/iwZTRE0lCfD8hBQNLJnIs=;
        fh=1l/IOVB6xbSu8O7U8XNo5sAWr4iT7N3p0Cfnb+eylcE=;
        b=Vi21ix49WgJFX6J9T4bvxe25PO97v6RxC3T29mDgoU+m2NOyVOFtoIoucvedtd4r/n
         +4iTZATccf2wSL/4VYHJsO5ErwvpN5vrQLF/7UIXfM5G9YyrFYSJBud32VgUQ0NfqkAL
         lRimBgqfqOFTlyppaGy33YjO7dn2UlKOdwPIf/0xCTEVdNAXS0qYuqwXaPxTvzAIOuv6
         C2y/1Yw2qOOAkI4xM+izqQxRO1t1LO+nv1e1lyHnSgqGrTNNvzYQyCfFkwV4DqwKjtWy
         j0WUcZyLXioACid2hHIX9YxQEV2ukPXQgCCCbZjcmH0gUMH/mmKTf1VeFRWqLs7RTlah
         AxlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773041183; x=1773645983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1ty6hSqFnrzRB3XG88cC/iwZTRE0lCfD8hBQNLJnIs=;
        b=A8gA2hRDnXgs5WrpwQi+dhzAd1zlZo1BTHX20WwOZZCcNbMBOnICESQ+Fq/yWGbA6g
         YeTcG7UcQaA09D9Mn71UzGkek0ERh2D0s6gBmJv8Hkozu1/iTJsCwdbJUIgZXFqV1yKK
         6Oem+hJgUeabaxe9lPEO4OTxyl1wSkuNb/GLmgKpt+sDc1TGpM37IY/j8jVazj/92v9X
         An3JnoNbj7JEg14eniv95GHWyhZ2OYyJT0wrlYMKEDPEHaM7JmQi81cvsiz25YR9+j13
         f2uBGSpdgR45fmVydvDkhrMQIOMvThU2waxnZ8GiK/Jgtzr+gyc80ZRsUjAmgUPNO4O4
         XCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773041183; x=1773645983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1ty6hSqFnrzRB3XG88cC/iwZTRE0lCfD8hBQNLJnIs=;
        b=vOLNVC39HR6yf0eYtmX9t1jTRTTRLo0umIXFIaLtjUZNyL7uJfBOnJfs5WvyaHxjB8
         cr48obzlu5KWuT57baSM6FY8QBruQE97M1gjAHI1ghGYkrNw2dP+pZzplHy9tLdt1gfH
         //C3SfLfnAvHuGgAmiChGzsMx63gUJRUFDMxi6sRrWsVchN+gnzHdVrPUlUQPlp9JM9z
         3rU5hNOfuuwz2G9dPQgjf8BKlwUN6vc9yZ6XzuJOIZ9pm9tOdk4xdBa3MCYvgJFLVQ8j
         MNlSS3lWq02UYDIR3zcFRdOp/GuzgWlWzCR8nTAvugLbm0pqNc/gK2Du7d/+p8gSg0GI
         FiGA==
X-Forwarded-Encrypted: i=1; AJvYcCXenZ4aCf0hGI2B/HyrPttu55pLOmGX5GWYVQ+8JXkjTN1i6mlZmiDJztB83LUIjg5DGfMAB+sE8+7e@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+JZhgWnSKN3sRlK2pAWnnybCZOxzQxYb83dCGb6yRIq/9vUSb
	G59pQDGfF7cEznRCj3vYUiTLpDF6CmwUqafaJSGwt7YIF7JN8VbpOZlThRy+56poyu0s1024zH0
	ENAq+caWUa9z2CL8pEpcys6H/TIyPG9q/LYlimJti
X-Gm-Gg: ATEYQzzfMwOVus17YE4rUUSTHm8SRl0Lm/xgbIM/yBJomfNpelTxK7PO0r8KJA+p1dS
	Iyg9JM07wQYWo0Led6nk+rODfTMqjOfk2CzH97CxyQFMCFgBjH5ayDN+o49akV2DX0TBGJRrinC
	oAN2wd3vw8kxQbyVu99m7YYa00VqGs4xW1n6JcyRzfV25+z5nyGm2+B9CN69W7Aei/LeO5NSiP4
	CYoXx5h9sGto+zomFJ2ndh7fJ8Ilzkycm2XQAMWL2m4C+Irz+QLISvpOkl+McT6Zk6Ro8Cdh0Wx
	bBk6a9w=
X-Received: by 2002:a05:6214:2aa2:b0:89a:1536:2520 with SMTP id
 6a1803df08f44-89a30a7d461mr142404526d6.26.1773041182131; Mon, 09 Mar 2026
 00:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309023846.18516-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260309023846.18516-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 08:26:11 +0100
X-Gm-Features: AaiRm50o_e6zoBfA91A7V-Gnt9-tGRqpQxxbgPA3vagSfMfB5nBzBMx_MrJn41o
Message-ID: <CANn89i+H1vuKLMrSy7M4o_=gEKroQLSz9S5pKB2DJYSdPc_BcQ@mail.gmail.com>
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

On Mon, Mar 9, 2026 at 3:38=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
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
> Fix this by using RCU and refcount_inc_not_zero() to safely
> access smc_sock. Since smc_tcp_syn_recv_sock() is called in
> the TCP three-way handshake path, taking read_lock_bh on
> sk_callback_lock is too heavy and would not survive a SYN
> flood attack. Using rcu_read_lock() is much more lightweight.
>
> - Set SOCK_RCU_FREE on the SMC listen socket so that
>   smc_sock freeing is deferred until after the RCU grace
>   period. This guarantees the memory is still valid when
>   accessed inside rcu_read_lock().
> - Use rcu_read_lock() to protect reading sk_user_data.
> - Use refcount_inc_not_zero(&smc->sk.sk_refcnt) to pin the
>   smc_sock. If the refcount has already reached zero (close
>   path completed), it returns false and we bail out safely.
>
> Note: smc_hs_congested() has a similar lockless read of
> sk_user_data without rcu_read_lock(), but it only checks for
> NULL and accesses the global smc_hs_wq, never dereferencing
> any smc_sock field, so it is not affected.
>
> Reproducer was verified with mdelay injection and smc_run,
> the issue no longer occurs with this patch applied.
>
> [1] https://syzkaller.appspot.com/bug?extid=3D827ae2bfb3a3529333e9
>
> Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@goo=
gle.com/T/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v2:
> - Use rcu_read_lock() + refcount_inc_not_zero() instead of
>   read_lock_bh(sk_callback_lock) + sock_hold(), since this
>   is the TCP handshake hot path and read_lock_bh is too
>   expensive under SYN flood.
> - Set SOCK_RCU_FREE on SMC listen socket to ensure
>   RCU-deferred freeing.

This looks better, but please note there is something missing in your
RCU implementation.

You still need to ensure s->sk_user_data is read / written with
load/store tearing prevention.
Standard rcu_dereference()/rcu_assign() are dealing with this aspect.

For instance, the following helper is assuming a lock was held :

static inline struct smc_sock *smc_clcsock_user_data(const struct sock *clc=
sk)
{
return (struct smc_sock *)
       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
}


One possible way is to use
rcu_dereference_sk_user_data()/rcu_assign_sk_user_data() or similar
helpers.


Thanks.
