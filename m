Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68E1FBF7B;
	Tue, 15 Oct 2024 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032519; cv=none; b=IslLNKrpqylcLl1YDPan07na/iKY1OAkTwVAgqfcJdE2I1xS3uv86gF6D3MhdVbzjdutRonuhWO07gEzghgKn1Lp7b50ycIoqcZKZCWaGRNJHpQof11g2DN4yC5r4xEjXoOiBxbUBPP9NRmKrLc84eZTkuGC/Au9Xc+qrJtzfss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032519; c=relaxed/simple;
	bh=6fug8UcZA31z1WDHRjCaQNBPXIA2Ym99No37vjGAAvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGXefg3KaTEtbGBcISf2Dzgy8Fuve7hwYczEDcoqFxtpTfg01ha9SbnH9nuP4rKMzjGk8bS03ZClldIGGh7N1Z92FyOb9Me6rnK6USmf+y3M9TDNv8EcGhOlZEhr9o7fI/PZKLvCbc89MkxOxHU7mG4o6yhKd/lLrggr9jaefJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3cn6/KQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3cn6/KQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdda5cfb6so28220235ad.3;
        Tue, 15 Oct 2024 15:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729032517; x=1729637317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhopaATavFb8v8R1JjsKVC6ma8QBMUL6hqdDjaAqBYI=;
        b=G3cn6/KQ8OYnoKOs0Hqpq9VH4sTsgVZ4a6SHnIOWGbUi0PZvIiBAAfEOxt1Gz/Yrd4
         68itHcuBvyCOZTVy0bhQbpzM4RiY9o8TZScE8nRCEuweg8FD/nM0/drHaszRJnCQWcKe
         2GbfL+GQChXOy7ZM4rrKb522Jkpv+YewVw+TjJS8DJCrxQ87+ejij0GEvvir50wW47zj
         jTT+0/+sUVp+fAuSLUc3QcxTSslv692QbA4ZE7z9X6wY5+Vn0VzWWN5/efChCvPO2Y7K
         daY5D9RXnJV96ErAgHgMhRUcYOwiLEyP4zOPKXHo3Bme3bF5sd2cIJHCIQcdTKw/pJcP
         9YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032517; x=1729637317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhopaATavFb8v8R1JjsKVC6ma8QBMUL6hqdDjaAqBYI=;
        b=Y8IuNEwrmBEVVeH+vL5gXtmpWC87reqnqEsXRbijHZlFNEwcy/UE42SbfLAIjYSFUD
         h+zL4TwI+8Etw/m8eiyL2EJt4W+f+4HdvNl8Qmd1MV2AIUjnEBhC/7AyN24BAoQFw1p+
         kHCNL13tbMJEegUQ9zLADOK5/y3L+bbs+Sg4YsKi+tyIQzv2yw4ahx1n3XkJU4PbqARW
         /DuwYuSJJZ/P4UQJ+49J9gR1to3wijDpjuGIG3+uct19VyUywIs6v15LjO3OFmL2Px2q
         SiKwo5nxuRiosPWoC/2Ycj9qyVq5xzJnS7Yq8GVpdcQUTDMzOD3yVsLdFYJqWXpZ5mw+
         pO+w==
X-Forwarded-Encrypted: i=1; AJvYcCVM/YaZHFqhFQ1Ildmu8jOn6n49sPyrQPHLxeJ1PgeInjQ6eMCPQKmxNcUNiFlSGEyYN4l7PYDmiVXvqbg=@vger.kernel.org, AJvYcCVO4atZnWcC8VvJfIBrhUeNSBiT7xUYxiB/ANt3lgdrlHeS/+76LRYbqJ18UuenGreqEbKy4xMx@vger.kernel.org, AJvYcCXeLAKgMxDk+E2qMysYMMkJrBoPzQ71yA5mGqZRn86Sq75zWSCh16IqJr/bWXR9dDHSIDuutXx0k6WkPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdAiBPjPv8ceR/vIkuIHdbumOn2g78XoJJQkG5Rd3oKMiSujVJ
	EWsftRAXRehOQwLeZLBSo3cqFaaDJcsb6siRDpeXBNW0Vda6jr6y
X-Google-Smtp-Source: AGHT+IGB7TcN1tpZ+LTRdXOjO2Zpt63vGVNmdoYU7qqqJYSD2RKOb3BCwhuqjOA1pTX+2q1UBAg4ag==
X-Received: by 2002:a17:903:32c8:b0:207:15f4:2637 with SMTP id d9443c01a7336-20ca142a227mr190912615ad.12.1729032517513;
        Tue, 15 Oct 2024 15:48:37 -0700 (PDT)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20d180366fdsm17205465ad.128.2024.10.15.15.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 15:48:37 -0700 (PDT)
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
Subject: [PATCH v3 2/2 RESEND] resolve gtp possible deadlock warning
Date: Tue, 15 Oct 2024 15:48:05 -0700
Message-Id: <c2ac8e30806af319eb96f67103196b7cda22d562.1729031472.git.danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1729031472.git.danielyangkang@gmail.com>
References: <cover.1729031472.git.danielyangkang@gmail.com>
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
+static inline void smc_inet_lockdep_annotate(struct sock *sk) {
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

