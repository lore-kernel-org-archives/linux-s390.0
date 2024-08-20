Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD218FC72;
	Tue, 20 Aug 2024 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156135; cv=none; b=QT+TZcjvu60Rc8Pu8nGkmB/+fuXgsSEiUyjDJIkB66AxfMqCZNIS1X6NmOyv4yg0hlYc6BZD0eLusc2KLXb4QZcoEBWYePW8AwmWTfPnVAjabZkENl6iOHXqW5d+iVT4u/NwLvcLnvdi8cMC6yju5QJo48t37v2mtAGUnpHCNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156135; c=relaxed/simple;
	bh=3Rsxurh3oebSOC9CSdQymFF5A6WyB1+tnn6Om+aTABk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eS26qke8/uBdbqMkKQ9PNGCMiGfbcUC1OxsXD3fOJulD+CmslqbXW8coj2y5ahjmvNgP1p/tX8tQTHY1Airjk3Zi8DqXAvNSjEJZLb+rIBUPFFdO58HOszcpWL27/f28bVds6OxMBz5czgZjCPvg4GNNy0qd734jTo11nwv9j/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwEPLKBC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwEPLKBC"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so3601234b3a.1;
        Tue, 20 Aug 2024 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724156133; x=1724760933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnzctouXAZ5Z924Ba3lV0yqN0741CnCOlYB+XyAgYVQ=;
        b=iwEPLKBCljTNTXxie/jcLMf8Zs+1eViOz5ru8RGsbCR9dqzoDx32pylbXQ7H6ces8E
         sOxA3BM1PwhQH1+pnx5DDI9WSM9GNZseFJWyIRNFac/14kaoJi76vsaMalyg1PN1tSsH
         GyFj+oA25Lh9aMttDcDtxP1VtxWO2mP0Aa6KnbkE6TWE81NbabB8WGG0h1UESdR5JBTU
         tSN8cUTgXOR2GAhU/kkPonKMOHRc71k3TJrh5J5ji+mhSivzTjBCYx1332hNYxyE+4nL
         JA3OBMnHWDMmiK+3AExe3MirnAOY+wOqtslkWMA4qYSijMVPxHMk8yACNL8Tcxsv8JSF
         n3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724156133; x=1724760933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnzctouXAZ5Z924Ba3lV0yqN0741CnCOlYB+XyAgYVQ=;
        b=W9DGDoX+wMNlesM/2iV7gdXKJgdN/gjqZy4jr10JwFKMjBgaJNy6ocLKsMeN574K2k
         +U3rQRIgAX5rho5xjgpypz7OzkmlF0I6D+btbkgCTb9Oltu/KiuJ+Zk49Z9UA/gV4y10
         UHCVjrxcH2j8FdQb5ZfL1iu3xmrIm0/H7oBu4jMpHRPJwk95wlWTbLQqajauoxSjxIib
         XlAzRa8jw+Jbti9P/EjvSyxA9NC8ucmSEyQ/xg7ZXRbehoVKNpNfwKWUBmoXtW5M3dct
         B2BfSBl/Slz7iaVyAUH8goj4t2DsUCI5kSnx+zQPpYTn6GuGDjHggCWLfxGOID37Ehbr
         EvFw==
X-Forwarded-Encrypted: i=1; AJvYcCVSeHzJrd38nkOtsjOpWYvz6F7Xp8TW94gmLykhdaxuDjUz6HEPcu8I+omP9XCc+9oTMZNLv03GJT0QcFKX/MQyZVXVMV4OgkAFaF+acnJjAbnMwx0/jeWDy62WDJeJ6aP+fe+F01fP0txCeYuH5HI7P5ruCedCvf+xe4vN4S9USA==
X-Gm-Message-State: AOJu0YxA3CV2FygeoDfojN/rSMX1NGXRbEEBVeV469xx+O0zmsNl+P9y
	ZBRbgck1hT5Rafx+tpsPSUAPKf9xlK41dT+p9RgRY9GokZjcUFqg
X-Google-Smtp-Source: AGHT+IE5LBNad2gqtiOKBmKFO3vibqCB1+pQr1HohVNt326OKWBqpfpCdRt+RrkUoAH8cqj5zWgsHg==
X-Received: by 2002:aa7:8886:0:b0:70b:cf1:8dc9 with SMTP id d2e1a72fcca58-713c525114amr18450202b3a.25.1724156133015;
        Tue, 20 Aug 2024 05:15:33 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add72a1sm8068518b3a.27.2024.08.20.05.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 05:15:32 -0700 (PDT)
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
	utz.bacher@de.ibm.com,
	dust.li@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net,v6,1/2] net/smc: modify smc_sock structure
Date: Tue, 20 Aug 2024 21:15:26 +0900
Message-Id: <20240820121526.380245-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820121312.380126-1-aha310510@gmail.com>
References: <20240820121312.380126-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
point to the same address, when smc_create_clcsk() stores the newly
created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
into clcsock. This causes NULL pointer dereference and various other
memory corruptions.

To solve this, we need to modify the smc_sock structure.

Reported-by: syzkaller <syzkaller@googlegroups.com>
Fixes: ac7138746e14 ("smc: establish new socket family")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/smc/smc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 34b781e463c4..f23f76e94a66 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -283,7 +283,10 @@ struct smc_connection {
 };
 
 struct smc_sock {				/* smc sock container */
-	struct sock		sk;
+	union {
+		struct sock		sk;	/* for AF_SMC */
+		struct inet_sock	inet;	/* for IPPROTO_SMC */
+	};
 	struct socket		*clcsock;	/* internal tcp socket */
 	void			(*clcsk_state_change)(struct sock *sk);
 						/* original stat_change fct. */
--
