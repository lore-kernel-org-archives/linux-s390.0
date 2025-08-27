Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89E2857DF;
	Wed, 27 Aug 2025 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291358; cv=none; b=Cdui2DJqwJiZ06Ky4YrQ2EidbKRwDjlX+s257h8GHVeL+TmYUaCtYNUJHitrGrbNO/AhULXcXpvQMx9kkOELjzwDWcagZzkf50Hs/My3M1dSDntIyaOOO1wdweJ184FH4w+PA08YaWRCjSqoVQdEZjIc4ajyvncmt/InNqxlTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291358; c=relaxed/simple;
	bh=ZtBIdZnCHZQ12LtgRqgW3EI2B93ul2ZH8koIDN46ZQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxvs/vRltA3CY/VYmR2UNWVxvmAsMAD0bbYo70pbwkhYuGwwIIa1Z5l9+29fPVyfBXlFeh8UC29rnjtg7qtCCxP2x3HMaR3EwJfqrmdk1x6FfafDaSY9r0salbNSO79mTUMwg95EkvGCwrywEjkfN9EyTtYpJqff82PeVK+F1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afec56519c4so60515566b.0;
        Wed, 27 Aug 2025 03:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756291355; x=1756896155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G79AwsSEkP9NYp/OkHMwA+Hki4uOuwUkISdhI+Igu/o=;
        b=fi+ISCrcnk+pzj6AMEFq0LcCBthTD5k7JwkSWFMCSSiQ/FRQyrV5dxf8WrVyFxADiD
         bssL++6n6C6gVuTjPjTm3xd+gpmpJQgk/TPDqNgAvSubEyG9dhWswPTLMT5ORFneB9Qa
         syDPLg4ZtCllG3XxIEFsaCyao3LGiT9CJfatpyecv13GF8dTnM7eXl7F7CNSvHiD82sH
         ceSKVRoi8GuTbF5T+6KFtOpT9SiuYQ2r4p7bgJq/KlOBLcze6avdyS8J/CeQ9bL6kIzJ
         TZx15JkBSW5YnVlaL6B+lEr76OsNCMt7xNhF3ZxpIbg2zeAN2fO66lkzPjnssCryMDN+
         ljYg==
X-Forwarded-Encrypted: i=1; AJvYcCUlinTxvvKIXyNOxtI8lRLPEtCRnhhwDsEI+R6Z9LDOXjAR5Fe1fZpFx0GjjPct7OK3paTuTLs42xMIgA==@vger.kernel.org, AJvYcCWTh+tqMOGGywge0DagzDr48OC9mnr+Qb3pbP3aGQ7Ur9QFtAAkV827BAg6+2OblmnpzPW8D5kLRbx4j50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9i4OQjTgRHN+tZuFnqQdI57CDpUW1rA50RzhcF4N+OSEfd3MA
	y9odofeLu1xCOW1R4IBSv8ISMfeZJ5Ej/X4n1QSL11I4V6w8vxDpNepI
X-Gm-Gg: ASbGncv/Lkznrv58dnbbKwphIPEztmC0ui3qK2IxKaDWQYZVYYmu8VubgHd0WDvC0k5
	RAeVudoc6zghASh1bqDMWQjNWDJ41PfKgdhq76t4JIZOjD+TKtL03Pxa3MLgf5B4kqDeQpAvEeJ
	ns5G0GiQzYNTFjpVmE4rEOB4eK++995GPfeNN8BLwhCzCbPAVkZGvianiUnsi83U509O5EIHbCY
	K8PecIaJzpkiWq1jqD02GCmCKX58cR2k1VQpbNkmwANjTJcImg3mMZd3Eg7bxBG3frtcVtu6UUn
	qmNv5K5ebGuMp076LYoh4EzhKU9j4ioA31jk7dmPFHBze9JL1r3LDPig17tPy9/HZaSP6WuZg1e
	Mct+uyBdtQCBmGA==
