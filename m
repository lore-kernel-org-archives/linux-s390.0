Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA4B4D9577;
	Thu,  1 Oct 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850796; cv=none; b=GZUV2IaFeAGPQCGJK1dcH3WeGWMkly24Gdzgom1fFYM5X+syYLbgJmLhS+OuS8QkGCDtQXSXXjHAqLpyjmsR/MpRjVvXE200iYKvHBT1N2Tg5w5A+1O9T83aTSEUGTuthKvvFUwy3kXWvKJSWJC+Enofcoo5Mi7pcXi0KgUsgmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850796; c=relaxed/simple;
	bh=zSKIRVCaTq60h/uU6EhhGMaPc/Vwv+XqeDlm8gfBoOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utELH7yoxXjZmJI7ESCFYpw2s7E4RLCQWvc3QTLbUOVRtNuFv7qlaRuARKCzM7FwY65JHd8T5hfAXYVtbgVPLz5I3vphl7CR+sswexEXbCDfnOemiZkk7Mx3h5/dHfbhpoIcZLPaYZPZwYoUpZTd/TTRXtywCZwAExG+fjiROHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sS3kUL09; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sS3kUL09"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175NwP1085937;
	Thu, 1 Oct 2026 10:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yXCCU2E6QDTS4+JqV
	e/DYrV9ydwnwjvsUWZrLt3tRSg=; b=sS3kUL09t6lpVyq8f573spLyU+lm29og7
	KsOhYQUoW/LiPFjq1YooDkEYUYTkJp0kt/9r5TmWN0PjnT3oVgpApnIVtSEQ07qL
	TrsnHbxzXCSwJkgfnwpeMxKtXvTVN4IaHwODTv57kUiJB/bwDlRgpF69dK2rtFTi
	nKkWlJ4vhxITZFj9s0jgsqjy4qZeEFLAI434kRPWYpLyQxtbbqo/r7zccqMppyuk
	jpIqh+PtZ42MCZuHIr9OVJI8bQcpifoHSYUpg6mSnUB4cvD707e2ms8ExxgRWQMf
	g2wF/Z5nyVUZrfBstYbx8dF421vgAuH/z6TNj94aXMBug7xoXkjQQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5jk2t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:33:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172TVa557896;
	Thu, 1 Oct 2026 10:33:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23r4d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:33:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWv6642336514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1346620040;
	Thu,  1 Oct 2026 10:32:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC76B20043;
	Thu,  1 Oct 2026 10:32:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:56 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 31/32] s390/bpf: Simplify exception table entry handling
Date: Thu,  1 Oct 2026 12:32:46 +0200
Message-ID: <20261001103247.1989111-32-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001103247.1989111-1-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXwUAlZVMC13wg
 ryHojtIwI5nk+ORpKSScIjIl+p0cl3Ex8TNxsN6OVUdAnKrVh9W2IAR7u4EMGF8s5prcyYBK3uB
 OTK1Q63ENJvNd/clkUz8P5/SSfEXeDE=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abe36dd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=DKa8rqKrbTOd84IxAboA:9
X-Proofpoint-GUID: rVd4RcI1pndIyRTiRb-KSq1csyYcQjdK
X-Proofpoint-ORIG-GUID: rVd4RcI1pndIyRTiRb-KSq1csyYcQjdK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXw1wfN4WZhKx0
 GtfrW7QIn/KbdG4DH3jgP4BPd8DLN03fLD5bkp03Q0Q0lwcdhxbjLrXIv6cCY/uT/319isWos4N
 tHGWDNglyYwu72+1zth/byEHGy7nAH/imGaprOf3wOm0OQtVziR8TrveMzJbni31/kK/GW9BuJI
 ESkBhWLHoDJcFSuhoX0odg+RoWTiJmal0Ft8uUIHto0ot0PYsT/q5lHRUXpPzXJakuv8c8YBFJV
 1P4alECT2sfPkfK7Yoz2CAmaEWp2gLWPh6622m3lWZBd7TWRkmEOx7gj2NJXA0F8H/twMvXPGne
 SUx+Fw05yQFR95eP4eKju6aLoPwy11qvzaBKSVERoIOLe4WEqAPsGuM2WiDhx4f8FSNTvH2fah4
 0/w9SXlihNKUDt7nRbPf+IepNu3vvfY3vfOAs4lFaTebErCra2a87CWmx+/G7483wgIIDJ/0HUN
 8s6Lf/oj2iYdsjk8TeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

With exception table lookup always pointing to the faulting instruction,
only a single exception table entry per probe instruction is needed.

Remove the second exception table entry, the extra nop instruction
emitted between/after probe instructions, and simplify probe handling
in the BPF JIT.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 78 ++++++++++--------------------------
 1 file changed, 21 insertions(+), 57 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index c4b47070bb59..9f1632e068e1 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -723,7 +723,6 @@ bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
  */
 struct bpf_jit_probe {
 	int prg;	/* JITed instruction offset */
-	int nop_prg;	/* JITed nop offset */
 	int reg;	/* Register to clear on exception */
 	int arena_reg;	/* Register to use for arena addressing */
 };
