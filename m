Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ADA231CA6;
	Mon, 14 Oct 2024 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891058; cv=none; b=Onootd0Kn5ENhuKY5eoO3ZZo3LiJeGFGFOWRJcqqqLGlkKwt4mmmw4ypfRveyMt/JTTe+vr1siKTsmKXtmwovqP2FQSBr2a400TG0ugEbEF7a7bg2IGIu2ABdoe+siK8UyfMg1uy9nLtyRPCvyoskQaSjvEFtu9qsq+30VtggQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891058; c=relaxed/simple;
	bh=h2TpHCcXKvjjQbkLK+KDdm+NpuKUW+htPXR/QR+kba8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5V0qtuwlf/Ds4Oi6uxpRBixPtLIHRTLi4YVk8F0b+aCAiwhqJb6dab6/EBgSHvCRoPg54NH+thDEMn9hg/a5GTPh3OMZfE+pgL26HJ/wGpq/dp/oKg/6SlF0PCvergtlC2hQGZ7VdzVuGMCTRJSrAuMk3+aTnJnZ1eXvclQpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlY+j1UV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlY+j1UV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c6f492d2dso42857955ad.0;
        Mon, 14 Oct 2024 00:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728891056; x=1729495856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0eza33mEm6JCADkBOVhQ8Rji6Layxr0e11dgnxnqgs=;
        b=LlY+j1UVQyHOtA7jQnP+Tmupf3siXrzX6aN7IHPAvAAkOCc4PB0ef4s9isZiEpVrkq
         Jhe0c5SlRz7mjWEsYuublUgohNzQnYYN0bSA4fbjAkL6QEP0pflxrvYFP4whMEXxbdNQ
         oflNhn1p2Ut9Xiu9Nie8dm65dLtdCdzmhX+ynoLFFImBTf0wBSlaPmcv5s/jegsn9irP
         y9BpapIyRuo3Gay+uFPrWz4SVxUIq04oyenkcylAp+4PhX8psmMQVWIoALAHUBzmxG93
         nX8uh13TlYlU/uv5JBb+rFJNU1Pn/KhlY8ZmNocIGkoTzFWnvUJ9I38wOr1pcKlZUo0x
         31AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891056; x=1729495856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0eza33mEm6JCADkBOVhQ8Rji6Layxr0e11dgnxnqgs=;
        b=gn5NIEy4srwd2fLsOLtBevrtW6kx0Zb87/5x3Z2zbuxy3UdyFeU5Phf6XmZ8REhFno
         eFRfsSwq0XoY3TXAmzSRTweuzIZt3JExRjpp0PpTkNDVksE8uCmnRtS5j8HFhcJ+iVZF
         sZpNyAxDXS473IIP949AvySMytMVMfKOFST8NRUdGOlIRoY7bgCqQLFUGg0y4R3UWT6p
         OfQDkIlQZ/RVv3X90xjuaq3NKs4ou+7VjFR6DiD91d69gm14kTkhN59HndHDU98ZVqy9
         ZjTepYbtO34UAJQWOc7Imhp7G8h1zIydApMXEiGUL2v1aloTAF1x9BHsdMVGYEZTwR81
         doPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0WeeOiLXReQWY+sW+aoyFutH/bvy/iRKyGDxn5j+B12L64UB13gmaRBV2OjqiFcw7/yv6I8L6RhO4il0=@vger.kernel.org, AJvYcCVNRhBUqlN7QxGUToGqOxoMvR5XH4tALP+Jk7Xlsm/DMv5oHYIF/4V1PukSC8VuG3u/0S7WemqTKq+zdw==@vger.kernel.org, AJvYcCWToGlIGf2WXuh8Cww/QIhNTLgFeUfcKEW7IX1h9TMtvbP/1uX3BJP7N/xqBgzgFq/loELuSHDP@vger.kernel.org
X-Gm-Message-State: AOJu0YwzWFttRMLahFzVWrxkErJnK/5m0oM9o9LK/hP7RHFK0/ooIoZe
	MGXnZEn3ETniC7oOwGgW7sMBQnDE+4dgXOyFQMKqerwABUEh96Ru
X-Google-Smtp-Source: AGHT+IFxcTIioxfG7xn9xSOBHCCvQ+ALZ2C0ycvdjskfpFd/JqrTskv/4IAJx4X4+lsFP4V6YseNCw==
X-Received: by 2002:a17:903:1c4:b0:20c:7c09:b2a4 with SMTP id d9443c01a7336-20cbb2a0b7cmr120118545ad.50.1728891056264;
        Mon, 14 Oct 2024 00:30:56 -0700 (PDT)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c8c213258sm59719315ad.202.2024.10.14.00.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:30:55 -0700 (PDT)
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
Subject: [PATCH v3 1/2] Patch from 
Date: Mon, 14 Oct 2024 00:30:37 -0700
Message-Id: <20241014073038.27215-2-danielyangkang@gmail.com>
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

From: D. Wythe <alibuda@linux.alibaba.com>

Adds lockdep annotations on smc inet socket creation

Tested-by: Daniel Yang <danielyangkang@gmail.com>
Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
---
 net/smc/smc_inet.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index a5b204160..7ae49ffd2 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -108,14 +108,39 @@ static struct inet_protosw smc_inet6_protosw = {
 };
 #endif /* CONFIG_IPV6 */
 
+static struct lock_class_key smc_slock_keys[2];
+static struct lock_class_key smc_keys[2];
+
 static int smc_inet_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
+	int rc;
 
 	/* init common smc sock */
 	smc_sk_init(net, sk, IPPROTO_SMC);
 	/* create clcsock */
-	return smc_create_clcsk(net, sk, sk->sk_family);
+	rc = smc_create_clcsk(net, sk, sk->sk_family);
+	if (rc)
+		return rc;
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET-SMC",
+					      &smc_slock_keys[0],
+				"sk_lock-AF_INET-SMC",
+				&smc_keys[0]);
+		break;
+	case AF_INET6:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET6-SMC",
+					      &smc_slock_keys[1],
+				"sk_lock-AF_INET6-SMC",
+				&smc_keys[1]);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	return 0;
 }
 
 int __init smc_inet_init(void)
-- 
2.39.2

