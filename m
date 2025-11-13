Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F12F49F5;
	Thu, 13 Nov 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046485; cv=none; b=Cpf4NaCSyyfnRFIVezZPEI8ZUEZXxTQkFJlIBc46hpNVToiW6ztBJbD3j/VJPLOjMlM2EQRKbDqy18g0BxiKjuyWwLl/3+TqtnDQs42YCT8jiwx1mSjgyH5XsD8Rn2zhmoypx8uqXk4nD7bAxNEKisYHZigacBwghdXDjQ205Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046485; c=relaxed/simple;
	bh=0im30e1UgCVmTrxD1wQq/K02RHQ4+MQn3xkoQrWduds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrftRvKyarwj8zsh6edLCNoxScWRSjEA65s3FZRDs4RYrSJOPYJ/uO+7zdgDe5uOyxW0fV03rqVuKipVMeoTSA87BfHPw39AAcVbihOdRbPSymnhTgaKXqfGK8w+kDcegSYeSHPh94akB9rsTorkJgD5Q5XP+M+ePgzFlDxaJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b5cOKXnT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b5cOKXnT"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD57TPG025879;
	Thu, 13 Nov 2025 15:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Kc4tW2clWOeVoSJ4c
	ied8xQVgj+1DDXWQidKk7slMoA=; b=b5cOKXnTRGyMUSp7IBJWbIglD8LiV7QPv
	XQYa6jw13E4fD8ro6M/NM9BKh9HqRXtuuLTmfDD5c8np6qX7mTv37K0z1sfmx6zk
	I1Dfr4kmw9nJj/xg+bqyi1VvxXpdjyynrGaJb2Mv7jHM21z+RQSewQ4qcRBTftwA
	DEilCPsnZ7FXBN75eobJB/+58kai50zys5cHwRrXRisNw9UnWTk7CRsoZlcuIemi
	RfUD/y7fAaykBVnDrttZyU4gDEYGP0/rJ+PNc/64ZsXNS+bD0Feg6OwU9Im60vsN
	8BoSQ5j6z0XtGmhUobi0LHY+uLNm2egNsYkk52wcWScsx01glinWQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8gnv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCoVII011431;
	Thu, 13 Nov 2025 15:07:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1p40p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADF7XvT58327404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 15:07:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1590120040;
	Thu, 13 Nov 2025 15:07:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEC052004D;
	Thu, 13 Nov 2025 15:07:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 15:07:32 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 7/8] s390/syscalls: Remove system call table pointer from thread_struct
Date: Thu, 13 Nov 2025 16:07:29 +0100
Message-ID: <20251113150731.2697279-8-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251113150731.2697279-1-hca@linux.ibm.com>
References: <20251113150731.2697279-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX2xNgm56KGa0L
 TGkOG98Hd67/LVKeI8D+W4N7AMnAhNVNmBfj7a2g8X9EwMF/CSaXKpGeeAcr8zleHp1ZMljwHDv
 m9mW8GYf1EBqDPHUg9ZyA2Ly2d+tbyIHtTjwqpkDMpylus081CTs43rMoH7bK/HzJIzwKIKLp1S
 XbI7JvUz3cMCysKjnKcvVP9bu4jNMM196QeTYUe8WMYIOoBIxJlKezQgq2BRBVFbb3FfFSN6q3M
 udbfcYQSv6ptka/KeBqhRDle05IVksyaktmM0hQNJkINULT9v0moJsZJGNnMJ1HgpNsok+iYInx
 NbYWoiSFmjfiFcre3CzZQzjv0tPotkQT/9QyihzeQNc3XAZeU1RvvWFgq2jyzdGoiXk/rlYBLuV
 e+ISqOGJzin7KiFXUrJ4WSCOMsbjSg==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6915f439 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=LYhLu_zrJ8Ea09b5hJ8A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: A9R3yBeo3T6DmJa4qJGDh6hkcRA8WnuM
X-Proofpoint-GUID: A9R3yBeo3T6DmJa4qJGDh6hkcRA8WnuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

With compat support gone there is only one system call table
left. Therefore remove the sys_call_table pointer from
thread_struct and use the sys_call_table directly.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
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

