Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A633BC680
	for <linux-s390@vger.kernel.org>; Sun, 27 Sep 2026 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494337; cv=none; b=s5t86QN7uoGjmQTSnDg/i4GYAQIeDiGZ//sjz6COfNIyTmixa+xmHNEGbCWi8cTtAWbG3YnYV2pB7vxdEYur7jcyU7F1qNBdL+JSnnzO6CXA3HZg0DJQQxVufiG4Ge3M+6sbgJ0qwjgxtBYewqAlUC4wOGLzCbL1Hdtd751R8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494337; c=relaxed/simple;
	bh=nY8qGs46zgeEK17RWUhh5D/oORqRp0Zwjy2eAU1BJVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOVrNM1/toRfQngHiuQGrV3fupEVNoUjR9B9aXkK04mZ7rWMDKr7dqNWfoQya30wU/xIc+3xgzeIiMwE6fIo26VOF4Z/AAg3Ge5I5pKl18jRIlaP/d48BlMQbFF6V+xjionOYsJEk2TVXyL9xTqdGffg9PbRVUKSQtY2mQWEXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHv66hE+; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHv66hE+"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-340f45daf45so204627eec.3
        for <linux-s390@vger.kernel.org>; Sun, 27 Sep 2026 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790494332; x=1791099132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gCHlGAQUPQqUwMiZODOWYGN6xif3TdPxiD76nVrz+oA=;
        b=AHv66hE+453a1o7CCAhJdKZZzPPjIciAqAg0DNN9j5vvISW63i8NiBAdyleUetCeF0
         EWN0bO5YGoTsQlT+cWBlPqy1J4qcxIL9ClgcpRRL6k/uowZ72xM/Q7MYg90ZYbX74A2t
         pJWKQ6/+1ZKnbQMQNzRpnprnEfzGvN4F3hLNQHUJW0+l5/Ua/PbDDy1JqPdOx/A6t7V9
         xYeb5wKsNzcrGjdTShWBNirv0AMsR8oqjKpKa6xyG7rvg+GyEB/VWKru4nIJK53QP4yG
         fkRE1JUSqpcyUXgNNL0JMAKBlqm9qirduMLe/x5i7NszncNakSLS6ucuejuz474lZliu
         As4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790494332; x=1791099132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gCHlGAQUPQqUwMiZODOWYGN6xif3TdPxiD76nVrz+oA=;
        b=jOptIJ0Ke/tt52KbCn1XG1vfSNCLHWsNurii6JG/uaNQ52aW1I9jy778NkO1rzkf77
         So9tuCIJ/lsrFc7iaqPHnFzQNB1cAZ7N6v6A9yTiwgb0sPoqeFmhIxyI/ljYtMXMAq7r
         kJEFmvCO93JX3B47FNP3Z+ykJglw37i43BOn9w8XBoCDaSYZWQzSeqpdtIwWQV07Gefo
         CApNGvhfWF9hPrR9jknsZfGOHDZdyFigfCnz7cs7bA+vKX8BOO39vlcPt08rcnSidngQ
         c13yy5E75dHFRXaqwSPtFJkOFss2QsCCHYI/UfI5Oxo6GIK4qldqucyB5O6eDrc7xuF0
         56AQ==
X-Forwarded-Encrypted: i=1; AKwUvByVqTpYLzGWppak0GgUrWDtWoHbeAySiNFkr5zogesfYTJtVZNM22aEo8Wf18XbK7y0WidJ1NQm6oOL@vger.kernel.org
X-Gm-Message-State: AFq9FYKzSVGE+mWzkgCfzA/JMCS13Ep/ZI4KF3sCvxq8M80KQbP8w51Z
	HyeBKBiPslArKdlZuIcqNnBXiuhMYo2tsPP3zoN1L3UHiICcE6zFbPgV
