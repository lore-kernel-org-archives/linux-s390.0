Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7FD3DEADC
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843513; cv=pass; b=YHcKVa74FYu7mzOL5gwQyyZ2PEkqLhWp3L3wvPUncW3zimQVcUEwUkHIDISU07DNuYgxALFT5Zl3Gva4sD0CZwKhhKvHBVeQe1+8TZbE+DB7ISOhmUoNf+FIYoKZ+0cTBhgWPZF08JpmMAxn5XJj/7GIWL4W//y1XMPALDvJxl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843513; c=relaxed/simple;
	bh=D7pWqv9qadXnG7/eNmqv6/JPm+vTpfQ/ezdHwN6Ik7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=en9PSv4RV8lXozczDV8qz6MKkbktLOI2/h/jg7VTx2lvy0B7zWAFTfKOQPIq6PldkOE9hbFy2wmw0aFU1RPFFP3XnpWWI37M/87pwJpEcRgl670pf7q6q3gCSrdlfrtl/QF0ctgwrfapLk5Q8I8X7Jnm7y5WCLOnXy25exhQ8+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=U+FEk1EO; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="U+FEk1EO"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-847921eed4aso1745059b3a.3
        for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 11:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782843511; cv=none;
        d=google.com; s=arc-20260327;
        b=BQzg3cXUU5p/0K+sGBDLW1r0DnA8ml0DgmkyumeoMIdxmAysfh2waHGJ/1OIXxYUiH
         XH9OFnnFdsKRhD7XNVQjxK50t1JUfNwrPR4YlMKxZDZTbK/cWl/Vs1UXh0T6M0hyAh6E
         DAe1Kwy/J9kz9VCtea2M+YEuudodQ3GCLDOHJfkI8p3QWQXjb5rVrwupRM3QCK5HpdOd
         ak5AEFJUyT9aItVi1gjzzIeQuy2GRjbTlwwhv8SejvgE8aB1T3Ci9IU4RJ2dxsmYMwaw
         n09kGUfBsQGqszhQQfK/5hoWQGOtVX0SeCVVzH5S6H1Yew1IUaYWKDtbb5GDpwbXHGlw
         ymWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jHHcQEADeEYM8NgWJTNCVWKKAnE3ygKO49DHhHbmJ18=;
        fh=bWpU/8u+ffvWR7zsCbiMpnkDQILnavYMZ+rQScwWWqc=;
        b=qpLPiAWxwwLC96Fhm9VdXFsy1ooMG0xNJKC/6t/2lk56x7+svoSRvd9qrdez5HJjOz
         74vpmyeTUEc03lX6GnZmfMd0aB63tSmsiFxhD5jbXMcQqg9R4JriBioPWT8n2AkPOTgo
         0eiJtm3do7wf8ji5W9jQkUaHGMM3HGfQJ/rR3T/N8ECDio0dBincpZTZHQpPIGHscnkz
         Z2k7rjmckzbS+Keb5ZWqo/scc0sOVgXlQP+TOl2lDvSJNWOZNL1SUbMFOqlCZYyueUwO
         WG/QKtDCTUtTbKRz3njX9GAcGiBjGlUHtA6FA0lPVP5K3Zt51KUZL6CLtVuGjUPit945
         2Dhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782843511; x=1783448311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHHcQEADeEYM8NgWJTNCVWKKAnE3ygKO49DHhHbmJ18=;
        b=U+FEk1EORjslgWxiCYj0ayv2t1GotS7aUy5prhuna+y+J8WiDx9vGL8Cw9uuTGqkWJ
         A3GQoA8i5K2WAjo8aLv94iApIRwmXHeGVlF34puyjvSeNBL0kaspRa25TKVg1P4lGcgE
         TP4k3S5gclJv2kUU4fRk3M2qmpc9oplrk/ee6p63fSVEcOIHFAESktlapU2JMjOjY3xK
         PRm1hzUSKMqPCzkgR6TtfSXSSsB5El31q5Xg92xZAFOJd4QAFQOlne/e386E0UkwbTfm
         /4Yr79cMLyVnJmcfA1cu5ku/NtM3WsjR1FWnM1460tqj1li27osLoCtyhABWghguVCoH
         ONGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843511; x=1783448311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jHHcQEADeEYM8NgWJTNCVWKKAnE3ygKO49DHhHbmJ18=;
        b=TY1BU7Rv4ciEWJZBqbLWaXlkxiyj5MOV0fD2bPe6jDy61TH0mwLKic6zObJ/FmuKuy
         L542Pwq0P7TdhGSdGv7YS1mnX7xrH6AVvrbASsLBGJTOXAJAGZ8x+37CDn5asAQiF164
         +xdj8awQEHimgsyzOPg44vV5+aa9108VhCWYoLe5NKxP3iNBGpSoRYreP/EbONSXq9h3
         lD2nSUgL5o5o7A8ETIQI7x8oR6hkx3vMkBT1uIJjBu8r25tGg1hC2jHuXT5NFk/u/iZS
         efIozC3oyQ8dFnozawqYAN6LooC2p19mmZDXDHg2HT9e3W1idzlGwzJZpMlwvu5UQmh5
         IgjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrko3sYaIcbwxja/+eYi4IlWd/0Onx+M10tf8yeF7lqjBMnWX9tC2BvXyb155pWZPM3ieinKxm/se0Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6FcfLje8xZN5aRaIUgX2+h9/KS5vQeEY0DSDr9xpSGVM7T1z
	j/4SuRUNAkx/CBFFNDNrF/Igw2m+txiIbvWbsBjB4QdBq4+yss1oTToaoV+PyD4Q/LflT++16P6
	jm5fKAZkrGWZh0x2NUxWzZxkHWcJp33v8o7LcgoRb
