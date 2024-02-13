Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4224B28
	for <linux-s390@vger.kernel.org>; Tue, 13 Feb 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821271; cv=none; b=SZEWXNQ0jS/f0tXagjs3lrUP2glO7kAID4a5nNQzkbDTbK6aiphj/u5tevrBNhZs2kCCa3pTnCRTmMl3yNmmZj/3IsTvJkV+FEwgKNtU0DLQhX8XwY61SFeDCGL4avBFKCjHh1RrNA2TYOaVRtnnt+7KNVkHwHJrFEfKoumtCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821271; c=relaxed/simple;
	bh=1WIIQr8j17WJeXd/bhJU6t23K/ADlKEe6sBB/97wubc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SwJx5r2x7zf0vi/cTBP2stRp+fO0QFB6Sd9/rPkPLv0n4oH5QjMGw6q2/+76Y+OI24J9H/fe66kdGizYIP3+bG5vmkUwQjZLsjG/9Msnj4O3hdHIJAM0J1mPBfNjwTysJ/irRO4evTKBt+InTU/OuYvtLGz2q/2aAsf8Nv0vokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yyl5A2rX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yyl5A2rX"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DAHH8R028039;
	Tue, 13 Feb 2024 10:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TMehByRDUS8zuuN//bdhlSu5ZQ+RHou61kEr26Yxucc=;
 b=Yyl5A2rX14f1SGNYGh0HoN/q99mbcYkOD4BzUBhn48w3EHnvtf7N47atqmIJpvOkHI5z
 ch0WHuNVHw6bGNNiwlamxR54MHnkGhcYZXksNEaweUrMRLSQGCxVcJw9o8yVur5/Pr76
 EWxpbcLd7eaMBRtQmqLWyXHGNJUgSzRcLUqXUM4wdFPim6ZG2j+fCE3Mmnni1H1ofpFr
 TwZEalRxca+9csAj89MJf2r0P/2cwezktCKGTN2TNK7qaqdhVNjtbknBrhjOENSC9+dk
 /ddiwCfC6mPcb1P3SQDpZQuPpxpGei2CUNRXyjslZQP2EgXL4IVw2ycA/hSqwGOcIvxa jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86hm8r65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:41 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DAHvR2029557;
	Tue, 13 Feb 2024 10:47:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86hm8r5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:40 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41D8Zo7t016207;
	Tue, 13 Feb 2024 10:47:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymeq7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DAlY7r58523968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 10:47:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 647C52004D;
	Tue, 13 Feb 2024 10:47:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 212DC20040;
	Tue, 13 Feb 2024 10:47:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 10:47:34 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-s390@vger.kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
        agordeev@linux.ibm.com, sumanthk@linux.ibm.com
Subject: [PATCH 4/4] s390/kernel: vmlinux.lds.S: handle orphan .rela sections
Date: Tue, 13 Feb 2024 11:47:07 +0100
Message-Id: <20240213104707.673053-5-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240213104707.673053-1-sumanthk@linux.ibm.com>
References: <20240213104707.673053-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0ZCBSFzFudFpXaqr_VZFLYetO55SGozF
X-Proofpoint-ORIG-GUID: nrnOeXw_G-_lXJ1971tHh5do27VLKNzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 mlxlogscore=635
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130085

When kernel is built with CONFIG_LD_ORPHAN_WARN and -fno-PIE, there are
several warnings:

ld: warning: orphan section `.rela.iplt' from
`arch/s390/kernel/head64.o' being placed in section `.rela.dyn'
ld: warning: orphan section `.rela.head.text' from
`arch/s390/kernel/head64.o' being placed in section `.rela.dyn'
ld: warning: orphan section `.rela.init.text' from
`arch/s390/kernel/head64.o' being placed in section `.rela.dyn'
ld: warning: orphan section `.rela.rodata.cst8' from
`arch/s390/kernel/head64.o' being placed in section `.rela.dyn'

Orphan sections are sections that exist in an object file but don't have
a corresponding output section in the final executable. ld raises a
warning when it identifies such sections.

Eliminate the warning by placing all .rela orphan sections in .rela.dyn
and raise an error when size of .rela.dyn is greater than zero. i.e.
Dont just neglect orphan sections.

This is similar to adjustment performed in x86, where kernel is built
with -fno-PIE.
commit 5354e84598f2 ("x86/build: Add asserts for unwanted sections")

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/kernel/vmlinux.lds.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index cb052ce302bd..c6e534704304 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -280,6 +280,12 @@ SECTIONS
 		*(.igot .igot.plt)
 	}
 	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+#ifndef CONFIG_PIE_BUILD
+	.rela.dyn : {
+		*(.rela.*) *(.rela_*)
+	}
+	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
+#endif
 
 	/* Sections to be discarded */
 	DISCARDS
-- 
2.40.1

