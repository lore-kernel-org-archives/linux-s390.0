Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B640B0F0
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796159; cv=none; b=GylYWAFbR5vyLHfPTVPCQq8X8Y89VxPYmPaCGjDIgSsrzylTmzPoOZFbRqthxKiEa6R4IKo4d6tBKmxJUVspRF35RKLqaa7ip8Sy9f8jTsGvp7l9k65+o5jhPbioV/F2iwg7tlVfrrtZ8xR3VsRD7PxUf9TrCaDOpugGghFLcN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796159; c=relaxed/simple;
	bh=vwNZd7hsnMhC6g8P/8uqcYqrETGyvRj8jw7km8n5taI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4rse9TlMTgL7OpXsvZ4VDYrtiEwDF55qP6gLs8bPc5Wc4+gJmZ2phNZsm0XWhSfE5vnTIa2TLWM1l5BlXkBQLHNDZyW4ZodGIl/UMedKvK1KGv9lT+Cr3kBIOCwphLOjSXlNUylwyD6m3B0OFFCFm9/f8EO189kIfwLGWahsJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=noZs+tkZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="noZs+tkZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N5C0MI192246
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 08:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=K22qWElETQlEv2ehpsCKle+l+QX06spbrRmD1FyI3
	54=; b=noZs+tkZr4Z1fdcGkKYnfJdJv3XLy2+o7mRCTQ4KC82+Ns79LC3cVEPHa
	pZWHgHufTz5ZnccKieHfLCoOSysLdWUVHsj6+Tc2K9YtPkkdCWSlD8s5E/Veck+H
	oPFlaFD+sbLeVauKRBn8pc32JOaPJlg/IVBgomEPf52hr0ehXA0SK/aBXlOM8pxU
	i438fVbRDrBttOLaQ0lKXquc2Y3el0DbxeYOPLVb6WIYSb5GeNMQDos/CT4zZOFI
	QYjIBjSdik+WfNlGmS3EbG3ClJRZf4SJmoFBd+cgXg/r28lJ61hAPcIijmMklL8y
	vKjAlIHPOSbHfBU2QqzQMlM0xkDJA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77apkv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 08:42:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N8YdCL025879
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 08:42:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyk275-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 08:42:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N8gWi315729098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 08:42:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D963201C0;
	Thu, 23 Jul 2026 08:42:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C10D201BF;
	Thu, 23 Jul 2026 08:42:32 +0000 (GMT)
Received: from t35lp84.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 08:42:31 +0000 (GMT)
From: Ciunas Bennett <ciunas@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, huschle@linux.ibm.com, svens@linux.ibm.com,
        Ciunas Bennett <ciunas@linux.ibm.com>
Subject: [PATCH] s390/spinlock: Add contention tracepoints to lock slowpath
Date: Thu, 23 Jul 2026 10:42:29 +0200
Message-ID: <20260723084229.923353-1-ciunas@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m_0kaYEHNydK6R0YmXWRqvlnW0trQYRI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4NiBTYWx0ZWRfX8kw79T23QoVL
 QrCebTxV7396a47oS67dIsETBF56zlPDsvIYW6WOwBV0TW0Y/2UDlzXYWKrrcnNzYeDulZQJvnm
 KdX4TgAiiaKu4ALQ8c0eRTFFnSLuWYY=
X-Proofpoint-GUID: m_0kaYEHNydK6R0YmXWRqvlnW0trQYRI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4NiBTYWx0ZWRfXwquuGDEO8rFq
 TsI5dQrG0v2mr072GZXOr7nleJ6B3CYct+lcAi6OYxScR0iQ8xefl+doLV5LwQ2qZO3aG9auPSc
 /lz73T93/rISc1sOLols6Q7mWJdJsBY2HdsfLjfV6zZ2rbwRS50wQYGRiCaWnHULJ3uqgrC196N
 RS6t7gcnUzNq+e5t2l4cbCZCXdXZmcTJ9FRysFFh5VaQNySE9XbNtR7RgYQJXKHMDpCpHnNIZkk
 1Y4dLm+TG4/68SXsLiao7+88I4GEslFRqF5ra8k9YffDW6A39zzPLoSfeGPxuz0InWAF/NC6URz
 l8+Dw06XLRs4SuMQHVcpeKBWC7LcCfsTJmG5pILXfBS76zxuIs6lG37P9vj+aKyyD62FXP8K1/8
 9xgQiwZRMpxKvHCVl5UhNUQoDPapXPBty3x/Ba8KnvfYzyqh/VFTQXbcliuyA3iER+wxi07YiXr
 KY2l9GoUXzsPKBjs9jg==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a61d3fd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=qSQXw63EB045wfeYdAwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230086

Instrument arch_spin_lock_wait() with trace_contention_begin() and
trace_contention_end().

These tracepoints are used by lock contention analysis tools such as
perf lock contention to identify contended locks and measure wait times.
Both the generic implementation and powerpc emit the same events from
their spinlock slow path.

Place the tracepoints in arch_spin_lock_wait(), which is only entered
when lock acquisition falls back to the contention path.

Signed-off-by: Ciunas Bennett <ciunas@linux.ibm.com>
---
 arch/s390/lib/spinlock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index 10db1e56a811..dbabca35c008 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -18,6 +18,7 @@
 #include <asm/alternative.h>
 #include <asm/machine.h>
 #include <asm/asm.h>
+#include <trace/events/lock.h>
 
 int spin_retry = -1;
 
@@ -281,10 +282,12 @@ static inline void arch_spin_lock_classic(arch_spinlock_t *lp)
 
 void arch_spin_lock_wait(arch_spinlock_t *lp)
 {
+	trace_contention_begin(lp, LCB_F_SPIN);
 	if (test_cpu_flag(CIF_DEDICATED_CPU))
 		arch_spin_lock_queued(lp);
 	else
 		arch_spin_lock_classic(lp);
+	trace_contention_end(lp, 0);
 }
 EXPORT_SYMBOL(arch_spin_lock_wait);
 

base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.54.0

