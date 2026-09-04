Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211333BE174
	for <linux-s390@vger.kernel.org>; Fri,  4 Sep 2026 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551502; cv=none; b=WbMbjQ1Uv2KDiJmd8egrlruh60drgurEHXw6llO4g4v1aN5ablMm7LB39LK6beL/LIO2b8b7blHUvekwSDS8T6Xi5KJU5EHsQ+hCWLe9vhr78iCGPxMbDr9/X87FD9q/zPHpQGSha5h1mbCh5ZIhNi7MqTzs1O7vGbpyNXJ05y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551502; c=relaxed/simple;
	bh=Jp46YtN9R/imYbaeHst5myObtgXA5/fwhYDAR9XdoVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezGSGvgVYPhbzZ4l8oqAHY01XirLwE3eEFTqsGagx8c4Wepsu+8qp36xtA1VTSF7j7RujuacW1oH+Yn0Npi/b97LhLiTq79T3GHGorhuMsl0Di+NsOSo6+URUYXPQ6ugHzRFnxCCuvfrztP70dn6EZFuPobwhvw1COrRNF0J5BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/u+8D+J; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/u+8D+J"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-85377c8bc96so1278668b3a.3
        for <linux-s390@vger.kernel.org>; Fri, 04 Sep 2026 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551497; x=1789156297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+qDNedZBe5IOgOVXUT3YGJ7aNww3Lf+ZOsFiBHpPGIg=;
        b=D/u+8D+JIiQfe3DJMNRgrsB+YnnnGVlgn0waHPAIS/HyNT1ywY5UIJrxyiJPP89Aiw
         3kCCc/W89QT5C9SXNQme8IA1EQq07/vQA8WOTTnkIr195uZZIRe0UuRVlFx8KO6yuEAs
         rHSgAr+053sSlzasJ9yUNHeXtExYO1bOAP3eq4sQkH2KTozxD39S0PQtugRNV6GmFw2T
         8H1jAYYy2nkMqoWzemUWnblc1XZgnQ2NM3QVXoiRYYfeGsCCdPR3iABNMEhDW/JsGtno
         McyXwuVENinkGJkIgh1CXC0gtNLXy1WVCnNuNgvyjl5C4csHhHx2vxkntXxGdn9KdvAH
         WAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551497; x=1789156297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+qDNedZBe5IOgOVXUT3YGJ7aNww3Lf+ZOsFiBHpPGIg=;
        b=OmvhtdjHkN7kcDWoG2zZRYRrT+Jf66RqrXDvuW1FBAqxpNwx+1eKRPTGyZmjbIwdh3
         cXtjJJTmnvRrt6IhVOH9sVFhhz234JHs7PGaGu/4vPTHPqVe3TvQoNZ/sXWAuR/Yx6Nm
         Di5gTrQbzNyTTSYetYl+n2mSpqLrX9+wCrvYwvWLnx2hNMT6Nix/iW8NUF5/EQs60EsK
         RYucmmTrkg5ZQqQL7um7/6buzUTtrsKdzFmryaO8S9SnlAaxlabjLpYNEKCskST46Fwu
         zF3L68fSqO/atP4uCwVh1kRwYZ9/QLsw/e8e8+sNAW0AyPh+yEHLG8PcGbd7At3bbksv
         PUNg==
X-Forwarded-Encrypted: i=1; AKwUvBxx3lZKeCuzotA9wAi/mWeP2/NKOBjZ1Di/6hGqJlHQJU5sxZOIQDWdmi0nYLa7TJpjxhxrOF8BlFIw@vger.kernel.org
X-Gm-Message-State: AFuF++khn/jL2CyvndFpNrG25AbMRg8yjw2kB6xmRcSN0LvcQjzzcouJ
	jdiW5x3hEnV56OPY9iPIfuAGRP7PS66y4qQmIyl4aUG9jAoGbGfwI9In
X-Gm-Gg: AYBFou1d174BJKXXfMukk8E6rCQhPQm8zrtCKUCHyC8aVY6Xs7BIrf3wO1oqcBlMDCu
	ryTzuqRoM0ct6pqpwtq1oZvH4Ab1ongPyfkELbSmnB/74auw40OtN9MElXN3gRggN316pcV3svN
	mNd0GYdBiSXdNNAcgHCd9F0iDvXmYJe0aknoYCa6bYleSSdKtpfe//Kb64C8WCpMvhq0lH1fIpg
	5LTCrqa5VMqVtF2X6jL/qAbEkw2mk+eEYsvMx/GNZYWYvYrKjKyk3rMeVnnyzMo8sLYrqyWWFVT
	geEUUBBfQqL7BOLM2OvU+xgDmd9BIEGuDflALokKfqI6sWdGcUtanE4Kuh9YKHVtv8TRlX/+3uW
	DYMJKWNQy5OoL6QT8skNn4WHxyb6EX2srb1ctjP9YBfXVDo6fFi/T1DtKs6eVmrEHtugfs7QGRX
	E5lKPl8tXqqzL7hTXge9bqyTlgeV60dsgtADbG7HqKYPlZz4cZbme1c52CjnqYf/CWEawjTP6Io
	MyJJgny48zsPKURd/QFMieceIhVaDPOQ7vhBdQ1JAjmQjLzt6dixJEq3p+t+uHUoW586U8g+Pir
	Rm+LNeLVn+ztt7x41S493lY85qyL8W0NMEdtsr+Cr3Kuajun/QWMKO6ud63DfK3tIYuVDVWsSPU
	=
X-Received: by 2002:a05:6a00:3007:b0:846:4d4c:23f8 with SMTP id d2e1a72fcca58-861662d4c34mr11674869b3a.1.1788551497395;
        Fri, 04 Sep 2026 12:51:37 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.36
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
Subject: [PATCH bpf-next v1 2/7] bpf, x86: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:27 +0000
Message-ID: <20260904195132.141068-3-sidchintamaneni@gmail.com>
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

Use the pointer directly rather than adding it to RBP. This preserves the
private-stack address selected by the JIT through R9.

Fixes: 2fb761823ead ("bpf, x86: Add x86 JIT support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/x86/net/bpf_timed_may_goto.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/net/bpf_timed_may_goto.S b/arch/x86/net/bpf_timed_may_goto.S
index 54c690cae190..6e9d9e7c2b1d 100644
--- a/arch/x86/net/bpf_timed_may_goto.S
+++ b/arch/x86/net/bpf_timed_may_goto.S
@@ -11,12 +11,6 @@
 SYM_FUNC_START(arch_bpf_timed_may_goto)
 	ANNOTATE_NOENDBR
 
-	/*
-	 * r10 passes us stack depth, load the pointer to count and timestamp
-	 * into r10 by adding it to BPF frame pointer.
-	 */
-	leaq (%rbp, %r10, 1), %r10
-
 	/* Setup frame. */
 	pushq %rbp
 	movq %rsp, %rbp
-- 
2.43.0
