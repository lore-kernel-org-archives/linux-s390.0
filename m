Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BEB2CA5;
	Thu, 15 Aug 2024 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723696754; cv=none; b=r4bXavkyJcYS2THQdnGwvCCaMF+dmmdpdu4lFTfJkg4mIb22L7GCxWg5qlmxqDQ2cK5bH8DjEMiLJMrT9DXn9hLe5SXe4at+yjCRebrmROUb3GtQgFpOAmMuKYQ8PZ2w0e8QpMzd5GRdDms/6yb+FNzK1x83mUBS/Z1aPU+IvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723696754; c=relaxed/simple;
	bh=TDAiidY7Gxy3SZtR9kjBg00Cb9ghmdQIjHFIOtITHr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vDewlTu0Zzxhha2mdg5KsmRaJm6OMqFRdfaarAtO3hQlIyKQfR+MmY9zQMt5Rjwfl90jUx2uhDPiHN7um4adISyAhKts4+w1c09ZoUCrk5XEmxNkhGwQNCJ8rXTl8h2LEPotXWB4/SJLW8iTu6y6YDChYuCA2rnWGgXL3K8W02E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8UVe6LW; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8UVe6LW"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-26ff51294c4so443091fac.3;
        Wed, 14 Aug 2024 21:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723696752; x=1724301552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS+V7yKBk2IVPFtRnEb4zPDl5yAUU9pIOQvTDvNYQFI=;
        b=R8UVe6LWH9dskg0MP76+InDhFzXLD6fUZq0KYkC7kAqJ6kGlrzOwEInIIbIgp9Wkz0
         XbELWX573u3YhtUFgUqZ2zP3vIEhLmwNUNoh6xR13SRG0aIuLSrQLc0FtmTB9tXmtnPr
         INJhwQ1Z9Vl8KbTSLF1qlVhh8SU/ph8t34t09Zb5JKN1MP1Mahcp7GSflhGgj9AOpeCf
         OhjZLHiCIKrobFIxjkyWPj/coJxpjLmPcxcWl/S49UJOoCk6n+sDnMiC4n4SJJFNWa+3
         Y0inzSzoX5oAi4/jYrQSGxH/tHnD7HboDK1tekcuqueIqjNCC493KPIH3QIrvmu9gCbv
         7MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723696752; x=1724301552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sS+V7yKBk2IVPFtRnEb4zPDl5yAUU9pIOQvTDvNYQFI=;
        b=YjiVIByZqdp27nBJi1J/Cu3mWBZ+jlsaanSIlkxMMx5c8p/dGpJL2eiwwbKyhupDCS
         dtOCIagH9JLUmzje0bVgNMNo5aqK3tIO02oljtGywXVTFXXTEAvRhdDzHvulVFZ5vq9Z
         AOE+WGqsTlZru78RtBt7PBAvA5yNDvjFP4C4dA0QouWH68RoJIMHP+oaEp5+RfP4AaKm
         5X/rcrUhsDdj1wJgF2QDUy62AdhJ9MbyxX6cJvZKupoyyesaHpacYLIvELvjUJWa31gH
         q2nQ3GVr/aSHjm7S3E3FZZ8DzcpMENm+FQZ1JjKH8bJFhLNS71al5fWhyIxovmuNaur6
         xSxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlIaRvjM70T+oqCt+1ObkbNVrgR0gfEQ9aSg2/U5p5BmvGCuuKhrfTUwEtf8dBvVEAOG+8bun8bU8/+/d9Z47zmPcV8tasJW0Obqi9RCX/M0ZsefXvbWBAY34TpuD2zoBuIUXGUfgDTRsoyH10nu9YE9SOvShRuR0zzqXI4AU5YQ==
X-Gm-Message-State: AOJu0YwqeEJInYqmuSV5qhAB77fmKqfOz3VYYngnnWz8e2rxEuzACUlx
	qyc7+KuXjb9zBnRTcMYqxKlWhFy0/2eTnKqUVREzaeXmE/yIhL6g
X-Google-Smtp-Source: AGHT+IGLl/Y9xZa+NOlt8WOo7LOtI0V3UmspWC9Q14k5tl4UfUnNYXAUy3MZnSCFuDEKAPU1+1iAMg==
X-Received: by 2002:a05:6870:d613:b0:24f:e5f2:1cf0 with SMTP id 586e51a60fabf-26fe5a2cdffmr6271249fac.14.1723696752197;
        Wed, 14 Aug 2024 21:39:12 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3df55sm358102b3a.206.2024.08.14.21.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 21:39:11 -0700 (PDT)
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
Subject: [PATCH net,v5,2/2] net/smc: modify smc_sock structure
Date: Thu, 15 Aug 2024 13:39:04 +0900
Message-Id: <20240815043904.38959-1-aha310510@gmail.com>
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

Since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
point to the same address, when smc_create_clcsk() stores the newly
created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
into clcsock. This causes NULL pointer dereference and various other
memory corruptions.

To solve this, we need to modify the smc_sock structure.

Fixes: ac7138746e14 ("smc: establish new socket family")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/smc/smc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 34b781e463c4..0d67a02a6ab1 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -283,7 +283,10 @@ struct smc_connection {
 };
 
 struct smc_sock {				/* smc sock container */
-	struct sock		sk;
+	union {
+		struct sock		sk;
+		struct inet_sock	inet;
+	};
 	struct socket		*clcsock;	/* internal tcp socket */
 	void			(*clcsk_state_change)(struct sock *sk);
 						/* original stat_change fct. */
--
