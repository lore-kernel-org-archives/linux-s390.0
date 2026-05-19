Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66019CD0A
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151946; cv=none; b=gpJt3kZ1ukb/R+r7y0rwwCEcYC4g7fYs5U/eeo677nGjsFfxsvTKxChxCJSatQbqsr8c8zEVupiPdEaT2dc/INyc9PG5x1WPM72l9aeC/UnWKj7GEKFv9mLX0bSSQDbS+lt/WLcaT31amJCaRSyJPkh0Ut8iJ+sW48QvU+aaCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151946; c=relaxed/simple;
	bh=8WR9rCQI8pYKIwDYraHrHjYIExw2j9LSvcpKQg2e6KU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZD6LmwU5cdzdTAReo5goSYjUufZqgHcHauhDzrH6io76JO4wbr8olxigf7i4Ml6J5SlqdzSXKsXwO5FbCFqO3EnPcblmdwd7DbZ6CRtiXgldKGQy45ib0YElXGd2wfQY+gaS4XK8HJ+xYz+elCJCGGXkadmdbKmrQIfShTFUv0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eD57G5qW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD57G5qW"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3684a6f3b0bso1635319a91.1
        for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 17:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779151945; x=1779756745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/pD9nTHCsUwMY/2ZvH2eEJmq55Tr5vZPtGAv1sHO/wQ=;
        b=eD57G5qWHjI7bto21FBFhIad4ZzZQBRThwy/3k8aRkIBtsZGdOpjX8+deCRRMakq3t
         CQ6RrRBoqidAaCx+ztHMCtPAbyLdqD1aYxH+sK/sPI0r+SNoxaJwvL11bigxnPKIZ3l4
         4pQMa4353Z8JzTgQg57oeUZ4EXgc3VWXfoMUlOlVYXKKNkngMQxsqWKPCjalD3z8DKn7
         9mJyyjAvsr+yK+muWQf6m6SRAdQGgp8XG42pgpfEGNXRsxDarlQunEVKgi+XMQB+VF0+
         dEW7Sg2Dy/6gm7EVQtNWRvxuoFNd1cxmJXBjTItyfDi+5VwXmAvPr7wG/skQLyGWszaY
         elWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151945; x=1779756745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pD9nTHCsUwMY/2ZvH2eEJmq55Tr5vZPtGAv1sHO/wQ=;
        b=L1gYPbgdnXXqp7kew5/MUAdQ58kNpbNvSGDky8WMzuNGc/A8Qg7YPqoRR8I2xtTBRU
         UfijkMLjvsgVGxqNW7Qm9cUjHAwwCWjcf5FYiZENV8cL6ty6tXAb5x3Oe5ZTCIQeddoE
         igk92d2JV5mU/pjsn05/pMnAL8UmoMPKTFBYV0L81k3yVmHkUV9DyDa6RMisqOzayvs5
         38B71cK4aqnCNmFe0920O/4oyb2MqnMz39Aj49Wn+/dtwh4C3z/Kx+O/02UYH7ckga1J
         +IrQUCNMn7fhYk0sNagK0/f6GXTUawuj4MGE738ozM4jyaa5uFV1GOpJtoJ7XnCuMJzm
         9/vQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qe8o7l1hE7BJycg2XjoTbckag7VyahWGAzzAVUYB8NZwdl9xEM4cE3e2+4NFR4yV2C2Fy8Nhj5twr@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSC8jiF5JbkstvMbfwoWza4T1C7w9y9HUJQSrCR38SUwmY1J3
	82NdV/+VNOEwR6+rk2K77X3ahiccZM4DXlTS9FhrnCW8zuUjlB0pJ8XH
