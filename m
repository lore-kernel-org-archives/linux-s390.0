Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7436A030
	for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924968; cv=none; b=m1co/73E4jlUPyyHxJ0RuwGLzFZmp69BCqpP0eQgBk7pG+BLAIRVt4x7AKPDfieBIRJaZ6uUtrTdI1hcLfA+egCQsvR9Rqi5sD0Wc2JsngJZ6F3Cd0ZdmHr5HjkLSfeeASwL597fBoFQgqZM5Qj1l0qm/U7Lqwt7nCfwh9VkI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924968; c=relaxed/simple;
	bh=r0QhidL2qVGhtoDDwycY2a78DmN6eqKCVWtFn/P0iBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0I7fRRrDQv4gk/rwS/b9NQ6bjonSQuFEB4M+CK525EYrw8SCtGfovy+M0twE2zrex4LZ+GEjjQXgvYdcsOJLvrycFPgN4Bh7890aLbAT5cV/ld4tdAzNSZd5vRI76Glj9+uRi8ZyRyuENf5tKDb6OAjwLRK08Ar+KMnLhFYJRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgoww0tV; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgoww0tV"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a7bced39cfso54354455ad.1
        for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 01:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771924967; x=1772529767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECViA3v1HDI+Yk9qZobu+6ZWgxCzTlC7kywhlIlor0w=;
        b=fgoww0tVBq/lLMnrlpWhXuO1QkTmH6MR+31kTnl5NP/jXP0X/OcrPJiqd3YQc6ayV6
         IJO4SjFGM275YTSLNkjGKhOIoKcRtKPq7PPFibO/1ktf3KOALsEmrWQ8riXijsAr0Pgc
         TeL9fX2RtrgTxr203nBVGeS+OJwAxn/It5hLPjKmxZcrMWHLbEHMPc3cGUzePtxwayUL
         llS431XWL6wIUWFpMutbpUFn/7YajxLyJp7oljQGIsHlIypah2bAK3H0gbAsIesVJHIg
         B8m9fm6iszWouNzpIyHsRPblrA5Wbsu0BeZgVKflr4HyAhH6dmFcG5bWW6YgOBAhsYhT
         T19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771924967; x=1772529767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ECViA3v1HDI+Yk9qZobu+6ZWgxCzTlC7kywhlIlor0w=;
        b=B6QIGnk4OgeBqNbDuMgJtMdavZf2o/TeW8FqUvjCdoUYHAMGOw0HHi+oFkml8HiWJW
         rdEwycEFZd2OdNCpodBtzvECrhCfgi5zNg+1peiL6qvolk2h1e3Wiw85YDKqpzeTXAyd
         Mw9eeXTdE23uXOSGfstzs4cC2I5STdoOQgWwMw3j4YXE40IhJ/lc1PWDsMWZ78Zgn8Gj
         qO2MU+Lp+M9RAEgchxAcz2/BHh5+lpDV5KbBU75jvkHDQMXq6Bb0Bhg4ODGH4JqeCugw
         0PzgRhZLR6khw/Lp7/PbVL/bjYEJqWMdpxy1ijRgI92EtPC8X/47dN04rihfBYU90hIA
         NOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw803W8z4rUeU1+g9FRMcwouPjqEJsi7lbhSTZaRkwWpul9/LmoVJ7bmibKfA/n7h+ISyDk0C20aWp@vger.kernel.org
X-Gm-Message-State: AOJu0YwWNPNXc36WLzVJF/E6W7AUO6+DPRxsKGjBfUfOTTQBQwiq7ge2
	+OCUIhEh817NSN0/qw2azpcAiC4GLhQLakC/jdSAj0xIt3GnzEmPtYgr
