Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1369C17C64;
	Thu, 15 Aug 2024 04:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723696735; cv=none; b=SaUdIUTbGELUudFpXkcCMcqoxQKdL9307qU5DMcD/ogThbdiUS99PVg1GEp/Rln7F1qoRLYYUY1aVBcFcNmzERPDlAnMRqaZazaHTgpHp0nK13Dc5S2Oc11Im5DL077I3jV7EYx6mlw1d2gNcb+pezYNzU1eQjmbBNQmK2L8ST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723696735; c=relaxed/simple;
	bh=Ew9gEW24tB5PwLWZww2dX6D1W8emEapk15u0xCtAQn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FOhsBLE6Y0KUvBCXHmXZheXFP/cFoiJyUmHFWHpvR63JG0a/I8ijcWqZdHa6K3RD47J7qSSWoD1z8/RRljFssb5dqun8IaJu3VqutEFsE14xYPNxpnvAg83OI/4XfKbvR2WjDIumcGhUGSx78TViKvw1vl51IZg1n5vQPxOv1Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPYxz7Mx; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPYxz7Mx"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2689e7a941fso467765fac.3;
        Wed, 14 Aug 2024 21:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723696733; x=1724301533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnb9cbaaRXrIkMveQjNklGXFqMys5v1vGEzF6B/6hIQ=;
        b=IPYxz7MxtH4zzCdDa0zdbU6bNy3SV0KzaD/nka1fWb4KBgzzja3nVzE/1YLoe86cd6
         LwLuj00bJ12rDMwnF4ntQm70DFIoehvYvv1x+mA1mPp4t/e/8fNNPhHfJwqKVU7qeUku
         rl+xHrjRcnb8WT/6G4uuHJtTOiK5oF108h20/LaxAGR7SvG7HWmX/XjSkGSruKrBmdTG
         SFTYYI3zi4GzbTEtZzh7d64kEvOjvEOPWIx9byFsWhXylJFfObp6HcVr56ktxOP2Pwxe
         bHjKpMj7dftLXEcj58dAM5mwuh0ubZg8kG66PB6nuB35ddJyCKkH/xk3cUwcFkiGLs0g
         qBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723696733; x=1724301533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnb9cbaaRXrIkMveQjNklGXFqMys5v1vGEzF6B/6hIQ=;
        b=dFWBYnuub8hr94MNtPF8dWWOVEF4D8VTM31UTUE2x9jt2sJ+GBHRzCdOK1JJeUJLVH
         YdNXobJOia16T3d1VkLmO1WAQU5THrxNwh690Qrso9OqxXi8/69kYpEKVfdxbdraZ8Fm
         Ine6lGUAfKXe53KaxjtKjWPbikDQVZYMy6eL7Cy04o3h8cNWscCf0Lx+Frn/FWqTXcvt
         bJYrnvZLA0j5xnPYIEtYuAgbvJus/UB9Nbnivn0Zu6xZkYaaWnAaJZr0pC5XTTCrrJz4
         d4/Klq2swmvaCf+1wUaZy4dw0iaLgKzBkuTEEz6ppRQMRUGf1RXl/iDQRMZ8Fu4XN47N
         OsHw==
X-Forwarded-Encrypted: i=1; AJvYcCX+40fyeK5Okpzd+55v9yT3+zDaYyT86FxyMd8WlH6EIidt2u4Z+xXDNT9B3f4+fthILnjjWIajtSCps7GNZn58ss+HQffFJeaQpiPOVs5l+3dpPMtRcxUV4ruQNb1Jw55A+WYxsazeynQFwNQKcoOCCGpF0GmlvMy88qp2oTjxBA==
X-Gm-Message-State: AOJu0YzEvrDiDCoD6lUqbXqjU3NqB/ea8eGCxQec8qxPsMNH2SMuwQAk
	IZnP13w821XVx7dCW8eUW+mgvTFjBbh0q/P65dXm0leT/eq3A/Sl
X-Google-Smtp-Source: AGHT+IFFRSSVdnn57rHUdSTkB+jpT2iU7Y0T0cJecHO0DzGJXMGl3HKIUAgVzAW5zqHA1v/83dtWiA==
X-Received: by 2002:a05:6871:b22:b0:260:e2ea:e67f with SMTP id 586e51a60fabf-26fe5a042eamr5845540fac.10.1723696732981;
        Wed, 14 Aug 2024 21:38:52 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127addf5f5sm362508b3a.6.2024.08.14.21.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 21:38:52 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dust.li@linux.alibaba.com,
	ubraun@linux.vnet.ibm.com,
	utz.bacher@de.ibm.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net,v5,1/2] net/smc: initialize ipv6_pinfo_offset in smc_inet6_prot and add smc6_sock structure
Date: Thu, 15 Aug 2024 13:38:45 +0900
Message-Id: <20240815043845.38871-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815043714.38772-1-aha310510@gmail.com>
References: <20240815043714.38772-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since smc_inet6_prot does not initialize ipv6_pinfo_offset, inet6_create()
copies an incorrect address value, sk + 0 (offset), to inet_sk(sk)->pinet6.

To solve this, we need to add code to smc_inet6_prot to initialize 
ipv6_pinfo_offset.

Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/smc/smc_inet.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index bece346dd8e9..1f2d7ad8851e 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -60,6 +60,11 @@ static struct inet_protosw smc_inet_protosw = {
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
+struct smc6_sock {
+	struct smc_sock	smc;
+	struct ipv6_pinfo	inet6;
+};
+
 static struct proto smc_inet6_prot = {
 	.name		= "INET6_SMC",
 	.owner		= THIS_MODULE,
@@ -67,9 +72,10 @@ static struct proto smc_inet6_prot = {
 	.hash		= smc_hash_sk,
 	.unhash		= smc_unhash_sk,
 	.release_cb	= smc_release_cb,
-	.obj_size	= sizeof(struct smc_sock),
+	.obj_size	= sizeof(struct smc6_sock),
 	.h.smc_hash	= &smc_v6_hashinfo,
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
+	.ipv6_pinfo_offset	= offsetof(struct smc6_sock, inet6),
 };
 
 static const struct proto_ops smc_inet6_stream_ops = {
--
