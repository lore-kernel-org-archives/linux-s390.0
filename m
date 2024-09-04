Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5351CFECB
	for <linux-s390@vger.kernel.org>; Wed,  4 Sep 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447030; cv=none; b=JmD6ULFBaUASvUxDdLWiVErKo23ZahxR6IaGdrCE6SL/3QiJPNAAtcEefEotmXPzzgCXsZ3pMP8XKXJ1Wv4AvvUl+kq5ZnctecR2RBfddZG0UbMp4u8wz6MnB7DlF7TNyoGC+YeEJENuMf70WQ7nMOdkATB3AKIxBSleAXx6TwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447030; c=relaxed/simple;
	bh=OdXf2H2QDLSAtlOxK+CnZ9ratRbha5XGfAp3jGdKS2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8ROJ7Ukqpd3+aJQ3n/B+6jMtk3ZluB2tHFZOb5X91eS4NUou6ehAaaYOOfacMo4Lk1wGTtGMZgoxob2wap3WZh8MVwU/xg+RhY5GcdnTdd1KquSieaOzi8OJqPWmJaqTxY96aXkI08tVWS3epW7PHGZO8QMo3CKo5nNxmUF6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fZ0sTCwl; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fZ0sTCwl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725447026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8NNLQYH8P4X4ClL5Bx8RReyaTo01W2Due3h6Q3oXYc=;
	b=fZ0sTCwlLwmNS4Qx14Caj3m7+Wf9GvHpK45FyYLnYSoeN3sTNUc9ZNhvJFFXKjE2qIit3w
	xrRRlddFhToMEzSHA9L71dLm3+ol7hxzwVSZI5woh4aBt6SMFmmXNpDbpi/I3M9lEtpG9g
	qWnZMd/+09bOVCE2Sd/kwb0IjKBB0FY=
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com,
	thuth@redhat.com,
	lvivier@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	atishp@rivosinc.com,
	cade.richard@berkeley.edu,
	jamestiotio@gmail.com
Subject: [kvm-unit-tests PATCH v2 1/4] riscv: Drop mstrict-align
Date: Wed,  4 Sep 2024 12:50:22 +0200
Message-ID: <20240904105020.1179006-7-andrew.jones@linux.dev>
In-Reply-To: <20240904105020.1179006-6-andrew.jones@linux.dev>
References: <20240904105020.1179006-6-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The spec says unaligned accesses are supported, so this isn't required
and clang doesn't support it. A platform might have slow unaligned
accesses, but kvm-unit-tests isn't about speed anyway.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 riscv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/riscv/Makefile b/riscv/Makefile
index 179a373dbacf..2ee7c5bb5ad8 100644
--- a/riscv/Makefile
+++ b/riscv/Makefile
@@ -76,7 +76,7 @@ LDFLAGS += -melf32lriscv
 endif
 CFLAGS += -DCONFIG_RELOC
 CFLAGS += -mcmodel=medany
-CFLAGS += -mstrict-align
+#CFLAGS += -mstrict-align
 CFLAGS += -std=gnu99
 CFLAGS += -ffreestanding
 CFLAGS += -O2
-- 
2.46.0

