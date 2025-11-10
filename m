Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ABA3346B5;
	Mon, 10 Nov 2025 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800892; cv=none; b=nqIb/4Mxfn3OdoOsIR0ZuqISMRnavJryt6/C8oO0Ivhu/A1+6uvbaMS1ewpccJ0Oj25XfEVBDkDABTlWkuNWk87QnHTsfkf7+pFGiuncCf0zslVzbRr4gTrcvNZtIk0FpQUSZrtJgYzS1tl1MUcH+4pWzjdcVJN9zfrRxI78/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800892; c=relaxed/simple;
	bh=j+MXff3jFcQZlDfhVIxlBAKtCRFuULUFPCwrAVYv/As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmdQFOuIcYtWqFqOBN8qHiidLsDXH2wFxB9iCjC4+LYOv4LS+WrXHNgcwYVG+qXj8mhk7RFW7fg1eS8qqIyKAFPnzptaI8NpNSTktrSMQ9iGKoduqxJ/vvZ/Prsn2RtJ9uAaKIPnJ5MlpmZ/epC4JglokE3MYYq9UiiPj/8KjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sjipPIb8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sjipPIb8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AADa9ho031615;
	Mon, 10 Nov 2025 18:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=T9VXU3+GCnB4U7Dbr
	xFzjN3emp641y6Qusg7d6mTvmg=; b=sjipPIb8KjfC3o6EYXp9tBq9YtoHoMVQE
	eRgeXxT+bbGIZSGo+fBRxII9Fn/+R7R/BIHGif+Q9RX7WI1RIN2mQ4eP+1/BM43f
	zyrtRyFcsIyQyCesuXjaqvsp3jOfg+8kXIf8S3AhhwOv7QQf3WsFQl9fWybEOvyw
	+UnWHNojluw3hYybk2YPmYZLh7GcGk/UBBYkVoYI/agHkyIiQ8fycPRXwetObW36
	gEuTHqUh1AZzCKvPfvImG/HJjG9VBCdZnMlRKdkJiAl9W7XaaBfBd+jM3915NKu8
	3ViVPGqqeO9F5GZ3spKRYvgHTypnXqiEE8+mbWNAcHr4qYnwSEW5A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk81qva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGcZte028880;
	Mon, 10 Nov 2025 18:54:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6s79g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AAIsgAc30278120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 18:54:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41CC620040;
	Mon, 10 Nov 2025 18:54:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DF6A2004E;
	Mon, 10 Nov 2025 18:54:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 18:54:42 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 7/8] s390/syscalls: Remove system call table pointer from thread_struct
Date: Mon, 10 Nov 2025 19:54:39 +0100
Message-ID: <20251110185440.2667511-8-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251110185440.2667511-1-hca@linux.ibm.com>
References: <20251110185440.2667511-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfXwq6NnPZtOqsw
 F1fWHrLocB1GCAqeZlGTXgxbUu6/MeqO+sv7p0v7i0pVeKm61NSM2Qqh6T6w+6U/jF1YKVD/H18
 XjC1LN0psCMm8OPzv6nwoyMOgmVNZ9v44xR28t568ddFG07DWXRWFMMOMD3EcCByI3wmvM+wAJE
 //QelTFwD0IqPvkxRXKV/miOtrIQDJTpU8U3fb6udRjI0yjsj3JAN+1kpSrQsWs/bSJpOkRqKtF
 +phjX8Y0sLkYQEOOCaw5gypyvLG/amayk7YGW3XS1RueX/e5U/2c3UH0zhVNiLjK0LsL+CMKuF0
 o4Q+Vw9pPaov4vjHpnL8uk+sqL7BAIDz2pdgQrj45psiAtoeLM/Cx2sdxTo0JCuM9erBSKobOzl
 O6ukWz0FeA8GIcXE5dGacI4vIwk75g==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=691234f6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=V2k90pc3cBmEGCY727kA:9
X-Proofpoint-ORIG-GUID: Kd8XnTsp4G3Dbz8SFI8hqB3tNfZf6pwh
X-Proofpoint-GUID: Kd8XnTsp4G3Dbz8SFI8hqB3tNfZf6pwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

With compat support gone there is only one system call table
left. Therefore remove the sys_call_table pointer from
thread_struct and use the sys_call_table directly.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/elf.h       | 1 -
 arch/s390/include/asm/processor.h | 1 -
 arch/s390/kernel/syscall.c        | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 2b6ab483b1ca..bb63fa4d20bb 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -217,7 +217,6 @@ extern char elf_platform[];
 do {								\
 	set_personality(PER_LINUX |				\
 		(current->personality & (~PER_MASK)));		\
-	current->thread.sys_call_table = sys_call_table;	\
 } while (0)
 
 /*
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index e3e3230aaf11..44d558fb8422 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -175,7 +175,6 @@ struct thread_struct {
 	unsigned long system_timer;		/* task cputime in kernel space */
 	unsigned long hardirq_timer;		/* task cputime in hardirq context */
 	unsigned long softirq_timer;		/* task cputime in softirq context */
-	const sys_call_ptr_t *sys_call_table;	/* system call table address */
 	union teid gmap_teid;			/* address and flags of last gmap fault */
 	unsigned int gmap_int_code;		/* int code of last gmap fault */
 	int ufpu_flags;				/* user fpu flags */
diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index 4fee74553ca2..3b7ea1ef468a 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -122,7 +122,7 @@ void noinstr __do_syscall(struct pt_regs *regs, int per_trap)
 		goto out;
 	regs->gprs[2] = -ENOSYS;
 	if (likely(nr < NR_syscalls))
-		regs->gprs[2] = current->thread.sys_call_table[nr](regs);
+		regs->gprs[2] = sys_call_table[nr](regs);
 out:
 	syscall_exit_to_user_mode(regs);
 }
-- 
2.48.1