X-Google-Smtp-Source: AGHT+IGCNXjZVRJSHl42HEXN59RSgLMpGNWQpTXxDCqtsTc88Oi0JVJAK4fEp5EBAEbzQTdpR/dOjg==
X-Received: by 2002:a17:906:eecc:b0:afa:1d2c:2dc7 with SMTP id a640c23a62f3a-afe296ec4acmr1912007166b.57.1756291354609;
        Wed, 27 Aug 2025 03:42:34 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8e77c6aasm519657866b.56.2025.08.27.03.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:42:34 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 27 Aug 2025 03:42:21 -0700
Subject: [PATCH 1/3] arm64: kexec: Initialize kexec_buf struct in
 load_other_segments()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-kbuf_all-v1-1-1df9882bb01a@debian.org>
References: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
In-Reply-To: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <bhe@redhat.com>, Coiby Xu <coxu@redhat.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445; i=leitao@debian.org;
 h=from:subject:message-id; bh=ZtBIdZnCHZQ12LtgRqgW3EI2B93ul2ZH8koIDN46ZQM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoruEXEz5/jNTGfDniMg/ZnAHUi/RMcmE+6R2RF
 hCO9Exf9kWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaK7hFwAKCRA1o5Of/Hh3
 bfYLEACXBlAx2lnDz27xwPzW4zjmn2zElcwunujZrWs1v4Z9od/NKARCH6tvNwN20afKpZ4gIW3
 ySL5qOqXCFGmp8SICmUgtEu27vihwQi5mE912eHGfaowVn6ehUpfu+PzplkMA1smdOaHKHkJElB
 3rTziKVwLCCkKaGmYFL8sw+IHAxJySOHATGacXbu1CE60eGYgDk5d2A+aa8BgAml1iuEuCNP1vY
 Z/6VWe5imGd5Fv1lua0SdlFkQ9vWpntT1gXLqKVUospwxDgz/H7D3hcuiTZm5/ggqr9hvD8+4LB
 7GkcMPs57t1luyhKi3limgE818GFrnBJT3CNwqxIFy3pEUO+hjdtbtGWwwj0oT5pxu2HUCBe+Jl
 pLWp7tIEqg5IMLdERqOPKfcyojA2U6l/qSLx6WX84Pk+AT6jI84silv6NNYzG5XAnJQgvRCvY0x
 SgPs4xSMmkgeztXFOcuGg1jUU0m9VJEELoU9TIUAef07ss+dwSXMRzmNbf/hoRp5LlOCwUgr1KM
 cyI4eLuldyoxD039e+c2KuUsITIwwDgJXtNeqo3vzpJKU127Iu+anDRICtyp4mRZVACnKmo+nFw
 D75fz0VAeYQ4+jVEtiG5Sn2CSzpUejInwoTSc5s38P1brzQ0Lz62qtytjJI+IdB1lmT8vQwx2hQ
 opV5AljUUPp0+hA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The kexec_buf structure was previously declared without initialization.
commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
added a field that is always read but not consistently populated by all
architectures. This un-initialized field will contain garbage.

This is also triggering a UBSAN warning when the uninitialized data was
accessed:

	------------[ cut here ]------------
	UBSAN: invalid-load in ./include/linux/kexec.h:210:10
	load of value 252 is not a valid value for type '_Bool'

Zero-initializing kexec_buf at declaration ensures all fields are
cleanly set, preventing future instances of uninitialized memory being
used.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
---
 arch/arm64/kernel/machine_kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index af1ca875c52ce..410060ebd86df 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -94,7 +94,7 @@ int load_other_segments(struct kimage *image,
 			char *initrd, unsigned long initrd_len,
 			char *cmdline)
 {
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	void *dtb = NULL;
 	unsigned long initrd_load_addr = 0, dtb_len,
 		      orig_segments = image->nr_segments;

-- 
2.47.3

