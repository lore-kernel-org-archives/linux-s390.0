Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E276165F1A
	for <linux-s390@vger.kernel.org>; Fri,  4 Sep 2026 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551504; cv=none; b=n2/rpXfF7VE1xmGd/8uCCdXqQeFFCRSdKwlWrTYO4vJAqOjePSMylgXVZK1fAb85FVIdmRdnMEhwvyCIjiLrMMkcYONJLu0CwZ6Jg5qu4dIuuzxGrpO7T2f8+jooTS/6vMqRg60lGUlUvDFffnfcHFrSAJLSzWrGC5ldbLOeH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551504; c=relaxed/simple;
	bh=UZbyG5HwV/ItMLroTmcQJXFCJWeN9RrzvXMhN72UKYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZkeHi//sr9Ah10UxGvFZulsCoMqvbYjqh/3J0Ptkw7slZQANFZCO363yx3PNIFBRKmuUa0xGxwR1/F0UPUzUv3eiD+adAv10kLrc7n62CqO2yaLYUPA22ZpeoRAHXDbblf0GTXkIjOb63KAuh5KgwR5GdXuRfJR6PXiUp19sGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX/HLFgC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX/HLFgC"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84830c774a0so1289058b3a.1
        for <linux-s390@vger.kernel.org>; Fri, 04 Sep 2026 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551498; x=1789156298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvrsiIV2Lldx5aqamYQifBQ5Wmg+CQWdeLatZB+qlSs=;
        b=FX/HLFgCMiToRE175+b7mm9v9nxn3pFQpwk3UlQlj9Tm+x5l5QYw/wlPtWfwqJqFEO
         CNcEx7Fym091n4GXtRxY/j5p0bFc+wsJ6+bZymOi7dfsOz3hFB5qls9pa/6Dds9PVlgc
         YruqbwbIpxB1UILlQCQF3oUgtT0s1i73arEH1/inH5/EjH9mejNpQzchMwzW6YJpPJLh
         5nK86Fy5756tC3uFh23jTPE4zCaEkZxxl52jKv74oofFZgAf2F7Gratk7PDOdLWVyfJR
         ntseAgKMWAe+JE8cTW4jLxbikXERhSD96HwgrP8CCnhmON2ir+aV8+GcVCZXfQvZxd7f
         QGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551498; x=1789156298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fvrsiIV2Lldx5aqamYQifBQ5Wmg+CQWdeLatZB+qlSs=;
        b=TZ39xo+3wZPdTqkhZVOgexOYDCDgMOVf2dWh3mgQW4NCu3xrTfG1Tlx0F+tq6Mzywb
         A+zCzVblP9yAQZe54zUI8ZB+rcbLkjSbSFKUnGocPRYrk1hV1hHDfMQva5tbg5/5Q53G
         p9RPq5IWeIQBfsj8vsO1B5jkSfR3rkL9p5nbXQQUpJYaZ7n3c5xW24zeE+KkajydPoBs
         da08lG3ZHhM18LShKqvXutCrX7JE8WL0LEdFK3u4HKQamr4cLrkV3XfBGZqPT1lLQ+Qn
         v+u0Ljx0V+9iVG9SYQtfPdQB17cTDXo7CdSghjH1DTlLTZeU+ZadLS+Ljn7Bzy1PiLjm
         YdIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRA2UiTZDUXorSrm2mfI7dV/HoXEVMm0M1RTBvx8jc1ujj75rAFFXDxnM0O0TrsM/mbWNXH9iRveMH@vger.kernel.org
X-Gm-Message-State: AFuF++nHOqmItXUfYc6eVjLkhkas4Smp/pVN0INhZZtZ4YEDOW8mpp0D
	xYw2+UMutHp2i3SMwMNW7mdnBNiZ8/zmYnavgQJqZimZKXkMgocr7CuI
X-Gm-Gg: AYBFou0lacoBPyBRLOzxXlSj+9GAMy1xG+LLrMY8cVXYjeqdfAk8EtJp+gksIGHpx1N
	T1SAt3d1QccQTapcyQ1ZA76VyBHFWzQWkQDU2jA/DNSL1vtJ5GkgHeyh+gEYax69tp7xEvnnJk4
	voPgHcV14oM9Th70dv3/lDhOKRc/72vFcePSk4hGWkFt4W6VQ5YgkmrN9M/Dh5KZdePPW9Mr57X
	Zgdj4h3DY1KRxi5GVwVO12GOgKD0tXBqqhbrRNOhhUI1D/OFqc4spu6R8fp++Dhq2WAUN1ICsyP
	MAn5Xkg8fKZ3hYWjk/JUDE6A0ZQswx0E65mgJZCbHLZmqDPvQeoVX0Mmm5qcnK4YWOQ0kwEu573
	VA48mT8K4oEnH5DnjUKDwbr0y3vm6i9b5M9BUBhdg4u2DnnLEPUpGbkUqblOiyWNtVpZv1awg6h
	GVBpu2D5SNmBagAvDuLbEuEjEsGWWVy7+JOJj0cIDB5V7iiLC2b6rB4zpDN+E7Uw1f4vCgFMbET
	DXxd1/8xJ2tClwzjVsTie3AdJb9Zz54J3Z+Ysvewng4mJlBZ21k50GZomKOvD4eNW0i8UxXBHOm
	rb3nZx8yuM8utUNhrGZsPv45YnnQpfs1a99eMhskhGHMs8M8pfvmJiToUALcvv58/N2xHBbVWDA
	=
X-Received: by 2002:a05:6a00:1151:b0:85d:84a5:b7bb with SMTP id d2e1a72fcca58-86168d8c2fdmr11042192b3a.18.1788551498348;
        Fri, 04 Sep 2026 12:51:38 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 3/7] bpf, arm64: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:28 +0000
Message-ID: <20260904195132.141068-4-sidchintamaneni@gmail.com>
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
BPF_REG_AX instead of a stack offset.

Copy the pointer directly into the first argument register rather than
adding it to the BPF frame pointer again.

Fixes: 16175375da36 ("bpf, arm64: Add JIT support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Assisted-by: Copilot:gpt-5.6-sol
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/arm64/net/bpf_timed_may_goto.S | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/net/bpf_timed_may_goto.S b/arch/arm64/net/bpf_timed_may_goto.S
index a9a802711a7f..53148c9a1c58 100644
--- a/arch/arm64/net/bpf_timed_may_goto.S
+++ b/arch/arm64/net/bpf_timed_may_goto.S
@@ -14,16 +14,10 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	stp	x3, x4, [sp, #48]
 
 	/*
-	 * Stack depth was passed in BPF_REG_AX (x9), add it to the BPF_FP
-	 * (x25) to get the pointer to count and timestamp and pass it as the
-	 * first argument in x0.
-	 *
-	 * Before generating the call to arch_bpf_timed_may_goto, the verifier
-	 * generates a load instruction using FP, i.e. REG_AX = *(u64 *)(FP -
-	 * stack_off_cnt), so BPF_REG_FP (x25) is always set up by the arm64
-	 * jit in this case.
+	 * BPF_REG_AX (x9) contains the count and timestamp pointer; pass it as
+	 * the first argument in x0.
 	 */
-	add	x0, x9, x25
+	mov	x0, x9
 	bl	bpf_check_timed_may_goto
 	/* BPF_REG_AX(x9) will be stored into count, so move return value to it. */
 	mov	x9, x0
-- 
2.43.0
