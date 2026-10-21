Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587634;
	b=BtX2TsJKeivE7ukHvWaHxKluilMTaCMPNHY/yeUtzUi4NyquaE4nseqL6PP5TLRAwiLt
	 2GNSqWEmFDGQVZmrkjCDcbJcG77whC8RF2vcI3ihsAia1VVaFihZ6J20jbQOEuyWz7wco
	 uFEVJlg8l4fMwaQsvjCGJl6auyTXZ2a8nbf2CzfAzEieAdGyPu9cwiij3j+ECWWBiwb4D
	 8Xqaw7fDT4KrsWQ0psx6nZEEbef/qiK9dyhPr2ttX/Sobk4bBEMTTs6SEWn6pW3tPMZ2U
	 QzzusDApQ0Vppk+rNnwG+YP3Ina3AkmnJ1h8MAGH3RyauTNXYAGNRe0LjVNNPIMeFLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587634;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rHjaZRWoDqZfL1B/WVCh5qFm2xeIH11ASh6m0wHP0LM=;
	b=OZ2x4kJHZZKc72BtY9Bs+YPTQqGgjBQl71/fqw6DjKByNIzpyH7IvRVuXghnAE7vVyKb
	 f/ILtZe91p2ReCX/fIchMOwikeBYiN51OdPiXRd6qjo6tzKjtoYS8JNMI3cLbDyEfyArv
	 /7xq+0QMIztAepngrMIkfOSaz/96RF5T5CACrwGgOjanM2BGgzjrZODlNnPpG+FVYyixM
	 MV4Y7bS6wRDsrykB7bmzsXv3d9bEFNDlQN+D5XEzQl5lQkcnVoN4Z6dLpDKgxTx72t1EX
	 Uhzatt6v2ZkMKX2T18l9BjSBzcnNE9zt8FXg5N0DHBUYrvRjOnslLfyN/cMGlnlR/Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jaQU28wK;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21930606A319;
	Wed, 21 Oct 2026 13:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21930606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jaQU28wK
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBiXS91092544;
	Wed, 21 Oct 2026 12:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rHjaZRWoDqZfL1B/WVCh5qFm2xeIH11ASh6m0wHP0
	LM=; b=jaQU28wKH9AkbkSAjShUx8Noz6SUHCtzRY/T8d+4GhZK2eMqMsLB1xLFr
	M9U8GLLuADr5i8SPnUDUoEl0+mpK4I4laaCoyZ0FgsMP47Ut8kCspO9bjFShc3gB
	5DAUrY7deaealu34JsJYs6F+heK1PickyPPIPmCzV1Gts1jtuzRPaIpqZXxUljKV
	gLtbQ7K5lpQxywnKhwbC810qq1kWWwMV6JeffVcW52UO3rnJ0YhsyLy0RtLel1ci
	Lr1yvVVIgmFvaIywVumkGe9SvOyD3Q7K79HOCfyCe6uT1CV7oIJhWBI/Mj0/pyAF
	Ckgs8ruitIHjsyBEGv6fKuCPvzrSg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a0t9c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 12:59:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBntpB3044442;
	Wed, 21 Oct 2026 12:59:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he6gqde75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 12:59:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69LCxCHe47513862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 12:59:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36CF62005A;
	Wed, 21 Oct 2026 12:59:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 135682004D;
	Wed, 21 Oct 2026 12:59:12 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Oct 2026 12:59:12 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Dmitry V . Levin" <ldv@strace.io>, Renzo Davoli <renzo@cs.unibo.it>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH] s390/syscall: Sign extend system call number retrieved via syscall_get_nr()
Date: Wed, 21 Oct 2026 14:59:11 +0200
Message-ID: <20261021125911.1550331-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MCBTYWx0ZWRfXxxFA8w3xOy5q
 BOciB3/5p/JD7spVHgzNZuNWl4UZJYqwgeUpAXWgCIhh2CRRJ2fIvMUK1xS+hLNOiwKhmguu+Iz
 YJeXVkseQmvib7DeZDTszVBqkZ0hWHfHFxQOtpa0DsLBt2g5K7he80ZyoEQYHv9xuJb5RwP2a58
 ufMsLvU+cktuZyaYWnhQHLKrUtdVhT/RLcZ8jDNEz4RzmQqVucbO64HqpsIrqYKvtH9PS8gOFGn
 kFCwbgX3vpg3PnB4ppKjdiU5wDd6jdW9XIOnkOSnzGgSqciPLukN6hPyswxVdTG3XToZ2h+HBBW
 mPRUDWFa7NhpcyRoGshHYlkBxw9eKeouDX4P7hzAvbOUaaWhEDP7KXbUHaO8JthsdpSjvES/koA
 JHV2rRVHMCLeMWvX+nGmPN5i39v2qLsyqN6lSMjq3iXVAWEZAQCql+WZp9dTMECE9SnmAPT75gw
 wV3LKcMTjJlkct7aNQg==
X-Proofpoint-ORIG-GUID: FiMhRsIxayww1GfQUnZHMQbvdkXSZG7N
X-Proofpoint-GUID: FiMhRsIxayww1GfQUnZHMQbvdkXSZG7N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MCBTYWx0ZWRfXwDS9YT9Uebra
 2cA2xbNOzbhBacjQ+TPvZh096CJbwztpEMLjYkYT1tjPeijhQY54ahFvZSwQMQtnUYbgUU/G+G7
 KyucodkXwNJP4anEgDBi4FdXf0MB5TE=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad8b725 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=b7FEdbnEW2k4qxqQiRAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210050

s390 is the only architecture which supports only 16 bits for the
system call number. Furthermore the system call number returned via
syscall_get_nr() is not sign extended.

This makes s390 also special: if -1 is passed to syscall_set_nr(), and then
syscall_get_nr() is used to retrieve the system call number, the returned
number is 65535 instead of -1, like on all other architectures.

Address this by handling the 16 bit system call number as signed value,
like on all other architectures. This reduces the maximum system call
number to 32767 for s390, but that shouldn't be a problem.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/syscall.h                   | 2 +-
 tools/testing/selftests/ptrace/set_syscall_info.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index 5f310caad1fc..c67eeca3f33a 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -20,7 +20,7 @@ static inline long syscall_get_nr(struct task_struct *task,
 				  struct pt_regs *regs)
 {
 	return test_pt_regs_flag(regs, PIF_SYSCALL) ?
-		(regs->int_code & 0xffff) : -1;
+		(s16)(regs->int_code & 0xffff) : -1;
 }
 
 static inline void syscall_set_nr(struct task_struct *task,
diff --git a/tools/testing/selftests/ptrace/set_syscall_info.c b/tools/testing/selftests/ptrace/set_syscall_info.c
index 1cc411a41cd6..2c5fab4a4c41 100644
--- a/tools/testing/selftests/ptrace/set_syscall_info.c
+++ b/tools/testing/selftests/ptrace/set_syscall_info.c
@@ -72,10 +72,6 @@ check_psi_entry(struct __test_metadata *_metadata,
 {
 	unsigned int i;
 	int exp_nr = exp_entry->nr;
-#if defined __s390__ || defined __s390x__
-	/* s390 is the only architecture that has 16-bit syscall numbers */
-	exp_nr &= 0xffff;
-#endif
 
 	ASSERT_EQ(PTRACE_SYSCALL_INFO_ENTRY, info->op) {
 		LOG_KILL_TRACEE("%s: entry stop mismatch", text);
-- 
2.53.0

