Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732666AbfIDQDF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 4 Sep 2019 12:03:05 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 01/20] s390/bpf: fix lcgr instruction encoding
Date: Wed,  4 Sep 2019 12:02:44 -0400
Message-Id: <20190904160303.5062-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Daniel Borkmann <daniel@iogearbox.net>, Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-s390@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit bb2d267c448f4bc3a3389d97c56391cb779178ae ]

"masking, test in bounds 3" fails on s390, because
BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0) ignores the top 32 bits of
BPF_REG_2. The reason is that JIT emits lcgfr instead of lcgr.
The associated comment indicates that the code was intended to
emit lcgr in the first place, it's just that the wrong opcode
was used.

Fix by using the correct opcode.

Fixes: 054623105728 ("s390/bpf: Add s390x eBPF JIT compiler backend")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 727693e283da2..e53d410e88703 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -886,7 +886,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		break;
 	case BPF_ALU64 | BPF_NEG: /* dst = -dst */
 		/* lcgr %dst,%dst */
-		EMIT4(0xb9130000, dst_reg, dst_reg);
+		EMIT4(0xb9030000, dst_reg, dst_reg);
 		break;
 	/*
 	 * BPF_FROM_BE/LE
-- 
2.20.1
