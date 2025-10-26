Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6BF288C25
	for <linux-s390@vger.kernel.org>; Sun, 26 Oct 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761470051; cv=none; b=ThiVgsCPTFMjq6DcaGyVbSX4eNvhYTA/tdCwzxcvIx+cehMsQrwg0Z647h/UCq/lF3LJQgAVFTxXwWZs3/3vmmW5gdT4cRsaGQco4UxnCZGhsBvlmzRPW+ek4IHQsCXL6Pep0P0XsVgA+RK5DMcElb4CteWDrPFVyY5lNHy7sb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761470051; c=relaxed/simple;
	bh=yYW/ak1UJm3E5gbSPOy3veYjolaLM2LzMiaO2+3Xn2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zd2BH9C9fQVmkqsGaJ/vtmvleQlUwCqH+fozFsXYkEVYgVl12ALLkdmg/V6ofnyKEwkWcP6N84XDj204jJWvEXkq6ZmCjgugp4O+BZC1RvCNH6ij64fy9vh+fxkauMdTZjVkZq6sk6xVm2/Izb5YMJDOH6+umoUzK0NB35180x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF4AZV6m; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF4AZV6m"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2897522a1dfso32609495ad.1
        for <linux-s390@vger.kernel.org>; Sun, 26 Oct 2025 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761470047; x=1762074847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QKaKeVhm5UnUNE6DNnz1ldVsC0c/aJHI3r3WJDhZOKs=;
        b=kF4AZV6m1tneegcMM2wixBcccRSfwk5zcS/uYPlAqNsYE/vddP4wYRrK6siY064vRJ
         loyTut8uMFLWYzACAo1NQfY+sm/r0KNI1Y5mUUshvnm7SFVcnaVN7GuNRP/NI4UY6uCM
         M4vVrnFzrqnDF7lpj31GH5+8L5f5uaiI+N7rDaVJuiGwQve8BEJUb8zfroq2CXoSAisB
         RYV3Jpb4ZVbxHjYyf3P7ickYXHZfvTHKn8AFxbVsLgTAUx6p1hR+Jxz98iKenZ3TGAFj
         0Azp3fmNunv94+5+6SsDLAwMdf+dGRp0tFRP8pUF09nSIhGD4qE4EF2IZ4FUeHFoDQzG
         EexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761470047; x=1762074847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKaKeVhm5UnUNE6DNnz1ldVsC0c/aJHI3r3WJDhZOKs=;
        b=bupniQTbqxnZ07x8ICbTnBsOn89vNQH9Ce2eW1QTmd31pBk/TIjt1HbYfuSviHJHMr
         /0BkgFTGKqaFSsKPJBx/5kMi4/0aeRYS6qUiwk3OcItgy7selgIF8ZZ6UMUXxlZFsiKf
         jlvsZs6YRAvjgbFC1IxJnZOeAbA69HtPjvGF6LWKmKvF/ejDaA9ila/y0j22cwvrrrUF
         7ZmlJvoMonl/+quvOOm/3vdv3xQMTI+AcHx+RRwlEu8y2P7fD+o/uRUcv+sVTRGew4nT
         yKS4Vh/Vo6RUAZlo7Qqimp7OCtcwhLTm6fA9X1SQK6UUlMkPvJFD2N1IpLOkHI9szIlY
         KgsA==
X-Forwarded-Encrypted: i=1; AJvYcCUy3WWdDaK04Bv001G8JU2kC2yeXIAEcsIB7N8FgQ5sNQVuU7Zd0r+AxXk6Z61QRyGF5auPnx8zCmAX@vger.kernel.org
X-Gm-Message-State: AOJu0YzveIztlfGlFxsTJidHRN0/6z/fcOC31WUyv7UuFBx93j+kgzwu
	sRB03Qw0jFGDSouXIlhVTCI55TBayiC+Y3xZSdulY2RCvD7LpDEmUO6OctGkhI0FrNY6hw==
X-Gm-Gg: ASbGncsW5Kv01XEoXRgdY1VNhmBTLNkqum4RCT99qxAXFEKFFvw6kaxZjoOlMcWs/vQ
	QiNm82dUCnIQN9AhWVvnnfm9G+17bglLgoCYYN6gHrgHXZ6jhoRfyOVmFKEc0VSRYJgZpCwSWhB
	tintWu/BAt1DUFOV6Zm5a7iAX97uiw5y6mfKoMmfym2Wfdeenu7pF7//O8b6QT+Dy4KeyeuacKW
	jWejCs90x0HmBBTRT1gE1GjpJVJvf4z1WC5+2k6rNovJMv4gYcw+e5rSe/qkgdZZnQV0LYNhSbc
	sHOtxcKiMIbflz2981tOX1mgEPv+pnTu2Z0QzYXq0ZMXcQ+DItBT1i0OHzdViXm/hpkNMk1ldrX
	7SFrypZOmaNNDqgXhnEdPmY3nsOn/UcrUqZ97kQFUtydYGOMAhi7YgRDivI2kIre/FP3qM99HPn
	jjzoN3sJgYK73Ah5vOQhhuug==
X-Google-Smtp-Source: AGHT+IEe619zwvr7QyCnZh0FhG1JilOPvnQxrGb0fx5QjWMkrsvOWzzaRjQT6fRCzSTx06geLcWkig==
X-Received: by 2002:a17:903:32ce:b0:290:b928:cf3d with SMTP id d9443c01a7336-2946e299a01mr162561475ad.59.1761470046967;
        Sun, 26 Oct 2025 02:14:06 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fed739b81sm4732043a91.6.2025.10.26.02.14.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 02:14:06 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] s390/mm: Fix memory leak in add_marker() when kvrealloc fails
Date: Sun, 26 Oct 2025 17:13:51 +0800
Message-Id: <20251026091351.36275-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kvrealloc() fails, the original markers memory is leaked
because the function directly assigns the NULL to the markers pointer,
losing the reference to the original memory.

As a result, the kvfree() in pt_dump_init() ends up freeing NULL instead
of the previously allocated memory.

Fix this by using a temporary variable to store kvrealloc()'s return
value and only update the markers pointer on success.

Found via static anlaysis and this is similar to commit 42378a9ca553
("bpf, verifier: Fix memory leak in array reallocation for stack state")

Fixes: d0e7915d2ad3 ("s390/mm/ptdump: Generate address marker array dynamically")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/s390/mm/dump_pagetables.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 9af2aae0a515..0f2e0c93a1e0 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -291,16 +291,19 @@ static int ptdump_cmp(const void *a, const void *b)
 
 static int add_marker(unsigned long start, unsigned long end, const char *name)
 {
+	struct addr_marker *new_markers;
 	size_t oldsize, newsize;
 
 	oldsize = markers_cnt * sizeof(*markers);
 	newsize = oldsize + 2 * sizeof(*markers);
 	if (!oldsize)
-		markers = kvmalloc(newsize, GFP_KERNEL);
+		new_markers = kvmalloc(newsize, GFP_KERNEL);
 	else
-		markers = kvrealloc(markers, newsize, GFP_KERNEL);
-	if (!markers)
+		new_markers = kvrealloc(markers, newsize, GFP_KERNEL);
+	if (!new_markers)
 		goto error;
+
+	markers = new_markers;
 	markers[markers_cnt].is_start = 1;
 	markers[markers_cnt].start_address = start;
 	markers[markers_cnt].size = end - start;
-- 
2.39.5 (Apple Git-154)

