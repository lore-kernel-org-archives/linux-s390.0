Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F3471D04
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449255; cv=pass; b=uJlNkqwC2uk+TY/lWtAntH2jB11fYCflzV3//ENCw8ucFf6OxN6juqwf11vUC/QXj99wwcNHWIEgfPJQp51Gs0dY8utGQ5sw1xC2mpet7w6D/CyaM9Uk6mnJEfXHFzT4qmoIVC11VXJ/eVQIZ+yD0yPQZ5TZqpDvFbOQcb6mo9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449255; c=relaxed/simple;
	bh=wnf1Rxz7GOXO2mt1drF6YwLshKbYBKmoC34txj8aINc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfdA40VBf5rDU2Eq2G7EFblJJPOB3nJURZM+c9sx5hHLgwpMeCGzbEoIlM3YASl+Fnry61iksDReoNQrU48RaxkVKvDQZMTZSp0P+/OXm+8ypFDLDs4RuAFY47eD6GkjYm8jrB+BwPcDWZkPxJbjvvPS4eEHOH1GlKULBcDNDUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuUSni7h; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuUSni7h"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2af2ae1258so8294466b.0
        for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 01:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791449250; cv=none;
        d=google.com; s=arc-20260327;
        b=WXl5EACSkZNisSglyMh+X27yzD7HRZhOxRgEestdm9hFokMWABrNQE4sF5s29UEQjw
         iP+W5V02oH/5sneAPxbB/b1Sq42n4wUZ/Q0r9TpcIeBuOgF+iOdmKp6rpNiEE3mT5r8L
         8bd2pLMFP5vssMFRAVXue9LpIXe+rolc0S3JnUlBVUrNJACJTMuYJUnaLA35Y+97g6H7
         zHQcLha3ujLlhGJGyNrOHk3pQOapl4zlWI8IIdWOWu252JsJDuznRwgXTfaJn0R5JuRy
         zjWB3yJ/gDJmHJ61OdHUVcyya/64smLMETyx/yV1Wuh2gkiePlMi/W6nGOqqy3sqs2gn
         u9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0UcH2PL4jFdt0IAXyp77qe+AKdk/VbOyr7Y+0xZparU=;
        fh=Heye0ieMiznTiuxxHLazh6FXd0BmHJAlFOpnZ+dxME8=;
        b=ffX2qq3oyXkTyTCVAv7OIvUii9xXBB6YeGxwAoCnJFR9bZ7Im5XSmu/QvC9soNgYbj
         bYnkTeEMeTLJpZnhHw+478ZLT4/qjFAdvvap3MtIjtl8kVy3F5gKES9aIRcmLSH/JXo8
         KuZ+jFaiWtEt9pzcEkpq6h+bTRhGo8o7VxeKMjjjsrY9WUUFigK1LCZiAdbaszoZdcyQ
         qJvrF0w4lIPUaNiBzm1+GPF0FhccrC9zW+fHT+qLmYxHxVaFcRJ6qn1UBUGZ17vZHMD/
         ZLa76U8cNZB0DDOSYrjiUZfn+T17lKAUF3a3DggPt0jx6VmHxPuJ05sgYqZtNqf5WPzx
         ALdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791449250; x=1792054050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0UcH2PL4jFdt0IAXyp77qe+AKdk/VbOyr7Y+0xZparU=;
        b=kuUSni7hlE4lksl+gPcGL9an60/cobuTciWPG0OHc+15BstRjhLcDuDM1OwQ9BGf/e
         NjakGT8e6p5scau0Y74rF6mcakjRAxwRiRUzY3OiXBH05XesXmmD2g8dH6YnPFtS9p4t
         bm7eTNGm7PywFocmIleZf/dVg+prWH4BgkWtOCKHsOdqbPzYyV4JyVGQHS2TTba6zoIm
         2PLN65i+HaKPTU6OWXSYaJWZsUfNWjDO8UFmcGFkEZSk+erBZn/ydIUOHAkyNW81JN5d
         GBzF+7ANa+901btPE0aYQwHRNiFzufhlKMI7tpulSek/nGkGgImRm25mO+8b9jX2gOJt
         WMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791449250; x=1792054050;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0UcH2PL4jFdt0IAXyp77qe+AKdk/VbOyr7Y+0xZparU=;
        b=gNLUcJMgHaldz/veVf64a3wpNhmfGjwF+RhijOgQUQESkobRRfAUVEXjMbmG53oknT
         icW8dW+DFymgpFdtP6rw9NFbIok3+qOUleKbA0GMCoqB36EKzlnuCUe5d9CRdfEv83KM
         6y87eAMk2Wyjf9QfZLo+LtZxRcEfBqWWVZWvH6l47Pkwuz0S7R/mHwlQ4vA1xemv7XR1
         biAy34doYXGfStEj2Goz+9qtoDW4KMoZw2SJRii9edO+CDLK4R9clRaGY/KX1Qb8QIHJ
         7eMbxiFRD/C5ajNwEBe6XS/LkcGithWBtf5ZTJlL98tpcfB8yKqotCP61DYXVg2PvEsg
         pGFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhkVwfT82bobXX1eVVLjpdSYjyD41I5M2TP5c1uW9hlesnKaov2xBmnTRVIigS9ijT0ICeDyyk3OS4@vger.kernel.org
