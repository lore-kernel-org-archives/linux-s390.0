Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00CC403AE9
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590972; cv=none; b=nTGH7C71Aemw61R2QKA9ICL0QFwIBJB5gbwt+Yldj44Imy53+o7L1ZVKcD7nLhhRBZmYf2sdXzmGQG8btDapgf9hRZqFolsEQonY+qdCwyUOp4hFPQKKYerjxcBEf6yngzSOvQwxLQVLT7J8wUT+lISxwcsVVM/uaGBTuclRMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590972; c=relaxed/simple;
	bh=2JgBpAWc31ZSpkYiSaZDvjmnHKEA4A5V63g6j0fsopU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAsLMThz71Ez8Vx3qiX6u8GZ7+2i/GVuH5PUJVvPS0EkgFIMOL3icbyaoupLTqbVCz1VYAyFKUfnXMMnLmlgSjYAkzaxmrTeEuY9aqNQ0rpCZcVL5txe9Mx/DhbvoXEFEF/WWWVo8dyz/U4eL+sBtS5aS5tyL15GHKfG833kEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=LD3Fad6o; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="LD3Fad6o"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493ed9d8c5cso2307075e9.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590969; x=1784195769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=LD3Fad6oh39v8c+zQa82JZBsYIfQEkOKAD7U54Yp6LpXoRZa3be0fua16CIXdNP137
         YKaKavVDpq5LxPMx//tGV6b8NpL894RgbRTMI/6VpCD1i2O445qTMygiCTf7U9ZlavNn
         K0Sc9CbY0APGtGIX73E0JN+JhwSXXbn/MwnG8p7s1jYO/NTY0lZDM7KPboGJEDIh61jC
         VVZxcm4LuB+efPQi73Qh2Sxua1dF48A6MAx/O6LQKJapBUZSS/jlXxGt85IHLKpDRR8B
         QJ1p0ygWV9LL0XU+WGRMJ+3r5hfo57BvXwtInPv3TTblS0Wde7efcijJfdQkc1YjECk4
         hdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590969; x=1784195769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=Fdh5Tgv4PGGJRjjdatAcIQUNHODk3OrPZzrL9bMn6i/ysWmhS3z/AUTLiQaG6RALzr
         meMnTOOPBwHUjBdB+exJd9BUEKW1momjw6cht9UTCiLZ1ObVcb41dj/3AH4ploZFg+6a
         H7VUiH7t9cBOpfRjAcKZtDJIz6D9VJQyEoCf2IXwilO3VY+E6FjYPE+X6CCoh+LnftSg
         frgEdJkWsvp5ZvfJTj+DdtzxSllYx+C/Ks/pRFh/oL8AR7xW5LJRAuDNBjvTc/fpDrt9
         IOAqg7C0SjJ3WCDhKEhNUS8dMIo7r3m52mS6LyGNUbLPrc+5OYJzFH9lO4qiYof87GgH
         ikHA==
X-Forwarded-Encrypted: i=1; AHgh+RqXeKhRAx0IOZWkV69xAnbDLL5JCUucVIJAhCfHlUtLCKeumiBvwIORpLk2NulOyFxS+wzDFJm21m09@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqv+ixpxhYuTXSpiErr5gDiCMOcMgzqA+QA6hkujaD9TGruWH9
	uKuloZ2hOicp9BUO+qxPRVxjdSSpgtmHlBDKtveJR28Wgyr/Mgg7Q0epZoB54n6OMsqcfJtdef4
	Wmc/W
X-Gm-Gg: AfdE7cnk8SwdmhID7QeBxHAKWaK0YPBqYLsP165E2X8TElOoWcyEGxivzk8Z7gnMjab
	EymoKvE5uEpqTTq6hObEHxsBHjIkhecvW0KIKkU5K/iz5yEvJeoG6feRKRqy5OuZkb+kFYEz0vn
	jn5UqnH1PRGjv0gz9OSs1/m1HfkM4ZA1Xzig5he9wICBGqAIwtmno8lcNCkRTRK2i3QLlAfUxOM
	HnBMENqEtFNsQt7akCye1oGgorng0ObzvQJT7tpxN1W1aO5M234lR8Courc4cEwCA8P8v4qEXMU
	Azg0MAbtI2YwR1huy8VLL58dhxesXL4eP5StDCxWR507jpDcgc6NMM6hMAS+yKLwn3Q7AdXRExS
	nd+wRbyFYP18ZaX70ik58IsACWnJYrb+8gKFObELr3J4yk90KODqHULo1yI3Hn/TRq1sq/ysNOQ
	Fzm7eyM6ATNgJWFt4jYNkjMehNamuRI3ll
X-Received: by 2002:a05:600c:c4ab:b0:493:e4b2:5290 with SMTP id 5b1f17b1804b1-493e689c26amr56899785e9.12.1783590968959;
        Thu, 09 Jul 2026 02:56:08 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a5d174sm148972975e9.2.2026.07.09.02.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:56:08 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Subject: [PATCH rdma-next 10/13] RDMA/core: Document the SELinux ibendport net namespace limitation
Date: Thu,  9 Jul 2026 11:55:29 +0200
Message-ID: <20260709095532.855647-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709095532.855647-1-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Document that SELinux ibendport labels use a global (device name, port)
key, so same-named RDMA devices in different net namespaces share a label.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/security.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 9af31d1d9d70..a82c46965416 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -700,6 +700,12 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 	if (qp_type != IB_QPT_SMI)
 		return 0;
 
+	/*
+	 * SELinux labels an endport by (device name, port) from a global
+	 * policy. If devices in different net namespaces share a name, they get
+	 * the same label; distinguishing them would need net namespace support
+	 * in the policy language and tooling.
+	 */
 	spin_lock(&mad_agent_list_lock);
 	ret = security_ib_endport_manage_subnet(agent->security,
 						dev_name(&agent->device->dev),
-- 
2.54.0

