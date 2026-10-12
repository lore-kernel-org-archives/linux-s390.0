Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EA3F326A;
	Mon, 12 Oct 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819242; cv=none; b=QjcrsUG8nvpljNXjwvmBalKKJUUMovt1dtZnnuTpiY23tF7U55aoJRA/toBQlR0lo++z2VeQ9BsK1uHzhISn9j9zaDxrKggbD+nW4LBUDgZB4quyvs3pog9Jmbe9W+w9Qy6RnERAqWBHN4E8W+lMVBG1C6L5EXdqT2gNRu43VGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819242; c=relaxed/simple;
	bh=NHXW19TfCNREfIZ4st116iB1wZ6dKSxU0juhsOvXjxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=swENs86m/JyNLEa749JaF12cgPNXPBkp+03UlLurCMJzURp8wDRdXfLLK8qw7jlK8yRyofu9mxzYOTuNrLDTMTzCkKHqr3UyPoGUKxt7/W602dK7BL5kggQsrSv3ktI1R2WoVi9Mo3cnWQZdIEQD4tj4EhFehJ8vBAlhBnNMu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H4K4En8e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H4K4En8e"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEIfs231290;
	Mon, 12 Oct 2026 15:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ll4bhSX7ftAssgkAyHLTRohfguoFqydvc4xSKpMeu
	fA=; b=H4K4En8ek1c1rEQqj8tGjtngOFvEdUHaf9s8jICWwuELlzwPbZl5bybM9
	K8Dzl/mYXyerzulSqbDA1Ha1y2zsPAjsGBjT0jSmlV6iRiRMEnVtvO59HDWKkUFT
	0TXH6juINKsV/mo7VjRnqqyqIARe/sAWjSibojLOhvu+nqzqMtPIIdaCPqVnl2bU
	uY+Gtj8rgy2OIGp1oUwkNcsBbJolA7ZbeZtAmBl57sHhmmGTTqoXiOdQKyC3XT6J
	7xRdSDv37j4YPkoOWla+wm0zXx6sZ8AWRlRabyzuoTkVPF/sD2x9yd3i34O27VAP
	+xQVeWUUb0XfPbxrlUQP0UW/H6F/w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w19wh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:34:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC57B41287213;
	Mon, 12 Oct 2026 15:33:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gwqrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:33:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CFXtxg48431610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:33:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2B552004B;
	Mon, 12 Oct 2026 15:33:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77B6D20043;
	Mon, 12 Oct 2026 15:33:55 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 15:33:55 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/signal: Fix incorrect return address in signal frame
Date: Mon, 12 Oct 2026 17:33:55 +0200
Message-ID: <20261012153355.1529314-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX2cL4/oUxmE6W
 oQPJe42xGkni2WMe21lAq8o5F8xjh8yipvsMsp68xo5OVCjnabLnDRj0LfAw3nAUZ7MVuEAVZvL
 /YVF59iicmfBpqfZ52deS+81dihI24U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX9Kds54ShZXOF
 FBl30ky8QPQGVU3zRS1Gnj5TI1/FXd4oRH4EmCcz5Oy8L3ifQ20gLcm9CaMRYG0c7ZEqCHE8StF
 r0cl/NS5o0f52N+24tTJPIq4JsMNKx789KI/N8aAz+Dcb1k7+NSbitEAMJQ1UVXFmYoQKCVkljT
 DCskzmH1nJYuXIOKnVk1dqdU64noxjkqlAi7otI9VQOEyCj7brnbC5aON9eyucbmA2CupJuLyjK
 rPT0c+hUTwcGXGF3lHj36of9PzzfUIMUJ2v3BYkxTOGGxOeLpmCfmFPOJzAbRlxGuJ0W6m3QJiR
 Eg03gYTMjnOzbes+rrznxJZNafp6WkbzwXrST7EhWkaZtb35Q7l836pcQwSpJeJ5DPIEXl7VcnC
 NG6yfTmtglyToUD9Hd8GL5veqM+JXB0c6qid83LPcma0Ot2CHWM+gFq3OrHPI6mTq37VtVgiaw7
 HApKHKmJZ8D560ZN/6A==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6accfde8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=s2RLOPMWBR7UFyH-IBIA:9
X-Proofpoint-ORIG-GUID: HnFL9lQSMsZDMg4yY3WXh_MdK2tJ-qO_
X-Proofpoint-GUID: HnFL9lQSMsZDMg4yY3WXh_MdK2tJ-qO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120060

exit_to_user_mode_loop() can call arch_do_signal_or_restart() multiple
times when signals are pending.

If the first call set up a vDSO system call restart by saving the real
user return address and adjusting psw.addr so it points to the vDSO stub,
a second call builds the signal frame with the wrong return address.

Restore psw.addr from arch_data before building the signal frame.

Fixes: df29a7440c4b ("s390/signal: switch to using vdso for sigreturn and syscall restart")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/signal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 4874de5edea0..25781d4a0ad0 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -475,7 +475,10 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 		}
 		/* No longer in a system call */
 		clear_pt_regs_flag(regs, PIF_SYSCALL);
-
+		if (!(current->restart_block.arch_data & 1)) {
+			regs->psw.addr = current->restart_block.arch_data;
+			current->restart_block.arch_data = 1;
+		}
 		rseq_signal_deliver(&ksig, regs);
 		handle_signal(&ksig, oldset, regs);
 		return;
-- 
2.53.0

