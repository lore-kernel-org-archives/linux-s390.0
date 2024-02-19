Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEBA2E85A
	for <linux-s390@vger.kernel.org>; Mon, 19 Feb 2024 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349298; cv=none; b=dI2CrfqvjrqqnSe2zSMHI3VjYGyMHAWdpmrdBWm5vh4crlmEe4oArXcM1LDX+lHWCMxXhk5sD9Ovc3xDas8SP+/Ft/Ui+gkC+rgVubREqvoMXh42Wqz4cholxZiSX1DD3Qe9tim++TTBDki7+md7RRU+Yg3k+1E6h9wbjFmEw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349298; c=relaxed/simple;
	bh=3nzKQiVrfK9DjysDqKu2OZOGa1DQyG3DMhJQ4Eexgn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ihxJONNGueefKFI83XeUxspxIrs0mse1pUXGE2Hw1pRAQmVkDN0LpYPQLWAgMF8UNLusHHan/fdHgB4PKTZylDQN2+mwmf4ca+nPJcE67HAuJqkKgAr45icYGcDSF7UGiRa+PvHtaFjFhSjCxqvUUGTiS9sMHRAcwK1gM1HocOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fW715D71; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fW715D71"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JCs2RH004892;
	Mon, 19 Feb 2024 13:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s5aNOhGVmOl3JVVyXQ3eebMHLBZEGKDfv58exim1edM=;
 b=fW715D710OUKkNR5a8cqCaolEtCutyLLSId73hVS/L2UWg/9Ip5jDkUG+lbBdwN/kX99
 CnGvN+PeIeLIvGjnJYxyBIX7gTtN6xBqL8YchK0fdgGtENQlse2Q34LAkc97F+Sr3uTq
 vKQuxpNoMgY0THbGVzevBvyvbY1GjnUQE0E7NIlBG4b+z+N/0odhO8lnXTyHRxgWROW3
 TWaaUZi1aes5ooVIDJlfREM5xAfmOpD0a44tuDUTMCk0G39KMsLVsbWtSk1MM5hGELx7
 SWx61MwyZcJeHWnVoPYVuCKUaEH+SQizinUhmLHfqgtg+iVA8HbanEEtBjIrNf28k6Eo aA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc7d3gy1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:28:15 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JCvIkY013170;
	Mon, 19 Feb 2024 13:28:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc7d3gy07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:28:14 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JAtq6a009541;
	Mon, 19 Feb 2024 13:28:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p1dfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:28:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JDS6eG58524004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:28:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E76E20074;
	Mon, 19 Feb 2024 13:28:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 540F72004F;
	Mon, 19 Feb 2024 13:28:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 13:28:06 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-s390@vger.kernel.org, hca@linux.ibm.com, jpoimboe@kernel.org,
        joe.lawrence@redhat.com, gor@linux.ibm.com
Cc: iii@linux.ibm.com, agordeev@linux.ibm.com, sumanthk@linux.ibm.com
Subject: [PATCH v2 4/4] s390/kernel: vmlinux.lds.S: handle orphan .rela sections
Date: Mon, 19 Feb 2024 14:27:34 +0100
Message-Id: <20240219132734.22881-5-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240219132734.22881-1-sumanthk@linux.ibm.com>
References: <20240219132734.22881-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QWDk_vitsdcSuxrOrudlg3u7olp_SZQn
X-Proofpoint-GUID: QXKAq_RbZ72HgFSqpuFSlBkV2jPHjgWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=689
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190100

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

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/kernel/vmlinux.lds.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 222b06662e19..404883b1b023 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -277,6 +277,12 @@ SECTIONS
 		*(.plt) *(.plt.*) *(.iplt) *(.igot .igot.plt)
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

