Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF904A02;
	Tue,  9 Jul 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541160; cv=none; b=hGa+6E2GshQ9ufnaGZ7Y9eyGAMSUUzliXELpjqPfSYXxSWLWklw8WUCzGWkiL4kSPWJdEA8734a4v9uPNlbT0K1NUICFGhGr06QcEeRbmVVukCMbm+1EkFMx0p7h6Y3wI4fhHpdbCHBtPL1jbkL+HkXvqG+KjOFolNB2J9QQgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541160; c=relaxed/simple;
	bh=nWTLXY9HN+du1MWjpjzvNyHlVCQplXKA4/1rwWPWQ6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sFdTSDMMwBGogYW8L7B7+WxhnHCfNTSuwIuwNg2MgfDwx5eGzisHYVZQdgrR/hBuRMICAws+FXHLt2MImgIlet+/clsEmm/pHD+Wv64T5k+cLLg80niVGyVYe0OE4UVDmxv+qrx24W8TtP1Kj4ysUpO5wYHoPH/x/W0ajjALzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dNxL2flB; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dNxL2flB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720541153; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Gef74ZFkoHmeg+9wnPO3M4CLYopK0Jl9u0mSEnTR2IY=;
	b=dNxL2flBUz1RtKAZCaPQgwzk/6P+bCex9N/gPqcglcC9d/iLFBohF/rAFQ+drw1eokAfZjwGDWicWoxSveu8fdeS6vq60ijCoiL7qv2TibmFbGLn8WSTBwgqWPv8HJ+d4ySwbD+hmIEB9YFRs6BVd1hNA3gBLKQMt7yKXLrVUj4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WACV18d_1720541151;
Received: from 192.168.0.111(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WACV18d_1720541151)
          by smtp.aliyun-inc.com;
          Wed, 10 Jul 2024 00:05:53 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/smc: introduce autosplit for smc
Date: Wed, 10 Jul 2024 00:05:51 +0800
Message-Id: <20240709160551.40595-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sending large size data in TCP, the data will be split into
several segments(packets) to transfer due to MTU config. And in
the receive side, application can be woken up to recv data every
packet arrived, the data transmission and data recv copy are
pipelined.

But for SMC-R, it will transmit as many data as possible in one
RDMA WRITE and a CDC msg follows the RDMA WRITE, in the receive
size, the application only be woken up to recv data when all RDMA
WRITE data and the followed CDC msg arrived. The data transmission
and data recv copy are sequential.

This patch introduce autosplit for SMC, which can automatic split
data into several segments and every segment transmitted by one RDMA
WRITE when sending large size data in SMC. Because of the split, the
data transmission and data send copy can be pipelined in the send side,
and the data transmission and data recv copy can be pipelined in the
receive side. Thus autosplit helps improving latency performance when
sending large size data. The autosplit also works for SMC-D.

This patch also introduce a sysctl names autosplit_size for configure
the max size of the split segment, whose default value is 128KiB
(128KiB perform best in my environment).

The sockperf benchmark shows 17%-28% latency improvement when msgsize
>= 256KB for SMC-R, 15%-32% latency improvement when msgsize >= 256KB
for SMC-D with smc-loopback.

Test command:
sockperf sr --tcp -m 1048575
sockperf pp --tcp -i <server ip> -m <msgsize> -t 20

Test config:
sysctl -w net.smc.wmem=524288
sysctl -w net.smc.rmem=524288

Test results:
SMC-R
msgsize   noautosplit    autosplit
128KB       55.546 us     55.763 us
256KB       83.537 us     69.743 us (17% improve)
512KB      138.306 us    100.313 us (28% improve)
1MB        273.702 us    197.222 us (28% improve)

SMC-D with smc-loopback
msgsize   noautosplit    autosplit
128KB       14.672 us     14.690 us
256KB       28.277 us     23.958 us (15% improve)
512KB       63.047 us     45.339 us (28% improve)
1MB        129.306 us     87.278 us (32% improve)

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
---
 Documentation/networking/smc-sysctl.rst | 11 +++++++++++
 include/net/netns/smc.h                 |  1 +
 net/smc/smc_sysctl.c                    | 12 ++++++++++++
 net/smc/smc_tx.c                        | 19 ++++++++++++++++++-
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index a874d007f2db..81b5296d79f4 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -71,3 +71,14 @@ smcr_max_conns_per_lgr - INTEGER
 	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
 
 	Default: 255
