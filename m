Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1355303C91
	for <linux-s390@vger.kernel.org>; Tue, 18 Nov 2025 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427203; cv=none; b=l/H1DcDif2hsm4wgEOOAkqNy1cN8hexM4QmBVJYCp4odoCcdOpm1HlOQAs5WDGKIQcaZmujIsYUxoWmc4ahI4l1egmN7oqgvSbBQf+0Byc9qHJ3VGY/Me0qSv54XxoSmMeLAYp5dFOSaOyqd4qHFzQofJtJrd/aJHqzBegVRfjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427203; c=relaxed/simple;
	bh=mxX/gPyXLSW9fvdVbcxRxIhK5u9925lyqazn8p1TInM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6poHIDAFPZXGafXlMPu6+Ld2GGBHEFicy2Xc5pBx8SW80Eo1hl+oJNZGs8YcuqiKfvN4yrk60sVdlzGIho2vW38an9uRQOCshWzmI+zjV9cHKTB7JFNVKv6Unu5UByW+ZhslG0VGHBDVU1BRy3CJQDwQPV2r0TTIiKHfIoY0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=LzpbjX5A; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="LzpbjX5A"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297ea4c2933so3662455ad.0
        for <linux-s390@vger.kernel.org>; Mon, 17 Nov 2025 16:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427199; x=1764031999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJWvEh/HJ2KX3LdjCjzprEHwj4So4ol1ev17Vb/Ad9I=;
        b=LzpbjX5AFX7c/jme4uRTA9wmguzVLGKBOKU4h7Rq6qx8LqIYMi2wAdT7edAO4Zhl5r
         Zvmk0NCEy91LIEu8xEKUgHt89r3bDYbhtJYTHlJUV0yvnO8PUtBXUlAuKYmGAxbFGtF8
         2d4t6By8+t7C0dNzztjzqcGEw78jv+wI2ndJxRJ2+gRpJU0MdRi/mZQqt7sLK51ohGAH
         55BPTumm7yoYec1oOiIaHbGsPV893TKM3YS0fF9facGr4hte8lUSquZ6jcfM6M8uwFuF
         hzSUO9iiYjGhW1W28MdESoVq7st3oxRedBKVUqpoWXL0pJC1ecV+oG5BaMH6TXFsyDrP
         aCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427199; x=1764031999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJWvEh/HJ2KX3LdjCjzprEHwj4So4ol1ev17Vb/Ad9I=;
        b=J1zWxKCZBCuaSx9n7olnr+AKJUgJxXbZmpUFF95Z5MtaWymVAmjYDli7EkBgdHzJyV
         1/S/Zl8ltCpk/uZtzEogSXbdICiIfcGISsxuIgUzXV2OLpqAosXC8WNQgRZcrSnW3Oxx
         cBu6crBA7X36wFx4voSTj3kDuujAIv8BZustE438OaQEyniu93seEF4Rq/yxokA/LJR/
         KSYezygPbrPnhsVJROGKC4xcRGSd8zLx7d0u5vK2+i3XZbR4ynPlnmiklVB8DXFftzml
         148VeJlSlkrN/pCqfMWQ+zrE+uaXhQv1tCLEFV3n2k/T04tlyECPq7FdpZgzTccqW1Y7
         9bQg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4lfchT40JBLiNrZuiL4yNdLu8aJ5gYCFe5R72AdP36P3fGu6PgOx0Ke7Zew3bh4FwBrsLfkPJdyL@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZ+o756qpe9GbogfAKvFFApL1JahBn3G47HnAvYQ563B+iaQe
	7eKyVW/C140USbjvgl+pPoxjEUUPgaXZPPqEz4EBMc7fn8epVJzUP8Nb2wPyXNUPm/o=