@@ -731,29 +730,10 @@ struct bpf_jit_probe {
 static void bpf_jit_probe_init(struct bpf_jit_probe *probe)
 {
 	probe->prg = -1;
-	probe->nop_prg = -1;
 	probe->reg = -1;
 	probe->arena_reg = REG_0;
 }
 
-/*
- * Handlers of certain exceptions leave psw.addr pointing to the instruction
- * directly after the failing one. Therefore, create two exception table
- * entries and also add a nop in case two probing instructions come directly
- * after each other.
- */
-static void bpf_jit_probe_emit_nop(struct bpf_jit *jit,
-				   struct bpf_jit_probe *probe)
-{
-	if (probe->prg == -1 || probe->nop_prg != -1)
-		/* The probe is not armed or nop is already emitted. */
-		return;
-
-	probe->nop_prg = jit->prg;
-	/* bcr 0,%0 */
-	_EMIT2(0x0700);
-}
-
 static void bpf_jit_probe_load_pre(struct bpf_jit *jit, struct bpf_insn *insn,
 				   struct bpf_jit_probe *probe)
 {
@@ -815,47 +795,36 @@ static int bpf_jit_probe_post(struct bpf_jit *jit, struct bpf_prog *fp,
 			      struct bpf_jit_probe *probe)
 {
 	struct exception_table_entry *ex;
-	int i, prg;
 	s64 delta;
-	u8 *insn;
 
 	if (probe->prg == -1)
 		/* The probe is not armed. */
 		return 0;
-	bpf_jit_probe_emit_nop(jit, probe);
 	if (!fp->aux->extable)
 		/* Do nothing during early JIT passes. */
 		return 0;
-	insn = jit->prg_buf + probe->prg;
-	if (WARN_ON_ONCE(probe->prg + insn_length(*insn) != probe->nop_prg))
-		/* JIT bug - gap between probe and nop instructions. */
+	if (WARN_ON_ONCE(jit->excnt >= fp->aux->num_exentries))
+		/* Verifier bug - not enough entries. */
 		return -1;
-	for (i = 0; i < 2; i++) {
-		if (WARN_ON_ONCE(jit->excnt >= fp->aux->num_exentries))
-			/* Verifier bug - not enough entries. */
-			return -1;
-		ex = &fp->aux->extable[jit->excnt];
-		/* Add extable entries for probe and nop instructions. */
-		prg = i == 0 ? probe->prg : probe->nop_prg;
-		delta = jit->prg_buf + prg - (u8 *)&ex->insn;
-		if (WARN_ON_ONCE(delta < INT_MIN || delta > INT_MAX))
-			/* JIT bug - code and extable must be close. */
-			return -1;
-		ex->insn = delta;
-		/*
-		 * Land on the current instruction. Note that the extable
-		 * infrastructure ignores the fixup field; it is handled by
-		 * ex_handler_bpf().
-		 */
-		delta = jit->prg_buf + jit->prg - (u8 *)&ex->fixup;
-		if (WARN_ON_ONCE(delta < INT_MIN || delta > INT_MAX))
-			/* JIT bug - landing pad and extable must be close. */
-			return -1;
-		ex->fixup = delta;
-		ex->type = EX_TYPE_BPF;
-		ex->data = probe->reg;
-		jit->excnt++;
-	}
+	ex = &fp->aux->extable[jit->excnt];
+	delta = jit->prg_buf + probe->prg - (u8 *)&ex->insn;
+	if (WARN_ON_ONCE(delta < INT_MIN || delta > INT_MAX))
+		/* JIT bug - code and extable must be close. */
+		return -1;
+	ex->insn = delta;
+	/*
+	 * Land on the current instruction. Note that the extable
+	 * infrastructure ignores the fixup field; it is handled by
+	 * ex_handler_bpf().
+	 */
+	delta = jit->prg_buf + jit->prg - (u8 *)&ex->fixup;
+	if (WARN_ON_ONCE(delta < INT_MIN || delta > INT_MAX))
+		/* JIT bug - landing pad and extable must be close. */
+		return -1;
+	ex->fixup = delta;
+	ex->type = EX_TYPE_BPF;
+	ex->data = probe->reg;
+	jit->excnt++;
 	return 0;
 }
 
@@ -1705,7 +1674,6 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			EMIT6_DISP_LH(0xe3000000,
 				      is32 ? 0x0058 : 0x0004, REG_W0, REG_0,
 				      load_probe.arena_reg, off);
-			bpf_jit_probe_emit_nop(jit, &load_probe);
 			/* Reuse {ly|lg}'s arena_reg for {csy|csg}. */
 			if (load_probe.prg != -1) {
 				probe.prg = jit->prg;
@@ -1716,7 +1684,6 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			/* 0: {csy|csg} %w0,%src,off(%arena) */
 			EMIT6_DISP_LH(0xeb000000, is32 ? 0x0014 : 0x0030,
 				      REG_W0, src_reg, probe.arena_reg, off);
-			bpf_jit_probe_emit_nop(jit, &probe);
 			/* brc 4,0b */
 			EMIT4_PCREL_RIC(0xa7040000, 4, loop_start);
 			/* {llgfr|lgr} %src,%w0 */
@@ -2364,9 +2331,6 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
 			 */
 			fp->aux->num_exentries += 1;
 	}
-	/* We need two entries per insn. */
-	fp->aux->num_exentries *= 2;
-
 	code_size = roundup(jit->size,
 			    __alignof__(struct exception_table_entry));
 	extable_size = fp->aux->num_exentries *
-- 
2.53.0

