Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A33D34B1
	for <linux-s390@vger.kernel.org>; Fri,  4 Sep 2026 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551508; cv=none; b=Nrt/N88SDH3FsIVVDaypcEPUriyhYtGOCoLIzBVpI+HkkK7iqfRYBEpFfhkLKE0m8DIWYyiKf7A8iHUqjvNBlOEFAOj4SD4HlY3v8ODUyB0pFb0STQRha3PEUwwVpOX+G1CLFz361MGO86Y499/yjOC3s8mgEqJP+ld1BKSi9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551508; c=relaxed/simple;
	bh=WtpKffk3cusl9Qtu7bcBmG20buJHAHab36M3KdSl+vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/H/EoQ+jWMGehFHNfiztUkmpLwMGVg6J3NiOvE2ONEEJ/GNBBaC/rbaNEddXmwX/E6KfMdsnH0f/jdkh64YoDcL2o/Soc6fPD4MSnlUECj9oOlkGEKoQvG5GXBpF5TUsKREUCP+6YLmkQu6L2gTz50rzSUN9m2OAfYNq7rsD9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPeUyygg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPeUyygg"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8485b358552so1220580b3a.2
        for <linux-s390@vger.kernel.org>; Fri, 04 Sep 2026 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551502; x=1789156302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQCTqvUlSwcygaUD7WF/GhyApu6o4em2Qqn+xndUeoE=;
        b=aPeUyygg9NMw7KGknp/o3qWN1vdM6PedAEuTS4r0IyO37qSn1AuYGSzbqxMVXLSlPr
         7RlkMNd39h43pDBoNTJQpctNDbEg4PM8IOw+uFdqupKcUdUbvKZt1ksDuK2XTSmI9kS/
         Uhd5O/VPPytxGkoezGTj7D0pfCUZJmJkaumMo1MRPpYCIerBXIHiZl6KW5ygFoQpMUZM
         1HH9tc64NpcxMOrib6kGDWWhDVPt3x5fjnv8aUppkghd5xYThJZZhCynshPP8DVmaZeN
         pNBF/n9mfeWkcwQfBmdSldyfaDVOjt/W2/scBlo1ZS5Iz+RB+GZPHkroAhmzc7cbwdfS
         PGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551502; x=1789156302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQCTqvUlSwcygaUD7WF/GhyApu6o4em2Qqn+xndUeoE=;
        b=U0ySh+/rfkZC2I78/u1JkL1sWjfAYroNg4eYFBgEl996+0mwpWtL9om0nVQsJnQPMX
         BvD2gu16E+LRTB4VfRaDoBSSHjs0D9lC28x+wIk0VUg6+tYwWfaQNE4tRnUYnPlHCB/m
         0L27We7bmlPSUmH6XGHQVb6kARwSuSxkvKu6iWwsT7fDm0BysZrQ7E0gVaXyBG9WYjmQ
         OPfvuYAbVyI1j23nAwDVrtr5hTGiqbU75ZUU4PIL3tOlC/vQy5NhwW93SuxCXyQqQLgC
         nqE4aRG+uBnfSqpJ16d2iVSWqXp3pnHLhr0zppucsuT9iE2lyH37U+P6EB5LoAyCAmsA
         odnw==
X-Forwarded-Encrypted: i=1; AKwUvBwB6Xd02QDXOF4SLHwW/IZnvYR5Vt0+3JSnOKs1sjzU5FvwGn3qjBumfDfUv5PDYLpt64JQg4nlB9Fe@vger.kernel.org
X-Gm-Message-State: AFuF++kZqFbUh0jdZA5CEnFfgrHM2cPDwYSG2/0fljS0lqxP505kfxvE
	ulAHeDP5wc4Z7tRNwAh4P5fcsfc3rCiPHOzyBwBsQtDj/yij1I0ZGaz3
X-Gm-Gg: AYBFou0hxr9rsY+2L78vKsrQ8tggQ2GnjZCjEY5zMdqCOKAKgAkrB63J0TSVACENvWN
	wIn4ZoVzBE42h78bpZSdX5GKyOT6Vn8oCXEFGOgfydmfSYvShnos1OUOytO7+64/GtKYDvxxgWz
	JAoCYLxl2DT53+a2H+elUcMC4zfbohQhxc2HznkCGHBUyOTgXgyVamvQtskIl7vXiTqNO1E4Z7d
	vFqAq43Yt55gjlbJXG9mOesDevlKRBXPFDY1OxiwSIE2dgZZeDOsigim+iV1ZzJDdB+ZooAbcHw
	2xj8aXJ8rQPeZNLiol+hJWZabTuNUhu4YCeK+ogCumdaSA85HI8voYfv1BfPjQ6P0hLbCrvo352
	0UjO7WmuC5Kw5WR4cnhKC2PtGgOpkTOmWc8rTcM48ZxDO4t0mi3+AuM3/6LRREC0UDIYiVkrVcr
	SFAx74d0mNJwa6dgIkYRjefm+iW2JYeexxh9se2i6h63rn5P46AfX0hFPepJuLtvTqOUyxzpunW
	jShE9VjumGT2eBZDNJzvk96VxFg/45IcKgBFj4cbKQIJ0Y6uBFfX2vPkt8mLNVBIa/+PFTvimMm
	dlsxihROLpVhCZGNJqqvKvIf9TNMISYkrRQtLnqdJlr07w/TUBaJ5AxRJHMrlhDysMnkThEqml0
	=