X-Gm-Gg: Acq92OG4wvetWkjRaVY4mTx2zbUYoiuaOp8ogmsCAgcPudkL9o07hvZ5Sf295KQVOdJ
	BMmKHEvWXvX3norrtC2McIOG2iFui5YFwkjGhBOpdsI+tsrcyFZfC5/CsOzcjNa3HffZJJiattt
	BJ7E+gOyRU1Z+k1NIpn6TkM7B04UzIMaL7/eFFYoGV3PbE6rQQuCHZAF5/RPuhLLwn6/6UWA/4P
	FgBEG/0T3dun3nS89MpvGafEfMDiiV+PoTrgNPuieZTDOK5On7Sy5uTlQDP4fAp5F73Rdn1LbDL
	UpHkqCESJGiwXRjMXonasEP0TblShC+fszCa/zcrwRO+0Mu7DYFzJ719l8Vu196QxJSoba2nl5+
	FY7rf8jNckDCDF4vz7ebLBGXhbKPzxuTph/a9ZeV6YQbOGLG/f6vkyULn/lB1T109Yx717orPnH
	/5cC9bnHBrOaDHZXreSnsBSkwasGCzH3Gk4U+il2YJvd8l5YChuNeNMwoUQ+uykmRFI5pumCJgw
	NCoV6og/K72TTTCFOvmnncuKcMYD9HYOC0=
X-Received: by 2002:a17:90a:c10e:b0:368:977e:2bf8 with SMTP id 98e67ed59e1d1-36923603c63mr18107714a91.10.1779151944807;
        Mon, 18 May 2026 17:52:24 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bdc4c2cda4sm74177405ad.58.2026.05.18.17.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:52:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list),
	linux-s390@vger.kernel.org (open list:SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS)
Subject: [PATCH] smc: Use flexible array for SMCD connections
Date: Mon, 18 May 2026 17:52:06 -0700
Message-ID: <20260519005206.628071-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the per-DMB connection pointers in the SMCD device allocation
instead of allocating a separate connection array.

This keeps the connection table tied to the SMCD device lifetime and
simplifies the allocation and cleanup paths.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 include/net/smc.h |  2 +-
 net/smc/smc_ism.c | 10 ++--------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/net/smc.h b/include/net/smc.h
index bfdc4c41f019..a2bc3ab88075 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -40,7 +40,6 @@ struct smcd_dev {
 	struct dibs_dev *dibs;
 	struct list_head list;
 	spinlock_t lock;
-	struct smc_connection **conn;
 	struct list_head vlan;
 	struct workqueue_struct *event_wq;
 	u8 pnetid[SMC_MAX_PNETID_LEN];
@@ -50,6 +49,7 @@ struct smcd_dev {
 	atomic_t lgr_cnt;
 	wait_queue_head_t lgrs_deleted;
 	u8 going_away : 1;
+	struct smc_connection *conn[];
 };
 
 #define SMC_HS_CTRL_NAME_MAX 16
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index e0dba2c7b6e3..bde938c5eb39 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -467,17 +467,14 @@ static struct smcd_dev *smcd_alloc_dev(const char *name, int max_dmbs)
 {
 	struct smcd_dev *smcd;
 
-	smcd = kzalloc_obj(*smcd);
+	smcd = kzalloc_flex(*smcd, conn, max_dmbs);
 	if (!smcd)
 		return NULL;
-	smcd->conn = kzalloc_objs(struct smc_connection *, max_dmbs);
-	if (!smcd->conn)
-		goto free_smcd;
 
 	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
 						 WQ_MEM_RECLAIM, name);
 	if (!smcd->event_wq)
-		goto free_conn;
+		goto free_smcd;
 
 	spin_lock_init(&smcd->lock);
 	spin_lock_init(&smcd->lgr_lock);
@@ -486,8 +483,6 @@ static struct smcd_dev *smcd_alloc_dev(const char *name, int max_dmbs)
 	init_waitqueue_head(&smcd->lgrs_deleted);
 	return smcd;
 
-free_conn:
-	kfree(smcd->conn);
 free_smcd:
 	kfree(smcd);
 	return NULL;
@@ -557,7 +552,6 @@ static void smcd_unregister_dev(struct dibs_dev *dibs)
 	list_del_init(&smcd->list);
 	mutex_unlock(&smcd_dev_list.mutex);
 	destroy_workqueue(smcd->event_wq);
-	kfree(smcd->conn);
 	kfree(smcd);
 }
 
-- 
2.54.0

