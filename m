Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072B13A86D;
	Wed, 14 Feb 2024 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938979; cv=none; b=t2izbg+Ddkp+pQ7KmXJEga+sk/hX1M6NjkmbD50M7vNHo+LbXaH0jPrYCDWJ/W2QiFILB0Necwyc4BMznHx5r+ahbJXq1ezFGaQn4qUh4NV6c1wFAICWhRscd8uDxkE9FIJGyxQeE3zVsRkp58ShgdredsbMDKzDj1uZqvlSZPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938979; c=relaxed/simple;
	bh=QCzp9YRA0AxQJiFdycILk1iurRLZLIhZs0fhSe5HG9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pm+YWeaxXMITdRdTw0qO8BcQPlf0OrYSqcqGGETCaSFZeKeY5rofRzphia5pnwopRdJBiRvZhk15Gdo9AKvXwXm3nXbsJwzUDmVuNbY4zCT2+1xiuFG7JYfdo6/IwJC9mb0WWwmW0tc/PgssdeH2/2A8RaG0D5oaxP2BZkA+SlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BA1KCijj; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BA1KCijj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707938979; x=1739474979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A2LKqF9/h28swVm/TIDUenPcS+Zte+SxcuuXg7Wf8w8=;
  b=BA1KCijjjDc8B7Ucu9YIAjGQ1J4HEppi2cafC/F7FBwkXTYPCi1nXwD8
   esrqnQV3wCVEGmxWn0zZVr0DDvU0vibblpAYm4f8HO3PWR0hTVe/QUL5s
   N3ieQrp8nXnm/0+9I9SP2j7qopsQIwX3OwmmE1hVy38Lufne88O/8EN+Z
   s=;
X-IronPort-AV: E=Sophos;i="6.06,160,1705363200"; 
   d="scan'208";a="274170742"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:29:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:39233]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.156:2525] with esmtp (Farcaster)
 id 45d1ec6a-d6a5-4596-ad6e-808d1aeffb85; Wed, 14 Feb 2024 19:29:35 +0000 (UTC)
X-Farcaster-Flow-ID: 45d1ec6a-d6a5-4596-ad6e-808d1aeffb85
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 19:29:32 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 19:29:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gbayer@linux.ibm.com>
CC: <alibuda@linux.alibaba.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<guwen@linux.alibaba.com>, <jaka@linux.ibm.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux-s390@vger.kernel.org>,
	<martineau@kernel.org>, <matttbe@kernel.org>, <mptcp@lists.linux.dev>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <tonylu@linux.alibaba.com>,
	<wenjia@linux.ibm.com>
Subject: Re: [PATCH v1 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.
Date: Wed, 14 Feb 2024 11:29:20 -0800
Message-ID: <20240214192920.1333-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7e387643370020483fb53f2c1e9dfd2b9ba28818.camel@linux.ibm.com>
References: <7e387643370020483fb53f2c1e9dfd2b9ba28818.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 14 Feb 2024 09:14:33 +0100
> On Tue, 2024-02-13 at 14:31 -0800, Kuniyuki Iwashima wrote:
> 
> Hi Kuniyuki,
> 
> I'm adding the newly appointed SMC maintainers to chime in.
> 
> > Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> > removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22
> > ("net:
> > remove SOCK_DEBUG macro") removed the macro.
> > 
> > Now is the time to deprecate the oldest socket option.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/sock.h  | 1 -
> >  net/core/sock.c     | 6 +++---
> >  net/mptcp/sockopt.c | 4 +---
> >  net/smc/af_smc.c    | 5 ++---
> >  4 files changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 88bf810394a5..0a58dc861908 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1194,10 +1194,9 @@ int sk_setsockopt(struct sock *sk, int level,
> > int optname,
> >  
> >         switch (optname) {
> >         case SO_DEBUG:
> > +               /* deprecated, but kept for compatibility. */
> Not 100% sure about the language - but isn't the DEBUG feature
> *removed* rather than just *deprecated*?

SO_DEBUG is still here, and the user won't get -ENOPROTOOPT.
That's why I wrote deprecated, no strong preference though.

> 
> >                 if (val && !sockopt_capable(CAP_NET_ADMIN))
> >                         ret = -EACCES;
> > -               else
> > -                       sock_valbool_flag(sk, SOCK_DBG, valbool);
> >                 break;
> >         case SO_REUSEADDR:
> >                 sk->sk_reuse = (valbool ? SK_CAN_REUSE :
> > SK_NO_REUSE);
> > @@ -1619,7 +1618,8 @@ int sk_getsockopt(struct sock *sk, int level,
> > int optname,
> >  
> >         switch (optname) {
> >         case SO_DEBUG:
> > -               v.val = sock_flag(sk, SOCK_DBG);
> > +               /* deprecated. */
> Same here.
> 
> > +               v.val = 0;
> >                 break;
> >  
> >         case SO_DONTROUTE:
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index da37e4541a5d..f6d90eef3d7c 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -81,7 +81,7 @@ static void mptcp_sol_socket_sync_intval(struct
> > mptcp_sock *msk, int optname, in
> >  
> >                 switch (optname) {
> >                 case SO_DEBUG:
> > -                       sock_valbool_flag(ssk, SOCK_DBG, !!val);
> > +                       /* deprecated. */
> and here.
> 
> >                         break;
> >                 case SO_KEEPALIVE:
> >                         if (ssk->sk_prot->keepalive)
> > @@ -1458,8 +1458,6 @@ static void sync_socket_options(struct
> > mptcp_sock *msk, struct sock *ssk)
> >                 sk_dst_reset(ssk);
> >         }
> >  
> > -       sock_valbool_flag(ssk, SOCK_DBG, sock_flag(sk, SOCK_DBG));
> > -
> >         if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
> >                 tcp_set_congestion_control(ssk, msk->ca_name, false,
> > true);
> >         __tcp_sock_set_cork(ssk, !!msk->cork);
> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > index 66763c74ab76..062e16a2766a 100644
> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -445,7 +445,6 @@ static int smc_bind(struct socket *sock, struct
> > sockaddr *uaddr,
> >                              (1UL << SOCK_LINGER) | \
> >                              (1UL << SOCK_BROADCAST) | \
> >                              (1UL << SOCK_TIMESTAMP) | \
> > -                            (1UL << SOCK_DBG) | \
> >                              (1UL << SOCK_RCVTSTAMP) | \
> >                              (1UL << SOCK_RCVTSTAMPNS) | \
> >                              (1UL << SOCK_LOCALROUTE) | \
> > @@ -511,8 +510,8 @@ static void smc_copy_sock_settings_to_clc(struct
> > smc_sock *smc)
> >  
> >  #define SK_FLAGS_CLC_TO_SMC ((1UL << SOCK_URGINLINE) | \
> >                              (1UL << SOCK_KEEPOPEN) | \
> > -                            (1UL << SOCK_LINGER) | \
> > -                            (1UL << SOCK_DBG))
> > +                            (1UL << SOCK_LINGER))
> > +
> >  /* copy only settings and flags relevant for smc from clc to smc
> > socket */
> >  static void smc_copy_sock_settings_to_smc(struct smc_sock *smc)
> >  {
> The SMC changes look good to me, so feel free to add my
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>

Thanks!
