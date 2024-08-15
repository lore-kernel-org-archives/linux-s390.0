Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F1BEC4;
	Thu, 15 Aug 2024 04:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723696642; cv=none; b=PGFdARJjwfjQJoswgmLjSjVdo5TEHgpw/1+zBMzoNCRQzV5NyGuaapPhZAsaekOOyiDvxLCjNExNPgEOhQYU/2t642taqFRl2F1u6nZpmaDOWu7EyBKX1Vb3wZI1mNx33+E6YHs22KxC2WfvF6JVuBQIkFT2r00fg3ez/6/fmtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723696642; c=relaxed/simple;
	bh=y9J5zSN5z0sua8E2eLCGRkvQ6EfUE41XgG3IlsTHUxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CzsTYXAG4oCcsnHwW25pvQuTqILoofdZ4oyzbera7Y/ymtIM+JQc2B1c4dR7z2rvfkwZDPCzVmZmcGxqRqIxb0PpyFB/he/0zJkLc5/zU4liEvKiLm5ShndwRZOrys97D48XE3WrtM13CeqihmvqxnHsqubeCtbDY+EXvtIWDkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njV3gTok; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njV3gTok"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd9e70b592so5519315ad.3;
        Wed, 14 Aug 2024 21:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723696641; x=1724301441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Delqls4XZvd+0CZ7c4mLJoMdC6GpSpAW8Lh/tFw2bE=;
        b=njV3gToka/9md5KdKFADr0+blDLom1oILO1T8TJM6OQyKaiauU0lIVbUj8bNGBzpp5
         Mioaz/SV/qmp4jQfTaitAIPub7SnOIWqWxMi3642NgjVOF9BNUSicLShKViEj2SNDSdU
         EUFbeJKe3mcXxIKKBQttreFiHgwh06ju6gia17qLFlbo+jbOJ2nsIKmtKNZInGcHxf2o
         gv0gi9gMLmySOj6RTpoI+qq9qCGdTfIYxVjHj3j9Ltn+JoyU+wvdiSKbAJBDRjV3UT+h
         ViOC9q1V4vyNDEJvp+oW62ptEOEqmr6Y5gORI1w4hyMRNb1qyK/6zs3lNASTG2bgsDM2
         mC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723696641; x=1724301441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Delqls4XZvd+0CZ7c4mLJoMdC6GpSpAW8Lh/tFw2bE=;
        b=qno8ko2iRuY8CN1NUnHR6wuiBRezF70JWLW+LgLq0cz9XDXH/TJnCMuzp4Co3hssrH
         HS0tCmukcGHwz9qeuhs/sdQNVSzSco9vBc18HO+Z9Z0/izFcMcP0obsEUgb7PG73EM8+
         Bvbm0Ub79E1ejNkRq1inFrS2LNFcpYL2efSCar+wFNakt7uoUck1CEXAh2t97nU7NpSp
         ZkKFHwMLNtQQLE5wq6kYf+sPvu9G0jnNPo8e5yEqBcyNw5BBvRsFrcCz92/1eaCEOeCF
         jokisjGTL5u4ialTq96qSTakEmzPym8QBd5+t2dA8AtW4nBJFagsBCTUHY3X30Vy9xs8
         1huA==
X-Forwarded-Encrypted: i=1; AJvYcCXw2KK+jPcA/eHvymjqMpeaXfmMhWmgRYE1eLfKuOKsautHeEAsOwYPvkIZtMoS1yvfElaRdls6UzCyGi1kCWGFubtFtFgLtebsINpr1GVUAj3zd0ot32AQ+QHALKTeCJaNDbJuvDmGBowKjVqYgVCRrgkZcziLTtPL8smGx4UKGw==
X-Gm-Message-State: AOJu0Ywm3cyM2yonXJ8zhKusT06FsKp2zClaED+E4R4EM07mXBa7ero8
	yGZoWI/5WHaCWUkgANIqjOj7nCxM+isBPXfIGm4DGGubZnN/Haqa
X-Google-Smtp-Source: AGHT+IFsl94gUcWu8Q1A/r/Mbwxmnvec4Jrd6LKqDJcfReBU+3PcMfb8gJ5kP77tYZZMvSZ8030bAg==
X-Received: by 2002:a17:90a:db86:b0:2d3:c862:aa81 with SMTP id 98e67ed59e1d1-2d3c862c27fmr1345303a91.32.1723696640735;
        Wed, 14 Aug 2024 21:37:20 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3c8840a1bsm493157a91.45.2024.08.14.21.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 21:37:20 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net,v5,0/2] net/smc: prevent NULL pointer dereference in txopt_get
Date: Thu, 15 Aug 2024 13:37:14 +0900
Message-Id: <20240815043714.38772-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is to resolve vulnerabilities that occur in the process of 
creating an IPv6 socket with IPPROTO_SMC.

Jeongjun Park (2):
  net/smc: initialize ipv6_pinfo_offset in smc_inet6_prot and add smc6_sock structure
  net/smc: modify smc_sock structure

 net/smc/smc.h 		| 5 ++++-
 net/smc/smc_inet.c | 8 +++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

--