X-Gm-Message-State: AFuF++k1xEkzKoKXMnGdsLsSO3sjhTOdt2YcSqIrcFrYzTTurkVyKhcI
	bTrjsNGm4wQX1JHkj64l//83ipC0xxTs4W4QRf/4D36/R+VsHdF1RjmkArMyHx2FPUsbyMF2DfY
	RFkeWdwOwYe0YnEbGur2H67vpAdn0h5c=
X-Gm-Gg: AYBFou1zgXlXVwkHp9ySkBBNZyX9a/xYRjOj3lRZs2rLwmloDEwA3epgIsuKuuVnxXo
	WpXmbSaXoychry9+OHEGjgIn4CmkIepQ90Dn7C1F1tPZ3lJIAZc/4dryOig7+yw13K4snXRZObw
	GvhPwuDy290tH/89EpOivWa3U20hzxROEgYAKdP4u6BpeMlk2TLr+lbxgVmgOp1Wmwk8VD92LoD
	pdH9Sinfa1Bmu9Qxp2zw1nP2DDfaPhA3nWaCgRA8PpWrJ0MJF4HP09vtBgXV5ws9/2EIWmIjAJ+
	KAMZHmTCZQVmNasyDHMGw8YUg7q1HPtGFAtV6TaENKdKvhOHSNwTSogXeGSC5ls5mjImf42GBp9
	VN+d0t6ObTuk=
X-Received: by 2002:a17:907:3f1a:b0:c29:5637:ed76 with SMTP id
 a640c23a62f3a-c3190b7f237mr174970566b.2.1791449250106; Thu, 08 Oct 2026
 01:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003183325.2289707-1-nicoyip.dev@gmail.com> <4bb7f15e-2cd8-4598-9bab-1ea5f5d2bb59@linux.ibm.com>
