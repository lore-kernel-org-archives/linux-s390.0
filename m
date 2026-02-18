Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3572233372B;
	Wed, 18 Feb 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424423; cv=none; b=dJZcZw92+ZhiPNKm6gC6tghrxn9S5azakXPhoW/nzahk8n6WBW2esj9e4PB4iwDUJtq3HStea63T2zp4MfkdVsVCd8E/bdjXXEKPPa3l8rnxjCQwgftQ4nkmCKg414RyZnYhgZLi+cMYFV1pJgbsg9Fyl/cTv/N2rIlK0zZ3QXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424423; c=relaxed/simple;
	bh=fdylgc7cPmNb6dp32O0Wt/EKQhM62YSOB21zcp6moCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=On1kVzkGSCeD8vfxq5oxEZrIkqHqw7U6ODWrhbF0+yFDbQfKNg4hhY4+RlzxDtSD3xxE2KXE8sqOLroLPlaJ1RewuwnnRXNHOtWpL/Dm9gqW/ncfL88L1MO4qp0xkqwL/iNU7GPGw4E0szQEzcodH+JBo007/9RCzj/SPCaQ3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=on4jb2XZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="on4jb2XZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I7xiLa3527333;
	Wed, 18 Feb 2026 14:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5+8vwqEQt32wTGT4C
	2XxuWjR9AsCRt1IZgG9BstDWCw=; b=on4jb2XZt1fK0qhjZk+AMKTCUAK0x8XZh
	0TG8qxJdyiUea73vVzIYCbJqSmt+lgbXXBroTIDKaIXcGTUPhWp8PKjhDCFbtg4n
	t6rwIXPw96FbKJUSijOmicr1Vzc2wUv1pjDp/xX6Hqo83lf252t09WUmuJNdEGNj
	LoYA2M8bOSHQAeFDE3HJbPnuJAZac++zsZsyIBPcBCleXcD27oNmJdBA8tkD4Sim
	q+bGWbN9Rof0rEjMSVPYuSFOsbAXWingL16NxJ1nuI7qMufzO3kEMNsohH8qp6Re
	RGu/nqgFh5HqWG/0vUKz/Wm8CQpwoHcTUJjH2y8YxVQQqGg+4XCsA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjgf3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IDZWvJ015846;
	Wed, 18 Feb 2026 14:20:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb4583dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IEKEvV15204758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 14:20:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DE2F2004B;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E06920043;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 6/9] s390/irq/idle: Remove psw bits early
Date: Wed, 18 Feb 2026 15:20:09 +0100
Message-ID: <20260218142012.863464-7-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218142012.863464-1-hca@linux.ibm.com>
References: <20260218142012.863464-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JbEqZMjVj7UpCedg6npI91aB1PN-nyQQ
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6995caa2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=eQc6JQ773LVZH5CQlr8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEyMCBTYWx0ZWRfXz13rJpevYK6n
 ugc+Iyk7MEY718fc2+4MaqU5mqFPUt/Z3sfTTBC88vjaRACOTfZclZJvRzEZ4poA8nIEDfjRnto
 yrUhNRp/dg95o4MYCp8O0azC/nTp9faSNj2LChApxwh7/sl3vjRJ9HTOLnwstGOh3JjXmgX7EPP
 MN+s8MPQ7T9SQ1+y7X9+Cli231YJK9fb+ld50ue5KTTU2CKfhZFKyH91yV50BecLvmkbNGrJh62
 Yv98E73eBWnoTRBF5P+CraHS2V6NaaZ/qkWo/+OEK6aXUmVtnAawblHVSXxsTQGloNA5jrE0Ava
 Ao7DFiyi26leWRoEob4jR/+v0DErahiWanyWRbp3WIxnniE/4MBLfcege7O5Ny/BRo26vJqer1W
 Pk3Oc1WCreEhaBYFcbx219yjysIT6ySJuhnaSgmTgMmDIKG7V9BeJsDNgVLUSo/Ga7Tj+0KmY/I
 VEXNr4JFreaBUrriSDg==
X-Proofpoint-GUID: JbEqZMjVj7UpCedg6npI91aB1PN-nyQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180120

Remove wait, io, external interrupt bits early in do_io_irq()/do_ext_irq()
when previous context was idle. This saves one conditional branch and is
closer to the original old assembly code.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/irq.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 080e9285b337..084919a04e04 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -147,8 +147,10 @@ void noinstr do_io_irq(struct pt_regs *regs)
 	bool from_idle;
 
 	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
-	if (from_idle)
+	if (from_idle) {
 		update_timer_idle();
+		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
+	}
 
 	irq_enter_rcu();
 
@@ -174,9 +176,6 @@ void noinstr do_io_irq(struct pt_regs *regs)
 
 	set_irq_regs(old_regs);
 	irqentry_exit(regs, state);
-
-	if (from_idle)
-		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
 }
 
 void noinstr do_ext_irq(struct pt_regs *regs)
@@ -186,8 +185,10 @@ void noinstr do_ext_irq(struct pt_regs *regs)
 	bool from_idle;
 
 	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
-	if (from_idle)
+	if (from_idle) {
 		update_timer_idle();
+		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
+	}
 
 	irq_enter_rcu();
 
@@ -209,9 +210,6 @@ void noinstr do_ext_irq(struct pt_regs *regs)
 	irq_exit_rcu();
 	set_irq_regs(old_regs);
 	irqentry_exit(regs, state);
-
-	if (from_idle)
-		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
 }
 
 static void show_msi_interrupt(struct seq_file *p, int irq)
-- 
2.51.0

