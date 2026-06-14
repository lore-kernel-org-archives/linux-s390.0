Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0F23AE9B
	for <linux-s390@vger.kernel.org>; Sun, 14 Jun 2026 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781438994; cv=none; b=gXL0xizh5aZEQLjHs4Ixtdui30YcpnPSpazHK/HHd98whXspM0dNNqy6u6CwsWUuB38gm9Q/TezdrXG0B4Vt9FDtaczYnIFNZ3lrC54lo/6Kdibk/8Wx5RIGuCCI1jEDvLDcKCg/8QCug1lB5U8qSzNIEZy3tmd0o9MyNLGFk/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781438994; c=relaxed/simple;
	bh=ENl8qycC4hOgV9OJcdWSk1WCzOza6yzUWtNtzRZMFY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J2KC5MuRTGgoV5zyMF77/LdHXTI9rVMLcGoOOURrUmaqzLmkOG10KXunWNTxcJcix7e7WuhAAsKiQ7ZwOVSFxKtYlftcFSbohCtvL31Q+bR//syVXtYbRriCcIOA0ORfRfUnHSdpmNBngC/WeVoI5zdWhDHbWvlNRtkwqIHkbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAicbphZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAicbphZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso2444908a91.2
        for <linux-s390@vger.kernel.org>; Sun, 14 Jun 2026 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781438992; x=1782043792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IBz8xwezxj1aIuO0db8vVWpBd4FeH4XlQcs+DSABQC8=;
        b=iAicbphZEk3Mmjed3KjMcjmUGU1Uv6F8ceO9iTIurE7KFL6E1n5BQlBw5laN71ubJz
         VGQeANWZFOFIs3PAdkOH47kqzFubfa0idjt6IdKOt4ubP2I8CabGL4UiiZcApfx1x1QS
         1D0c3XLsN+cUbRWYzydlvDeHNl8yt8s5fY9tnixWqZglCyRveVcHZ8o2youENAEBbTB0
         Zp3o+H9Rib3vQ61aLhXAhtoS3XSKxqKm2PWP3pJs8Gk/AwYacvpFf8eBQzF2gvCAsbZO
         0JVyEXc2mey14jLnRDHL98gBJnHNOTKiBMyiL0GTkVYUpjvZJj4Qkemgs+0R/3Xm51U3
         cJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781438992; x=1782043792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBz8xwezxj1aIuO0db8vVWpBd4FeH4XlQcs+DSABQC8=;
        b=hYudltb/PS2sQVLpfANwCh0A5HMYg9a+mBa5SnJf8mKxMl2qHeaOiHaj4eZ2noLbQb
         O7C2tCC3AzH7SOeRqlQ2A7s0Fi1Y9gn/FeC5U1nuuz92xIr4UgoJPBMMnPOZoxYsiORY
         SuyvKnf9M+XbziYIN/tIiWSeJpOFUmYHOBM2uijYM/5Yp1zEHeKJvwdpvmJYKSeStmJK
         SyfIAzZKDChPWJNs183Ge6eS5Nnak5K6pV+AydkDfAJf5IDfCkkIf3jxzNKes4RL+hob
         ZfUcZM0+vt3XmAk47FzRhLfMdWsRke2q3wwF2rE5drdxc3soaoLaUYUH007lTFBZnkz8
         MBiw==
X-Forwarded-Encrypted: i=1; AFNElJ/0XQwrYJhW4ltJHewfv1vyw6evTclXgC55ZLtX7Wz7JcB6R08jbXvaKtr6kdvPNJAmS5+N6kTOQ52p@vger.kernel.org
X-Gm-Message-State: AOJu0YzlHmbIBNK31OV12Gcxbq+EN6RZxMCFpEQlE2KmsIZN6HTQ95dj
	bVGadX0184OZihWt8Gw5jyaTqaEduFtX0QJHOWqNxqcBv44vb19w1tT9