X-Gm-Gg: ATEYQzxncZZEU7QULPQxZ3WH1haw7A5ygVgvVsaWGBN7VaF30dOnKsmhOJA52EiTMKp
	AJHmAWI5KZOLkAsoFNmLvnFIM4i1d/W6gcXqtJWFfqhiQ0udqVUz46cDvr3mRXLNQpwza2F0+rY
	NxGhnA5VD2vh0UR8H20H0IkfFWGU3mkhrAlSBhLJQ8S9yONRqLWs3yVHNKodVV7Y13LeJuAQvRC
	YKn+bOEm5SgVO5wL7ystmrykabicBH98mWRvrLx/bzz910MSrrOuZw5y1pq4hsD8mERit5bNVkL
	V4BltdrSHVTbT3fSHm4k0o4NpGsQ9H0NAaL2dYflFvI9D47ELgpx1jVJ6PPt4AEWMPfgazHOlam
	e4rPxrlWXf8LtIhcZ0D2nGBmD8Diuu1ZogVKnWWK5kQDqQZucgJYq756P00iQsVQaDWrPzeh13e
	rntkVzXqUowj6oGFtLDGDM
X-Received: by 2002:a17:903:2a83:b0:2aa:f43d:7c4b with SMTP id d9443c01a7336-2ad74447149mr92280335ad.19.1771924966875;
        Tue, 24 Feb 2026 01:22:46 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e2b2sm97181695ad.52.2026.02.24.01.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:22:46 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	iii@linux.ibm.com
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	bpf@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/3] bpf,s390: add fsession support for trampolines
Date: Tue, 24 Feb 2026 17:22:07 +0800
Message-ID: <20260224092208.1395085-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224092208.1395085-1-dongml2@chinatelecom.cn>
References: <20260224092208.1395085-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement BPF_TRACE_FSESSION support for s390. The logic here is similar
to what we did in x86_64.

In order to simply the logic, we factor out the function invoke_bpf() for
fentry and fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- fix up the comment style
- remove the unnecessary checking of fentry->nr_links and fexit->nr_links
---
 arch/s390/net/bpf_jit_comp.c | 74 +++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 76c80d75184f..2db32bb04246 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2480,8 +2480,8 @@ struct bpf_tramp_jit {
 	int ip_off;		/* For bpf_get_func_ip(), has to be at
 				 * (ctx - 16)
 				 */
-	int arg_cnt_off;	/* For bpf_get_func_arg_cnt(), has to be at
-				 * (ctx - 8)
+	int func_meta_off;	/* For bpf_get_func_arg_cnt()/fsession, has
+				 * to be at (ctx - 8)
 				 */
 	int bpf_args_off;	/* Offset of BPF_PROG context, which consists
 				 * of BPF arguments followed by return value
@@ -2585,6 +2585,28 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 	return 0;
 }
 
+static int invoke_bpf(struct bpf_tramp_jit *tjit,
+		      const struct btf_func_model *m,
+		      struct bpf_tramp_links *tl, bool save_ret,
+		      u64 func_meta, int cookie_off)
+{
+	int i, cur_cookie = (tjit->bpf_args_off - cookie_off) / sizeof(u64);
+	struct bpf_jit *jit = &tjit->common;
+
+	for (i = 0; i < tl->nr_links; i++) {
+		if (bpf_prog_calls_session_cookie(tl->links[i])) {
+			u64 meta = func_meta | ((u64)cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT);
+
+			emit_store_stack_imm64(jit, REG_0, tjit->func_meta_off, meta);
+			cur_cookie--;
+		}
+		if (invoke_bpf_prog(tjit, m, tl->links[i], save_ret))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int alloc_stack(struct bpf_tramp_jit *tjit, size_t size)
 {
 	int stack_offset = tjit->stack_size;
@@ -2614,8 +2636,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	int nr_bpf_args, nr_reg_args, nr_stack_args;
+	int cookie_cnt, cookie_off, fsession_cnt;
 	struct bpf_jit *jit = &tjit->common;
 	int arg, bpf_arg_off;
+	u64 func_meta;
 	int i, j;
 
 	/* Support as many stack arguments as "mvc" instruction can handle. */
@@ -2647,6 +2671,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 			return -ENOTSUPP;
 	}
 
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	fsession_cnt = bpf_fsession_cnt(tlinks);
+
 	/*
 	 * Calculate the stack layout.
 	 */
