Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B113B7B5;
	Wed, 14 Feb 2024 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940464; cv=none; b=ohNJuvzdL3+6NnRCrPyTKddgeAiyDC0HZG9a1JYO8t0UcFKXg9hXCG566yAalxXo7UJizDuAGsSkhnfbBI0/P1JP0uFTb6Dj1YJrNUx9+JbwBPIo1yuAd7I0zIOoq0eP30aiBvtA97vfUe2smWwwfPY5YWRnNZ1KKu4ordM9XEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940464; c=relaxed/simple;
	bh=pX5ktANLCNHhzCAQMMNXkAAqI+3XxyypNCoWVaVyTY8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=svFUrwEcuQFMMfxiIWc3fRUANN4PtLUTfN7jUfGL88B2zn5jJiJ63vcfMnMWl8eAgg9PObyLTE8l3eQBxfqJ+MveJE6fzLdvUzP7K7XEQBI6VqyTdrDoeUWPq1EeW8FLi7ZGuoDA/0LzOX2M/bDLxu8JvF3EoV7Jos6q3dLny9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bBAEB9XS; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bBAEB9XS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707940462; x=1739476462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m2Q4OpjpGBz9kVmtpoHuc0YezpxFLS/C2T7bgx3/2Rs=;
  b=bBAEB9XSdyf/bm3bMMwTG6zHY3IWoDdJ3lFiM5HR0biDaYGVZVzl6cmH
   GldFkoUAhOVgd8nHVkHwhCnOEXtA51tZ3EUwGt+58A+NXu8E9BNV3f32y
   G3nsI7SEyUUarl+5qNVVOk+KLSXnOA2G7VWoWVAZHjAcxXUC3PjdXuIlK
   M=;
X-IronPort-AV: E=Sophos;i="6.06,160,1705363200"; 
   d="scan'208";a="66063691"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:54:20 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:1991]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.156:2525] with esmtp (Farcaster)
 id b23fa01d-caf8-4308-b77a-06c46f123499; Wed, 14 Feb 2024 19:54:20 +0000 (UTC)
X-Farcaster-Flow-ID: b23fa01d-caf8-4308-b77a-06c46f123499
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 19:54:20 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 19:54:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
	<martineau@kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
	<jaka@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, Tony Lu
	<tonylu@linux.alibaba.com>, "D . Wythe" <alibuda@linux.alibaba.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-s390@vger.kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH v2 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.
Date: Wed, 14 Feb 2024 11:54:07 -0800
Message-ID: <20240214195407.3175-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net:
remove SOCK_DEBUG macro") removed the macro.

Now is the time to deprecate the oldest socket option.

Note that setsockopt(SO_DEBUG) is moved not to acquire lock_sock().

Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Move setsockopt(SO_DEBUG) code not to acquire lock_sock().

v1: https://lore.kernel.org/netdev/20240213223135.85957-1-kuniyu@amazon.com/
---
 include/net/sock.h  |  1 -
 net/core/sock.c     | 14 +++++++-------
 net/mptcp/sockopt.c |  8 +-------
 net/smc/af_smc.c    |  5 ++---
 4 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index a9d99a9c583f..e20d55a36f9c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -909,7 +909,6 @@ enum sock_flags {
 	SOCK_TIMESTAMP,
 	SOCK_ZAPPED,
 	SOCK_USE_WRITE_QUEUE, /* whether to call sk->sk_write_space in sock_wfree */
-	SOCK_DBG, /* %SO_DEBUG setting */
 	SOCK_RCVTSTAMP, /* %SO_TIMESTAMP setting */
 	SOCK_RCVTSTAMPNS, /* %SO_TIMESTAMPNS setting */
 	SOCK_LOCALROUTE, /* route locally only, %SO_DONTROUTE setting */
diff --git a/net/core/sock.c b/net/core/sock.c
index 88bf810394a5..c4c406f4742e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1115,6 +1115,11 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 
 	/* handle options which do not require locking the socket. */
 	switch (optname) {
+	case SO_DEBUG:
+		/* deprecated, but kept for compatibility */
+		if (val && !sockopt_capable(CAP_NET_ADMIN))
+			ret = -EACCES;
+		return 0;
 	case SO_PRIORITY:
 		if ((val >= 0 && val <= 6) ||
 		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
@@ -1193,12 +1198,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	sockopt_lock_sock(sk);
 
 	switch (optname) {
-	case SO_DEBUG:
-		if (val && !sockopt_capable(CAP_NET_ADMIN))
-			ret = -EACCES;
-		else
-			sock_valbool_flag(sk, SOCK_DBG, valbool);
-		break;
 	case SO_REUSEADDR:
 		sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
 		break;
@@ -1619,7 +1618,8 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	switch (optname) {
 	case SO_DEBUG:
-		v.val = sock_flag(sk, SOCK_DBG);
+		/* deprecated. */
+		v.val = 0;
 		break;
 
 	case SO_DONTROUTE:
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index da37e4541a5d..31d09009332a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -80,9 +80,6 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		bool slow = lock_sock_fast(ssk);
 
 		switch (optname) {
-		case SO_DEBUG:
-			sock_valbool_flag(ssk, SOCK_DBG, !!val);
-			break;
 		case SO_KEEPALIVE:
 			if (ssk->sk_prot->keepalive)
 				ssk->sk_prot->keepalive(ssk, !!val);
@@ -183,7 +180,6 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_KEEPALIVE:
 		mptcp_sol_socket_sync_intval(msk, optname, val);
 		return 0;
-	case SO_DEBUG:
 	case SO_MARK:
 	case SO_PRIORITY:
 	case SO_SNDBUF:
@@ -329,7 +325,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_RCVBUFFORCE:
 	case SO_MARK:
 	case SO_INCOMING_CPU:
-	case SO_DEBUG:
 	case SO_TIMESTAMP_OLD:
 	case SO_TIMESTAMP_NEW:
 	case SO_TIMESTAMPNS_OLD:
@@ -363,6 +358,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_WIFI_STATUS:
 	case SO_NOFCS:
 	case SO_SELECT_ERR_QUEUE:
+	case SO_DEBUG: /* deprecated */
 		return 0;
 	}
 
@@ -1458,8 +1454,6 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 		sk_dst_reset(ssk);
 	}
 
-	sock_valbool_flag(ssk, SOCK_DBG, sock_flag(sk, SOCK_DBG));
-
 	if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
 	__tcp_sock_set_cork(ssk, !!msk->cork);
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 66763c74ab76..062e16a2766a 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -445,7 +445,6 @@ static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
 			     (1UL << SOCK_LINGER) | \
 			     (1UL << SOCK_BROADCAST) | \
 			     (1UL << SOCK_TIMESTAMP) | \
-			     (1UL << SOCK_DBG) | \
 			     (1UL << SOCK_RCVTSTAMP) | \
 			     (1UL << SOCK_RCVTSTAMPNS) | \
 			     (1UL << SOCK_LOCALROUTE) | \
@@ -511,8 +510,8 @@ static void smc_copy_sock_settings_to_clc(struct smc_sock *smc)
 
 #define SK_FLAGS_CLC_TO_SMC ((1UL << SOCK_URGINLINE) | \
 			     (1UL << SOCK_KEEPOPEN) | \
-			     (1UL << SOCK_LINGER) | \
-			     (1UL << SOCK_DBG))
+			     (1UL << SOCK_LINGER))
+
 /* copy only settings and flags relevant for smc from clc to smc socket */
 static void smc_copy_sock_settings_to_smc(struct smc_sock *smc)
 {
-- 
2.30.2

