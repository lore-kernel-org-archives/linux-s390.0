Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9609627EC;
	Tue, 13 Feb 2024 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863518; cv=none; b=Hb9LdLFv25hhwGqe3ZvPGWKQiweSOm3LG+GEX25oIX7BmeEs0Jz0Pve37wRLCsvyJg7ATFn6NQ3ER7twCTS1vnm2Qra0EdFh7b7n3YaTIHycrYDCZ5nIel8bRJn7H9NQSCIZB9RtKz0zIzcK+bAuWpCIZYqD6BVLpebSlxC8UKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863518; c=relaxed/simple;
	bh=AjyFJoB2E5hmBxbkwSQYS3RBJ8kjXzZkJDGogqKHWkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fo7mwjFjzUnewEdeToTBzH00koXQuRVuye4N/R1QOpZvcEy8OJ9V/3pjxrV5t7Nkq/wnBxwaxExkzDBg7vQMYaUzSc7PUuLC+O0nxyiXUmaXZABhtuia7e0GENqTCUmglhdygDnf/l7SgV4k40Y8pBBzKZm+r3SZjBokCqC+8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LkQy69fs; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LkQy69fs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707863516; x=1739399516;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xASju9eOcReBWPS5XiOgqPyTtw+QoZR04RComZSbo04=;
  b=LkQy69fs1jYhP477KyLFvEcnTA3qVobwW3xFS4xzjTQPWKk3U6veeQ4W
   fRS+s6DbuTTT1v0Pn4nZS86Qk7wUW8XNxr+uMW2BzxcUcG7Tam4NPH6ll
   1hGCGfSsajQS24/aOvoOr8gklaqlnZCnMwdun/DOded8ywEZqQVPPppRk
   E=;
X-IronPort-AV: E=Sophos;i="6.06,158,1705363200"; 
   d="scan'208";a="65833263"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 22:31:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:35044]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.112:2525] with esmtp (Farcaster)
 id 5276ae52-4884-4071-a6ca-c88b58983b92; Tue, 13 Feb 2024 22:31:53 +0000 (UTC)
X-Farcaster-Flow-ID: 5276ae52-4884-4071-a6ca-c88b58983b92
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 22:31:53 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 22:31:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
	<martineau@kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
	<jaka@linux.ibm.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-s390@vger.kernel.org>
Subject: [PATCH v1 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.
Date: Tue, 13 Feb 2024 14:31:35 -0800
Message-ID: <20240213223135.85957-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net:
remove SOCK_DEBUG macro") removed the macro.

Now is the time to deprecate the oldest socket option.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/sock.h  | 1 -
 net/core/sock.c     | 6 +++---
 net/mptcp/sockopt.c | 4 +---
 net/smc/af_smc.c    | 5 ++---
 4 files changed, 6 insertions(+), 10 deletions(-)

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
index 88bf810394a5..0a58dc861908 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1194,10 +1194,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 
 	switch (optname) {
 	case SO_DEBUG:
+		/* deprecated, but kept for compatibility. */
 		if (val && !sockopt_capable(CAP_NET_ADMIN))
 			ret = -EACCES;
-		else
-			sock_valbool_flag(sk, SOCK_DBG, valbool);
 		break;
 	case SO_REUSEADDR:
 		sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
@@ -1619,7 +1618,8 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	switch (optname) {
 	case SO_DEBUG:
-		v.val = sock_flag(sk, SOCK_DBG);
+		/* deprecated. */
+		v.val = 0;
 		break;
 
 	case SO_DONTROUTE:
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index da37e4541a5d..f6d90eef3d7c 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -81,7 +81,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 
 		switch (optname) {
 		case SO_DEBUG:
-			sock_valbool_flag(ssk, SOCK_DBG, !!val);
+			/* deprecated. */
 			break;
 		case SO_KEEPALIVE:
 			if (ssk->sk_prot->keepalive)
@@ -1458,8 +1458,6 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
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

