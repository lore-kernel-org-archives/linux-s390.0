Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175A3B27C3
	for <linux-s390@vger.kernel.org>; Fri,  4 Sep 2026 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551508; cv=none; b=GGYzcyytVFa9wR90VN+CXg2UBeEUtD6Vv1EP4Ubfe2TDx+D80GNrDPfD7xQYFZ4jdXvpLnU4o3cKWHAFHPzWkcw7DFureZp/5isBcS4PC7UkkmZ48kIa1i597XNW2OYAibXXFvR08Vs9Dmpoh4q3EFbENUEBMNgqYQhvikebfok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551508; c=relaxed/simple;
	bh=7B1nbhpmBWLmPjG/0jbHLb3RgyBVGkoDinhLmCcp2wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+rNn1+AXKiN3BEN3wqGfphwuG3TVPCm93SzhjLDMqJGJB0n2BLYYTJTefalXtI+Xws797Koxesa4zd1JoX2A1/EqrhBlHHQBkHiDoPyu22S6ZurXWEFv0os98umPazU4pYddP6oJ2eLZHFTGpcC43HJauVtlPh25FMcGq6am6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX28FTNs; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX28FTNs"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-862815e2683so572602b3a.2
        for <linux-s390@vger.kernel.org>; Fri, 04 Sep 2026 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551502; x=1789156302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVBsoFTvre1N55biXZd8wIwrI+sXnvIOODIR/1bsh18=;
        b=gX28FTNsWgriqxF27as6e/N4RLgetAMKvKEJBswYBr0pyjVguaLz7DskNO3z8cxJp5
         Ki39bMyZjhI6GuGwLpswaHSOdb831sCg9cAF2Fn5VJQEbRkCc+fECxzsDBhxp2TQM3NI
         sOt8TPs4twOUA5Xa5kSekJG6e/+TcUWmnn5wlH75fPZEmiFjiem5l5WujT10akJT11Dq
         FfarvdnRvkTvNlrw4oYvh8VSt9XirfRWM2vFI0L5MW4q5PBCyqvyA6533TCO4st0I22A
         VziDpQSmHqEFsrHZLcaZsag5jjOYHyyERPc4X+MQxsgQ1m8sd5X3Fh4emL3VCf79wLgq
         ogDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551502; x=1789156302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yVBsoFTvre1N55biXZd8wIwrI+sXnvIOODIR/1bsh18=;
        b=sbQr+lu1F8juZ8eyGV3Ju3mxdxni3kyTk6t6Lsj3WFXlU1MHYZKM8y1ep6FUNcOlZH
         iaVEThF7N6/6dotOEEs88amroDSuuxcTEFKgwzCO45xhfdEBHl9T7nB2BT9Qdu3vM+9N
         OszQGw2qTl/4Y9djH2R0DXEvXfOEgBnAdlEoNVfp2+gViWx+07wvPA7yRgQIcrQkUCto
         7ZcE2IkOwFdjMGHwo+n58qNEocxBkHnVJK3RQWvp7YLRrhURWgJF+9CwJn9uUCjqP7fw
         MS4KKMtoheXWQ7rXaCf1Q8PJLCYsgjgY8005FowGXIemQWKG8VLpxn3xCD6IG2zBbl9b
         YMvw==
X-Forwarded-Encrypted: i=1; AKwUvBzggmxGLhcXgLJvVXd6aMDmrfuXgnDwSFu4E/yK2Q0amEBhDV0oVlm75DN27xg651EiiZQlNpGDBNiN@vger.kernel.org
X-Gm-Message-State: AFuF++nsCe/mQpCYlkvxjdy/veDeDbKKB+L6DRpzwhJGxnkc0WNobyG+
	zXf7leL1aIk0N4u0I2yc1V5yWFOJkHwthmkeh0hx8aetgUFGLmHRa6fl
