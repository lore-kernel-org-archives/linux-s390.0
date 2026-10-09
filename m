Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C14D37CB;
	Fri,  9 Oct 2026 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552372; cv=none; b=k4l6Bw3dCbwXx6ATabOEI1uh2fZlkns41zuAl4e87xb1OQxYCN80ROouoPlkKiTl2Jp8CYLx4CJWTrNUAoUVnnft2XUVWlkMR/RjS4a5mbE8stVxQD4m7ieMZqBVtzV8frGMNXKJUP/VtcmXnVv7aPmlE7XEAFoxe0oy+vwI6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552372; c=relaxed/simple;
	bh=ainA64ldmb5/1OlXR4cv4LvHs6nQ/IQeteCnZa36QfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qpGAIKDOgGsqcE7OTjrGM+hS3SLHd6g6buhkrVhXYqjRro5MTy0sduSA6hZQ+5zOujQ51s3hmcXwYMvoRvACNmuWUUNK6520T0pO/VbggvnYB5TNAdKOlMOMqWlt0m6LTR+JvlxMjdTtxyoMjO1atsTD/Yn5bfFmZZdZTiIuOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DPdg0Cp1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DPdg0Cp1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998Zukg3667263;
	Fri, 9 Oct 2026 13:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rJbOXT/U5y3P71DEwLdM+lne5wu5AE0NRsPzg+5Xy
	h8=; b=DPdg0Cp1Hopjl9rYuxJl6uWYYWxXvve99rnkGJyI0GOLLsZ0JaukKFTBy
	YwVf9vNZaa4LNnmDyHu9jL8wWkbCUMSkuMmtkzeJvhm3Mmq/VHvNsKSSUHCWEXaK
	fAEfmIXQ0+AvlvZ+tlkoZZIl88zuhsIeDAdniV4S/Ld7JK42lJLpn6GxecGnmMm0
	iIfm67oW12s1fGhLN0EyU2sWZP55ds2nEnh32CFazJXvmPsOybnzUd11B9E4L86O
	Aal07+h/r5DQW8H7cmmh0op94kFkAwXR+02vCvY4VH6O3qLLbl2uiGYT8f/GhASj
	+qe7C6WOWxhB8JnuQTKVOgL2GgvTg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjwa6c1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 13:26:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699D10AW621431;
	Fri, 9 Oct 2026 13:26:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnk5e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 13:26:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699DQ5G751249638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 13:26:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 417552004B;
	Fri,  9 Oct 2026 13:26:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F152920043;
	Fri,  9 Oct 2026 13:26:04 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 13:26:04 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/uprobes: Fix off-by-one bug in emulated PER handling
Date: Fri,  9 Oct 2026 15:26:04 +0200
Message-ID: <20261009132604.2434271-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1MiBTYWx0ZWRfX0H4fMpX/liKn
 Llgzl4caJR1qFpErhTIBl67rR5JiVK8FYXw/Gh1QECR8pjlCQrr/ugtvMTfOMnEERXpJfBPkUgB
 0t505W8OuASd9Sh3Z2o/PNb0lKP8ckE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1MiBTYWx0ZWRfX6W1mrqdMDulR
 LPlR0l000HxFRcmOR7yLyFdElVsAAOAHUCx1BJ7ckmYesQ1NQTXB52R8WQWkxmNdOa8kzyIzrIU
 jkS21y9+sksUZ3GrX/yU3x62PJm4ZkkeSZUPf2Z/Ct4FLIrK4GoOBUhRRzv6x7Wu36FfGJZFtD4
 ajWNBcgioYhX00txoeT6UnuZEwNr2Fxtq6Og+06jR9+Qq0v03A1uNvzaos+0LEnzHebrqHLIgiR
 BhMDGSVrENiGEzjeD3hGi9tiJ0rIv4by9i3tirYe9gKsqlNP5jPXYg52+S9EQ+h4WYgPsjyvqQN
 VBCWyeoamoeTPaoC+YUZl+JdHPmtRQkDmj5E5sH9aTOFoDUmt0L7sq9SH1xCYUxSrISEL8QaT4u
 zo7S6V3ajD9p3oUTNh5gFuQtQ67MluxEWuE3iPlfImQAVtlJkiheRWssxWY3J6dJA/dX4oEjXEk
 a8LLYYJVmduESGnPWHw==
X-Proofpoint-GUID: mpqWyPMI8581bSJww2oRNwLETn78fDAl
X-Proofpoint-ORIG-GUID: mpqWyPMI8581bSJww2oRNwLETn78fDAl
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac8eb71 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=XC33CQ3lbx3kdvIgZk0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090052

The uprobes code emulates some instructions, and with that also
PER storage-alteration handling, in case a debugger is attached.

The PER storage-alteration handling contains an off-by-one bug, which
may lead to PER traps which should not happen. Adjust the comparison
in sim_stor_event() to fix that.

Fixes: 8d1a2427d8fc ("s390/uprobes: fix user space PER events")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/uprobes.c b/arch/s390/kernel/uprobes.c
index c624f3361e43..b2b8a377ced6 100644
--- a/arch/s390/kernel/uprobes.c
+++ b/arch/s390/kernel/uprobes.c
@@ -241,7 +241,7 @@ static void sim_stor_event(struct pt_regs *regs, void *addr, int len)
 		return;
 	if (!(current->thread.per_user.control & PER_EVENT_STORE))
 		return;
-	if ((void *)current->thread.per_user.start > (addr + len))
+	if ((void *)current->thread.per_user.start > (addr + len - 1))
 		return;
 	if ((void *)current->thread.per_user.end < addr)
 		return;
-- 
2.53.0

