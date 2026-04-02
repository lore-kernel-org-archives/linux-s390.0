Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F93EF0DD;
	Thu,  2 Apr 2026 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142108; cv=none; b=p1rB1lsWUAiLejTqtSnffq2CX3j3AJigktU7hzZzmedR0kSyV34G8zTutgA/TZJLq7HjyPIbDFFtYmjo9GTioTtu7J+QoPLl1qZhAan3aXnQAZSipuO4pq76OzA56tvY/NEthJNQdh4xoHS4ToxObUIf0gZcw/GarGt0IjaxTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142108; c=relaxed/simple;
	bh=e/+5/qEEo63UXy1ywVmWm0yTTpZdsmFpd0m/57Ro5Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+XxzwG3rqv737A2w2W4Usz4eiq0R7qSGF8UAHyn+LckRaGBeiE48Wiidvfz3o/OoNdM0d/D7C5kDTuGIRksbf19qkzF7DgslK5mHweD0Igf7CNhsJGn+Qz186psYEzUr0Z0hfiywzgd1IdL9Gs9gwdJ/i001fg3QdEyadey1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gSdnjz7Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gSdnjz7Y"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6321QLsM108580;
	Thu, 2 Apr 2026 15:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZSGVAYAeoKV0OpUc8
	NfP2xhZ1pjTYesAxfT8FV5dGWM=; b=gSdnjz7YSYtLspbE8hb3BR5mmdKFwhdFm
	l51KyAR2zhCfntKvCDmqJconwfFo2bN0AQuI0yvKxmMc4fqMHec6+CRoYLrs4wQZ
	tD2SJLNDWUlYIvXMiJfY22YJ8tCmR/KRNJr8pOqayQm54O0Cq6aq9MFRnPaL44jo
	vlSw2elC0/4cN5U3m0+9EdXRBjQpUFAnOPbjHd7Wf69jK726sU64kJEII8OTAQ2i
	HOlBlVrB5jo7qoeDsGha+X5m1dvlFZyCCSYpiWpDFb8kn0pLB6bkTqhjyBfJHCEP
	hCxL8DdIFnX3aBuJTa05NEkqOMGc9JSNPZiBWclTn6XZeHfpkPo2A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcmdkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632B7ara013987;
	Thu, 2 Apr 2026 15:01:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttktd1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632F1bS246531020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 15:01:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67B0620040;
	Thu,  2 Apr 2026 15:01:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5C5C20043;
	Thu,  2 Apr 2026 15:01:36 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.129.177])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 15:01:36 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 1/6] KVM: s390: Add some useful mask macros
Date: Thu,  2 Apr 2026 17:01:30 +0200
Message-ID: <20260402150135.196943-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402150135.196943-1-imbrenda@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ce84d8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Oh1pnlNaMCSVx7q4Av0A:9
X-Proofpoint-GUID: bhQnYI5Cbjjo7Egg56LwmWIPO22KM-vs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzMyBTYWx0ZWRfX3/+R2RbWy8J1
 gqbu5EA0hrg08OzjxIQIJ3W0QcWycHTt+zM4qguouKvJ8inmzA5hzcHWpSAZz/NI7R/p7dQhi2O
 GKJ3vo9WpfPY/h7BLzVT8LDfNMjCC/atK/UckPK9177O7h1KJicBtLWSE6YaGnfdb3vu3+GxPZl
 M2b/rMyZioguEKENKgKbv9I6uA4e250Y2WKOWtIhCI/BOE5zfqp7Nhs5UhJbCqiJ2pkFJVhgjBw
 WR17MakwIRKst4pylQc5N7qKAq4PVqTeWxz9Mx3BcLRWKUJMY4hm/C5vbS47RpejwaemkUwBA1i
 rEhUM7sd2Kw+NwdjidiMs+VI5+8HB3d1RR6aCXC/MDTSdrk3Q5a+KftPi6AmzfzRoe64hLapmod
 e2hnhlk/mDyQhZ0wj3JvtDvu+vPADDrUQlePn+G4jbH9RWsD7E8RCp4kQOGKR+GMmAvbQZKuBqB
 SsYI8Xl9/0ux2LO1Ndw==
X-Proofpoint-ORIG-GUID: bhQnYI5Cbjjo7Egg56LwmWIPO22KM-vs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020133

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

