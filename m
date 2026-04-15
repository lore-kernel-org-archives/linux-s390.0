Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656513D6CDD;
	Wed, 15 Apr 2026 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243158; cv=none; b=HRbheBWJ2mtG8d6ifV+w0Z45d+rG9V2RbaWkyDLcINBOJJrBXu8Z7UV4wQXIgkfesN8F5v85AIfrVjeJBd8zWhUVzyaVWVOdQ0LdtqCDIzu4Ja9zNOeijWPCgVJbPQP3wdg13oM9XWtSbb2iI3ldwDLfuTP04Z+5w69lgjO/DV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243158; c=relaxed/simple;
	bh=rGo+Qxonq8xVgEHIrIpMR3xis2teaA1f/LBy36R0vng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiKJHWw7ZmlZ15xjMhpVIHTArURh2qSplQnBcVPXdnpcie0OjmXdWhIE+J3Y9GbId63pUzBq+aEkhQBQYSFhe1bUtQ6ODnm5cZT88DVEL3DS6YkviCDNBGXSJz247jYm+HN3faG8pbUQbjqfw9Fy41i0rD5wt0Lw7vPgxUJQ4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sqq0Lcce; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sqq0Lcce"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F4q1Tt1842840;
	Wed, 15 Apr 2026 08:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oCnw9t42nA4HhNmdQ
	hooKXfKel2qxJFtS1lj1RsN8SQ=; b=Sqq0LcceBW65qhmUJnlEdhyDG13+lMylE
	cOMVhm/DS7x2NhbPSjc1tqojDsOCTzZn7hW58ZrPZ7wmaxAnHhXtc+85feXeVTBF
	Mh6VJutAKB5CxoIejHZ4t96WZxEm4qUDBxOu8M0/1eme+/UAIgeeIaRWFBfc1uJZ
	uRiUy9QjP06VPXJEDZDZ183xIyroMIRIhmu2Np8ZqVPnDHpnbQjCrH0j30f6o+MI
	hRh13W3sDaJ400cmBxkg+GCNJf0rNGzT8ZhjE5BIVBClnAl0TEnFJAOt5AJyo6Kj
	9mJUzM5mrCd7HSWPThEtBW5y8GhSnRZc/OIgJnp6yBXG3vILi8i0w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mq4kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:52:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F444qc025831;
	Wed, 15 Apr 2026 08:52:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1n593-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:52:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F8qW1U24117742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 08:52:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34D0720040;
	Wed, 15 Apr 2026 08:52:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 181D82004F;
	Wed, 15 Apr 2026 08:52:32 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 08:52:32 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests 5/5] lib: s390x: Remove kvm s390 prefix from sie control block
Date: Wed, 15 Apr 2026 08:45:45 +0000
Message-ID: <20260415085145.91197-6-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260415085145.91197-1-frankja@linux.ibm.com>
References: <20260415085145.91197-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4MCBTYWx0ZWRfX9/i6IHTIU8Vq
 wxyPBH1SDJcYZiV26RiQnZT520Zyac3cWW71LYK3QMtseRCz4Zz2O4wpdqwjGTQ1qeWTrLpmp/F
 g+op4/Tbk7DmJTLUSny7QiiES/PenP3CGI8hhzY6rX/ycFIVc1ZW5P9DaLhKJjj7Ud+mX+IUPbm
 nIJdqm4HggQ/w3xMTJE7mIAV3YRfbrqO/DEwSScRQbb0axsC5M2LYgOAC8yYrvInJKrNHEUV1WU
 tBjvZ9QU0N0tqSnka+goH+kgOqtQ7PMARc2YrJyZ6gn8Ypn07Car2ZtDdZVrKiNOZNasIhaqAJz
 9D5L0khrgc8RuqntgXxV6EMI7zCV/j2h5gPaiaoT0mkm0Xxqbufynmz6QfJL/2wfnXHjth3r4Xc
 Y+imv8wXdDETLSWRNi+j0ohiVH6kSAnjf2ZmnBZpnMX8ylsn+fyc0tRSvsuv83QuiCWBcEs7N7Y
 UBm2bQMZ5U3vlA8IR3g==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69df51d4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=nnliqRWUN49IhPuP2m4A:9
