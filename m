Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A534D901
	for <linux-s390@vger.kernel.org>; Mon, 23 Feb 2026 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836045; cv=none; b=aPumH4UJPt1ncGdQGjowjmw5tM2QPgoRTQyA9MTMc0NSxjl9OqCUNs36AVSIgBnqB4Nd0Qgl7aLpq3ItkgPKwnk0g1PrYzPZCz0JXuS31wfRFOZxralGhG1X5+G91m6RGzx5OZeacWTZYyrRawH/iN5dpBL1drxhRMoZZnMagxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836045; c=relaxed/simple;
	bh=nEKT87239/0oP7+UDsczkgsNom6oeFHqhXSC4GmgIow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xs1bw/HqaW/EqaQtDFZsskhknfe7+TM4k523Ofv2G2gTeFYf3oLh9QeW2y13ZYZd0z4fYAJg2OwRQUBsONV/gg5DfsuQ3N/mL8SfzZPgcWbeCifszQyBeljmXuvrpwxWf3tJJIAinKPSgY9ZCkSSrzH5p1KN/FlnaXw6xMN+0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL0AflJe; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL0AflJe"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2ad21f437eeso28478205ad.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Feb 2026 00:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771836043; x=1772440843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJMqZhTw+6tfgh3M5mC64dvgKIeBryvh3KcIHfyE5f8=;
        b=lL0AflJeEkevNniuKe641iyJiuA7l17hJ1EPbvVzFbWMzrOjpCQ5xelcPMmO5gv1bB
         iM7coXX/mn2FslusCaIUGnBJCh4FPq72JMfIJndFBSt0f0nLMJFjMgJqkPYsvzSIEemy
         zhRREC2c1p7PB3vGxskwgX0NhA3+CGDrKIat1uBQmzwFZkfWOzNxjXi2UqqdBYC34XiZ
         9Il6CKXYRMQ3oZJvOuZbNF+KhkH/ZhMNrhBwy33u/Jv76tAjqPKu57NCuCMfCQO8vK6j
         0kmaFIdeRsvRyoxqdLkSRNa9rZgeWIm3uMHvXLxsLN817jUXSd3LSL6ZFRgG0RhU4um0
         T3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836043; x=1772440843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DJMqZhTw+6tfgh3M5mC64dvgKIeBryvh3KcIHfyE5f8=;
        b=euZ6G70Dhi/D4Czi24C+oi2lz7ytMuUWqKaauCk07N3c6210ukQS4PC+hcy54Nrqns
         eReDqal1uHteww1nI+R6zn5KW2AMKURYSPcWfY40qIP1WQ9NATGaQGWityaHzNBvW1yD
         jJVLqm+dc/3udY84IIOzVguyY7FuVWag1pQE4sInPGOtmm4IulI316TW6c3sVEFkrcTm
         tPt3ImVjjeQ9XbZHSNmj2Ze/a3g+LdvDMZ/zSKj5jJ+0PzQbtJNMshQI7O3ui/h5+bIL
         HRIgu6aKSZ95yA/R8NRWZVTLJmEeuTwskHAfTvbynSN597BzmZXetKhFKfhXE5vfCXQz
         k/zg==
X-Forwarded-Encrypted: i=1; AJvYcCX+BWkM3iC1HEENo7jUwj2HQtOxJa/z0w6/dB6ul0iJGtpUhFvDNTn2tAGGl6jiObmVi/1M6/9yofuf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ehTNHOGJ6GMTq6T/gTc+vmRZv20kWKUqEYTjzR9LknUHLHaQ
	v6x8GDi4EzCMoVCWR3DlGWQJtfi4uAGVoXEGbmM9UFN/CX8q7SvZcxJs
