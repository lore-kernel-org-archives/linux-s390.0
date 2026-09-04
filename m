Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D753D3324
	for <linux-s390@vger.kernel.org>; Fri,  4 Sep 2026 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551506; cv=none; b=gBCjcSzn+eklAcvwuOqUQhPN9cWs1xCVWhghr9eFly2m7wou9zqxMUzLCvRShG4lDEPirw2zFi/Q+ntjIOeYEiq8NxCS9f9WleFsOSw0Kk8WFAFLh2BJgonsuH9bCZyDayGxXvgpz/KZZocvgQzwA90aMFvaRdPSn/RWTNbIN8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551506; c=relaxed/simple;
	bh=w5NBvwVDK4jynWMDTkCIvGpfq2JarnNZCBIHvTxjTak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyfwCnILgH4RZFAHlt0Hb+JIq7okS+mwFQcn7VXLQq/T5PFDE9flSNXprIgEJnNOQuZUe4gIPQLQu/jZeGXdGcMS0wnuGJXvjuHlhB0ThC/oNlr9AyjAVxTG8Hfyop8V9eugXl8NCcNz7R76gL4MtYnub1j0IOzk05kcXXWEgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHR9Izx6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHR9Izx6"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-85590c5aeabso1020621b3a.3
        for <linux-s390@vger.kernel.org>; Fri, 04 Sep 2026 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551500; x=1789156300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhQhsQ4UfwQumqLXBrbDqGkg/NZUYL46Pvxy1S1ZxCg=;
        b=DHR9Izx6yDwbSX2kj+NfWQf4+9F+ftlbHin3rBXCRSgmaSmQtVfWHoqwFlXGp23kSL
         TA7aI6zF87Q3fubPyfjBm0AU/8pF18HXNVrXZhe2z5nNQiMR1ig155oLfrggOIo5ZXo9
         1h/XROsibTSqai/yza5aD3UHmZV9raTvRVKEgpz7o00hMQBCw3IevhqQK+BBBGnXtpYx
         WCmsIucckseIF0FwFwkjTAp6K/SJUvN/EBWjGE7v5S6dKRrRczGylIWE5HjgL21u6Y6q
         TRkdaGKn6dSnjFWvM7wAJitEE2LcxMaA9bPpSbNkR1tvsCb56G3LB18sJHP53Ok0Fay7
         eMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551500; x=1789156300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhQhsQ4UfwQumqLXBrbDqGkg/NZUYL46Pvxy1S1ZxCg=;
        b=Em0hRPYo3L0adNEN2nhvfOVQAWkn6AFlsGyCUqro/VgIcJeIKc4MWsB47Vvcu/zXyH
         8TXSapdWpR/JVEPzevtDGXruesM4g8ma/Cw3SqxP0MFim7PhlOIXjg5EkaVlT+2MQO+h
         zzmyWB5NfcH2uEjUucb0lBqL4z8L2sMmfwa/YynEGbKkCOGKh2ZO5Ub7anzHauk7eHJO
         2ZtVwj2+Y6pA0REGsVgvEkFB1Fz0L1VsdqLWHvYLIHo2HATBLZg+AdKNzDYYMGpHp4yp
         FMUa6UKeidcC4nzo7aUAqbgySCpAtQ2II3uV/VnQxR71qjpEn7qhh75jTgJEi0tQtcbR
         KGjA==
X-Forwarded-Encrypted: i=1; AKwUvBz7Ifl14+9aAoLtrZHbjOJuwH8F3I39HAUwTALcM94zkWc+WfXxw/Y7BJV+Jh36P/T0SBmP2wVd+3P2@vger.kernel.org
X-Gm-Message-State: AFuF++l1J+LI+RVC23x01Mb+CmpvCPfcME9lI3Ti5Nq12z1tFORQBodw
	H7VYwwhhLMXZnkDctQC6/129v4c3dtRyUufCMTYvtp2Qwt/c6Gf7RHer
X-Gm-Gg: AYBFou1skQ4YAVGVvk1sRKXYrL5sz0Yd5i8cf+Mz20OvDbL0TqLpqumj1Sa9GsJyyrN
	trHsV3PnaM46PzeNjxJzZJ4vfE4VBwl4WR75FnsRtA8YdR2xv42wJ4qpNjBOtaom8EXUl1zM6/r
	ZTC0akOLiMZ8c3sbBu6i+QFNblSLDbpOSgqX2XSEeiXb9uAr24ermhOEjiBIfLRLcIhsAPU9zJr
	Qx9ihGTUrPCOqQ08AeeUk5DFBhVCdxDesq67FOLF/AR7RshCucv1le5xHtd8U6jUabpTprB99O5
	VO6rEiOY/GgIQ0NWYRCo6H4nLcnNUXQwWSqDFCJ72UUilwMNT6/HoQXrEQUflMd3hT388P3vczG
	OF3B3mTlHkioBbnYzTIW1cZJG+CiNyfdwnyK5+c8v0qHZMNDvzKKqg5rLYOynctMMZKRzClkCW9
	8SwyYDqbogXvj5WMHL4zyQUw4iMecYsX16EzPE0sTXoinX03IqtL3UqDgX+8opbFdMQnpW7rBp+
	G9jBDxZwFBmVxt5tVXh5qpmrgbaXnoXgz8cz52QN+cz2+SqYUVc+1o9HZKqrfiUyoai6ETVNuUl
	gIhu8liitqRLA8rf5D4ajRTEbBUdVh47zYWXMTNmidlQCk3E8bnEX1zZewbjhjwww6Aw1Q2dfZQ
	=
X-Received: by 2002:a05:6a00:9286:b0:84f:77cc:63cd with SMTP id d2e1a72fcca58-8616a06be4amr11190015b3a.17.1788551500394;
        Fri, 04 Sep 2026 12:51:40 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 5/7] bpf, riscv: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:30 +0000
Message-ID: <20260904195132.141068-6-sidchintamaneni@gmail.com>
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

Fixes: 6ef8ff20c30b ("bpf, riscv: Add support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Assisted-by: Copilot:gpt-5.6-sol
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/riscv/net/bpf_timed_may_goto.S | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_timed_may_goto.S
index 02c637d87420..8c03e272e0bf 100644
--- a/arch/riscv/net/bpf_timed_may_goto.S
+++ b/arch/riscv/net/bpf_timed_may_goto.S
@@ -6,12 +6,11 @@
 
 /*
  * Trampoline for the BPF timed may_goto loop bound. Custom calling convention:
- *	- input:  stack offset in BPF_REG_AX (t0)
+ *	- input:  count and timestamp pointer in BPF_REG_AX (t0)
  *	- output: updated count in BPF_REG_AX (t0)
  *
- * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI, where
- * ptr = BPF_REG_FP (s5) + BPF_REG_AX (t0). BPF R0-R5 (a5, a0-a4) are saved
- * across the call; BPF_REG_FP (s5) is callee-saved and needs no saving.
+ * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI.
+ * BPF R0-R5 (a5, a0-a4) are saved across the call.
  */
 
 SYM_FUNC_START(arch_bpf_timed_may_goto)
@@ -28,7 +27,11 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	REG_S	a3, 1*SZREG(sp)
 	REG_S	a4, 0*SZREG(sp)
 
-	add	a0, t0, s5
+	/*
+	 * BPF_REG_AX (t0) contains the count and timestamp pointer; pass it as
+	 * the first argument in a0.
+	 */
+	mv	a0, t0
 	call	bpf_check_timed_may_goto
 	mv	t0, a0
 
-- 
2.43.0