X-Gm-Gg: Acq92OGZejXwOisNE50KcZtDl+i8WxaPeUNLS9xpJG8Qp+jHbkjHEtM+DgbU8Ptd1Kq
	FFcjPwPwNwnEbMHfni1Diof8AxWn43QFzKWNsqAa1x07kf+o2pAirkZJQu5C4Hib1zzJcp9DkQm
	nYOeqH8NFLmQKNMc3FPiRUkMSscXCN+loRzCeX6saitu4BOviDU5is9EUgbfn8BH7xTkPV5j8Xn
	HDW8APpwQ0+fhqZbp7AISfchstW48tS3ifHdaGLNcGp6P2Ik8qTgPiGUhH/0tNBHFqdsoNejHKJ
	QUSxSWW6qJqvbkXeYLX6oHiYtKfSe1vQs9EKxrF/Gbgw+geAYxAkaxawylv2yzLR1dTLoNiy3Q3
	YWVZO3YrVqWEVdWa8d4+Wc3domk9/RIx0M/wyVJqpHABlgnzr2bb5PUVqy9G3b2h9mKFdO50Dta
	YdhfSdFKRXFNCaBzkK842uIUMQYuFak1R2P1eAOUWOEvyQzoFfi5pO0LU0LTKIpSgBQpYyXy2s
X-Received: by 2002:a17:90b:2884:b0:36d:635a:ac1b with SMTP id 98e67ed59e1d1-37a03ccdeadmr11438677a91.22.1781438992123;
        Sun, 14 Jun 2026 05:09:52 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a20dbc386sm7260143a91.11.2026.06.14.05.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 05:09:51 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Guvenc Gulce <guvenc@linux.ibm.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/smc: fix out-of-bounds read in smc_clcsock_data_ready()
Date: Sun, 14 Jun 2026 12:09:30 +0000
Message-ID: <20260614120931.4041687-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_clcsock_data_ready() is installed on the listen socket and reads its
sk_user_data as an smc_sock. A passive-open child inherits this callback,
but sk_clone_lock() clears the child's sk_user_data because it is tagged
SK_USER_DATA_NOCOPY. smc_tcp_syn_recv_sock() restores the child's af_ops,
but the inherited sk_data_ready() is left in place until accept.

In that window the child is established. A cgroup sock_ops program can run
bpf_sock_hash_update() on it from tcp_init_transfer(); sk_psock_init()
stores a sk_psock in the NULL sk_user_data. The inherited callback then
reads sk_user_data via smc_clcsock_user_data(), which masks only
SK_USER_DATA_NOCOPY, mistakes the sk_psock for an smc_sock, and reads a
callback pointer past the end of the sk_psock:

  BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
  Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
   <IRQ>
   smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
   tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
   tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
   tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
   tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
   ip_protocol_deliver_rcu+0x226/0x420 net/ipv4/ip_input.c:207
   ip_local_deliver_finish+0x35a/0x5f0 net/ipv4/ip_input.c:241
   __netif_receive_skb_one_core+0x1e5/0x210 net/core/dev.c:6216
   process_backlog+0x631/0x1470 net/core/dev.c:6682
   __napi_poll+0xb3/0x320 net/core/dev.c:7749
   net_rx_action+0x4fa/0xcb0 net/core/dev.c:7969
   handle_softirqs+0x236/0x800 kernel/softirq.c:622
   </IRQ>

  Allocated by task 67930:
   sk_psock_init+0x142/0x740 net/core/skmsg.c:766
   sock_map_link+0x646/0xdf0 net/core/sock_map.c:279
   sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
   bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
   __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
   tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
   tcp_rcv_state_process+0x241e/0x4940 net/ipv4/tcp_input.c:7231
   tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002

Restore the inherited sk_data_ready() in smc_tcp_syn_recv_sock(), where the
child's sk_user_data is already cleared, rather than only at accept.

Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/smc/af_smc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b5db69073e20..152971e8ad17 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -156,6 +156,12 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	if (child) {
 		rcu_assign_sk_user_data(child, NULL);
 
+		/*
+		 * the child inherited the listen-specific sk_data_ready();
+		 * restore it here, as sk_user_data may be reused before accept
+		 */
+		child->sk_data_ready = smc->clcsk_data_ready;
+
 		/* v4-mapped sockets don't inherit parent ops. Don't restore. */
 		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
 			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
-- 
2.43.0

