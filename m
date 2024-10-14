Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D71487DD;
	Mon, 14 Oct 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891067; cv=none; b=pcdIFw3lANn7akCPvpqIibAJhmYxeYekYhKU/q/gRpFwK2RSLSv9cl8AwhrR/W0iMvMe6Ir/rN2JuBdgwibNFwFlxJsmUsYH1xts02jCtAF2D/ksTvjngsBKAhTzA4Qmmuv38ZU3b5L5ZOK+3rcP00yPP7IF0W1GvDUCzpo/d5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891067; c=relaxed/simple;
	bh=PbHuZhtigdL7nx9SVhwNC7oNIWPcsZQSDnX8GpsP61E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qg8GLYtGpmtENQUQshl8LQttb+xyAx9jfk8B2ME8ccEcT46CUhfNa1m7y4ZSQT8muJO0Kg3o2b1KjEP49YUKzuFRkF/MHO8d0fDALxFExE5+pEp9lcYKlbw5qi+gnGIjCk4d+YOpsyfiLPJV+BWyLShvqYcSUeO65Eodm/yKUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgeCY6Eb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgeCY6Eb"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ca1b6a80aso19047105ad.2;
        Mon, 14 Oct 2024 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728891065; x=1729495865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rd0b9cV8dn2IPQ0SylKLEt3DtGFzHpSwgJ0jzUgwL6E=;
        b=LgeCY6Eb3PcUAWAOBVnXt/P6RrfPgV9A9MyPO+OOGpO4Qv4RCMuW6UBFIeWmvHoKOl
         IRoAWpLteaHzta/0pDx2/7txzW0VnXj5unpR3vvU2EuQq1D3t3iY9f3njfIs8Wj2HFbA
         WfP5lUpnpgYQ9mTHCkTyUhGI2J3nw9QUPJfHJweK00srWYQShDTJPGqvTf6nFpHHiCp8
         WceYmu5gaDCb/f9V+uFXHNF+K4CqTZQFHP5mFBRIoJLEbK9TfqGqnvJhjY2xcXg2jKIR
         +3hfKytw1rp7WdVwPQoP5aZkPvyQz7Y9YpP7zEOW1S/uD3/ohOv1P3oX+LfV7yUtuKmX
         Nwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891065; x=1729495865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rd0b9cV8dn2IPQ0SylKLEt3DtGFzHpSwgJ0jzUgwL6E=;
        b=i/8v3yMCJ8obxnsp1FF0/QRJJ4W/KKSSDskCVaIeEtEdHKMWIFjq/SNBDSi+HfxTaH
         41eyp+LrpGGVwjRPzvuSCtj5DMbdMqXV+cCAGqqabj73p1L/3zcU1MZA0IYpUrCUxQr+
         pm/9u47wMFc/BdqW4omRMznXw7jr7LYP5eDHRKp4qB4BqOsbYwh1q+99iBGlbDnTajwa
         Rcym3BrtrvFoEOE0OjbpFxgwquHD/Fb1xIoCYgf6DlSTcf8T2+Kv88ct6eQmQ0cGD6cp
         CmsUvYuC45JNJbslYZ/vBL/Zz8R/z1jvM3yw8Jv6r86+FxeNQFW5bSGUsXTbWDDOqGaB
         AJSw==
X-Forwarded-Encrypted: i=1; AJvYcCUAKlhEgsNx1Yvh3++wPA1uOjajGok9KiyRtuPCIjiQGxSUoq7Vm6ePsbb6PRaOyr8HeHZ8DD9/kHAbSQ==@vger.kernel.org, AJvYcCUz8myw26kzwC4wRFnHzyDI0CrB+o8E/NpKgL0DEqjKIG/V51pIWI4BUvQuLPwOdA711097QR9HiqHPLcg=@vger.kernel.org, AJvYcCXbMu8MWRyY9tHUPagYc7pRL+zr/jv/PNtv0mVYmhVKpBWs1VzaG8QopejlNIeJWCFe5mOu9ehj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8L7IknyZFNWv+jeLikqiLokqn88ZC1V5B6XpJanr+eKr+1yp7
	34bj9rVCh0mz3M1ARGqsB54qf63teyD1cKFRsrnr5/IbT+Gd7vVZ
X-Google-Smtp-Source: AGHT+IEs1DOE8o2DzSwdXu+kqUDBCIxl7IEfRGmHdJXTaLQZ7DgAgrnfy2mycV0tcQgWS4eJCNXz+g==
X-Received: by 2002:a17:902:db0d:b0:20c:7796:5e76 with SMTP id d9443c01a7336-20cbb19ab94mr109357695ad.18.1728891065490;
        Mon, 14 Oct 2024 00:31:05 -0700 (PDT)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c8c213258sm59719315ad.202.2024.10.14.00.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:31:05 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: danielyangkang@gmail.com,
	syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
Subject: [PATCH v3 2/2] Move lockdep annotation to separate function for readability.
Date: Mon, 14 Oct 2024 00:30:38 -0700
Message-Id: <20241014073038.27215-3-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241014073038.27215-1-danielyangkang@gmail.com>
References: <20241014073038.27215-1-danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Yang <danielyangkang@gmail.com>

Moved lockdep annotation to separate function for readability.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
---
 net/smc/smc_inet.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index 7ae49ffd2..b3eedc3b0 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -111,18 +111,7 @@ static struct inet_protosw smc_inet6_protosw = {
 static struct lock_class_key smc_slock_keys[2];
 static struct lock_class_key smc_keys[2];
 
-static int smc_inet_init_sock(struct sock *sk)
-{
-	struct net *net = sock_net(sk);
-	int rc;
-
-	/* init common smc sock */
-	smc_sk_init(net, sk, IPPROTO_SMC);
-	/* create clcsock */
-	rc = smc_create_clcsk(net, sk, sk->sk_family);
-	if (rc)
-		return rc;
-
+static inline void smc_inet_lockdep_annotate(struct sock *sk)
+{
 	switch (sk->sk_family) {
 		case AF_INET:
 			sock_lock_init_class_and_name(sk, "slock-AF_INET-SMC",
@@ -139,8 +128,21 @@ static int smc_inet_init_sock(struct sock *sk)
 		default:
 			WARN_ON_ONCE(1);
 	}
+}
 
-	return 0;
+static int smc_inet_init_sock(struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+	int rc;
+
+	/* init common smc sock */
+	smc_sk_init(net, sk, IPPROTO_SMC);
+	/* create clcsock */
+	rc = smc_create_clcsk(net, sk, sk->sk_family);
+	if (!rc)
+		smc_inet_lockdep_annotate(sk);
+
+	return rc;
 }
 
 int __init smc_inet_init(void)
-- 
2.39.2

