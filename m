Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE027A477
	for <linux-s390@vger.kernel.org>; Tue, 18 Nov 2025 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427200; cv=none; b=m82S/49y3VA+Rk8y0nAbfmhGsFrD+T2/5VBVp7DThfQoRRxfQFvWNdJ9NzX24bjy700SWfZu4xUF9392R0Khac/CYWVX7dzYetX6n596t+QfukELNzfWHH0cQ/fxRBsM6XSmIgMNbhtql4TlugR3C3jPLVOuAXbWJH1tsuJB7Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427200; c=relaxed/simple;
	bh=Zrn+p+qMGfDRzIJWvVmHVzhZ6SSP7NOvxFXyyl7qG2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu7wVBesvgu4p8kWtbOAqeJdyt7KVnKPIr2NISH27DIKTTY7o7G3kAL6YderQPFF74UrLFjRkdmBz8evqQHw9CPcC54YuoIZurGmX/a9Z49qiixAEBuip9xwdK5ht6OxV4Jb3T8uCm6G4aXJNenj3WSeTGQR1jrvBhpi48PHkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ejcojN4F; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ejcojN4F"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b8b33cdf470so152387a12.0
        for <linux-s390@vger.kernel.org>; Mon, 17 Nov 2025 16:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427198; x=1764031998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRmr4TJaLT4TSx3gKS19LTLI3SYTE0KLtbCqYCLL0GM=;
        b=ejcojN4FSv3O6+gXg4aObDniJCU826oFcxlcxhxuHO1lXUMKcDe1eweb8mAQhZIfH1
         X65my+G0z9ZRRHCP0UVxgrD0F04B3LT1apOp6JMg3Wqr+J7SERFmeCogx0cwE4w4Is0m
         TTw0hR+0WO3jJ8tmyslRqubZqLR2w/ZEActfr7ioSlUsy2g5iqtd4k2ItcZqoGPkMxfU
         8OfcRR5AQYAnGYxxibHUgi4nzpgpkUrrTs409RQpHl2pVWq3l5VeBpJdqqAI2wCALisX
         p/RbbIHoY5xwfe55BZrjoc73aRq8yWGTULHKJ+kWy1larwnzOfuPhphsxe6pABWEqNxw
         clEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427198; x=1764031998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRmr4TJaLT4TSx3gKS19LTLI3SYTE0KLtbCqYCLL0GM=;
        b=XTB45T9is41zlYTnSKbDoMNXNkCQWE1ccSKOhuOhsPeB44wcL3Uk6NrNyegiCvnFNn
         6p/wr/SlMjd+8GjcgoaBAmoChJ4fLnFrzpO8imwTmZ8qUNX7y1NRm6jbrODfW9GFB4xY
         S8Bl68osPpDp6Jc+rV/SlRU8M+H2jg5UBscqiBDnNqRbqtsyJXEuoG2YgHM0KbaRJcZb
         uIVbxX6alu+axhhFjXtrt16Q9WYSASGqFILwUbdzJPR4SpG1vdzF2lcxHC5yeQjAHwM2
         x9ljnM7hvqj3xRl3MfKfgt/p3QgZHU81hCu644jdwZNImnMhW/OZDnDZQoudUzkvQI8L
         CzvA==
X-Forwarded-Encrypted: i=1; AJvYcCWPIlOeU2iUXe56L8BlGvRO3ZdMULsqtp531AM+6cdWN0C7HU6CMH/iTCTqpWk9QM8CMyntVYL0TTbw@vger.kernel.org
X-Gm-Message-State: AOJu0YxbcD74nXYoxXhif63mwVmGCELgQckcvzzAYHUwfkV41Jco4BT4
	abjJzX/qhBJhwlzQCTFXduMPez+Lp8x4sQxHo3t+ox4QL5JJnNzbYvAWHMeS3EcbuPI=
