Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0323C3C2794
	for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220661; cv=pass; b=B2oekyQ1jIOddGR3nYZ6TN//nNlLJfYuhDsmIVbs1TCKYyiRVpf5ueumZPPScjo+cjWO/8+Od0GJpS5Z3WJWFXqckIYJW+sT0VW41G8wh6cDXjSuqO5RmzoOOwmB4rLCDDr86crFK1GaBp1CQRAFeeOsVpDm+OzQz8fp0fw/O8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220661; c=relaxed/simple;
	bh=OxP+oxlWMBqbtwfC/PQBmjuD1E0cI/hvZs3XVNyH0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvRvody9i8dCvNeDYm6W2wE0BiOJ6b1TER1gajn2i3cGZCr/38hkbHPEyjgZlHd9YgoPUoM1e16O5qqo7C9P58UGVcPYN1h5W2NMQ9cA9kRpfEMI1lyNMjhxXFqIMs+FUE5QSr43dxeK6pMucnLQziNi7cJmsDLVuGD1lGs9C5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0cJQp38M; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0cJQp38M"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-509006c070eso38496471cf.0
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 02:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773220652; cv=none;
        d=google.com; s=arc-20240605;
        b=I8Z5WbXi0dE9mYUhqEDyk2EPAtjLOJu3IplJKCKj2HK0ajHEeIiUDOQsHLWETTz8JT
         g5sfTPkuiNccUNYVXu/QjPz6xOJv0H+xmpWRbALZgo72DDB+P5eF5LWCj6jS5KxWx9cx
         UegVDQzdQqJ53YBpfaI6U14eErXI4qzfuuBipqomOU8XvRQjxrg4T7oc38B6I8k6Ms/k
         vjGgAZM00JVpWINTMQxymRLx1/hDJQXp2smBnu3wvGPSlWznBIErWtBCMWXLRlGoqg5C
         XIdDhDDODQFdtiOiK3E/k3M7R7ASSusmRQ+MV/ckM91WU/OsWQ1HG8rbF2WEfP+Kle4+
         WnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=34kAm3z124TDQNJNDxrj8wJyj1zVsoVCIkxuIHo91/g=;
        fh=2Hvv0ig64vCV9L/aY80HWEEsP7aAZctQroV8KaEpf+s=;
        b=AlJdQJvv9uO7x9IwVSITYbb4yC0B54QC3Q5fBf6NwjIpJkDbQTfDV/OVnXPxpZ+Dqo
         +Lc+Dom6R5U98uMig9jOFFxTg0KtGX6lqrUCS6nYtB2mI6F9qt6lW2mQK4jKVIwJ+Cld
         qP329pf84/iEWHTQlGOMpPuZMlo7ySPDe6NMJW5UH0lE1guFtk3HNdCRISv+6Vy1Q5Rx
         v/bTgHPI49im/Gl2linz0QW1wp3TZFj4mbvRoDcGKEbtElJsKZDbXf4ZAMT/M/aCYfB6
         7tZIbsdTJD7yT9bfqMPdCzQfV+MfwwCaqABrbyFCv21WOeVQRW1cip+ZPECpQlwPDjuL
         4r9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773220652; x=1773825452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34kAm3z124TDQNJNDxrj8wJyj1zVsoVCIkxuIHo91/g=;
        b=0cJQp38MAggzovUIISEwDjOMceCuoLNdTrcgauUMi9wfvxyw4OM/5Ipd7VMVX/E6XW
         zRxT6TVNYXk+Zkoi9fq55HDdRtoS+xXjxKaZbNV1VO/WnqVeXOAVQLK4mDEx8NJxhP9U
         HweUodg0iKD+xPYPsTnIvHnH7St0pbWHrlgKW2qvSnAqDYbYZEC0ZiJ+CpZGnR+NTjCd
         ++zxUjoUWHh3MiQbYJjog8VfbWKVKwLfCLxuxXpLyzu0ScNsYuQPYPZLnaLvMGKpWIH6
         jIDgZQEYz8qWwh/PStzOfQ/lEhl6yolU37GfRaIhwLKn0SqJ8ywx+5ZqLJF8ReaCInaF
         s6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773220652; x=1773825452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=34kAm3z124TDQNJNDxrj8wJyj1zVsoVCIkxuIHo91/g=;
        b=VxhNcu/mYqfjHgwoLqHnATOW6DdCBwKkHQ10hyDdNfVraKigyHziaYPGjVEC5wf1td
         1YTe5sjHrtU+RXtDlZBWpkeIRbmcpAdhPtq62TK18euo/dgCAIqCkh43Q9oJCok6vuYm
         D2p1ddorVnwzNcd/4MdSVAnFSAwHd6f2p4nepeu1nqVL0Ifk8yiM77e0apRDsmJrKQAj
         sjOd1FRIUeP0CLVz5y0SJo3n7u6qECgf4vGMw/pHWt9LlW2hnFIynVFEyYR7U9Y93A1w
         4xgcvpDfx5JJdokZPaCuEsoXU3C/pLBjG2xgstZ8ogCV/ZgiJCtcYF+O8vN/f7tXbrOm
         WJbg==
X-Forwarded-Encrypted: i=1; AJvYcCVSNjXxjmA6GQQ+dt6kqv1DRhmSTQ5TFzNUXIC/3kXn4CZqyuYxLZkippSBx9cdebQyngt/ExqpAkRS@vger.kernel.org
X-Gm-Message-State: AOJu0YyCSVwAS9o59HIfweqXdYthIM4bSkBNTxPoDlkRqVMdK06r5NzM
	qCe1yiWPbNprB8AhbFlnmbMVFyyLBnwp3di2xo6+3OQUkfTjlt0QenGC1te3JrRdaQK0X87Mmh4
	1o29bi7Dgw5NZnPtg+z5Lo8/fvbkXN2xvyg6Qowqu
X-Gm-Gg: ATEYQzz1E9UP8GAV0mJv4Q2mxfMEkhQXOB6GD3kKCRqrl2Hv7mtlQSYAbnxRzOui0cN
	W3koesU2BTgK5U5zaV+5/W2eGmXxFKIl9f1UBjMao+2OmVB6L3npuvA1WwMLJ2GabPgSzfVO4WU
	8fHEucnpmhg60Qwwu1y7G28Ks8fsERUrDPfdsL+kaxckhCWGN9n5/1eowamXs2rXY8Y1DyY5ILL
	aThdeqnqc0JojhscnTuxEbNmqylpB9M3GtWPJdFL8brEcxadLKbuLmaoyA48WiXi7MJvtKgPXQ1
	YnbeWEjaAwO103BvtPE=
X-Received: by 2002:ac8:7f8b:0:b0:509:3025:ff4e with SMTP id
 d75a77b69052e-50939fac746mr21570951cf.27.1773220651404; Wed, 11 Mar 2026
 02:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311022451.395802-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260311022451.395802-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Mar 2026 10:17:20 +0100
X-Gm-Features: AaiRm52u0CMFFt7ORPlVWQokL8IgQ6iecZLTd-DHcIzSTX7a8MIK-b_1wmE7h9M
Message-ID: <CANn89iJpjgEnsOfVuF0k4uERc+P4mwy5Tpu-hpSfcx8RGtWEKA@mail.gmail.com>
Subject: Re: [PATCH net v4] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
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

On Wed, Mar 11, 2026 at 3:25=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
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
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