X-Gm-Gg: AfdE7ckj37wqlVJfeJmULf5Ixhor86tNvAh0R5JDHrg8jCn1kB2Y5ul21Sh0vDNRTC1
	udPe4zjpGE0NF/XM7hhy0E08rIMDdLiPBbHQXFw2MTxrV/5UYkjUPta2Gllp4J4EzykMLxHCVVJ
	UKMzXYqLaVmyA9tbJBggv97OAJHfjTmN01xwXuxL5l+5/ce5X2xqYpk8IK+QxzZNuRs9Dwp59+2
	BNoIVicyE5ED7jwZpUJXqw3LylpAw2Mj0YczMvVeYKG/fOPmz8tcxgVUTDbTTIQmjPuec2zLl+T
	KB8l5uLC+EteIAZpTOqvZ2cfjMeU
X-Received: by 2002:a05:6a00:b93:b0:847:9178:f396 with SMTP id
 d2e1a72fcca58-8479eef471emr4195023b3a.16.1782843510931; Tue, 30 Jun 2026
 11:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627014948.3049512-1-xmei5@asu.edu> <cbd7c6c1-15e9-4a9a-aaca-4cbb5bd157c7@linux.ibm.com>
In-Reply-To: <cbd7c6c1-15e9-4a9a-aaca-4cbb5bd157c7@linux.ibm.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 30 Jun 2026 11:18:19 -0700
X-Gm-Features: AVVi8CcyJq-cPQIEnlscPzhDQpAH5DOCEd3nRx8zRWlCVhBcIiSkb9NH_NYuMpQ
Message-ID: <CAPpSM+Sbro9psvZGmQ4cpm=wRMc9M-nHXxdzsgkL35hHDSCCaQ@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix UAF in smc_cdc_rx_handler() by pinning
 the socket
