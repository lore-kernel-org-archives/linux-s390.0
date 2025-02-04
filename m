Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F951215196;
	Tue,  4 Feb 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686314; cv=none; b=h2qW5Qv8yyWfR+vRXGWgMILew9rgwXPhG9OKQGYMZRqZMXXjDr08SK7rLDhq0jqExC/ykXEbSGYO3HdMeLHhdiHl7vfmoKdVJem+iJwB6Db8tv0ukOvpHHfGMp87hNzn/zLgp4ioQEWy/akHlICEkXTak8penhPSwTKMZaxMjhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686314; c=relaxed/simple;
	bh=3fEAX56iNa+CycfmEtTazJYgTC1eFzflfXs3KGTszjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MbL7+FjJf9WtP2s3wJh9nXRKmtMTBlRvXPPcRa30PdUBLgdBRy1V0R4cg7gGUdquSePq8IQ3nuqj/FZsO7Dl26xHXk1v3pkL8qHL0IXnv4YrGeW8pXgBhPRNJiC7yPE6m4HN6R+EvnVM8NAQtI47oAydDDCU0mM+5yrOwi+Ha7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l++VE5Ls; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l++VE5Ls"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso3182654f8f.0;
        Tue, 04 Feb 2025 08:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738686311; x=1739291111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IA4Yp+yCwxNKEvtY2lHaAdyLql0BmH5cuaPGmjqth1w=;
        b=l++VE5LsEfesIck4VgABGK9gzK7hMRVwmnyilCBluVgj/K6RL3cjLbgVPYpfQUp0Gy
         BVCdHpstm4tobLoW4w/I2qb/fV8dREeIYfVDNMf9KZZkmmPsYIn8QccMtNNYXgJwFvD7
         yC0PWUEDPMSjsSFaFNCT19qVfRJR5M3SQu4FN3HygK4gF8hUHc3C6ylSD6zDGRdu9KCj
         yHUy7CRoafTZoAdVkkmjDyWsDia9i3B+I3+Mx9rnyUPj8ZNSe7CvpNJY8d3pG0pwf4SI
         RITomUm3zDBpf2NJ54CJ7aMKbvpuFRlaHOlmpvPTKVi1i1SQ19X6Osel/pr1dr6SJh1v
         U62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738686311; x=1739291111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IA4Yp+yCwxNKEvtY2lHaAdyLql0BmH5cuaPGmjqth1w=;
        b=Ec21J3FnUpOWLDs2LxjE4UOu+ecQB7x9KJ8PbxP7z9dt3wzJkcvyCkG0fFlKyxfqBN
         d1spzGDNUjOPIGYbgLBHoWRTKKyIdC/eDjgKjngBYKInRSpht12pqLHPGA/Nzbu6uBgs
         78cq2rp+d41Dn68e5Cwj38cjvaOPohHY7TXNCYGEENtGTWgMYjN5K5uoE3BYcz90Dc/Y
         z+SCXUoxCcX4YRuh4IdTP8/xAfMUGYvd6WB6uEV++YYVee61NA8slxiFw7yM2aFOoZcd
         GOse8aJa0DDnBP2WOpo1JYwnrINJ0NjcRgGxpGi/nzKMjSLevhwEIbmbp1kOTe/OcG2L
         /vlA==
X-Forwarded-Encrypted: i=1; AJvYcCWXmqPCl8HBfeRZnbtcH2cddH/1Iwbf3Qwngwd4F62Ze8zgNu9kJAhZuGimvWgN3J2KWAlnLPMNUGYvFZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNAJ0ESA4w8OdPL1htiUnw8m7EX6+Lt2ycg1bAPjUdbQD9xi9l
	VNK+ALmW8IaO7PprGidmKtRBEGApAaePTWH0DMMZmTDyExi4wNzehKrF4fpW
X-Gm-Gg: ASbGncu0mxBj3VjkxyiSBVJbmgMgZIrdbWEAsVyQ0ZFdDJUKxSwpu+U/Rpn5nSzxuiE
	1RNSldH+mOH1NI9jaQDk2Bg7zyZRprcI3vqZ2ZqDjpuMci7bxonEOFBgT9rteiRXZVrnX1oPodD
	hytvm1PdBHvmuGdgnLx5qyNKvxVc+UhIQn1MBT95NfUtzW9XFKiiBJ9FExV0mmpgtrEDuj1xCEf
	n7xcExy/7utlxW7+fPHasQ+gv2kkrlaq/We1PTCW3AO4wYGZ76OycB9O0GwPRGukvv5RwAXhnTW
	gEvPoNlWTWINrEh3
X-Google-Smtp-Source: AGHT+IGZLPKU2USTsvRL65kiUm/nRtgDWZ1R6LnaZd708LRV2tT4XJVniSk5UK6wn78+DjhPuztQ4Q==
X-Received: by 2002:a5d:4565:0:b0:385:fd07:85f8 with SMTP id ffacd0b85a97d-38c5197470bmr16556579f8f.29.1738686310622;
        Tue, 04 Feb 2025 08:25:10 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:8399:6015:262f:b375])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc26d6fsm228174525e9.14.2025.02.04.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:25:10 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/mm: Simplify gap clamping in mmap_base() using clamp() 
Date: Tue,  4 Feb 2025 16:25:08 +0000
Message-Id: <20250204162508.12335-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmap_base() has logic to ensure that the variable "gap" stays within the 
range defined by "gap_min" and "gap_max". Replace this with the clamp() 
macro to shorten and simplify code.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 arch/s390/mm/mmap.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 76f376876e0d..a3d3e09a2828 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -63,11 +63,7 @@ static inline unsigned long mmap_base(unsigned long rnd,
 	 */
 	gap_min = SZ_128M;
 	gap_max = (STACK_TOP / 6) * 5;
-
-	if (gap < gap_min)
-		gap = gap_min;
-	else if (gap > gap_max)
-		gap = gap_max;
+	gap = clamp(gap, gap_min, gap_max);
 
 	return PAGE_ALIGN(STACK_TOP - gap - rnd);
 }
-- 
2.39.5

