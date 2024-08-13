Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DAF199E9D;
	Tue, 13 Aug 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549724; cv=none; b=WHXNP2aWTwNryxs23PaY9x4XEQsPlZDmxy6Wa6/Kp0ymFKBFNt61XI5G7uOGFd37vNlUP3k2Tc4t8RVYQptcc2eYSoa7UFhnFWwi9DsF+EpsAMn0xvhy543vXhqvGP4EcQtKO0HhjRkKk1zFesm6rA5xxEnAH6DHB7OYuY88A4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549724; c=relaxed/simple;
	bh=Rhfwq0cg5lz4S8pNN27okoWlHYgUkEy8uDoZXs5jFZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCnzM905mPOfWpOIHdye9bd0XNGEtkPu2M331Aj7TBX0pqwjBojpxgp1X4H1Pinq9H8qL2Qj5JK3kxJNY65NAURFADPbI/KUalDFP12ea5sA5Q5ORconbWMdbwI6x66o0aSFRuGv4etlo5xqKlmYBR8900pZDNvy9m0fLoqjORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuwR6l17; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuwR6l17"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70eb0ae23e4so3937571b3a.0;
        Tue, 13 Aug 2024 04:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723549722; x=1724154522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fEwvddfgj60Kx5Z2+SKgI2f8D3YPCRs94fs0x4VsDhg=;
        b=DuwR6l174DMBDdXy96JjnoNE7JGDLtnFPDbtAXYsr9PwobbXO4inddFuQm+trI9tXA
         0nxEfREuVzC4YKpr+kdd8rVpqB6kYWZnOu1ZgtvjaDqlvx81KukX1OUWBuENjBYRniLD
         6lzC41nfXTXHvZxIpW8FllZmlGsQ5KPmvsdSqHAJqmZmijy3hqFYXi9thgV5jcPXc9Xs
         rtSdCeHF+ttycX6M5LA6k4PSW0aLVWk+0V+toP8b3QW+Krm5UUWacVIKOQnUjzrTjNaY
         dMeIB3Pq6I5s8qAlasZsjjWdMFzTas0/zLn3BuOnbVsbyRF3bOpOsQX2pf99Hu7SDdgx
         INxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723549722; x=1724154522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEwvddfgj60Kx5Z2+SKgI2f8D3YPCRs94fs0x4VsDhg=;
        b=Rw6TAl04dZQACIoCS20MeoTCHD2JUdkaMYe0iHLMARmdrE/B3nddTeemY0Xj3U08PP
         6qxcP/naAgPwwDPdyTVPioQ1f9hnDKhebshy4hcNsdas6ptDvbhNvp53qyWOcfj/gj6W
         zembcoK2KxB4gd2z5cOh4O8kMyfIkZhIgaF0zYOBGzJBxQGYo9HreCsdw5MriD3bRUPB
         Utvij0MDdLw6CsKCvzfxlxbhFcjMm4RZixP6GRg58M5UA7IFLioT5bdAzG+BSPChdzqA
         yDJzdZJ3R8yEJIuNPltXJmrDUttuF6EMResF7lW41H4HurBk9lFrMhCVqBBwdZtS/0cE
         KbLA==
X-Forwarded-Encrypted: i=1; AJvYcCV/U3WpZEtFTuCtQDqdp5SDxkzhxjnwMC273oZMfM2YO92PJmOuUgMy30Fz74phGSORBb8augO/qaxvhfYjkYwVD3793bVh9xcJnRhCnWxGYTjW57rKTlTiQ66k+qui2cg8lADJB8OCVO2BO7sgnvGr20duPPrKkFDPuI/dz5vvog==
X-Gm-Message-State: AOJu0Yw6mcrMBtFIjCY6yWU6COCdJuv3Dwyp5jhN2eVnaZsSMpdSL8im
	Iz/NHJBxz+rwOzLRltAjxSkP6UvzjGMwT89JVZXLJYRwKgqaH11ZEC293AgzOvFL3gtOldSYcRY
	I9adl2SV/4VxfLMC4OqHbqfNA5A8=
X-Google-Smtp-Source: AGHT+IErLKHaiYPu7SrHVEFIcB1NY4fQJwHTKBS3L1t80KOvCgat/nd00Cg6FmkDz305JLaCQONbAQzBWe5muBnYW8I=
X-Received: by 2002:a05:6a21:78b:b0:1c6:b0cc:c448 with SMTP id
 adf61e73a8af0-1c8d75b6731mr3449127637.43.1723549722103; Tue, 13 Aug 2024
 04:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813100722.181250-1-aha310510@gmail.com> <b4b49770-2042-4ee8-a1e8-1501cdd807cf@linux.alibaba.com>
In-Reply-To: <b4b49770-2042-4ee8-a1e8-1501cdd807cf@linux.alibaba.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 13 Aug 2024 20:48:28 +0900
Message-ID: <CAO9qdTFjG7TZ7BKJZ_dvvOm08tjYooVtjh-8mNSoOZ7Ys5H=Ww@mail.gmail.com>
Subject: Re: [PATCH net,v3] net/smc: prevent NULL pointer dereference in txopt_get
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, gbayer@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	dust.li@linux.alibaba.com, edumazet@google.com, pabeni@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

