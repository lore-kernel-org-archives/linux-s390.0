Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3734D4DC
	for <linux-s390@vger.kernel.org>; Mon, 23 Feb 2026 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836053; cv=none; b=dN8JRZXomiwzZKeuyseZQdEGlH1IRT9QkambMnA85KHaTPzb6y9CVvuWOesKwO5XPGKbinbiIkuIOS4m/kkfUISyjhsBwI+jQEuy1XQARmbVftBD1YVsKsUKxNO2z+sK2KTu2edB5y1PRI1kqk6Chsa9QnLcn6BrDxvTmlC6LVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836053; c=relaxed/simple;
	bh=H4FGkDsciyvqLsAgOwj9Z6j0tvm3/gijETOKB9Ix7l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpKpkNmkGRnvtccY2HMo7A1WnWN4N9Erq8Y/l5sdfc6jiuRSAIQlp99nt/uJwDMk+kqD+EDg8A+/nJRynx+Lpn8N2i/PkttAoDibe6LBLciFIvsRDp0FQ5Y6vILrAwIV8EZERWyEvlDQbukStl9g95pdBWTe1EsAqOjjgIo/jac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRFuTcu8; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRFuTcu8"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a95de4b5cbso37675145ad.1
        for <linux-s390@vger.kernel.org>; Mon, 23 Feb 2026 00:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771836051; x=1772440851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqDYeikxCzctMnDOkxJiKALxw8THCeumBykoyQa3Xfs=;
        b=eRFuTcu8HgT6vGgRxh/oNbKdPOObWBEb60OI3x35fx4loo9mlxzcZ9ViZT92vV+mkS
         reFRvigZcPim4yDHj4IRqfA6joN6mCxQPdY+ZXxaUh3c24NR7obJauv7eB891mbmgMQI
         Mh7JA6MkMuSOCxpe6JdHJDtqty6WgdlCZhl4cVf80HfETXC+mDCfYblscKm2tT/EIB/l
         1HcsQ4NJ4ggnQfToLjeFIjoWgaYxOApqvWHEYvk0CZAYX0/yo1dqRrD+3qTgJ//FTXT/
         fBrJ4zN9XV1hspdfenQggGaiZCfPXk4/3+GZ26GEiGsc1DnluwiVGR2leT2cDS3riH9R
         6oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836051; x=1772440851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fqDYeikxCzctMnDOkxJiKALxw8THCeumBykoyQa3Xfs=;
        b=JXUct04fh2a0z0pZhqcEFY1LanRxqPJd187lHXRCpLO4e+lDIbzFlII+22EpLgwYBt
         329NsTHllOD9QkqeALNeKvlYmbcfaOJddJfaFj+KOiGYA2zVQW1MyQhIN8N8R8xCH0SC
         regCH1RnilRN/10dckeykiDLaz624c3uofDJayftWMNfnXelPy9u6XXFWAwLlO5matSw
         Qyef+VbfnKL//m/w2PjjXH3BQB1VtmIRArzr8WdxmIVF/fClC9vlNDHH3FaBFge8Xw99
         1GBMcX8Ba70pfvcZHfURys0fZ5OeMLNJJSDvUPL4i7VreutIzODPBVKIAFEDVq6T3ymx
         1FTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkN0TgbyHLwqqEeryR6GIj3FGn5kYT7zSR+2qavLVxuU6dNIvmnwz6mf3JQ5hlxWCWn/cxb6vuwuGB@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxWm3XbswxQYsZMqRjQLxIZ3o000Wjp/U23xmB8gBojBchEfe
	wLeZLkRc0PvmLpsfN2w0EgNVYHa9otWufBKCYgOdOIBeXxDK/KXWvwQM
