Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769128FC;
	Sat,  5 Oct 2024 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728104057; cv=none; b=O2QH0WLQ+/AiedJ+szvyu5aPfaUyDdc+Fm03OxQlprr3YgixWWn8aJE2FPCMZcJg8wokR/M/K5nhcvhibYviZTsZkfrUBqGPa35Vd9DIrpYaRY8VOAZZAm/tuIOrN5iouKOY5biMw1jbF43/p594aXQrwV6krc74bE7PgB5S1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728104057; c=relaxed/simple;
	bh=zhNGqSxKgr9PeHUz1E8XxbOiIm7jV7ByNNqLcrQWLk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SvtYVVgW4/x6RdNWVKo/iEnDFA3Po76vsdm+91JFTVl8bPOjO/DiMo/N0kO7HA/2G2Stkn1VCgDOXWnQiDcEVGcT+Kjwo8qHnxFR+ubmk3GK/4sHw49sQSQNnCx/OMAjhOcV/Ybg9soVc9/h6SPxsVrBpmwuZZOSRsOh5DrGB4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cq9N/2pr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq9N/2pr"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71df2de4ed4so181629b3a.0;
        Fri, 04 Oct 2024 21:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728104055; x=1728708855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MoaHxIZrPXR0fYxmImQQSsEgYcwtCagFeohHoy4fC18=;
        b=Cq9N/2pr5G0SLbizZPUTFseY9lXnVCp7+e93ZE9k1/zRYOWjC9efx2TyQJD3ap+Igf
         hkdmIU6NugKUV03OlRn0l1CaJd+4BcV6NE9W/brB1BTMeCJJ//qmBn7+hX6cWNq5z/fh
         72ejKagSPLsmB9j7B8nXezm7tgZWbzTnjKG2AygbBnv1DjmKUkp0hhqPSwkw8qO2SBCK
         6X9M5vLUnKJosbbtZWjmVi+6Br3AOb6lBWBsYt/tRmzUTrT7JO76sxgSC9g8HqVLiCre
         nLmM3x3j92eYK5UOuAfPqkYyaqxl6SoFASiZI9NHAYu9PN6TXWtdDy1NZW/ssIRE517w
         11MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728104055; x=1728708855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoaHxIZrPXR0fYxmImQQSsEgYcwtCagFeohHoy4fC18=;
        b=ptp/nHQqGMSqfydoF5EZu+IFE5Rs7m8j3BX35xroagVTGNvk2D12U49s03bwVshsQw
         nIAqkOe4vtjl+2KZHizCA2eoXX9m19PQeFJhnL/NYmleSjj0xfUUkSkWUqRIntqhEG9Y
         xtJ7c6OBWYvZI//hIzfyA3sk0DRwHubQ3JC/saBdheUksM4N61qPOVh6+Y931jd1DQKI
         okhYCuZy3Zf4EYPu48ZIbLKO3iCn/F52GEdqCCEA/jjv755je2IxmaGkjT/v7pLyttiN
         tvnQqfpVu4MRHfiiZbyLRuWxCXc24b+A6R4UOW3Ajhy5zipZ+LqSXFGAx23qmvHvjw6d
         TCUA==
X-Forwarded-Encrypted: i=1; AJvYcCUnZG1/rAoUCCIt9EI5C2FmzKwib+36y0cW1FGsMCGmtt6skK3dg6UCgun8klibJ4yJimE4gv0In0DL7JA=@vger.kernel.org, AJvYcCUsJC+F/4A7meys74M3aEP9v6SfiJCS/+Se3uRDazrO13XYEhbY8yRL/tgCYi4vKwBA4qvlkpIxwzMvrQ==@vger.kernel.org, AJvYcCWvQ08ZVaRV5FUJTJQWzjXcPBrz7l3tO+g9wDFsmkebbbM3wtklaXyN39nj6c4AvlACC1GFMOOZ@vger.kernel.org
X-Gm-Message-State: AOJu0YysTiI5ie7MwhbUtGSVAS7Kf0rxFZNhWTNDkb4pyk4MbB6f3vgf
	P87TTh/0tOEUqRtYXON3YnZ7A2I5FahLBVPM3Ye/hZTR2784cEUa
X-Google-Smtp-Source: AGHT+IFPtY8qTHhV9UGEE+W9HaneFyGmt4IsZYQIdNsmPDudVVrx7Tc0pkUigBfcJfCcC7usu9yPfA==
X-Received: by 2002:aa7:8a16:0:b0:71d:f033:a772 with SMTP id d2e1a72fcca58-71df033a853mr2867097b3a.12.1728104055205;
        Fri, 04 Oct 2024 21:54:15 -0700 (PDT)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e9f6833cdcsm876583a12.49.2024.10.04.21.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 21:54:14 -0700 (PDT)
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
Subject: [PATCH v2] resolve gtp possible deadlock warning
Date: Fri,  4 Oct 2024 21:54:11 -0700
Message-Id: <20241005045411.118720-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes deadlock described in this bug:
https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd.
Specific crash report here:
https://syzkaller.appspot.com/text?tag=CrashReport&x=14670e07980000.

This bug is a false positive lockdep warning since gtp and smc use
completely different socket protocols.

Lockdep thinks that lock_sock() in smc will deadlock with gtp's
lock_sock() acquisition. Adding a function that initializes lockdep
labels for smc socks resolved the false positives in lockdep upon
testing. Since smc uses AF_SMC and SOCKSTREAM, two labels are created to
distinguish between proper smc socks and non smc socks incorrectly
input into the function.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
---
v1->v2: Add lockdep annotations instead of changing locking order
 net/smc/af_smc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 0316217b7..4de70bfd5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -16,6 +16,8 @@
  *              based on prototype from Frank Blaschka
  */
 
+#include "linux/lockdep_types.h"
+#include "linux/socket.h"
 #define KMSG_COMPONENT "smc"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
@@ -2755,6 +2757,24 @@ int smc_getname(struct socket *sock, struct sockaddr *addr,
 	return smc->clcsock->ops->getname(smc->clcsock, addr, peer);
 }
 
+static struct lock_class_key smc_slock_key[2];
+static struct lock_class_key smc_key[2];
+
+static inline void smc_sock_lock_init(struct sock *sk)
+{
+	bool is_smc = (sk->sk_family == AF_SMC) && sk_is_tcp(sk);
+
+	sock_lock_init_class_and_name(sk,
+				      is_smc ?
+				      "smc_lock-AF_SMC_SOCKSTREAM" :
+				      "smc_lock-INVALID",
+				      &smc_slock_key[is_smc],
+				      is_smc ?
+				      "smc_sk_lock-AF_SMC_SOCKSTREAM" :
+				      "smc_sk_lock-INVALID",
+				      &smc_key[is_smc]);
+}
+
 int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
@@ -2762,6 +2782,7 @@ int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	int rc;
 
 	smc = smc_sk(sk);
+	smc_sock_lock_init(sk);
 	lock_sock(sk);
 
 	/* SMC does not support connect with fastopen */
-- 
2.39.2

