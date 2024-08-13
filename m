Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADBB210E7;
	Tue, 13 Aug 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541187; cv=none; b=YzpexKCNpkJZnuteJSM5p24c1OyU9Mjpsqi0f6BPEnx1eyEl0ookvKvatpr3Iizc+G5QRCPn05kPAIh02ULgkS9SwUTwqEh3gFR/i4vSgvPuqBPmCBSqypDHI3yKhy3Bu4xB9WCFqthSbKnLbEg4jtuUCY3d24OqEZdQnnKarGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541187; c=relaxed/simple;
	bh=dI9eMxqkvuN5fgrBjTMkpsf4qPtUf3dQ4BQfGxByJqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1ZaY9nyeX+5Zi+VlLByfXCVCuoTK/XgNeRYHHoFO90k2nf/0uHKk3vXc3Z3dhYfEsPWnoMKKUZh7SB/PEu5PqsPtIMu2Z84o2fkCkZ9Pp20mCY4aqnNf9dO3fYXF+sEBXTzE6Hufi/DwhNYo9Rdg8n/IRP9gSlfhDb3mJRovsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0JKsO9l; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0JKsO9l"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd65aaac27so42649135ad.1;
        Tue, 13 Aug 2024 02:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723541185; x=1724145985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF+7ShMevVjnLSswFEKMXpgWA9irpFniO0B1JndM7Dk=;
        b=E0JKsO9lthRVCKfXHJArhY2Nf4if700GnVqN9nQgsO4BCVkRxY2xGWu0tBaral8V2G
         Im7rboDMZQssVGdZAq07jwOl4pL6SjIfYysvRKVXFaMpVyrwiNcBzH7CMDR2BDfW/xq+
         Y/+xp9/a9108g3vGSPAdGY2xOGfo7VHEzB6UwH61Ye4IXuOeYn8fKdPJCsc9JP7+YOSE
         U5mbWgLZfAwHtIwXbDlXFpXu2C7EeKJ7HkCfAWqtl2Tqtt1s6oOc/VGBaxIxue21QPxN
         GZrJLaq7jwC617pbSRy8zLUvfGb+uMm+0D2ncNuJyd8pRDrev7RRI27SFhV6LjP0DR2b
         daVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723541185; x=1724145985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF+7ShMevVjnLSswFEKMXpgWA9irpFniO0B1JndM7Dk=;
        b=vuQSr/8kRL1/9iEWj9bdQvcjwjAA2YWluEvO870omhg7YgUYGS8/pNLsMldBE5SdK0
         qofobK8ZidOPYq9EhNwxaHmUYzzV3P53ntOuDvgWw5UvhF/NPEpQOKjNAPBC0cyD5nl5
         ODWiCJ9CxX4o8Qmd8C/b08//E6bLoyTA8dtHJsbWqVJAohReblLrfBILOtjTcT8IsHOC
         fTD8Nw8JvmDg2bA4crtUwUQNV7+xzOaI2o7figVyPHX8TrppYVkDrWwzy9zibve7jgQU
         YccTq/kqyhfVZZojBfxe3qE7y1AAMVZxdurS+yNnTqpTy2OWN7DqLMuMAxG1v6GkVq91
         TlAw==
X-Forwarded-Encrypted: i=1; AJvYcCXBeRfYd6hZwDBuSyRzw/JIq/+6eX8Tj8Yq3KVInd+I9sXodJFEjxfbY4fhVbk4YlaZnfUJI6psQbo2Ppqd4TJBNH9IcBaQ6rEK/WHUgcu7P7OSYtaVypc4An4N8tFXO7MAIkyHw5ukkR8BspmzkrTwd5q4P+/nolUwGITvX6NLJA==
X-Gm-Message-State: AOJu0Yy1HpqEycVwoKuJBvgHeLgW5XS3FWcXRKf1U2ZQ57WtmNIiw+F3
	c9VmDl2mBDUwQ/hPlD6Y61u2OhR/fjKsnKYn4FBO8nPwnak5Zrxr
X-Google-Smtp-Source: AGHT+IHzQx9qTRKvbnSNhCG6N3qO/bYcsHC4+S3u/dwFTMIxQvUlAeXDAvANiHp9b6drGQAT2iNkBQ==
X-Received: by 2002:a17:902:ea08:b0:1ff:39d7:a1c4 with SMTP id d9443c01a7336-201cbc72244mr37246165ad.25.1723541184357;
        Tue, 13 Aug 2024 02:26:24 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd147eb9sm9567675ad.90.2024.08.13.02.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 02:26:23 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: gbayer@linux.ibm.com
Cc: aha310510@gmail.com,
	alibuda@linux.alibaba.com,
	davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	guwen@linux.alibaba.com,
	jaka@linux.ibm.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tonylu@linux.alibaba.com,
	wenjia@linux.ibm.com
Subject: Re: [PATCH net] net/smc: prevent NULL pointer dereference in txopt_get
Date: Tue, 13 Aug 2024 18:26:17 +0900
Message-Id: <20240813092617.175390-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9102add11cb13e94d3d798290e7d08145e8a6af9.camel@linux.ibm.com>
References: <9102add11cb13e94d3d798290e7d08145e8a6af9.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