X-Gm-Gg: ASbGncva+1gnRDUHpW7q7jnRSGuiMgue1cbY1Uv0ycmfTAmppKQEtXvrCLtoQC0ztaL
	sZdg9Mr3lYce3DT3TUGPOH3lufXnDEXEH3ylLZvbvJXn+K9jDFhyFC4wK2yGgjLAWQURbGbxb4u
	OeIXmJgVN6xvyyWrZmkgBR74uNG9J7PRnJ4sXauzZGoqBYY4w89osWyUiXnVfie7ABtrR8YZIC6
	1uZjUIU2QkkftjqSpQjZNJc8IbDv8Rx+cP/pBqW7ouqM0msurIZyxjshYSGgwuVVCFWDSEx9IxT
	kY2D2iQVZ7eBeWTXLIoAjZtj5n2VuGIN+MDx364faq/l3+xnCjDFE0eVSxCwG3CpEmEFy4pGXrJ
	ZuNymc09ywvvLEQ60g36TeFKXqNhNZTDAaYq6jcf22Bk/V8sTs22YBUgyT8c81I/MyLE10scCz0
	k=
X-Google-Smtp-Source: AGHT+IEO1zOxdD8wQil2LI5KwSO8MQLnWTrfWuipBo+pWWrpf29yptHnZPtimYMHyz4mxlU81XpbqA==
X-Received: by 2002:a05:693c:408d:b0:2a4:3593:2c07 with SMTP id 5a478bee46e88-2a6c985b102mr366146eec.0.1763427197571;
        Mon, 17 Nov 2025 16:53:17 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:17 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH bpf-next 5/7] bpf, s390: Make program update work for trampoline ops
Date: Mon, 17 Nov 2025 16:52:57 -0800
Message-ID: <20251118005305.27058-6-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118005305.27058-1-jordan@jrife.io>
References: <20251118005305.27058-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use update_prog in place of current link prog when link matches
update_link.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 arch/s390/net/bpf_jit_comp.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index cf461d76e9da..bf70302d1009 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2508,20 +2508,19 @@ static void load_imm64(struct bpf_jit *jit, int dst_reg, u64 val)
 
 static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 			   const struct btf_func_model *m,
-			   struct bpf_tramp_link *tlink, bool save_ret)
+			   struct bpf_prog *p, u64 cookie, bool save_ret)
 {
 	struct bpf_jit *jit = &tjit->common;
 	int cookie_off = tjit->run_ctx_off +
 			 offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
-	struct bpf_prog *p = tlink->link.prog;
 	int patch;
 
 	/*
-	 * run_ctx.cookie = tlink->cookie;
+	 * run_ctx.cookie = cookie;
 	 */
 
-	/* %r0 = tlink->cookie */
-	load_imm64(jit, REG_W0, tlink->cookie);
+	/* %r0 = cookie */
+	load_imm64(jit, REG_W0, cookie);
 	/* stg %r0,cookie_off(%r15) */
 	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W0, REG_0, REG_15, cookie_off);
 
@@ -2768,7 +2767,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	}
 
 	for (i = 0; i < fentry->nr_links; i++)
-		if (invoke_bpf_prog(tjit, m, fentry->links[i],
+		if (invoke_bpf_prog(tjit, m, bpf_tramp_links_prog(fentry, i),
+				    fentry->links[i]->cookie,
 				    flags & BPF_TRAMP_F_RET_FENTRY_RET))
 			return -EINVAL;
 
@@ -2782,7 +2782,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		       0xf000 | tjit->retval_off);
 
 		for (i = 0; i < fmod_ret->nr_links; i++) {
-			if (invoke_bpf_prog(tjit, m, fmod_ret->links[i], true))
+			if (invoke_bpf_prog(tjit, m,
+					    bpf_tramp_links_prog(fmod_ret, i),
+					    fmod_ret->links[i]->cookie, true))
 				return -EINVAL;
 
 			/*
@@ -2850,7 +2852,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	/* do_fexit: */
 	tjit->do_fexit = jit->prg;
 	for (i = 0; i < fexit->nr_links; i++)
-		if (invoke_bpf_prog(tjit, m, fexit->links[i], false))
+		if (invoke_bpf_prog(tjit, m, bpf_tramp_links_prog(fexit, i),
+				    fexit->links[i]->cookie, false))
 			return -EINVAL;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
@@ -2946,6 +2949,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	return ret < 0 ? ret : tjit.common.prg;
 }
 
+bool bpf_trampoline_supports_update_prog(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_subprog_tailcalls(void)
 {
 	return true;
-- 
2.43.0

