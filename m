Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F473C1081;
	Thu,  1 Oct 2026 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850778; cv=none; b=LiGiUHzclMpN3z8nB8C1EBCWk4K4l4MO9sLoJDG89DY820HI+c6XOKLtEeaJnuN9gcYVUGZR+OkgqT5M832R2py/fk5iDBbNu/AnmWEHHNVfrUt0DiKECLGN29hgvWGfC/MBM5DtnGIPOyhOS4II2AMPNvh6MfArMmRaZRyeSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850778; c=relaxed/simple;
	bh=WkfFe6MMLUO5Sp7DTruNgOqS0qngh321wx3bCAi6u5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbsYaiGSE/1mGDR3nEN0F5IHAT8iwMvXs6POjGAU0/ZY30QYfggxaHGEnWvBeqH+XXuNhaEfRjUp1VUVpyXL/HVJwQrT5Ga7o04QY2TKVaIco1W5AIIs3q0+L+cbZkTqJyqAQi9NIFv9AH37yvEDFIRJ4RlbxnYWqvf/qTqwuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iBdGAMpX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iBdGAMpX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175uSw1119705;
	Thu, 1 Oct 2026 10:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CHNVikhCNEIrGSAyW
	gxfm61aAlJ+9isMAzKHzaaf+hg=; b=iBdGAMpXy6wOOvA8siJ0030E1GU2yDRwf
	QC2O2BsdWTsoBoa2yMq+IE3Q3iytiWrhMpMuHlAaBbt1ZU6VgQvlWGihZWsrQncG
	XUHwMMErBl1bg7kNil1Q0ATerQO0X0MlVzXqGVc2zyn6rtMl0NfaJBgVKdNsTkik
	esP2KgABrYBEKaGd5SVYp3ngeq4d/GpPiEpq2HA87NQQpJy37Iy3N2xN1VC0LnHN
	JpSupESnxdeAE6frFPFQOcP/2/Og0jwqNh4l8pQIe8myUO1NJ10GNpgXdywR+ACZ
	FF4PWViFJ+DDU1JNkXNmO2fyJdACGGVKzpBYRoXNx5Ch/MEYR6jGQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5jrag-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172W6X520707;
	Thu, 1 Oct 2026 10:32:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpga5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWmY942336718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8A4D20043;
	Thu,  1 Oct 2026 10:32:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89FDA2004B;
	Thu,  1 Oct 2026 10:32:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:48 +0000 (GMT)
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
Subject: [PATCH 02/32] s390/early: Fix early warning handling
Date: Thu,  1 Oct 2026 12:32:17 +0200
Message-ID: <20261001103247.1989111-3-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX0NJXRI0Rv4oo
 YJxxXtCbhtNIqI4X3fWoUSuVi13kd3SLA48B9MSU8RZTu/6uWAOq6Wdp3yb9xRCc8GuX5BSUj3s
 lbQLn1mq1ffMNqNb7PTcnTwK0D2HxSQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX/beetAuEBpXL
 bKiavfbCuEZQELXatnkgdR84A541AhF8127VjXn3tMYZLxQKrdXGpaa4+UadBkNxZSmLR/Tp+fB
 u1g4PvXB+egPCP/P7C8GLUZzMnYIzzwRSd2Nj+iLH9bwz6mJe4BD2szIGmo7w8djHjwNEJK7ZyS
 J9SOdP3kAStfHalLrqFRzWMI4B7y92+nqPJK4/kUP54FOxuEmap3ukzUcAF0a+2pOJ0DyLS6hzC
 2z0+tTQew7j9mPZhtaQvtWOvKDRwREu3bH0sYYPzMkFyKWMlLyE8gp8EP6mSDAs6Fs1kHewOrAk
 DV19aKOVSZTyuUfg8voREcpsXwZFXHteKA7/Q2s5apnskQLP6xUwODs/xBYYbXQRtiGaOqStoai
 HgT8UUo7+r5dMdMdddWSXpjXPuK7WsB6NfE1w9CXNGxYiV92UBHT51eyJm57yAPDvxjYzT4ii1U
 yQY6oej7eR8Q4iFW75g==
X-Proofpoint-GUID: tuV6EuP57UDqkx_QQcqWryTu_g0Be44S
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abe36d5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VxC_P-UtoQCekwcQ100A:9
X-Proofpoint-ORIG-GUID: tuV6EuP57UDqkx_QQcqWryTu_g0Be44S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

When adding support for __WARN_printf() the early program check handler was
not taken into account. Add the missing support to the early program check
handler. This avoids that the kernel crashes instead of printing a warning.

Fixes: 04dabb4261c3 ("s390/bug: Implement __WARN_printf()")
Fixes: 79996065cfa2 ("s390/bug: Skip __WARN_trap() in call traces")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/early.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index b27239c03d79..1fc153d8385b 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -153,16 +153,25 @@ static __init void setup_topology(void)
 void __init __do_early_pgm_check(struct pt_regs *regs)
 {
 	struct lowcore *lc = get_lowcore();
-	unsigned long ip;
 
 	regs->int_code = lc->pgm_int_code;
 	regs->int_parm_long = lc->trans_exc_code;
 	regs->last_break = lc->pgm_last_break;
-	ip = __rewind_psw(regs->psw, regs->int_code >> 16);
+	regs->monitor_code = lc->monitor_code;
 
 	/* Monitor Event? Might be a warning */
 	if ((regs->int_code & PGM_INT_CODE_MASK) == 0x40) {
-		if (report_bug(ip, regs) == BUG_TRAP_TYPE_WARN)
+		enum bug_trap_type btt;
+		unsigned long ip;
+
+		if (regs->monitor_code == MONCODE_BUG_ARG) {
+			regs->psw.addr = regs->gprs[14];
+			btt = report_bug_entry((struct bug_entry *)regs->gprs[2], regs);
+		} else {
+			ip = __rewind_psw(regs->psw, regs->int_code >> 16);
+			btt = report_bug(ip, regs);
+		}
+		if (btt == BUG_TRAP_TYPE_WARN)
 			return;
 	}
 	if (fixup_exception(regs))
-- 
2.53.0