>
> On Sun, 2024-08-11 at 02:22 +0900, Jeongjun Park wrote:
> > Since smc_inet6_prot does not initialize ipv6_pinfo_offset,
> > inet6_create() copies an incorrect address value, sk + 0 (offset), to
> > inet_sk(sk)->pinet6.
> >
> > In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock
> > practically point to the same address, when smc_create_clcsk() stores
> > the newly created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6
> > is corrupted into clcsock. This causes NULL pointer dereference and
> > various other memory corruptions.
> >
> > To solve this, we need to add a smc6_sock structure for
> > ipv6_pinfo_offset initialization and modify the smc_sock structure.
>
> I can not argue substantially with that... There's very little IPv6
> testing that I'm aware of. But do you really need to move that much
> code around and change whitespace for you fix?

My intention was to add spaces to align the code to the length of the code 
added to smc_inet6_prot, but I think I accidentally added a tab character. 
Sorry for the confusion. I'll send you the v2 patch right away.

> [--- snip ---]
>
>
> > Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  net/smc/smc.h      | 19 ++++++++++---------
> >  net/smc/smc_inet.c | 24 +++++++++++++++---------
> >  2 files changed, 25 insertions(+), 18 deletions(-)
> >
> > diff --git a/net/smc/smc.h b/net/smc/smc.h
> > index 34b781e463c4..f4d9338b5ed5 100644
> > --- a/net/smc/smc.h
> > +++ b/net/smc/smc.h
> > @@ -284,15 +284,6 @@ struct smc_connection {
> >  
> >  struct smc_sock {                            /* smc sock
> > container */
> >       struct sock             sk;
> > -     struct socket           *clcsock;       /* internal tcp
> > socket */
> > -     void                    (*clcsk_state_change)(struct sock
> > *sk);
> > -                                             /* original
> > stat_change fct. */
> > -     void                    (*clcsk_data_ready)(struct sock
> > *sk);
> > -                                             /* original
> > data_ready fct. */
> > -     void                    (*clcsk_write_space)(struct sock
> > *sk);
> > -                                             /* original
> > write_space fct. */
> > -     void                    (*clcsk_error_report)(struct sock
> > *sk);
> > -                                             /* original
> > error_report fct. */
> >       struct smc_connection   conn;           /* smc connection */
> >       struct smc_sock         *listen_smc;    /* listen
> > parent */
> >       struct work_struct      connect_work;   /* handle non-
> > blocking connect*/
> > @@ -325,6 +316,16 @@ struct smc_sock {                                /*
> > smc sock container */
> >                                               /* protects clcsock
> > of a listen
> >                                                * socket
> >                                                * */
> > +     struct socket           *clcsock;       /* internal tcp
> > socket */
> > +     void                    (*clcsk_state_change)(struct sock
> > *sk);
> > +                                             /* original
> > stat_change fct. */
> > +     void                    (*clcsk_data_ready)(struct sock
> > *sk);
> > +                                             /* original
> > data_ready fct. */
> > +     void                    (*clcsk_write_space)(struct sock
> > *sk);
> > +                                             /* original
> > write_space fct. */
> > +     void                    (*clcsk_error_report)(struct sock
> > *sk);
> > +                                             /* original
> > error_report fct. */
> > +
> >  };
> >  
> >  #define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
> > diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
> > index bece346dd8e9..3c54faef6042 100644
> > --- a/net/smc/smc_inet.c
> > +++ b/net/smc/smc_inet.c
> > @@ -60,16 +60,22 @@ static struct inet_protosw smc_inet_protosw = {
> >  };
> >  
> >  #if IS_ENABLED(CONFIG_IPV6)
> > +struct smc6_sock {
> > +     struct smc_sock smc;
> > +     struct ipv6_pinfo np;
> > +};
> > +
> >  static struct proto smc_inet6_prot = {
> > -     .name           = "INET6_SMC",
> > -     .owner          = THIS_MODULE,
> > -     .init           = smc_inet_init_sock,
> > -     .hash           = smc_hash_sk,
> > -     .unhash         = smc_unhash_sk,
> > -     .release_cb     = smc_release_cb,
> > -     .obj_size       = sizeof(struct smc_sock),
> > -     .h.smc_hash     = &smc_v6_hashinfo,
> > -     .slab_flags     = SLAB_TYPESAFE_BY_RCU,
> > +     .name                  = "INET6_SMC",
> > +     .owner                 = THIS_MODULE,
> > +     .init                  = smc_inet_init_sock,
> > +     .hash                  = smc_hash_sk,
> > +     .unhash                = smc_unhash_sk,
> > +     .release_cb            = smc_release_cb,
> > +     .obj_size              = sizeof(struct smc6_sock),
> > +     .h.smc_hash            = &smc_v6_hashinfo,
> > +     .slab_flags            = SLAB_TYPESAFE_BY_RCU,
> > +     .ipv6_pinfo_offset = offsetof(struct smc6_sock, np),
>
> The line above together with the definition of struct smc6_sock seem to
> be the only changes relevant to fixing the issue, IMHO.

However, modifying the smc_sock structure is absolutely necessary. This is
because smc_sk(sk)->clcsock and inet_sk(sk)->pinet6 point to the same
address in the current smc_sock structure definition, so when
smc_create_clcsk() is called from inet6_create(), the already initialized
inet_sk(sk)->pinet6 will be overwritten by clcsock.

>
> >  };
> >  
> >  static const struct proto_ops smc_inet6_stream_ops = {
> > --
> >
>
> Thanks, Gerd

Regards,
Jeongjun Park