X-Gm-Gg: AYBFou1qOctV0NUFfHIzLh5LTDwg9V/ce3n+EcqxbtJVsainhuSAetMfp7xZwrr7b2W
	HyRSSRy5ty6gAqK2RSPvnxOvP4uQKXDiXpA3F1qmYkzv9v74tJGCjJQiP0joA/fdq0xkNNNohQa
	WijEeoWVSooPdgzaFZw+3I8O/PHLIWsrfuL+hCqGjwusW/bVcnbTjdh0hXleWZ2m0MuoWGnOtGd
	6u+jqpd2oc3Atejo1IuR90C4+ott6FT0xtuFp0Qbk9pSM6B2J3DA4R69E5f4HLSLkli/TbihH6l
	iGfKz5CGuu5UIYX2F2qzVFwOEoBU+WmVDlriIbWhFbh6BKwSAue4DXBwrwRk7syldiaYjfQ/JNN
	fEZy91G59QhR+3fihEiourd1yAq8o2V9Gr+8p4r5qb8RjmQ3t4I3hx2/pWwZw0qvnFs/2kY2joh
	HfjYDcsF4ehq7BU6adxogI/Rx35TMijsYwmmeM7So1YE7emEbcQtDZt+tXhqrKL0V7HPEes0faf
	Ebbf9M/LP4h/+P90zES5Ex9ccE5J55Tq6RGeqZGL3efaXIFOfJPOhZ0ZrWT/N0OGsrkMJBl+apS
	bUfz29FGsWNgQIWmNjHXyutDvv+6lNHE9oMXMgCfUT/MY4TX7zlqyN5BJPqw19qwhCIgbgCinpV
	d8cHtwXGAkiE=
X-Received: by 2002:a05:6a00:2994:b0:857:7384:b5fc with SMTP id d2e1a72fcca58-86169f6cbcbmr14428608b3a.24.1788551501408;
        Fri, 04 Sep 2026 12:51:41 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 6/7] bpf, s390: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:31 +0000
Message-ID: <20260904195132.141068-7-sidchintamaneni@gmail.com>
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

The timed may_goto fixup now passes the resolved counter pointer through
BPF_REG_AX instead of a stack offset and BPF frame pointer pair.

Copy the pointer directly into the first argument register and update the
special calling convention documentation.

Fixes: b8efa810c1db ("s390/bpf: Add s390 JIT support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Assisted-by: Copilot:gpt-5.6-sol
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/s390/net/bpf_jit_comp.c       | 6 +++---
 arch/s390/net/bpf_timed_may_goto.S | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index c46872b071ce..4098c3377c21 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1872,9 +1872,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		if ((void *)func == arch_bpf_timed_may_goto) {
 			/*
 			 * arch_bpf_timed_may_goto() has a special ABI: the
-			 * parameters are in BPF_REG_AX and BPF_REG_10; the
-			 * return value is in BPF_REG_AX; and all GPRs except
-			 * REG_W0, REG_W1, and BPF_REG_AX are callee-saved.
+			 * parameter and return value are in BPF_REG_AX; all
+			 * GPRs except REG_W0, REG_W1, and BPF_REG_AX are
+			 * callee-saved.
 			 */
 
 			/* brasl %r0,func */
diff --git a/arch/s390/net/bpf_timed_may_goto.S b/arch/s390/net/bpf_timed_may_goto.S
index 06f567a460d7..e34c99982c4a 100644
--- a/arch/s390/net/bpf_timed_may_goto.S
+++ b/arch/s390/net/bpf_timed_may_goto.S
@@ -21,9 +21,9 @@
 
 SYM_FUNC_START(arch_bpf_timed_may_goto)
 	/*
-	 * This function has a special ABI: the parameters are in %r12 and
-	 * %r13; the return value is in %r12; all GPRs except %r0, %r1, and
-	 * %r12 are callee-saved; and the return address is in %r0.
+	 * This function has a special ABI: the parameter and return value are
+	 * in %r12; all GPRs except %r0, %r1, and %r12 are callee-saved; and
+	 * the return address is in %r0.
 	 */
 	stmg %r2,%r5,FRAME_OFF+R2_OFF(%r15)
 	stg %r14,FRAME_OFF+R14_OFF(%r15)
@@ -33,7 +33,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	lay %r15,-FRAME_SIZE(%r15)
 	stg %r1,__SF_BACKCHAIN(%r15)
 
-	lay %r2,0(%r12,%r13)
+	lgr %r2,%r12
 	brasl %r14,bpf_check_timed_may_goto
 	lgr %r12,%r2
 
-- 
2.43.0