In-Reply-To: <4bb7f15e-2cd8-4598-9bab-1ea5f5d2bb59@linux.ibm.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 8 Oct 2026 16:47:17 +0800
X-Gm-Features: AclHuK-HvCltyPhbBd2tQBXjDEN4keSNVUMLUN1JKqvwBHV5wUDOdUDGOh2UcnU
Message-ID: <CAAo+4rVmRy7Hj-PRuCzuzXg=r5HDib2ztNnBa6On9+Lx1W1Ysw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/smc: serialize clcsock access with its release
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:32=E2=80=AFPM Mahanta Jambigi <mjambigi@linux.ibm.=
com> wrote:
>
>
>
> On 04/10/26 12:03 am, Chengfeng Ye wrote:
> > Link-group termination can release the CLC socket through
> > smc_close_active_abort() while the SMC socket is still open, for exampl=
e
> > after shutdown(SHUT_WR). A file reference keeps the SMC socket alive bu=
t
> > does not prevent this asynchronous release of its CLC socket.
> >
> > smc_getname() can race the pointer removal and sock_release(). The same
> > missing lifetime synchronization affects smc_set_keepalive(), diagnosti=
c
> > address copying and an in-flight SMC-R CDC receiver. smc_shutdown() can
> > also reach its final CLC shutdown after its close helper drops the sock=
et
> > lock and a concurrent abort closes the socket. Holding the SMC socket
> > lock alone is insufficient because CLC release runs outside that lock.
> >
> > KASAN reported the getname failure:
> >
> >   BUG: KASAN: slab-use-after-free in smc_getname+0x19e/0x1b0
> >   Read of size 8 at addr ffff888109abb4e0 by task poc/103
> >   Call Trace:
> >    smc_getname+0x19e/0x1b0
> >    do_getsockname+0xe5/0x170
> >    __sys_getsockname+0x8c/0x100
> >
> >   Allocated by task 95:
> >    sock_alloc_inode+0x1e/0x280
> >    sock_alloc+0x3d/0x240
> >    __sock_create+0x7e/0x430
> >    smc_create+0x121/0x240
> >
> >   Freed by task 0:
> >    kmem_cache_free+0xcc/0x340
> >    rcu_core+0x50a/0x1850
> >
> >   Last potentially related work creation:
> >    evict+0x446/0x6c0
> >    smc_clcsock_release+0xa8/0xd0
> >    smc_close_active_abort+0x26a/0x3a0
> >    __smc_lgr_terminate.part.0+0x137/0x2e0
>
> Hi Chengfeng,
>
> Thanks for the KASAN report and the fix. The UAF in smc_getname is real
> and needs to go to net and stable. However, I think the v2 approach of
> adding a new spinlock and extending clcsock_release_lock to cover more
> readers is treating symptoms rather than the root cause. Let me explain
> what I think should happen instead. What to keep from your patch.
>
> Please send a v3 with only the smc_getname fix:
>
> int smc_getname(struct socket *sock, struct sockaddr *addr,
>                 int peer)
> {
>         struct smc_sock *smc;
> +       int rc =3D -EBADF;
>
>         if (peer && (sock->sk->sk_state !=3D SMC_ACTIVE) &&
>             (sock->sk->sk_state !=3D SMC_APPCLOSEWAIT1))
>                 return -ENOTCONN;
>
>         smc =3D smc_sk(sock->sk);
>
> -       return smc->clcsock->ops->getname(smc->clcsock, addr, peer);
> +       mutex_lock(&smc->clcsock_release_lock);
> +       if (smc->clcsock)
> +               rc =3D smc->clcsock->ops->getname(smc->clcsock, addr, pee=
r);
> +       mutex_unlock(&smc->clcsock_release_lock);
> +       return rc;
> }
>
> That is 4 lines against the confirmed KASAN-reported UAF, uses
> infrastructure that already exists (clcsock_release_lock is already held
> by smc_clcsock_release() when it frees clcsock, and already initialized
> in smc_sk_init()), and is a clean candidate for stable. Nothing else
> from v2 is needed for this specific bug.
>
> Drop the clcsock_lock spinlock, the CDC change, the diag change, the
> shutdown change, the connect-abort change, and the smc_accept_dequeue
> change. Those races are real but I will address them with a proper
> structural fix as Me & Dust Li have already discussed on LKML in August[1=
].
>
> Why the other races exist and what the right fix is
>
> Every race in your v2 =E2=80=94 keepalive, CDC, diag, shutdown, the
> connect-abort path =E2=80=94 has the same root cause: clcsock can be free=
d while
> the SMC socket is still alive. Several close paths call
> sock_release(clcsock) before the SMC socket's own refcount reaches zero:
>
> 1) smc_close_active_abort() =E2=80=94 for PEERCLOSEWAIT*, PROCESSABORT,
> APPFINCLOSEWAIT states
> 2) smc_close_passive_work() =E2=80=94 when the passive close work transit=
ions to
> SMC_CLOSED
> 3) __smc_release() =E2=80=94 when sk_state =3D=3D SMC_CLOSED
>
> Every access site that can race with those releases is then forced to
> take clcsock_release_lock and check if (!smc->clcsock). Your v2 adds a
> second lock on top of this for the BH/atomic readers that cannot take a
> mutex. This complexity is unnecessary because none of those early paths
> actually need to destroy the socket =E2=80=94 they only need to stop it.
> tcp_abort() and kernel_sock_shutdown() are sufficient for that, and both
> are safe to call more than once. sock_release() is the exception: it
> frees memory and must happen exactly once.
>
> The fix is to move that single sock_release() call to smc_destruct() =E2=
=80=94
> the sk->sk_destruct callback that fires from __sk_free() when the last
> sock reference drops. At that point no concurrent user can exist:
>
> 1) fd users are gone: smc_release() calls sock_orphan() before dropping
> its reference, so no file descriptor can reach the socket after that poin=
t
> 2) workqueue contexts (close_work, smc_listen_work) hold a sock_hold()
> and therefore keep smc_destruct() from running while they are active
> 3) accept-queue entries hold a sock_hold() via smc_accept_enqueue() for
> the same reason
>
> This gives us a simple invariant: clcsock is non-NULL for the entire
> lifetime of the SMC socket. With that invariant every reader becomes
> trivially safe =E2=80=94 no lock needed, no NULL check needed, the race
> condition simply cannot occur.
>
> [1] https://lore.kernel.org/netdev/ao5bB9OCbJ5PQbEp@linux.alibaba.com/

Hi Mahanta,

Thanks for the detailed response. I just sent v3 with only the
smc_getname() fix.

The additional locking in v2 was added in response to Sashiko=E2=80=99s rev=
iew
of v1. I should have checked the August discussion before expanding
the scope of the patch.

Best regards,
Chengfeng