X-Gm-Gg: ATEYQzwtqw+dxuFAIVEq6rvs1FFT7AAy9NJsk+6ELI6fDMX8udnBwhA1fxW8+6/VXK4
	x3PprtaB8SQQYBJ//vS500kHvqtMSniJnjeyXH5Y9O9Qz/nmK1Vuf0WoZaweFYvBfMCxWt/eqBB
	4a5rGEPHaP0EvCAXB2TrI1cXN0q4kTL1fW6Q9lajEvulYN3G3yoDB29+lGPsJ9pFEMcMCe6g860
	hyezlpxEbMeFgPURCsBZbGmVPpjJVaS4ORagQuCYQ5VnAvoW2pvr/8yBHS15BrVevl/RFNo3MMY
	asEIQZJ+TPxnfnmyVLBRbhNDzJHnctDxbKvqMmFHXvwROdCVxvoBj0Ld8OXMcMpw6S6jS4Gxszk
	fOetLkRFeaz3lbiIhuHAo68/s+PlYN927wBseL4rZ8yUnIM+TbbY+H3zV6/ukfizjjVd+Qcd2aL
	oKN9VCzM5VGZQQ+Kq04aLz32zQbk3vg2U=
X-Received: by 2002:a17:902:f70c:b0:2a9:5ac3:a925 with SMTP id d9443c01a7336-2ad741c8be7mr72170345ad.3.1771836043135;
        Mon, 23 Feb 2026 00:40:43 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad750591e2sm65725405ad.91.2026.02.23.00.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:40:42 -0800 (PST)
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
Subject: [PATCH bpf-next 1/3] bpf,s390: introduce emit_store_stack_imm64() for trampoline
Date: Mon, 23 Feb 2026 16:40:20 +0800
Message-ID: <20260223084022.653186-2-dongml2@chinatelecom.cn>
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

Introduce a helper to store 64-bit immediate on the trampoline stack with
a help of a register.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/s390/net/bpf_jit_comp.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 579461d471bb..763d2491dfa3 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2506,6 +2506,13 @@ static void load_imm64(struct bpf_jit *jit, int dst_reg, u64 val)
 	EMIT6_IMM(0xc00d0000, dst_reg, val);
 }
 
+static void emit_store_stack_imm64(struct bpf_jit *jit, int tmp_reg, int stack_off, u64 imm)
+{
+	load_imm64(jit, tmp_reg, imm);
+	/* stg %tmp_reg,stack_off(%r15) */
+	EMIT6_DISP_LH(0xe3000000, 0x0024, tmp_reg, REG_0, REG_15, stack_off);
+}
+
 static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 			   const struct btf_func_model *m,
 			   struct bpf_tramp_link *tlink, bool save_ret)
@@ -2520,10 +2527,7 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 	 * run_ctx.cookie = tlink->cookie;
 	 */
 
-	/* %r0 = tlink->cookie */
-	load_imm64(jit, REG_W0, tlink->cookie);
-	/* stg %r0,cookie_off(%r15) */
-	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W0, REG_0, REG_15, cookie_off);
+	emit_store_stack_imm64(jit, REG_W0, cookie_off, tlink->cookie);
 
 	/*
 	 * if ((start = __bpf_prog_enter(p, &run_ctx)) == 0)
@@ -2743,18 +2747,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	 * arg_cnt = m->nr_args;
 	 */
 
-	if (flags & BPF_TRAMP_F_IP_ARG) {
-		/* %r0 = func_addr */
-		load_imm64(jit, REG_0, (u64)func_addr);
-		/* stg %r0,ip_off(%r15) */
-		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_0, REG_0, REG_15,
-			      tjit->ip_off);
-	}
-	/* lghi %r0,nr_bpf_args */
-	EMIT4_IMM(0xa7090000, REG_0, nr_bpf_args);
-	/* stg %r0,arg_cnt_off(%r15) */
-	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_0, REG_0, REG_15,
-		      tjit->arg_cnt_off);
+	if (flags & BPF_TRAMP_F_IP_ARG)
+		emit_store_stack_imm64(jit, REG_0, tjit->ip_off, (u64)func_addr);
+	emit_store_stack_imm64(jit, REG_0, tjit->arg_cnt_off, nr_bpf_args);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/*
-- 
2.53.0