X-Gm-Gg: ATEYQzyy77t7FzYmN87VhQWfE0TYMrt6Jw6PkUEJPBsDSqqIClBfqH985LMgFHnl1Ap
	TiTt4pCb+sbgQmxWNapEfQMPx0bQ8JDAl1mwE2ekhQK6WAopgezezuZtFUB+2/WUTFUCe4Xhxhq
	5NBronovkfGifKDMaDCKsea1pqddOyf0VYkYZoQe/rMXmUIUCRZxVfHXCn+TEBbWE/kvACoWfzh
	hXfcMGQBQwVF+5QMNlPomOJSvsYeniyR9UusJ+hzgnf3vsDgeB2R09dEM8fkKc2cmWxzn0Btvjz
	CV/AA+wqa74ZfPz7M82DJW2a3v6XyZbtKZXLzubGP4UKI+x7AVWtDVSmdW9cYgs5Az+Fa38bqSf
	fHHPJ9ZAaiefzxTdf/4dFNJdtf14gFM+jMSjnkMttdQHu0zR56K1S7HcUQ+YD125cSTbD9JIBI5
	huWbizDxSEGNP/pCpNM2jf
X-Received: by 2002:a17:903:3c4c:b0:2a1:3cd9:a734 with SMTP id d9443c01a7336-2ad7452bbcfmr79115605ad.43.1771836050649;
        Mon, 23 Feb 2026 00:40:50 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad750591e2sm65725405ad.91.2026.02.23.00.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:40:50 -0800 (PST)
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
Subject: [PATCH bpf-next 2/3] bpf,s390: add fsession support for trampolines
Date: Mon, 23 Feb 2026 16:40:21 +0800
Message-ID: <20260223084022.653186-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223084022.653186-1-dongml2@chinatelecom.cn>
References: <20260223084022.653186-1-dongml2@chinatelecom.cn>
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
 arch/s390/net/bpf_jit_comp.c | 68 +++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 9 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 763d2491dfa3..ea0c81f18ece 100644
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
@@ -2749,7 +2777,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		emit_store_stack_imm64(jit, REG_0, tjit->ip_off, (u64)func_addr);
-	emit_store_stack_imm64(jit, REG_0, tjit->arg_cnt_off, nr_bpf_args);
+	func_meta = nr_bpf_args;
+	emit_store_stack_imm64(jit, REG_0, tjit->func_meta_off, func_meta);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/*
@@ -2762,10 +2791,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, __bpf_tramp_enter);
 	}
 
-	for (i = 0; i < fentry->nr_links; i++)
-		if (invoke_bpf_prog(tjit, m, fentry->links[i],
-				    flags & BPF_TRAMP_F_RET_FENTRY_RET))
+	if (fsession_cnt) {
+		/* clear all the session cookies' value */
+		for (i = 0; i < cookie_cnt; i++)
+			emit_store_stack_imm64(jit, REG_0, cookie_off + 8 * i, 0);
+		/* clear the return value to make sure fentry always gets 0 */
+		emit_store_stack_imm64(jit, REG_0, tjit->retval_off, 0);
+	}
+
+	if (fentry->nr_links) {
+		if (invoke_bpf(tjit, m, fentry, flags & BPF_TRAMP_F_RET_FENTRY_RET,
+			       func_meta, cookie_off))
 			return -EINVAL;
+	}
 
 	if (fmod_ret->nr_links) {
 		/*
@@ -2842,11 +2880,18 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		EMIT6_PCREL_RILC(0xc0040000, 0, (u64)im->ip_epilogue);
 	}
 
+	/* set the "is_return" flag for fsession */
+	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
+	if (fsession_cnt)
+		emit_store_stack_imm64(jit, REG_W0, tjit->func_meta_off,
+				       func_meta);
+
 	/* do_fexit: */
 	tjit->do_fexit = jit->prg;
-	for (i = 0; i < fexit->nr_links; i++)
-		if (invoke_bpf_prog(tjit, m, fexit->links[i], false))
+	if (fexit->nr_links) {
+		if (invoke_bpf(tjit, m, fexit, false, func_meta, cookie_off))
 			return -EINVAL;
+	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		im->ip_epilogue = jit->prg_buf + jit->prg;
@@ -2951,6 +2996,11 @@ bool bpf_jit_supports_arena(void)
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

