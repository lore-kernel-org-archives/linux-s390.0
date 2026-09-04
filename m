Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02BC39FCC8
	for <linux-s390@vger.kernel.org>; Fri,  4 Sep 2026 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551501; cv=none; b=XS2u+EFrnCLlzkO0hUaHlpJwhtrbnVCAKDjkyp96StNcHYzktkI0lkTwqmCnFjY/4xswhhawZy4snVE3/UTVYn0SHJnyfbW1xKkXtvaMTl5tRK+w4RyxofAiEJVo3Cqoxhz8EAre3epSG9UcRXbgEkEc9MAa5n+B5Xe0bob9xQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551501; c=relaxed/simple;
	bh=dI1AE9WdbQKr87RUO/gc2ngcTAh4FhPd4AAMBS/OIu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ntpg5JZkBI3GBOCxM4aJTkpclYfyy+kTi5nLQwSWNRG9CM/dvSThU3rro3KK4GROjUa5gIA+F+ZsxDFYhB0k1h0U5ssn1Idt+IhJdcYWpJD7SCSx1sLxQDXFxLhlnOHxIUqx6dlvtrtyHls4uX1BQ/d2RlrssBhGw4+Cxk1S1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsVEQ/Oy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsVEQ/Oy"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-853c07a76adso1276411b3a.0
        for <linux-s390@vger.kernel.org>; Fri, 04 Sep 2026 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551496; x=1789156296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tq4f0YItm8Nzb37FYEFxDW+SOlv8AsSzRVHLQA1+cF4=;
        b=nsVEQ/OyBxO1uyW7OhZsJ/d//WgQi1NJTAUbmBvgGN+5s189oajK+Yq8B2a/G8bVXz
         nva2vnfFv4LfxelPwnv7AKuyPsJIsUzuzhPEbdkFexx5/7tRIlsW+JfqH3IXz/H56KVA
         Z/1Ofm3gYezZloZWyeWXTFo4cDvaOh7lCGKf4hh5sBDDqLHdmrK2l5YjwlmgCHzu7ZJo
         rc1D8Ce3pdqQQUC4IW41ygsFORayW1WqDMdAQ31vTQ/Bb328tCYBWX43Zy5AEXsjjiYU
         iFraTT096SalYC/1zEn7B9u9A/H1dsAkaEwCWlgfsidUHaIkUgpjv39fnLhhRPvwi1m+
         glzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551496; x=1789156296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tq4f0YItm8Nzb37FYEFxDW+SOlv8AsSzRVHLQA1+cF4=;
        b=EbFlMNlPtRR2xqyEht1eOKti58EYRm4CDLfTFZl/62DcIzqqTYnYuDGe+UeIFI/6z4
         qgr8/AIRumfETnyiz9eBl/FHSmO/laWojqaKHRJNlbip4X0m8XnnOvcs4iQ+huAZ43C5
         DoTTqOdT4M4KsOtCeFjXvNr3XS4m/qIMZN84R5ZQzzYzrsQdWC/FD4HWrK48qJJzOjsm
         Zet65Nc3wud5QrdgWeEgzxXztuZQPshlF83q5isp6atWbgEiyBDgoXLZktLGkR2bjb3T
         qWpdLVJPYYa73BU5oapwi/UD+Qhk6LxD6AdVOTnT6LbSd/tDWOeNn1kRNDho7K/klfKT
         6rWQ==
X-Forwarded-Encrypted: i=1; AKwUvBz703N+KuQMZczKI2uUZpsM5xfXIo5kA01t0zoSJP0FN0lfWQEaX4ZdN/Wtk8W50UkQie9Wq3q3h2OU@vger.kernel.org
X-Gm-Message-State: AFuF++ka8igmviNLBZSrejG/rIohujRZsQlrAtv2h+/WHMPuVcSjq8qs
	BwtwJ8EP9uEYvh8Me5KBwcop+MCd1KhH4dLnoRbgqW6EhlKUA6NV1AjL
