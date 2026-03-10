Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327EE3B47CE
	for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2026 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144830; cv=pass; b=qnJ3CeywOUxql3z1pBWrCeV9iwCZ2BzlRYX49UWetHgKvIGFM5Bq91tFYDCiNOBRXYbDfgnZc8VBYDCcWwVCwNaKcWepbSxAUIHh7TIq3+KQBHWIxuoEd9kBlccYQa9lCQeoV8EBu76jLnkEaAP/204HnCbMqxyl4uDgDLoqAgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144830; c=relaxed/simple;
	bh=oBWHWl4oFG4ctqngCJNsL2W/w/X/y+8sHCgAIJblmFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwSoXUm2IfQFULTw2DM10aqvnw489Zh+2hS5aDMa5KVaSfCuIC+fl3kjqqavjJv0XEmUeNwyC+cXr4edIEBnOoels1q3ANqNQND9xr1NPhKYEzIPYgiyN6fWsdPpTAmewcUhD6qHGisjMaDJKX6NcjC9kkv6pFumcDErgPYV8v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qf6uGOi7; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qf6uGOi7"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899f79df682so97474366d6.2
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2026 05:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773144828; cv=none;
        d=google.com; s=arc-20240605;
        b=INsEBHHb0/c1/qhaFDDuVPnGRJ2815/EduUjRnGvuYqUvk/TGPnZQYs5O4ojhKcKqT
         FgDJFkSKxUvItQ+gWQhQMPOXXAa8iwAKzNgTq0V8fSmhgMXZeP/OPejU+G9QxFIrzlT3
         pi0A8mdim9IQJmpInRxiD3JxVI/z6lOpBeAfI6E0p7aOAj1zYOyGbhRK2G8vUxQIQ4vh
         K+bbrS45a5gl6qwAuJ1ttxpmxKfUC06tY9jRNjdv3nOk7b9TH0RoFm9wApTmDWJt0Dpr
         N7BrW+yqrjwJJwuTf4PfWVw4gCt4Kw+0EQjc31mAxmhYhq7JuATGTuw0FKTt41i0NK7s
         Sq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aNlD1VnwwuWUuVdK0r+JEQho3gk9Img94yEEgNc2T2Y=;
        fh=5e+xmaVoxq8foqvK9NlYI6dESuo87jX1aE3453zFwos=;
        b=W/6iy4zwYl8q8ez3GeR0KCKzygPJPasecNI8gUPmwzkE19xoxN9dBACOfBxuP6jRTL
         bXIzZ2O49/j0TI6JYLPCAN9XMVquL35yNKd/20jYNZceuN1B2l7wVitd+u/vIveqPtF1
         jTWA/0aHvy9OW1n8zQQcklJWmU4u290AE39BoNea155EdYEecTUPBqV6sQiUnaf0rh6D
         hYLdZwzDseKhbetCjG8BBLWqMrOqdGy55vmMkACijKavRgeALVt0O1WALLsi34yXMR0i
         EssRkCJZeSn5Dko10pKC6bldKkn+a9XsfrCTu+aPp/x6sYaVAE7EzDXdT8UyKlG/TvHP
         uINQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773144828; x=1773749628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNlD1VnwwuWUuVdK0r+JEQho3gk9Img94yEEgNc2T2Y=;
        b=Qf6uGOi7YDhTAg2wqxZ2yfGHJ4hzAHx8ToJNEw3pxlLhDTBJbvjvysxSb7Z7xPwoko
         V12L0oqtIM23astGiRTGta2bljIhDOuSI15VR3mN0qN14HcAWhni34g6E09MApOPR5q7
         oAaaAMBDGNoYYMxAlZqPl1gRS6xl4isMN44PcNxmagXTeMC8jpNjYaXK3n/hnLthiTwE
         U+XACYDeQyVL/NypQuRjBhLmAUaWxeCmZmpoRAUT0gQYsIFsayo0jHH8OLt2Nzhg9/g9
         v4jIZwG1WKVlAStQWkO1QmpeCo3arE63uTEUoCV2eeag8nqtLbvyeiD6RQhOmL5XxUJQ
         HY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144828; x=1773749628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aNlD1VnwwuWUuVdK0r+JEQho3gk9Img94yEEgNc2T2Y=;
        b=JpMRfKKXeMcrNp/Ef96bWPQLNXpAEvmS71PtS2bR5mtdCSXfWFzZ/0AlyzIGR58OlB
         gmHNk5nRqqqkO+xw0BA/Gdnzh8QQe+j2BuNTzxWOzHqHEP6J4fEc3zuP/KZF/5c2ZRbq
         Du0iZkOqHAqaoTzcu3QXpaoHJHk/ChGqVs0jRX8YlqpIO3OVVtfm82E/Gx/pOGrhTOqO
         E0Fp1mRTG+C7NjCmNCZx4noB76FKiv6LD6Gn7nqOrJgm8coMtApiw/tLnI1CmVL/ToF9
         kLAwFV1O7HuKTcD/jDGtCKI57h1bK+ZPCiPD3hcoa3cSlD315OdsFa9bsZeUBzpgwJKU
         mqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnLxbc+MncvI2U/Ie1zjgYXWFRZsfpMtCEmvRRzU/INI/nmXkF7nFPN4InU1IO4ah5CYSrUppa27Sj@vger.kernel.org
