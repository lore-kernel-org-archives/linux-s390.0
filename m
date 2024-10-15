Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF91F819F;
	Tue, 15 Oct 2024 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032516; cv=none; b=GJ5x6/fqnBaT2+9M0lWOZLwzDd/6K+OdLrioN4IOzlz4VW4staPJqOdkl6bBgPCtmld0DwANp+fW4cpmHEVJX7SnFcI05tiFZ2N0B84Mp5epWqOJ7S5/c5XVToprdFsUr6ND2O8PuLdt03+SXQkfrEKehiVm3ucHOJyzrsWmFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032516; c=relaxed/simple;
	bh=q8XdwdqdA5vFLpxF2cA5NlU9hE29v1xzZ4SHv5UUaO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mKCVcEshzj9Or0qtUERmWD8R4DrE6FvtdVBW78JVrOGHaI7cRiiVF6ZnV5R7zXm9TFt0LuzJx91MD1HNhgSZ3U04/Ral/Vn5jVKU9/Z1DEHudmnBTIAMBOGXydDh76peyW0Abaf3n8iClQ1nZOcjaKpZwOZT82rAbxerJGibu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTSCyXNa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTSCyXNa"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cbca51687so32704515ad.1;
        Tue, 15 Oct 2024 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729032515; x=1729637315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0eza33mEm6JCADkBOVhQ8Rji6Layxr0e11dgnxnqgs=;
        b=YTSCyXNaBz4+YDv3IsvdwX5Htk1bxr+OSClPQKnmRTr/tCzhwUt3urP6kBrtj9aOH8
         QIVZYRxBBRZxkaf6WdHgiydFm+1CVUyW+nYuFHUwnZdZDZ9aRdNzYkFTkdQ0nM9+//KW
         ZW3YTxMIxW+ZEyNjTCIsHjlvBhy1lF3OsrSCEv2pARr3RZkuMjmvaA4kB8QaniZooWqb
         9UR0vkjFo6MV0eAY0mriBFlpmZnjjcfoLK7xyf6aYQaCXeDbdeusD1D2knNmfUsTpR2d
         zMt5HDEAg4db34xMvL6OUGdnYyIrlEUQHwno68nvyVh5eeL+dq+YX9235kP4E+OEsoyr
         DiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032515; x=1729637315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0eza33mEm6JCADkBOVhQ8Rji6Layxr0e11dgnxnqgs=;
        b=I1uE41PrkTw5Egh1pWBXHs/mFpXvwnsVYit3kpYHfPjXzC/U8lEop3KoUqexuaCAsn
         wHWcgtO/ioPO1Ta/OfO8sEs9o4AnN+doyUk/zbIUx8wsJH3ghmHq2lmlczU9NFonQsuL
         9L4JAHAOBdkZrGMe9ENLOmfGJyy9s3yv24GqyFTbvB1YLBOWRCufqi8yx0Bn8KoBaZuA
         fSyfvDt7vMY5VlXNnWZevv04YvOxCd02fxYiQ8pXW+9ZgRmFdpA4XtSEe/iruOJQ4h/b
         KNti4AhJEgZ4IxwPub1LsDtlLefmuz86yNvDActekvquqJjeA+kGgtvcciBzyE1B+SZU
         x8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUETduIJ3Zk6cLnP7G0tE5xg1Z5jqcJGFuLXkB87a1c2REiJux1+lvA1z3L9YYkGTm7DvbGwN8UzDZ1sw==@vger.kernel.org, AJvYcCVJISQt0JJKoyuVpTWX2jW0ZRakRe7JpLbThNo3ZRsqFjLJOlNdl5gPZtCbXIGYaIcQmSjckaes@vger.kernel.org, AJvYcCX0IcxTlBf4JyBHATgXUfbueACKOqOCvAP7k6Jr7+N64yTZOVcE1ZAWQoar9vQ6YI5uga3tStAILqgxglw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPP6WsLSZSRNe90A0gOhgi+PZy9r9MhSKjvorB8IRUtpwVUvr
	ZP9B0NRL7JAF1w3IV5NT9cTtCaATF53ndR+8R0SSolLxe2/Qsred
X-Google-Smtp-Source: AGHT+IFZfE+ooZzQsQC+FW8zoiPrfK79QnncsMlRr8Tu6+rNeOLh0pa+pCYavmA3SLnoL4Y/Ye7Ufg==
X-Received: by 2002:a17:902:e5c7:b0:20c:7796:5e47 with SMTP id d9443c01a7336-20cbb1a94f3mr256237955ad.4.1729032514664;
        Tue, 15 Oct 2024 15:48:34 -0700 (PDT)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20d180366fdsm17205465ad.128.2024.10.15.15.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 15:48:34 -0700 (PDT)
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
Subject: [PATCH v3 1/2 RESEND] resolve gtp possible deadlock warning
Date: Tue, 15 Oct 2024 15:48:04 -0700
Message-Id: <a226d1132aa6f7e1e5d9b9054bbf5c291fcfa664.1729031472.git.danielyangkang@gmail.com>
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
+		case AF_INET:
+			sock_lock_init_class_and_name(sk, "slock-AF_INET-SMC",
+					&smc_slock_keys[0],
+					"sk_lock-AF_INET-SMC",
+					&smc_keys[0]);
+			break;
+		case AF_INET6:
+			sock_lock_init_class_and_name(sk, "slock-AF_INET6-SMC",
+					&smc_slock_keys[1],
+					"sk_lock-AF_INET6-SMC",
+					&smc_keys[1]);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+	}
+
+	return 0;
 }
 
 int __init smc_inet_init(void)
-- 
2.39.2