X-Gm-Gg: AYBFou2r6EFkAbMLx74ARq3KY1zLunn/7C0fqFSQAEmh5Xx7e8S8qiFL/Dv/yubR7ie
	2BV9Ta6EY/H9KBseqq6QiUpLyudxvkwQy0SwkZA0oqJ4V8ZzdZQjcpsN8qYbJkN4hQHQbsl8eHi
	1X8xc5NLi7S70ycyg5LcndLmtT1RpM+r/WRJsD8ahAn0E20LIun/tOqUxMhMqoOZOgNxM6KAjSD
	zsSkPs3SMjJSZKfe58k/J0LGGVKEPIIoirRKfijaLinGoWYjP+BwMFNmSEokkG766yCQH7+hQSt
	7qc89vF+Q7tE4UhtmA2L52jmwfYrTTaZlw5OB85Y5UBzkGmcpK7SPcl45P6qd/Kc0LJ3Nbt6tmh
	Ubkw+AYnZMYoGBa/auEG4gKlLHbwpziQnokbPVZRXkBQ1X/xU6eET/HfjVEBQlXi1ju3s0GvPPK
	s/vqjY0OCJYSWgSXeskAqH0OMuBOCgYc/gWkZYhmaP00lNJarQLKNUVq0u/i80kCXTnjwuMm3bd
	T9Efooj7axAmzc5tQB3iM3d/8f8IHWSwvg5HQAoewu5NvUKYhf+Z+8mVbSE9AhY5OpHHv2m0jOL
	DxJDQYl7hHszjJmI2nH85lBSOkd6Zpv63BgXJRSWD7GkQQ3HMwK4HFgxUFXLRFECgTN5xmPRwdw
	=
X-Received: by 2002:aa7:88c2:0:b0:861:1acf:6915 with SMTP id d2e1a72fcca58-861676aa87cmr9593446b3a.11.1788551496447;
        Fri, 04 Sep 2026 12:51:36 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:36 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v1 1/7] bpf: Fix timed may_goto stack pointer for private stacks
Date: Fri,  4 Sep 2026 19:51:26 +0000
Message-ID: <20260904195132.141068-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904195132.141068-1-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

timed may_goto passes a stack offset to the architecture trampoline,
which reconstructs the counter pointer from its BPF frame pointer. This
breaks when the JIT uses a private stack with a different frame pointer.

Resolve the counter pointer in the fixup using BPF_REG_FP and pass the
pointer through BPF_REG_AX. Account for the extra instruction in the
internal branch offsets.

Fixes: e723608bf428 ("bpf: Add verifier support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 kernel/bpf/fixups.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 65b441e4a351..dc59501a32bb 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1797,20 +1797,20 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			stack_depth_extra = 16;
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off_cnt);
 			if (insn->off >= 0)
-				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 5);
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 6);
 			else
 				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
 			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
-			insn_buf[3] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
+			insn_buf[3] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 3);
 			/*
-			 * AX is used as an argument to pass in stack_off_cnt
-			 * (to add to r10/fp), and also as the return value of
-			 * the call to arch_bpf_timed_may_goto.
+			 * AX is used to pass FP + stack_off_cnt as the argument to
+			 * arch_bpf_timed_may_goto(), and also holds its return value.
 			 */
-			insn_buf[4] = BPF_MOV64_IMM(BPF_REG_AX, stack_off_cnt);
-			insn_buf[5] = BPF_EMIT_CALL(arch_bpf_timed_may_goto);
-			insn_buf[6] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt);
-			cnt = 7;
+			insn_buf[4] = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_FP);
+			insn_buf[5] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, stack_off_cnt);
+			insn_buf[6] = BPF_EMIT_CALL(arch_bpf_timed_may_goto);
+			insn_buf[7] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt);
+			cnt = 8;
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -2661,4 +2661,3 @@ int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env)
 
 	return 0;
 }
-
-- 
2.43.0