X-Gm-Message-State: AOJu0YxAoNw0IWRXuifrQmrzZ+ll+cEJA0MSJtB2QihlUBw3Z8ZfWR+M
	fYq8pcV9+NI4HxHK1LKyo1L1s8Wf5TxZDmPXBL0QnmMNGnr8WLSzDn3CPqrhAQnGceQTISyYUMa
	uRTGVueTeLAntp+vCGdAPcnJSOYZRvWAmpH9MvP4g
X-Gm-Gg: ATEYQzz7prrINg9gUJr2VFxL3fYZzbm/2J4R+nlTFyJRPQbKMjL/VksArcK0wOJ/u5g
	3NyEg5DxBQ7cOQY5uPv6+WntXnfKXiNddrov23+cacMul+25/c637JbY1eFrXeKzdQeY2WOziRf
	T2xraisZK8Tf7OhFwCK4xw6V5FAs0VmoABCYHtW65hgUFf8c0o60HvZi2fGN31o9fUL4jMkDKnJ
	Nq9ctdaFy9ansiEIKJi8BbalOHjDIwv8NE0Fo3xH3q5BYdTbP03rmwRXQIFIdPKFs44ldLxjdT1
	/bfy99s=
X-Received: by 2002:a05:6214:d08:b0:899:c803:ca2f with SMTP id
 6a1803df08f44-89a30ace932mr206169286d6.42.1773144827562; Tue, 10 Mar 2026
 05:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310120053.136594-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260310120053.136594-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 13:13:36 +0100
X-Gm-Features: AaiRm50qCXqay-aJR-sI5Vzv5JmvJjTgCTUtA-sXdrVxWvAsiISg39w7gsRzpcw
Message-ID: <CANn89iK-Kj7Gthff+Q8vSUDTYs9t6YZepm5uAv_2ZZJ4AkyxOw@mail.gmail.com>
Subject: Re: [PATCH net v3] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
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

On Tue, Mar 10, 2026 at 1:01=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
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



> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 9e6af72784ba..8b3eabcdb542 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -342,8 +342,7 @@ static inline void smc_init_saved_callbacks(struct sm=
c_sock *smc)
>
>  static inline struct smc_sock *smc_clcsock_user_data(const struct sock *=
clcsk)
>  {
> -       return (struct smc_sock *)
> -              ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
> +       return (struct smc_sock *)rcu_dereference_sk_user_data(clcsk);
>  }

Are you sure all smc_clcsock_user_data() callers  hold rcu_read_lock() ?
In order to avoid surprises, I would have added a new helper.

 static inline struct smc_sock *smc_clcsock_user_data_rcu(const struct
sock *clcsk)
...

to allow gradual conversion ?

Thanks !
