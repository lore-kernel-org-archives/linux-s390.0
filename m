Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C641353A8E;
	Fri,  9 Oct 2026 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559299; cv=none; b=dFmSJx/CItaD8rfIPPMaj9E03P+xSoWWBcYsu5CLRj6DVFeF0D0lSFy607qcWGfBhSnM5iPnlMW7iLI8KTiUEZfj/AOD7uCfQDdV0enE9RBcANFhIoF9LCVWeGr28I9lDc+chk0BL3o96CkTPamLccdibJTlhUt0t8j8iWdp/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559299; c=relaxed/simple;
	bh=qakflVnkh52Wf4R3neUScQY64K86splzSnD6QGe2XHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZcKVMw+9B95ZP2sZ6/Uh/HDR6iEqT9KP6QSRI/CDkVs7uOjOfFKqpcYf5fp82+K6g8/VZX7DImuN6IbLpry6hby7yUqxd6Jkyt/PDtt3JxoYeGLjqh2VXASanjY/4WL+dh6QZSSCsU9UCRRw0BBY83v/p7grLzvHpI50Meeb46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iph+uhJw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iph+uhJw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DZa1u2626195;
	Fri, 9 Oct 2026 15:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EwGr985UyuDXjFf2Qu1ABu+OkUWiHLW/fsZ7wLvCt
	Y8=; b=iph+uhJwHiaz1Q6gUwe+4u2WAplJmP8WO8XLw0j59UDgSoEQOuHo/zPwt
	jqwfQzTlcssFRno3aT+q+WPsZfbbEFyNUpGXef95e+dfYzwCa72d0tvxsFaNqKqG
	A5vUyge5DL3oQdtPfyuk7bgHxST3o4/1BRyRu1jDdJPpRRedSC3bEktKsbRHY4j/
	ZI4gvxPzB6mnhJTe1y/NV0b0+2dDpUusgrhN9urYfxiXkzDHmabXFVEBBpMnliLr
	K4t6FFLWSzfB0CQsIRQWcs/3LdN8Pd2TZK4SY2Fl76IBLGtArjHyoXsSd9ujHNVw
	N6XPX1Si83nMU0h52fHai8ABrR/nA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjwbhj0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 15:21:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699DWV7g905720;
	Fri, 9 Oct 2026 15:21:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6udd1mpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 15:21:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699FLWrp50921884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 15:21:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A7F52004B;
	Fri,  9 Oct 2026 15:21:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3104820040;
	Fri,  9 Oct 2026 15:21:32 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 15:21:32 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/ptrace: Preserve ILC when updating system call number
Date: Fri,  9 Oct 2026 17:21:31 +0200
Message-ID: <20261009152132.1113325-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CVhNIozGDM5jc5KJnuM-822nYtM4z4Ya
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MCBTYWx0ZWRfX2vITO1ndF639
 eIwyUUuwKLQRMjYXIvYx5oAtDmRbtdIIsRGzrDmhdN/410KXEC92xkljfu9V1iMWGeA2bPLysr9
 i4MVXe4BSTTiJYvogOEoOy7qVUDIFubABwgjlrJppEPgNKk9D8MU9DmejV4qmIMXFjBUI4SL09Y
 8zGa8uDMDPsTMai0EYZIRfOzeLzzLXiVtsBtZff4Pr/cy2j8EL8ZgdpmOmSplBJovalMqqsvAt1
 HNouCis/TBserxKrG3vCWVoeGob96zYMP9Gpt7Z4ZVc+VxohNtbxkhQgXixYePvoX/7pp5NtTg2
 dLIaibWtQWYTWY7K20Vdpr8dpeWFbU9lxUBBuqOUZExHeekkjsV5rLmnxgsM4OjvSbSqqLCtQKK
 6qZLuX9JU9nwgIwM88vxGZJqnUor5aveGV5MrgZpeeVkP2d3GFvjp6z/nUWO0j77Xe4To4ubOsE
 7IltrAC1uZDjRPodg/g==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac90681 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Zl4J_rZvSzdUSzeGvkoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MCBTYWx0ZWRfXxUGrv+IrpgNB
 Jm6RIl/lIck9H4KeUnbdSmAr6xOP5rxnt6knfgVRzW34WM39b5W0mpCw0icDD44R3JCf6ZIQwLt
 ORtYem7ZIATsBlYyJswWQh8lDVzwnrc=
X-Proofpoint-ORIG-GUID: CVhNIozGDM5jc5KJnuM-822nYtM4z4Ya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090060

When an attached debugger changes gpr2 via PTRACE_POKEUSR while the
traced process has PIF_SYSCALL set, the int_code in pt_regs is also
updated. In case of an svc it contains the instruction length code
(ILC), as well as the system call number.

The ptrace code sets the ILC unconditionally to a value which matches the
svc instruction. However the svc instruction also may have been executed
via the execute or execute relative long instruction, which have a
different length. Therefore preserve the ILC and only change the system
call number using syscall_set_nr().

This makes sure that in case of a PSW rewind the instruction address
points to the correct instruction.

Fixes: 56e62a737028 ("s390: convert to generic entry")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/ptrace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 125ca4c4e30c..d8d5e843859c 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -34,6 +34,7 @@
 #include <asm/ptrace.h>
 #include <asm/rwonce.h>
 #include <asm/fpu.h>
+#include <asm/syscall.h>
 
 #include "entry.h"
 
@@ -345,11 +346,9 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
 				return -EINVAL;
 		}
 
-		if (test_pt_regs_flag(regs, PIF_SYSCALL) &&
-			addr == offsetof(struct user, regs.gprs[2])) {
-			struct pt_regs *regs = task_pt_regs(child);
-
-			regs->int_code = 0x20000 | (data & 0xffff);
+		if (addr == offsetof(struct user, regs.gprs[2])) {
+			if (test_pt_regs_flag(regs, PIF_SYSCALL))
+				syscall_set_nr(child, regs, data);
 		}
 		*(addr_t *)((addr_t) &regs->psw + addr) = data;
 	} else if (addr < offsetof(struct user, regs.orig_gpr2)) {
-- 
2.53.0

