Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE047DD76
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039413; cv=none; b=tR2wQEKVbhjq3Ubwbtmec04oJmFNcvegSPdPx2nhuorUmnXrLzIX6NZKE2blNlYlLO1yhEuQioWZ3LdgA4N8kmFhVpkGvv6MQaZ/9BZuNYvq7NhW3k0yKdORKNtnAixPTOknzgXMcBWYTa3WgnsnUJXj7QesYMz2U77xrVXejn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039413; c=relaxed/simple;
	bh=2JgBpAWc31ZSpkYiSaZDvjmnHKEA4A5V63g6j0fsopU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qltXtn1keSZnDH+a9eSizGZBW9oIIPcXj0xLPD5QDdrcNOxszHtvDL2RNPKJIyZaOvLC04IysD2t9c3YpZMWirL4VQvxI+9ljTNSh1fuvkGD96Sqkxmf8dzPvBxOPtlw4iXG5wF/MhdByUfMOBoGEai/q65bJSjKG+HfXk/xf+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=tIplLQKz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="tIplLQKz"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4758bd3731bso814708f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039409; x=1784644209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=tIplLQKz7ETUgWcKFbHl0CWUrXenVkiXEyO3ng32niwGV71m/oIlqG0zutHaXUDmTn
         YXtlbK43Zle+QsSGZvahavbXjyKpupb2yhLdTwQbwyu+aE9aBLPKB3MzuH0tBTFbi0Fo
         w28wbfwUYeOoAbbs+DS1Ue++EkO7RQuVFmDxcSdN4t7lZTR1biPzQzSHco/so5vimC5y
         l0qcL1mvsChAugvRgeaMTPj6i43RpPrLaqRnILoJihFe1XIWbF0x3xz0Ge0wsW+I1E4d
         TGcE3lOQNqAJlhvSQ+hwOpokRo4GvE9inrTL/mcdyaB1TF1T59c/Ci8fOGj0LoYRID2V
         AgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039409; x=1784644209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=YxVpSeOWvQ23dKDp7VDRsfPSBNwSMVTSHZRJXqkNgxGtvsC9AypcsWYmq5UeArRRHc
         hSZ5wGa6GK4qi7wGoFQj60C14z0Dg/uQp6knDIoqNOeR11PSD9thzDvgBavKm+zPHCVG
         tLc4cPiow6GBMW/u23I6e5TS5yg4jsPCsGx/H6qKqOUt9bIMKxeqz7qS0/7JtmTX0LiP
         zMi76E0CJc2QRNWJ0IgZN3tUBp1wdnWIT9lXfR0ICSpmRoTOoGTsLEXTFNblT2ORBSIa
         q0SCqQTll7KLnBMERTbs8wRQyLgeXlm3iY9Pz1iD9s54E6xg2SfaHBHihhAm6QZUNhHc
         yrYw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7kiAsgPNK3b9U8U+BoM/MhxdbgKCYuinILf0No1czImQG913WDWnRNM0hSE9IG8aCAC+N9D6nVM6W@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8Q9O9okokzfXYW931BBe1YPe9QCJSzloNrR5hChxDCyqqPEz
	qf8Zy/GC7H7bSe2d3/hUgn23OGcfQ45cnwvSA7FU7Xod/iH7Nmlr+lJ3ucUAFkoyMGI=
X-Gm-Gg: AfdE7ckxxB3Nqi0g+aA81MltipVeZpRPHosPIBr3CfZ2l4gockGjxjCBJeAvaOg8xfo
	LZPuDO9cl80oPxM36SSiLXdhFvnm7oNYLVkg90CgTD5C+qhhw8FQ6vbWSwEWrYtMc0HGmQScdwH
	3kM83PsrK2FUg0+biafT20ApSGW/yJnAzpMTyRFDk3tE+ACVzw8D8lV7zRdaDK/aO2ZwkPezJlH
	apaTOsgiOvRL/bfpQihBaM+qZAaMAvo7SiCAL3O3y6PLkrJQxpnEK0lcrX9Val/XK3PKuUTXajR
	dcfGRbPZML+24ADKmqFz9NaOPc96YwDl76RjoDY1HhzEATyaweKBirHPPImhyuAzh064h8wrgjG
	Sh6QpG7YUH+TTv+b3c6hjiLhdE+rz7GnJnu9un+odXPZM83Qnr8HOp+Rn3NOkVe9+pgZVdCRNfK
	b/4o5f3fqCSSQeVQcKU50V7w==
X-Received: by 2002:a05:6000:480b:b0:46f:1b89:999 with SMTP id ffacd0b85a97d-47ef69910b9mr23198373f8f.30.1784039409490;
        Tue, 14 Jul 2026 07:30:09 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635082csm9292456f8f.7.2026.07.14.07.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:08 -0700 (PDT)
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
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v2 10/14] RDMA/core: Document the SELinux ibendport net namespace limitation
Date: Tue, 14 Jul 2026 16:29:23 +0200
Message-ID: <20260714142927.1298897-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714142927.1298897-1-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
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

