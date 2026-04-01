Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D6D47DFBE;
	Wed,  1 Apr 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065212; cv=none; b=ohwGMIXDc/Qv/SIMNGlL+Z0USSnQT51XSNYMildaoiazS0MRCZO6rLJFNS9fJ2s+pNa8dt6ladeDsVJU0KkFw9MLdbcmFq0aEkXKSyVH5ccyfBTP/CB6G3uIndzaV3YIS7H89RzAUafQznzhe5g6vA3Ydsm9qHqOq0rUeDriYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065212; c=relaxed/simple;
	bh=e/+5/qEEo63UXy1ywVmWm0yTTpZdsmFpd0m/57Ro5Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q17Z32XJBwC20gRy1Hi72BvBcJw9QG/D8nikSrWdUHD73VKcUeqdoccQLQ6e9yGyavP/DAi9Et+enCJogPnW0BidaKeEV0AqliHJ8kJZDyKM7QCdIP74GMrgGUfEtoxHV4gMEjpamsF4MpEqtWA8VokqARhp7LVM3wb+x9bX51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e80GWXQD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e80GWXQD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631B7P4w4078893;
	Wed, 1 Apr 2026 17:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZSGVAYAeoKV0OpUc8
	NfP2xhZ1pjTYesAxfT8FV5dGWM=; b=e80GWXQDDHaivsGm4V+giURVh2aH9upbC
	N/qLP9XG0TNoTp4B4YyPL+6U3hpwqO7WsUoWvG1f4KqWlU051RPeRuNt9nXf7eMY
	M2YzYaMJ3Tf/FtFLpiO133ICbxo3P8Qu5wggN0wdFI96CJpV1zkreIdhnrro5+Yc
	wTXkTN/io4wfh+3pXxSa8vNv/7dQ0M2A6bmcZm8Xf6a7InNz5PuruqUMsmH5fEoV
	K8s/adBoYYAr4ABpz93y8u1uUrgu93LPvyvhImGDaJZxK4yOl8UEtOm0Sz5IhQ2M
	GPoElBzOl8KubAF1zWyTg8hTlFPWB61YOnTioMhPqYuMNQfhUjGuA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q39e52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:40:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631F1WNo005947;
	Wed, 1 Apr 2026 17:40:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy6ubg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:40:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631Hdvnf43844024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 17:39:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B905720040;
	Wed,  1 Apr 2026 17:39:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1765420043;
	Wed,  1 Apr 2026 17:39:57 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.24.224])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 17:39:57 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 1/5] KVM: s390: Add some useful mask macros
Date: Wed,  1 Apr 2026 19:39:51 +0200
Message-ID: <20260401173955.314821-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401173955.314821-1-imbrenda@linux.ibm.com>
References: <20260401173955.314821-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W9c7cwAbKJJ1k-arHgoKWfQl30pXRZ9i
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cd5876 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Oh1pnlNaMCSVx7q4Av0A:9
X-Proofpoint-ORIG-GUID: W9c7cwAbKJJ1k-arHgoKWfQl30pXRZ9i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE2MiBTYWx0ZWRfX/3kJ5aTtpqvm
 slE2i3mF1R6TTcsLvRQl0aeOVXikCPhiV8Nn84rwph58CPw1akxIq76qurfA8IYoq1Wpw9DcVg7
 R/691zqKcjy/k5RR7MLXJoPqvpyrHPszuhGNrAW2QzTufP3XypgExtkwC5giaqRidXb5qywYjQ+
 UB2npVlxY6KgF/ybRElygbX7Tv+k/qBlptg9kvTjegfAK4BF2WGa8Qf39Yl56k948orA8mVoMdm
 MiW3SOu77bHLCZGdE073RkECV6l/JDiGfesOc0sxaYv9sXs1RdVMIwtfAteKcNx1Nn5D3cl9LSz
 mnnLNugGhTfGoEtU/iGbHLJTDhQ/zJP05ra8g+O2Y1l6Hl5V1C8k+nJ6bIJO9Ntq71Ciku+TmSg
 mLQG+ZODP+zAYiNkAoi6D/sHGvAKfTB92aKCcMo+ZJ2hAqzaiqupJYGvhzx+zDMQjw0FSe65hse
 gyo3IJD2e09hicjr7SA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010162

Add _{SEGMENT,REGION3}_FR_MASK, similar to _{SEGMENT,REGION3}_MASK, but
working on gfn/pfn instead of addresses. Use them in gaccess.c instead
of using the normal masks plus gpa_to_gfn().

Also add _PAGES_PER_{SEGMENT,REGION3} to make future code more readable.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.h     | 5 +++++
 arch/s390/kvm/gaccess.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index 123e11dcd70d..809cd7a8adb7 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -104,6 +104,11 @@ union pte {
 	} tok;
 };
 
+#define _SEGMENT_FR_MASK	(_SEGMENT_MASK >> PAGE_SHIFT)
+#define _REGION3_FR_MASK	(_REGION3_MASK >> PAGE_SHIFT)
+#define _PAGES_PER_SEGMENT	_PAGE_ENTRIES
+#define _PAGES_PER_REGION3	(_PAGES_PER_SEGMENT * _CRST_ENTRIES)
+
 /* Soft dirty, needed as macro for atomic operations on ptes */
 #define _PAGE_SD 0x002
 
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4630b2a067ea..a2ad11e2bf61 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1461,7 +1461,7 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 	lockdep_assert_held(&sg->kvm->mmu_lock);
 	lockdep_assert_held(&sg->parent->children_lock);
 
-	gfn = f->gfn & gpa_to_gfn(is_pmd(*table) ? _SEGMENT_MASK : _REGION3_MASK);
+	gfn = f->gfn & (is_pmd(*table) ? _SEGMENT_FR_MASK : _REGION3_FR_MASK);
 	scoped_guard(spinlock, &sg->host_to_rmap_lock)
 		rc = gmap_insert_rmap(sg, gfn, gpa_to_gfn(raddr), host->h.tt);
 	if (rc)
-- 
2.53.0

