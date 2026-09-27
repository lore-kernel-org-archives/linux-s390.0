Received: from mail-dl2-f21.google.com (mail-dl2-f21.google.com [74.125.229.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC53C3F67
	for <linux-s390@vger.kernel.org>; Sun, 27 Sep 2026 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790495172; cv=none; b=F4cuT80qe58Pl0HlDB/BmFQkaaKu2zlssFiUUOVblCP/1O8o6GZcIpAbDe9Lc/WVoooVlKe3t+QpkADYm9SJDa109yiNh+GvVuxvUR4M1u8wJkfHZwC3D4JthtkXoGNBz7fN8lsb05pHV5gFpMtPyqeWoXrdjIWwazgO9wzq8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790495172; c=relaxed/simple;
	bh=RGhJnf5GbbdO545DxKKBzB6+35VcnLhNLOUQSqAUEl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2QoLFWxMBFrRw5grE81rcoqcbXVf08nf0ucki1OSixTYXIAPyWKu+ykIMQpEi4OGoyOoX0bJHNXSD7snMFoACfabqptT+t0eWmELIY5S02KuJto9ix4IgzIiF1LAtZAjFKPYsCyR6GtSeiq+6pBRq+VX4UVV2Wh7/N8Oi4eU9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2FK8QLV; arc=none smtp.client-ip=74.125.229.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2FK8QLV"
Received: by mail-dl2-f21.google.com with SMTP id a92af1059eb24-1438421d1f8so64560c88.1
        for <linux-s390@vger.kernel.org>; Sun, 27 Sep 2026 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790495169; x=1791099969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIpYdnljm+rKdqL8zP6PbZGg5j820vV/IvXVHPJ2WOA=;
        b=h2FK8QLVwACU5o/ZNPTaVM4zpfnJPHq0ujCxHqI9ZIeLYN6T7vHzQXYHbOcrX1AYP0
         fSszXplsQOGFg2rt9dpRt86mZmTibxeiPqsr611VfOmsifCbFsaV7YrPWhNgr9Im6fON
         bfyKEIYzzBEwuVDxvFJnENRBgC+H+2tWpW4xYlazWb+SzqLjxA4kpbdmJHSeBfZNxMYn
         oTakB3p8OnZWTAAAAHqgJSQyqglk19R8wT+91sUckFJYOXqeJveZ6RUgmgdbT2sDLjhl
         1fa5P5qvmwr5jCt+qulAHSEmYifbuOywhlW46fl9ZbeGV7q5xcZGT/0qQ4W8lnC7NTRr
         jVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790495169; x=1791099969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIpYdnljm+rKdqL8zP6PbZGg5j820vV/IvXVHPJ2WOA=;
        b=NJYTfa91Z2shePa9NZbT4yHVqhO5y60e/clPEqY21iK3Mpr4hUJb6Ya+8qtLZyJ7Kr
         ZN84SfNQa5UEsqIYX9YchkGdq5z53Bfb0wjTdxZd1mLzM0IGirMef43BoT9YQtyWTrH4
         E5XDu5SXHSy3tDXJgddFv7mGYcOS79tINnCO+J4WZHM89c5tRpffd64j39PghARHQFTa
         IYqpZ2Y+DapwMHpyi41Wr741WA1+7z/1ljKRzacmrVDjJXwRGX93WoOQI2ye9BDUaNn2
         0EVayFxVAMf5eMm3E6lXG74nRlo/JkyEWDseRm2+2PG1DsSWaMkTgkJ37n1RXmwpFBMm
         KRfg==
X-Forwarded-Encrypted: i=1; AKwUvBwGKXuYPcLa7fTbTfly2+ARbJpZ4uEjag3xjE57G9cnqknJH4CH+cYjJdoOB2mDt6ixc5bpih/7DzjK@vger.kernel.org
X-Gm-Message-State: AFuF++kGX+449j/nHCJm7/bQVftn7+XmNbHicXb2RGgqemcbwedOlKCx
	ZhmfdeZrH1r8pqo+YC8cQJjg6panWRhFgW7ePZNpi0aSShF1aFCymh2X
X-Gm-Gg: AYBFou3D/2MdNWRaEywOUETjDYplxJExYF0a1sWsPnhKzC3XOHH/MSiBy8zZhAvMwY7
	A6lLeHwqWae6/11EDkFMgqwYDMytpPkHN1fTH1d5zosZrGk6I567fxebW754cHkR1AOCGR+mFmd
	JetMi/qcCCGn7ePLXv4Lteo/HK6UExSkJb/zFSXNYRqKqwTkQ11pW6JZ7GrQG1M8kgb/1V0cBi+
	nfxZ5pTf/S+xvOmEu0iKy0bQ4YwvsoAsklx3hGMjO4ceDwGzED3xcM5t9bJ4FhyPywbdfrFhoJV
	NxSyoW333HTiJsBB5ErZrMLHUaaTxQCZPF7QWZDOVDByazFB36MJxxMxknQWc0QkXCn7KqOJKmS
	DuDw0Jgn2NATO99QNNYstX3ll2qgBdU+nPtFV0SNpTFwsobe+Mjcjc9NiluRFU39rkBVwV69j2D
	es1g+Ehy3FkjhLO3t4Adx7zr4iFmRdM/a9llPMWp1+gUBNdE0BlqYcL4/d6k5RkbzzPRlVBCK4Q
	p4lq77Tcgn2e051sgWIfj0T+pzkZyX4FLR1K5Ejr9KUPdWKfb7an3/WlwvnRLRynRbPC8Q=
X-Received: by 2002:a05:7022:1504:b0:143:858d:fb0e with SMTP id a92af1059eb24-146caf2aafcmr10000211c88.0.1790495169220;
        Sun, 27 Sep 2026 00:46:09 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145adcc5b00sm17025244c88.15.2026.09.27.00.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:46:08 -0700 (PDT)
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
	Karsten Graul <kgraul@linux.ibm.com>,
	Ursula Braun <ubraun@linux.ibm.com>
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/smc: Serialize CLC preparation with link teardown
Date: Sun, 27 Sep 2026 15:46:00 +0800
Message-ID: <20260927074600.3694802-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smcr_clc_prep_confirm_accept() reads the RMB memory region and scatterlist
without holding llc_conf_mutex. The connection's link reference keeps the
link object alive, but does not prevent smcr_link_clear() from unmapping
its buffers and destroying its RDMA resources.

The CLC handshake can load the scatterlist pointer, then an LLC delete-link
worker can acquire llc_conf_mutex for writing and free the scatterlist in
smcr_buf_unmap_link(). When the handshake resumes, sg_dma_address() reads
freed memory. The memory-region rkey read has the same lifetime problem.

KASAN reported:

  BUG: KASAN: slab-use-after-free in smc_clc_send_confirm_accept
  Read of size 8 at addr ffff88810efcdfd0 by task poc/94
  Call Trace:
   smc_clc_send_confirm_accept
   smc_clc_send_confirm
   __smc_connect
   smc_connect
   __sys_connect
  Allocated by task 94:
   __sg_alloc_table
   sg_alloc_table
   smcr_buf_map_link
   __smc_buf_create
   smc_buf_create
   __smc_connect
  Freed by task 11:
   kfree
   sg_free_table
   smcr_buf_unmap_link
   smcr_link_clear
   smc_llc_delete_link_work

Hold llc_conf_mutex for reading while preparing the SMC-R message,
including the QP accesses. Reject unusable or cleared links under the
lock so that teardown completing before preparation is also handled.
Keep activating links valid for first contact and release the lock
before sending over TCP.

Preserve the preparation error in both CLC send wrappers when the TCP
socket has no error recorded. Otherwise the new -ENOLINK return is
converted to success. Existing TCP errors and short-write handling
retain priority.

Fixes: 541afa10c126 ("net/smc: add smcr_port_err() and smcr_link_down() processing")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/smc/smc_clc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 014d527d5462..6b9e64a5b9d0 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -1169,14 +1169,21 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 	clc->hdr.version = version;	/* SMC version */
 	if (first_contact)
 		clc->hdr.typev2 |= SMC_FIRST_CONTACT_MASK;
-	if (conn->lgr->is_smcd)
+	if (conn->lgr->is_smcd) {
 		smcd_clc_prep_confirm_accept(conn, clc, first_contact,
 					     version, eid, ini, &fce_len,
 					     &fce_v2x, &trl);
-	else
+	} else {
+		down_read(&conn->lgr->llc_conf_mutex);
+		if (!smc_link_usable(conn->lnk) || conn->lnk->clearing) {
+			up_read(&conn->lgr->llc_conf_mutex);
+			return -ENOLINK;
+		}
 		smcr_clc_prep_confirm_accept(conn, clc, first_contact,
 					     version, eid, ini, &fce_len,
 					     &fce_v2x, &gle, &trl);
+		up_read(&conn->lgr->llc_conf_mutex);
+	}
 	memset(&msg, 0, sizeof(msg));
 	i = 0;
 	vec[i].iov_base = clc;
@@ -1227,7 +1234,7 @@ int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
 			reason_code = -ENETUNREACH;
 			smc->sk.sk_err = -reason_code;
 		} else {
-			smc->sk.sk_err = smc->clcsock->sk->sk_err;
+			smc->sk.sk_err = smc->clcsock->sk->sk_err ?: -len;
 			reason_code = -smc->sk.sk_err;
 		}
 	}
@@ -1246,7 +1253,8 @@ int smc_clc_send_accept(struct smc_sock *new_smc, bool srv_first_contact,
 	len = smc_clc_send_confirm_accept(new_smc, &aclc, srv_first_contact,
 					  version, negotiated_eid, ini);
 	if (len < ntohs(aclc.hdr.length))
-		len = len >= 0 ? -EPROTO : -new_smc->clcsock->sk->sk_err;
+		len = len >= 0 ? -EPROTO :
+			-(new_smc->clcsock->sk->sk_err ?: -len);
 
 	return len > 0 ? 0 : len;
 }
-- 
2.43.0

