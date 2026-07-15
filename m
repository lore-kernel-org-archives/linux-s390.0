Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000162EEE65;
	Wed, 15 Jul 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122760; cv=none; b=NlzvdvCGYSF8QrSEl8qL51nZYsADmGlmRnWc39z5+mfrrGjiDWjYR5rAP/kS6WoFqCzCgOL3LERVsOReuzH1vORdzSHcDPdk7bOvyjG2kHPCsVD/+PKPRKbEkNQEyjRs/t2TUzk4EGkoLv3kwoXfsYXevlUl+xsTgVS4NWoOIm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122760; c=relaxed/simple;
	bh=eTnWb2eDSifwmF5oVOEoWutaj8feNd4j6WJHJ5zMqLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiAnpgda4Qhd4234SlQpwKVy5A1K4JOd8SvTZfJLCmc5Ojvhw1ychQFRoFouqIUEsk6IbQfZoNXjUo+4Qr21RBG6eio/adRgaYeySdgpoVdEmAHOZ9r300Z9VFeW7qmtq3bk6yPHoyslQR4Ssahaomq2I2MdAfZMp1/fOGADopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CAoX5i2z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CAoX5i2z"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBfrQW4187109;
	Wed, 15 Jul 2026 13:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XhoKi28UzkF/HK9tV
	8YKRbyE8PCL4HWBPf1RzVN7b9U=; b=CAoX5i2z9y3vMCsQqvs2IYjt8SjC6vi+k
	STGruYKVjVhZI46zJFOK2HLjEKQSniS1cjGIR2l/Pn/jyWfRd0CxaMyGjFDFymQX
	OHIiRLAjxSnyi6DW6HFGCANDPOkvqU5dakDdURCkwFGa4N6T3TMf92sBWu48baR0
	daL7sri0LssdNOFIO0OmZDAN25j5nai6rGLZK2akQihKAk/0qS6i3OWyyt26wKtI
	PnwzW3r5oAwcP5OqeQnQW2nE7EMJ7mn80dXsLgliCAfHdutWd2z+iv4UtYETzyBK
	RlBFa2OvZ9YW8PaE635G82XzwEJ2Prpd7lxUSWZoy2cnhQBJX5CXw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2ab6v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:39:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FDYb0n022222;
	Wed, 15 Jul 2026 13:39:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k07r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:39:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FDd1fm56361432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 13:39:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5284B2004B;
	Wed, 15 Jul 2026 13:39:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24DC820043;
	Wed, 15 Jul 2026 13:39:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 15 Jul 2026 13:39:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 085A1160E78; Wed, 15 Jul 2026 15:39:01 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] s390/syscall: Keep syscall return in extra ptregs member
Date: Wed, 15 Jul 2026 15:38:29 +0200
Message-ID: <20260715133830.2619853-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715133830.2619853-1-svens@linux.ibm.com>
References: <20260715133830.2619853-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzMSBTYWx0ZWRfX/YShqtp/BVWJ
 hY/Jv9yGoFlsL5723HcYKNUtkgC8JEaSqnmaBq377wMdnPjqr81s/lFekuwpWUsuSEuxcP07sW+
 MQQO1tEV3qgcVJIt47aPJZo06Sa/ugQ=
X-Proofpoint-GUID: CFg0j6CVz85h45cJpGzw4RlO0mugv5Kj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzMSBTYWx0ZWRfXwLS+aZs0hRG2
 MGQcyt6T3ArH7tWgVrb9L9soLlskoWUiRWdW1kmdNh7GnJGWREwNFBUUsESeRJhXarsbsI3/x1o
 OQiPV1G777wb+jzfepZd+FAU45s/cWn5ZMglKbOi7X6EuKO2OYMlvWpxNsxBpywP84qQdDzAwBA
 BCho6wV+Ko6ezwTCBJnjiuW6XG0x9BaFl9fk38RieHSxyNcbrYuBDj57SlQSg26opg7LFFDAsvt
 Yr2/LU8dljRZswTcOnRqR4ss13paRjxJMOcrB5vr9W9+ZBmNGVBzChaGJMt225Nvfwde7ruwOLR
 camFtuKJMEHWaTM71JHpQS6Hqfaa965W3Vqkrv2z4MhBX57fw+HdpIasMBGFxk1UVX/u5LmO6EP
 3iLVnq7BDq8AQf0F0NkYgV+McQ5tz5ga3CxGfEE4Upg5yTgd6vutOGzDaMC+eRGgu1bzwZgEFlJ
 eS8o65+LWSbDjJFcKqg==
X-Proofpoint-ORIG-GUID: CFg0j6CVz85h45cJpGzw4RlO0mugv5Kj
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a578d7a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=WsHKUha7AAAA:8 a=JfrnYn6hAAAA:8
 a=VnNF1IyMAAAA:8 a=aa-VIHj2BZ5_-WwWKUkA:9 a=H4LAKuo8djmI0KOkngUh:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150131