@@ -2659,8 +2686,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	tjit->backchain_off = tjit->stack_size - sizeof(u64);
 	tjit->stack_args_off = alloc_stack(tjit, nr_stack_args * sizeof(u64));
 	tjit->reg_args_off = alloc_stack(tjit, nr_reg_args * sizeof(u64));
+	cookie_off = alloc_stack(tjit, cookie_cnt * sizeof(u64));
 	tjit->ip_off = alloc_stack(tjit, sizeof(u64));
-	tjit->arg_cnt_off = alloc_stack(tjit, sizeof(u64));
+	tjit->func_meta_off = alloc_stack(tjit, sizeof(u64));
 	tjit->bpf_args_off = alloc_stack(tjit, nr_bpf_args * sizeof(u64));
 	tjit->retval_off = alloc_stack(tjit, sizeof(u64));
 	tjit->r7_r8_off = alloc_stack(tjit, 2 * sizeof(u64));
@@ -2749,11 +2777,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		emit_store_stack_imm64(jit, REG_0, tjit->ip_off, (u64)func_addr);
-	/* lghi %r0,nr_bpf_args */
-	EMIT4_IMM(0xa7090000, REG_0, nr_bpf_args);
-	/* stg %r0,arg_cnt_off(%r15) */
+	func_meta = nr_bpf_args;
+	/* lghi %r0,func_meta */
+	EMIT4_IMM(0xa7090000, REG_0, func_meta);
+	/* stg %r0,func_meta_off(%r15) */
 	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_0, REG_0, REG_15,
-		      tjit->arg_cnt_off);
+		      tjit->func_meta_off);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/*
@@ -2766,10 +2795,17 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, __bpf_tramp_enter);
 	}
 
-	for (i = 0; i < fentry->nr_links; i++)
-		if (invoke_bpf_prog(tjit, m, fentry->links[i],
-				    flags & BPF_TRAMP_F_RET_FENTRY_RET))
-			return -EINVAL;
+	if (fsession_cnt) {
+		/* Clear all the session cookies' value. */
+		for (i = 0; i < cookie_cnt; i++)
+			emit_store_stack_imm64(jit, REG_0, cookie_off + 8 * i, 0);
+		/* Clear the return value to make sure fentry always gets 0. */
+		emit_store_stack_imm64(jit, REG_0, tjit->retval_off, 0);
+	}
+
+	if (invoke_bpf(tjit, m, fentry, flags & BPF_TRAMP_F_RET_FENTRY_RET,
+		       func_meta, cookie_off))
+		return -EINVAL;
 
 	if (fmod_ret->nr_links) {
 		/*
@@ -2846,11 +2882,16 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		EMIT6_PCREL_RILC(0xc0040000, 0, (u64)im->ip_epilogue);
 	}
 
+	/* Set the "is_return" flag for fsession. */
+	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
+	if (fsession_cnt)
+		emit_store_stack_imm64(jit, REG_W0, tjit->func_meta_off,
+				       func_meta);
+
 	/* do_fexit: */
 	tjit->do_fexit = jit->prg;
-	for (i = 0; i < fexit->nr_links; i++)
-		if (invoke_bpf_prog(tjit, m, fexit->links[i], false))
-			return -EINVAL;
+	if (invoke_bpf(tjit, m, fexit, false, func_meta, cookie_off))
+		return -EINVAL;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		im->ip_epilogue = jit->prg_buf + jit->prg;
@@ -2955,6 +2996,11 @@ bool bpf_jit_supports_arena(void)
 	return true;
 }
 
+bool bpf_jit_supports_fsession(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 {
 	if (!in_arena)
-- 
2.53.0