D. Wythe wrote:
>
>
>
> On 8/13/24 6:07 PM, Jeongjun Park wrote:
> > Since smc_inet6_prot does not initialize ipv6_pinfo_offset, inet6_create()
> > copies an incorrect address value, sk + 0 (offset), to inet_sk(sk)->pinet6.
> >
> > In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
> > point to the same address, when smc_create_clcsk() stores the newly
> > created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> > into clcsock. This causes NULL pointer dereference and various other
> > memory corruptions.
> >
> > To solve this, we need to add a smc6_sock structure for ipv6_pinfo_offset
> > initialization and modify the smc_sock structure.
> >
> > Reported-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
> > Tested-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
> > Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >   net/smc/smc.h      | 19 ++++++++++---------
> >   net/smc/smc_inet.c | 24 +++++++++++++++---------
> >   2 files changed, 25 insertions(+), 18 deletions(-)
> >
> > diff --git a/net/smc/smc.h b/net/smc/smc.h
> > index 34b781e463c4..f4d9338b5ed5 100644
> > --- a/net/smc/smc.h
> > +++ b/net/smc/smc.h
> > @@ -284,15 +284,6 @@ struct smc_connection {
> >
> >   struct smc_sock {                           /* smc sock container */
> >       struct sock             sk;
> > -     struct socket           *clcsock;       /* internal tcp socket */
> > -     void                    (*clcsk_state_change)(struct sock *sk);
> > -                                             /* original stat_change fct. */
> > -     void                    (*clcsk_data_ready)(struct sock *sk);
> > -                                             /* original data_ready fct. */
> > -     void                    (*clcsk_write_space)(struct sock *sk);
> > -                                             /* original write_space fct. */
> > -     void                    (*clcsk_error_report)(struct sock *sk);
> > -                                             /* original error_report fct. */
> >       struct smc_connection   conn;           /* smc connection */
> >       struct smc_sock         *listen_smc;    /* listen parent */
> >       struct work_struct      connect_work;   /* handle non-blocking connect*/
> > @@ -325,6 +316,16 @@ struct smc_sock {                                /* smc sock container */
> >                                               /* protects clcsock of a listen
> >                                                * socket
> >                                                * */
> > +     struct socket           *clcsock;       /* internal tcp socket */
> > +     void                    (*clcsk_state_change)(struct sock *sk);
> > +                                             /* original stat_change fct. */
> > +     void                    (*clcsk_data_ready)(struct sock *sk);
> > +                                             /* original data_ready fct. */
> > +     void                    (*clcsk_write_space)(struct sock *sk);
> > +                                             /* original write_space fct. */
> > +     void                    (*clcsk_error_report)(struct sock *sk);
> > +                                             /* original error_report fct. */
> > +
> >   };
> >
> >   #define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
> > diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
> > index bece346dd8e9..25f34fd65e8d 100644
> > --- a/net/smc/smc_inet.c
> > +++ b/net/smc/smc_inet.c
> > @@ -60,16 +60,22 @@ static struct inet_protosw smc_inet_protosw = {
> >   };
> >
> >   #if IS_ENABLED(CONFIG_IPV6)
> > +struct smc6_sock {
> > +     struct smc_sock smc;
> > +     struct ipv6_pinfo np;
> > +};
>
> I prefer to:
>
> struct ipv6_pinfo inet6;

Okay, I'll write a v4 patch and send it to you tomorrow.

Regards,
Jeongjun Park

>
> > +
> >   static struct proto smc_inet6_prot = {
> > -     .name           = "INET6_SMC",
> > -     .owner          = THIS_MODULE,
> > -     .init           = smc_inet_init_sock,
> > -     .hash           = smc_hash_sk,
> > -     .unhash         = smc_unhash_sk,
> > -     .release_cb     = smc_release_cb,
> > -     .obj_size       = sizeof(struct smc_sock),
> > -     .h.smc_hash     = &smc_v6_hashinfo,
> > -     .slab_flags     = SLAB_TYPESAFE_BY_RCU,
> > +     .name                           = "INET6_SMC",
> > +     .owner                          = THIS_MODULE,
> > +     .init                           = smc_inet_init_sock,
> > +     .hash                           = smc_hash_sk,
> > +     .unhash                         = smc_unhash_sk,
> > +     .release_cb                     = smc_release_cb,
> > +     .obj_size                       = sizeof(struct smc6_sock),
> > +     .h.smc_hash                     = &smc_v6_hashinfo,
> > +     .slab_flags                     = SLAB_TYPESAFE_BY_RCU,
> > +     .ipv6_pinfo_offset              = offsetof(struct smc6_sock, np),
> >   };
> >
> >   static const struct proto_ops smc_inet6_stream_ops = {
> > --
>