On s390, both syscall number and return value share ptregs::gprs[2].
Before executing the syscall, gpr[2] contains the syscall number,
and after execution it gets the return value assigned.

This is problematic with tracing: When either seccomp or ptrace set
a return value and the syscall number to -1 to skip the syscall, the
return value will be overwritten. If the return value is positive,
it's impossible to determine that the syscall should be skipped.

During conversion to generic entry a PIF_SYSCALL_RET_SET flag was
introduced which is set when syscall_set_return_value() is executed.

Peter Zijlstra proposed in [1] to introduce a new member in ptregs
which keeps the return value and copy this to ptregs::gprs[2] before
exit to userspace instead.

To avoid increasing ptregs size add it to the union which contains
int_parm_long and struct tpi_info as these members are not used during
syscalls.

[1] https://lore.kernel.org/all/20260703105718.GO751831@noisy.programming=
.kicks-ass.net/

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/include/asm/ptrace.h  |  9 ++++++---
 arch/s390/include/asm/syscall.h |  5 ++---
 arch/s390/kernel/syscall.c      | 15 +++------------
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrac=
e.h
index 495e310c3d6d..f39b349da9a7 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -15,9 +15,8 @@
=20
 #define PIF_SYSCALL			0	/* inside a system call */
 #define PIF_PSW_ADDR_ADJUSTED		1	/* psw address has been adjusted */
-#define PIF_SYSCALL_RET_SET		2	/* return value was set via ptrace */
-#define PIF_GUEST_FAULT			3	/* indicates program check in sie64a */
-#define PIF_FTRACE_FULL_REGS		4	/* all register contents valid (ftrace) =
*/
+#define PIF_GUEST_FAULT			2	/* indicates program check in sie64a */
+#define PIF_FTRACE_FULL_REGS		3	/* all register contents valid (ftrace) =
*/
=20
 #define _PIF_SYSCALL			BIT(PIF_SYSCALL)
 #define _PIF_ADDR_PSW_ADJUSTED		BIT(PIF_PSW_ADDR_ADJUSTED)
@@ -130,6 +129,10 @@ struct pt_regs {
 			unsigned int int_parm;
 			unsigned long int_parm_long;
 		};
+		struct {
+			unsigned long __unused;
+			unsigned long syscall_ret;
+		};
 		struct tpi_info tpi_info;
 	};
 	unsigned long flags;
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/sysc=
all.h
index 4271e4169f45..22b6ed20a9ae 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -52,15 +52,14 @@ static inline long syscall_get_error(struct task_stru=
ct *task,
 static inline long syscall_get_return_value(struct task_struct *task,
 					    struct pt_regs *regs)
 {
-	return regs->gprs[2];
+	return regs->syscall_ret;
 }
=20
 static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	set_pt_regs_flag(regs, PIF_SYSCALL_RET_SET);
-	regs->gprs[2] =3D error ? error : val;
+	regs->syscall_ret =3D error ? error : val;
 }
=20
 static inline void syscall_get_arguments(struct task_struct *task,
diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index 75d5a3cab14e..ce244dceec6d 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -117,25 +117,16 @@ void noinstr __do_syscall(struct pt_regs *regs, int=
 per_trap)
 		regs->int_code |=3D nr;
 	}
 	regs->gprs[2] =3D nr;
+	regs->syscall_ret =3D -ENOSYS;
 	if (nr =3D=3D __NR_restart_syscall && !(current->restart_block.arch_dat=
a & 1)) {
 		regs->psw.addr =3D current->restart_block.arch_data;
 		current->restart_block.arch_data =3D 1;
 	}
 	nr =3D syscall_enter_from_user_mode_work(regs, nr);
-	/*
-	 * In the s390 ptrace ABI, both the syscall number and the return value
-	 * use gpr2. However, userspace puts the syscall number either in the
-	 * svc instruction itself, or uses gpr1. To make at least skipping sysc=
alls
-	 * work, the ptrace code sets PIF_SYSCALL_RET_SET, which is checked her=
e
-	 * and if set, the syscall will be skipped.
-	 */
-	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET)))
-		goto out;
-	regs->gprs[2] =3D -ENOSYS;
 	if (likely(nr < NR_syscalls)) {
 		nr =3D array_index_nospec(nr, NR_syscalls);
-		regs->gprs[2] =3D sys_call_table[nr](regs);
+		regs->syscall_ret =3D sys_call_table[nr](regs);
 	}
-out:
+	regs->gprs[2] =3D regs->syscall_ret;
 	syscall_exit_to_user_mode(regs);
 }
--=20
2.53.0