X-Gm-Gg: AYBFou2O8itEEuhQaO52/9DmHy4XNuh/aMEopCrSMQFawzF6lVGTrzJlIXZQp02w42V
	KJuVNzc3ZvVa7LZir82JG4OoHxGyXuN0c/fL8lsfMFLqTumC+TyKAKWa410jooOyK1+HNp88kWm
	TeJaltFzRdDO0B4Gns9fk1JFhn/TKgmDMk0Vekv+eMCc++v59rEJgrZFiym/Dh5G7HzIq3Timcm
	27Ndui7UlFuHLSCWmNAqVAGB8UkK0FqpISV+7u67JvrgEr5kBXCieuOywW2etm0C7Md4OOZvCzC
	L0tvkuaAic0enaccjcdXzH2ivf+olk+1Q6638ab7ezJ2KMBaG2JtSgLyVwE54ZNzjHyI4Vr58uM
	DZ0F3HzlS1lJmMbsK1H9NVVqBYN2IczLFmHFjG+4hPfgamgQrVygcRmz5S78VhBMPqrVZ/OUyIu
	T2Hcp9M490Hj//3Bojc8dhEX9OeRKbEqgTi9Hn+mA/E4cec2x2dMBmLWhNsVOMO5pK/DJyLEt8g
	+2gsZpIELygzDFiP11nPXCqgbFtcHYhO81U2laUWqct+YxWNh7o/Jk/Pg8zDqOwboK0ug==
X-Received: by 2002:a05:7301:b0e:b0:33f:3750:4e22 with SMTP id 5a478bee46e88-3426cce6521mr7959749eec.0.1790494331059;
        Sun, 27 Sep 2026 00:32:11 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3433628f5basm10705821eec.18.2026.09.27.00.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:32:10 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/smc: serialize sndbuf descriptor release with diagnostic dumps
Date: Sun, 27 Sep 2026 15:32:03 +0800
Message-ID: <20260927073203.3694279-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An SMC-D connection can remain in the socket hash while smc_conn_kill()
tears it down. For devices supporting DMB nocopy, smcd_buf_detach() frees
the send buffer descriptor without taking the hash lock held by the
diagnostic reader.

__smc_diag_dump() can load a non-NULL conn->sndbuf_desc, then a concurrent
smc_conn_kill() can clear the pointer and free the descriptor before the
dump reads its len field. The socket lock held by the teardown path does
not exclude the dump, and clearing the pointer before freeing it does
not protect a reader that has already loaded it.

KASAN reported:

  BUG: KASAN: slab-use-after-free in __smc_diag_dump.constprop.0+0x2477/0x2b10
  Call Trace:
   __smc_diag_dump.constprop.0+0x2477/0x2b10
   smc_diag_dump_proto+0x266/0x390
   smc_diag_dump+0x20/0x70
   netlink_dump+0x489/0x1140
  Allocated by task 70:
   smcd_buf_attach+0x11b/0x310
   smc_listen_work+0x2a62/0x4cf0
  Freed by task 98:
   kfree+0x131/0x3c0
   smcd_buf_detach+0x120/0x280
   smc_conn_kill+0x487/0x720
   __smc_lgr_terminate.part.0+0x231/0x430
   smc_smcd_terminate_all+0x2cf/0x610

Take the hash write lock when removing the descriptor from the
connection. This waits for dumps holding the old pointer and prevents
new dumps from seeing it. Free the descriptor after dropping the lock.

Fixes: ae2be35cbed2 ("net/smc: {at|de}tach sndbuf to peer DMB if supported")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/smc/smc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 9974149659c2..f32fc1bd5bc8 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1207,6 +1207,8 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 
 static void smcd_buf_detach(struct smc_connection *conn)
 {
+	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
+	struct smc_hashinfo *h = smc->sk.sk_prot->h.smc_hash;
 	struct smcd_dev *smcd = conn->lgr->smcd;
 	u64 peer_token = conn->peer_token;
 	struct smc_buf_desc *buf_desc;
@@ -1216,8 +1218,10 @@ static void smcd_buf_detach(struct smc_connection *conn)
 
 	smc_ism_detach_dmb(smcd, peer_token);
 
+	write_lock_bh(&h->lock);
 	buf_desc = conn->sndbuf_desc;
 	conn->sndbuf_desc = NULL;
+	write_unlock_bh(&h->lock);
 	kfree(buf_desc);
 }
 
-- 
2.43.0

