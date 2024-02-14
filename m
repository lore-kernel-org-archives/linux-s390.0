Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC48127B5D;
	Wed, 14 Feb 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939353; cv=none; b=EJ3c++lhI3x6U4/WVVBDfAFx9HLRjiSZYGapHCo/rVHB5Xx5PDxOqxbUakU1tFfpjoFGI8OFLSIYPn57/iDT8hKaZDZVobBpquys4AeilWcOorW7zGVAdlChnrjVrKaZHJWvTm7sCip0ORr4JU5kMry0194GcpWcxuXmIM8hoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939353; c=relaxed/simple;
	bh=QP7und2hQX09U1WPUXWVo0KBd4aOKh6bm7cKpEUrsWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaKYDImXY0MSxUxJzl3rqDe9pYcSr3fm1c1oNELNQja61/uTQ3PGYH9Vo0BX1//WzR6JPvDuaNw6CCJm5UmbTwvbWyq9KVZpm9cGrMhCl8iwkdBM+CeEssUL//k//5oO6E1+87sO3Flrit0sGHM19RgZWukH6x0zGqIW/V9ho+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=N+s9jn2d; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N+s9jn2d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707939353; x=1739475353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/ODHAmclPhLwKDZzntU5CXS8RXhxdY9XMuaTQo5LYe8=;
  b=N+s9jn2dnbEEVDYpI1sl+gcTuHsh5mTNrSSZeBxzM/OZhSoPHhrfk35S
   suMQJv6HPXTdVx+m+QroEFWObRhoPAASmlR7pn1UZgVyiau9DVnTF8F7Z
   KnIUKBqLRA2pe64+GH3dpbMz3Hr2MQ3MsuMARIcZISklYrF71+TfQpRPM
   c=;
X-IronPort-AV: E=Sophos;i="6.06,160,1705363200"; 
   d="scan'208";a="381147143"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:35:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:24115]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.174:2525] with esmtp (Farcaster)
 id 6b0001ca-3680-478a-b891-afee419fc99b; Wed, 14 Feb 2024 19:35:47 +0000 (UTC)
X-Farcaster-Flow-ID: 6b0001ca-3680-478a-b891-afee419fc99b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 19:35:41 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 19:35:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <matttbe@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <jaka@linux.ibm.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-s390@vger.kernel.org>, <martineau@kernel.org>,
	<mptcp@lists.linux.dev>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<wenjia@linux.ibm.com>
Subject: Re: [PATCH v1 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.
Date: Wed, 14 Feb 2024 11:35:30 -0800
Message-ID: <20240214193530.1813-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <60d7072d-392e-489b-8889-404f3c753620@kernel.org>
References: <60d7072d-392e-489b-8889-404f3c753620@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Matthieu Baerts <matttbe@kernel.org>
Date: Wed, 14 Feb 2024 10:32:58 +0100
> Hi Kuniyuki,
> 
> On 13/02/2024 23:31, Kuniyuki Iwashima wrote:
> > Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> > removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net:
> > remove SOCK_DEBUG macro") removed the macro.
> > 
> > Now is the time to deprecate the oldest socket option.
> 
> Thank you for looking at this!
> 
> My review here below is only about the modifications related to MPTCP.
> 
> (...)
> 
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index da37e4541a5d..f6d90eef3d7c 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -81,7 +81,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
> >  
> >  		switch (optname) {
> >  		case SO_DEBUG:
> > -			sock_valbool_flag(ssk, SOCK_DBG, !!val);
> > +			/* deprecated. */
> 
> If it is now a NOOP, maybe better to:
> 
>  - remove SO_DEBUG from mptcp_sol_socket_sync_intval() and
>    mptcp_setsockopt_sol_socket_int()
> 
>  - move it just above the "return 0" in mptcp_setsockopt_sol_socket()
> with the "deprecated" (or "removed") comment
> 
> By doing that, we avoid a lock, plus going through the list of subflows
> for nothing.
> 
> WDYT?

Sounds good!

And I can apply the similar change to the general setsockopt()
not to take lock_sock().


> 
> >  			break;
> >  		case SO_KEEPALIVE:
> >  			if (ssk->sk_prot->keepalive)
> > @@ -1458,8 +1458,6 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
> >  		sk_dst_reset(ssk);
> >  	}
> >  
> > -	sock_valbool_flag(ssk, SOCK_DBG, sock_flag(sk, SOCK_DBG));
> > -
> >  	if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
> >  		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
> >  	__tcp_sock_set_cork(ssk, !!msk->cork);
> 
> The rest looks good to me.

Thanks!