X-Gm-Gg: ASbGncv6OTS5TDmE4xfdrNvKn+t/3oZWgh9rIrSgt3kzrE63yjt/RVcHEn3tb5dYLWS
	s/NI4QE/UqWbqF5H+f+Uu+mFtaIG69tB1ZVArU6Dlkcq4H2blIfRkU3omOfcymZyerrwVxOGkhc
	tn8k8U0Sj7Tdm9sB8Y4ckm7OqPXT4+iiiSW9MTsjIEkfi/5Zs5cphG/xQOYukoYybANZoUuymjk
	zbBWmqcfpVupEWc+WUXRlGr8NsavxijrDASwl1Pz9BlyBSq0toPwgntwnUIglZfbk07gFwGj8Cx
	NiU1P1Fw93KWQNdLfN37RYLZc6Jwzx41AifFfMlNBW5rqu7hBrA8PQ/rek7aoeUiF39GFtBzUPt
	aEhsBxGx5E3CYalrx+f4UgE6Nd0GfLWoDE5cSjeXfD9EEd2bWcqt3V4f0NSxz78Yxh18FbjMMii
	g=
X-Google-Smtp-Source: AGHT+IG3sPrz8MEZiYwPiZ6/EpY059urBkdovE1wf/NV5guCPZ6qna+8U9eWUGcGq+wUPWME4rwtsA==
X-Received: by 2002:a05:7300:fb05:b0:2a4:3593:5fc8 with SMTP id 5a478bee46e88-2a4abb56fe7mr4474732eec.2.1763427198597;
        Mon, 17 Nov 2025 16:53:18 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:18 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 6/7] bpf, arm64: Make program update work for trampoline ops
Date: Mon, 17 Nov 2025 16:52:58 -0800
Message-ID: <20251118005305.27058-7-jordan@jrife.io>
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
 arch/arm64/net/bpf_jit_comp.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0c9a50a1e73e..1725d4cebdf2 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2284,24 +2284,23 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
-static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
+static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_prog *p, u64 cookie,
 			    int bargs_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
 {
 	__le32 *branch;
 	u64 enter_prog;
 	u64 exit_prog;
-	struct bpf_prog *p = l->link.prog;
 	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 
 	enter_prog = (u64)bpf_trampoline_enter(p);
 	exit_prog = (u64)bpf_trampoline_exit(p);
 
-	if (l->cookie == 0) {
+	if (cookie == 0) {
 		/* if cookie is zero, one instruction is enough to store it */
 		emit(A64_STR64I(A64_ZR, A64_SP, run_ctx_off + cookie_off), ctx);
 	} else {
-		emit_a64_mov_i64(A64_R(10), l->cookie, ctx);
+		emit_a64_mov_i64(A64_R(10), cookie, ctx);
 		emit(A64_STR64I(A64_R(10), A64_SP, run_ctx_off + cookie_off),
 		     ctx);
 	}
@@ -2362,7 +2361,8 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 	 */
 	emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
 	for (i = 0; i < tl->nr_links; i++) {
-		invoke_bpf_prog(ctx, tl->links[i], bargs_off, retval_off,
+		invoke_bpf_prog(ctx, bpf_tramp_links_prog(tl, i),
+				tl->links[i]->cookie, bargs_off, retval_off,
 				run_ctx_off, true);
 		/* if (*(u64 *)(sp + retval_off) !=  0)
 		 *	goto do_fexit;
@@ -2656,8 +2656,9 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	for (i = 0; i < fentry->nr_links; i++)
-		invoke_bpf_prog(ctx, fentry->links[i], bargs_off,
-				retval_off, run_ctx_off,
+		invoke_bpf_prog(ctx, bpf_tramp_links_prog(fentry, i),
+				fentry->links[i]->cookie, bargs_off, retval_off,
+				run_ctx_off,
 				flags & BPF_TRAMP_F_RET_FENTRY_RET);
 
 	if (fmod_ret->nr_links) {
@@ -2691,7 +2692,8 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	for (i = 0; i < fexit->nr_links; i++)
-		invoke_bpf_prog(ctx, fexit->links[i], bargs_off, retval_off,
+		invoke_bpf_prog(ctx, bpf_tramp_links_prog(fexit, i),
+				fexit->links[i]->cookie, bargs_off, retval_off,
 				run_ctx_off, false);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
@@ -2829,6 +2831,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 	return ret;
 }
 
+bool bpf_trampoline_supports_update_prog(void)
+{
+	return true;
+}
+
 static bool is_long_jump(void *ip, void *target)
 {
 	long offset;
-- 
2.43.0