X-Received: by 2002:a05:6a00:ac8a:b0:857:726d:2e9c with SMTP id d2e1a72fcca58-8616b560a78mr11539240b3a.25.1788551502338;
        Fri, 04 Sep 2026 12:51:42 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:41 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
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
Subject: [PATCH bpf-next v1 7/7] selftests/bpf: Test timed may_goto with private stacks
Date: Fri,  4 Sep 2026 19:51:32 +0000
Message-ID: <20260904195132.141068-8-sidchintamaneni@gmail.com>
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

Add private_stack_timed_may_goto() with enough stack usage to select a
private stack. Check that the JIT uses the private-stack frame pointer
when constructing the pointer passed to the architecture trampoline.

Update the translated instruction expectations in may_goto_batch_2(),
may_goto_interaction_x86_64(), and may_goto_interaction() for the
additional pointer construction instruction and adjusted branch offsets.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 .../bpf/progs/verifier_bpf_fastcall.c         | 30 ++++++++++---------
 .../selftests/bpf/progs/verifier_may_goto_1.c | 17 ++++++-----
 .../bpf/progs/verifier_private_stack.c        | 19 ++++++++++++
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 328cf630210a..c5996d9dc8cc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -635,15 +635,16 @@ __xlated("4: r0 = &(void __percpu *)(r0)")
 __xlated("...")
 /* may_goto expansion starts */
 __xlated("6: r12 = *(u64 *)(r10 -24)")
-__xlated("7: if r12 == 0x0 goto pc+6")
+__xlated("7: if r12 == 0x0 goto pc+7")
 __xlated("8: r12 -= 1")
-__xlated("9: if r12 != 0x0 goto pc+2")
-__xlated("10: r12 = -24")
-__xlated("11: call unknown")
-__xlated("12: *(u64 *)(r10 -24) = r12")
+__xlated("9: if r12 != 0x0 goto pc+3")
+__xlated("10: r12 = r10")
+__xlated("11: r12 += -24")
+__xlated("12: call unknown")
+__xlated("13: *(u64 *)(r10 -24) = r12")
 /* may_goto expansion ends */
-__xlated("13: *(u64 *)(r10 -8) = r1")
-__xlated("14: exit")
+__xlated("14: *(u64 *)(r10 -8) = r1")
+__xlated("15: exit")
 __success
 __naked void may_goto_interaction_x86_64(void)
 {
@@ -676,15 +677,16 @@ __xlated("2: r1 = 1")
 __xlated("3: call bpf_get_smp_processor_id")
 /* may_goto expansion starts */
 __xlated("4: r12 = *(u64 *)(r10 -24)")
-__xlated("5: if r12 == 0x0 goto pc+6")
+__xlated("5: if r12 == 0x0 goto pc+7")
 __xlated("6: r12 -= 1")
-__xlated("7: if r12 != 0x0 goto pc+2")
-__xlated("8: r12 = -24")
-__xlated("9: call unknown")
-__xlated("10: *(u64 *)(r10 -24) = r12")
+__xlated("7: if r12 != 0x0 goto pc+3")
+__xlated("8: r12 = r10")
+__xlated("9: r12 += -24")
+__xlated("10: call unknown")
+__xlated("11: *(u64 *)(r10 -24) = r12")
 /* may_goto expansion ends */
-__xlated("11: *(u64 *)(r10 -8) = r1")
-__xlated("12: exit")
+__xlated("12: *(u64 *)(r10 -8) = r1")
+__xlated("13: exit")
 __success
 __naked void may_goto_interaction(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index db7e30da234f..1721897160dc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -90,15 +90,16 @@ __arch_loongarch
 __xlated("0: *(u64 *)(r10 -16) = 65535")
 __xlated("1: *(u64 *)(r10 -8) = 0")
 __xlated("2: r12 = *(u64 *)(r10 -16)")
-__xlated("3: if r12 == 0x0 goto pc+6")
+__xlated("3: if r12 == 0x0 goto pc+7")
 __xlated("4: r12 -= 1")
-__xlated("5: if r12 != 0x0 goto pc+2")
-__xlated("6: r12 = -16")
-__xlated("7: call unknown")
-__xlated("8: *(u64 *)(r10 -16) = r12")
-__xlated("9: r0 = 1")
-__xlated("10: r0 = 2")
-__xlated("11: exit")
+__xlated("5: if r12 != 0x0 goto pc+3")
+__xlated("6: r12 = r10")
+__xlated("7: r12 += -16")
+__xlated("8: call unknown")
+__xlated("9: *(u64 *)(r10 -16) = r12")
+__xlated("10: r0 = 1")
+__xlated("11: r0 = 2")
+__xlated("12: exit")
 __success
 __naked void may_goto_batch_2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 3d9994a52464..639b53363c9a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -70,6 +70,25 @@ __naked void no_private_stack_nested(void)
 "	::: __clobber_all);
 }
 
+SEC("fentry/bpf_fentry_test9")
+__description("Private stack, timed may_goto")
+__success __retval(0)
+__arch_x86_64
+__jited("	movabsq	$0x{{.*}}, %r9")
+__jited("...")
+__jited("	movq	%r9, %r10")
+__arch_arm64
+__jited("	mov	x9, x25")
+int private_stack_timed_may_goto(void)
+{
+	volatile __u64 stack_space[16] = {};
+
+	while (can_loop)
+		;
+
+	return stack_space[0];
+}
+
 __used
 __naked static void cumulative_stack_depth_subprog(void)
 {
-- 
2.43.0