+
+autosplit_size - INTEGER
+	Setting SMC autosplit size. Autosplit is used to split sending data into
+	several segments when application sending data and the data size is larger
+	than autosplit size. Autosplit helps performing pipeline sending and pipeline
+	receiving for better latency performance when sending/receiving large size
+	data.
+	Autosplit_size ranges from 32KiB to 512MiB. Set autosplit_size to 512MiB means
+	disable autosplit.
+
+	Default: 128KiB
diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
index fc752a50f91b..26c7edeb71a3 100644
--- a/include/net/netns/smc.h
+++ b/include/net/netns/smc.h
@@ -24,5 +24,6 @@ struct netns_smc {
 	int				sysctl_rmem;
 	int				sysctl_max_links_per_lgr;
 	int				sysctl_max_conns_per_lgr;
+	unsigned int			sysctl_autosplit_size;
 };
 #endif
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index 13f2bc092db1..2aaf402acc11 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -29,6 +29,8 @@ static int links_per_lgr_min = SMC_LINKS_ADD_LNK_MIN;
 static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
 static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
 static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
+static unsigned int autosplit_size_min = SZ_32K;
+static unsigned int autosplit_size_max = SZ_512M; /* max size of snd/recv buffer */
 
 static struct ctl_table smc_table[] = {
 	{
@@ -90,6 +92,15 @@ static struct ctl_table smc_table[] = {
 		.extra1		= &conns_per_lgr_min,
 		.extra2		= &conns_per_lgr_max,
 	},
+	{
+		.procname	= "autosplit_size",
+		.data		= &init_net.smc.sysctl_autosplit_size,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= &autosplit_size_min,
+		.extra2		= &autosplit_size_max,
+	},
 };
 
 int __net_init smc_sysctl_net_init(struct net *net)
@@ -121,6 +132,7 @@ int __net_init smc_sysctl_net_init(struct net *net)
 	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
 	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
 	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
+	net->smc.sysctl_autosplit_size = SZ_128K;
 
 	return 0;
 
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 214ac3cbcf9a..331ce4ff7c6e 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -175,6 +175,21 @@ static bool smc_tx_should_cork(struct smc_sock *smc, struct msghdr *msg)
 	return false;
 }
 
+static inline bool smc_tx_should_split(struct smc_sock *smc, size_t *len)
+{
+	size_t split_size = sock_net(&smc->sk)->smc.sysctl_autosplit_size;
+
+	/* only split when len >= sysctl_autosplit_size * 1.3,
+	 * in case of a following tiny size xmit.
+	 */
+	if (*len >= (split_size * 4 / 3)) {
+		*len = split_size;
+		return true;
+	}
+
+	return false;
+}
+
 /* sndbuf producer: main API called by socket layer.
  * called under sock lock.
  */
@@ -185,6 +200,7 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 	struct smc_connection *conn = &smc->conn;
 	union smc_host_cursor prep;
 	struct sock *sk = &smc->sk;
+	bool is_split = false;
 	char *sndbuf_base;
 	int tx_cnt_prep;
 	int writespace;
@@ -235,6 +251,7 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		writespace = atomic_read(&conn->sndbuf_space);
 		/* not more than what user space asked for */
 		copylen = min_t(size_t, send_remaining, writespace);
+		is_split = smc_tx_should_split(smc, &copylen);
 		/* determine start of sndbuf */
 		sndbuf_base = conn->sndbuf_desc->cpu_addr;
 		smc_curs_copy(&prep, &conn->tx_curs_prep, conn);
@@ -281,7 +298,7 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		/* If we need to cork, do nothing and wait for the next
 		 * sendmsg() call or push on tx completion
 		 */
-		if (!smc_tx_should_cork(smc, msg))
+		if (is_split || !smc_tx_should_cork(smc, msg))
 			smc_tx_sndbuf_nonempty(conn);
 
 		trace_smc_tx_sendmsg(smc, copylen);
-- 
2.24.3 (Apple Git-128)