X-Proofpoint-GUID: 84bTD4kXYBW8sAXCeVe6z-nRW0kWFXvy
X-Proofpoint-ORIG-GUID: 84bTD4kXYBW8sAXCeVe6z-nRW0kWFXvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150080

We're not kvm.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/sie-arch.h | 2 +-
 lib/s390x/interrupt.c    | 4 ++--
 lib/s390x/sie-icpt.c     | 2 +-
 lib/s390x/sie-icpt.h     | 2 +-
 lib/s390x/sie.h          | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/s390x/asm/sie-arch.h b/lib/s390x/asm/sie-arch.h
index 4911c988..d9d5af81 100644
--- a/lib/s390x/asm/sie-arch.h
+++ b/lib/s390x/asm/sie-arch.h
@@ -29,7 +29,7 @@
 #define CPUSTAT_J          0x00000002
 #define CPUSTAT_P          0x00000001
 
-struct kvm_s390_sie_block {
+struct sie_control_block {
 	uint32_t 	cpuflags;		/* 0x0000 */
 	uint32_t : 1;			/* 0x0004 */
 	uint32_t 	prefix : 18;
diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index a75128b9..7e7371c1 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -227,7 +227,7 @@ static void print_storage_exception_information(void)
 
 static void print_int_regs(struct stack_frame_int *stack, bool sie)
 {
-	struct kvm_s390_sie_block *sblk;
+	struct sie_control_block *sblk;
 
 	printf("\n");
 	printf("%s\n", sie ? "Guest registers:" : "Host registers:");
@@ -240,7 +240,7 @@ static void print_int_regs(struct stack_frame_int *stack, bool sie)
 	       stack->grs0[6], stack->grs0[7], stack->grs0[8], stack->grs0[9]);
 
 	if (sie) {
-		sblk = (struct kvm_s390_sie_block *)stack->grs0[12];
+		sblk = (struct sie_control_block *)stack->grs0[12];
 		printf("%016lx %016lx %016lx %016lx\n",
 		       stack->grs0[10], stack->grs0[11], sblk->gg14, sblk->gg15);
 	} else {
diff --git a/lib/s390x/sie-icpt.c b/lib/s390x/sie-icpt.c
index 17064424..861dce02 100644
--- a/lib/s390x/sie-icpt.c
+++ b/lib/s390x/sie-icpt.c
@@ -7,7 +7,7 @@
 
 #include <sie-icpt.h>
 
-struct diag_itext sblk_ip_as_diag(struct kvm_s390_sie_block *sblk)
+struct diag_itext sblk_ip_as_diag(struct sie_control_block *sblk)
 {
 	union {
 		struct {
diff --git a/lib/s390x/sie-icpt.h b/lib/s390x/sie-icpt.h
index 604a7221..b1edf334 100644
--- a/lib/s390x/sie-icpt.h
+++ b/lib/s390x/sie-icpt.h
@@ -21,7 +21,7 @@ struct diag_itext {
 	uint64_t          : 16;
 };
 
-struct diag_itext sblk_ip_as_diag(struct kvm_s390_sie_block *sblk);
+struct diag_itext sblk_ip_as_diag(struct sie_control_block *sblk);
 
 /**
  * sie_is_diag_icpt() - Check if intercept is due to diagnose instruction
diff --git a/lib/s390x/sie.h b/lib/s390x/sie.h
index 3ec49ed0..b146e386 100644
--- a/lib/s390x/sie.h
+++ b/lib/s390x/sie.h
@@ -32,7 +32,7 @@ struct vm_save_area {
 };
 
 struct vm {
-	struct kvm_s390_sie_block *sblk;
+	struct sie_control_block *sblk;
 	struct vm_save_area save_area;
 	struct esca_block *sca;			/* System Control Area */
 	uint8_t *crycb;				/* Crypto Control Block */
@@ -46,7 +46,7 @@ extern void sie_entry(void);
 extern void sie_exit(void);
 extern void sie_entry_gregs(void);
 extern void sie_exit_gregs(void);
-extern void sie64a(struct kvm_s390_sie_block *sblk, struct vm_save_area *save_area);
+extern void sie64a(struct sie_control_block *sblk, struct vm_save_area *save_area);
 void sie(struct vm *vm);
 void sie_expect_validity(struct vm *vm);
 uint16_t sie_get_validity(struct vm *vm);
-- 
2.51.0