To: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hans Wippel <hwippel@linux.ibm.com>, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 10:40=E2=80=AFPM Sidraya Jayagond <sidraya@linux.ib=
m.com> wrote:
>
>
>
> On 27/06/26 7:19 am, Xiang Mei wrote:
> > smc_cdc_rx_handler() looks up the connection by token under the link
> > group's conns_lock, drops the lock, and then dereferences conn and the
> > smc_sock derived from it, ending in sock_hold(&smc->sk) inside
> > smc_cdc_msg_recv(). No reference is held across the lock release.
> >
> > The only reference pinning the socket while the connection is
> > discoverable in the link group is taken in smc_lgr_register_conn()
> > (sock_hold) and dropped in __smc_lgr_unregister_conn() (sock_put), both
> > under conns_lock. Once the handler drops conns_lock, a concurrent
> > close() -> smc_release() -> smc_conn_free() -> smc_lgr_unregister_conn(=
)
> > can drop that reference and free the smc_sock, so the handler's later
> > sock_hold() runs on freed memory:
> >
> >   WARNING: lib/refcount.c:25 at refcount_warn_saturate
> >   Workqueue: rxe_wq do_work
> >    refcount_warn_saturate (lib/refcount.c:25)
> >    smc_cdc_msg_recv (net/smc/smc_cdc.c:430)
> >    smc_cdc_rx_handler (net/smc/smc_cdc.c:502)
> >    smc_wr_rx_tasklet_fn (net/smc/smc_wr.c:445)
> >    tasklet_action_common (kernel/softirq.c:938)
> >    handle_softirqs (kernel/softirq.c:622)
> >   Kernel panic - not syncing: panic_on_warn set
> >
> > Only SMC-R is affected. The SMC-D receive tasklet is stopped by
> > tasklet_kill(&conn->rx_tsklet) in smc_conn_free() before the connection
> > is unregistered, so it cannot run concurrently with the free.
> >
> > Take the socket reference while still holding conns_lock, so the
> > registration reference can no longer be the last one, and drop it once
> > the handler is done.
> >
> > Fixes: d7b0e37c1ac1 ("net/smc: restructure CDC message reception")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  net/smc/smc_cdc.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> > index 619b3bab3824..b809139d7e87 100644
> > --- a/net/smc/smc_cdc.c
> > +++ b/net/smc/smc_cdc.c
> > @@ -483,21 +483,27 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, =
void *buf)
> >       lgr =3D smc_get_lgr(link);
> >       read_lock_bh(&lgr->conns_lock);
> >       conn =3D smc_lgr_find_conn(ntohl(cdc->token), lgr);
> > +     if (conn && !conn->out_of_sync)
> > +             sock_hold(&container_of(conn, struct smc_sock, conn)->sk)=
;
> > +     else
> > +             conn =3D NULL;
> >       read_unlock_bh(&lgr->conns_lock);
> > -     if (!conn || conn->out_of_sync)
> > +     if (!conn)
> >               return;
> >       smc =3D container_of(conn, struct smc_sock, conn);
> >
>
> Fix looks correct.
> A few nits on the implementation:
> container_of() is called twice for the same conn. The conn =3D NULL
> sentinel and the second post unlock check can also be dropped. Flip the
> condition, early return inside the lock, compute smc once:
>
>         if (!conn || conn->out_of_sync) {
>                 read_unlock_bh(&lgr->conns_lock);
>                 return;
>         }
>         smc =3D container_of(conn, struct smc_sock, conn);
>         sock_hold(&smc->sk);
>         read_unlock_bh(&lgr->conns_lock);
>
> Also please initialize smc =3D NULL at declaration, it's not a bug now
> since the early return guards it, just to make it refactor safe.
>

Thanks so much for the review!

Both suggestions are good. v2 takes the reference under conns_lock and
returns early inside the lock. And smc is also initialized to NULL at
declaration.

Will send v2.

Xiang


> >       if (cdc->prod_flags.failover_validation) {
> >               smc_cdc_msg_validate(smc, cdc, link);
> > -             return;
> > +             goto out;
> >       }
> >       if (smc_cdc_before(ntohs(cdc->seqno),
> >                          conn->local_rx_ctrl.seqno))
> >               /* received seqno is old */
> > -             return;
> > +             goto out;
> >
> >       smc_cdc_msg_recv(smc, cdc);
> > +out:
> > +     sock_put(&smc->sk);
> >  }
> >
> >  static struct smc_wr_rx_handler smc_cdc_rx_handlers[] =3D {
>
