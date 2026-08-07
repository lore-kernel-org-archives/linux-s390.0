Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F43F6C21;
	Fri,  7 Aug 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096677; cv=none; b=bAsUNLJKnD8NGzdkA4H01pAKh791LZoDR2RRNXH0TrW9dGB/Oyc3haUHu9/lOSMMbY631GeUAQkJL2y2vqHKF0A50Cxg6IF15sdqGUG5rPLfSLGcicv5xENzEq9nvqj1t75RPKukeBcebjDG4suneOy5KLHkFIFCJ7ir98A5TDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096677; c=relaxed/simple;
	bh=OYX5T7du9B8oAkGWWa6cKTEL/bSSwxFGIeQ+FZ/gyGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oiVSeuRnk2k5qLG2MXhgNzK/hh2MW84DWORnTpFOEVAWHJmqj6QyAIlMvMe1uyKooVgGQUlvqpWcysriOIUkaBMMBXd/d+ODJBHAXRQp/fVhI0xlCM5MpErIxPrTnC5ntMzFXWmx15IlTOtpwfI89hzqXcYanJoxqZQk4XBAhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VoFhWFhj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VoFhWFhj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HdhW4133707;
	Fri, 7 Aug 2026 09:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2hgCKk
	7nv5bD3an/v2ivMUiV5GUVjqhiRvqu6Jn4KuI=; b=VoFhWFhjo5rsHpJV0U09Cw
	R8ZJqwMJooILuWbKlW1aeix4xyJxUNqsQhHnFNwi7rCMh26NiSxduiaJAxIh4Jm3
	tNrJNMHXB0o/IZ2s0VhNF/5q0uHDt5ss9WTFB5LZ0/o2TWIEVL1Mo9vK38gYcJbE
	rRl2JdyOpE4/s6+gEd8tAIiXpOuxVaJK6za16KyM2HtB2SF1jvuYvqG1ZOersY0c
	/kZPQe751xC6I4MOuAE9jjQxvJr4TBwV7MchRpt5bFtF1FXbpgr1IJMcGHLw3ij+
	+/HzWETkYGsMQsEU/bH85uiSXzc/mG5MPYmeTXYBAlbtJocf0dFgCD9LgTyf6ZtQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy043a90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6779uNLu014582;
	Fri, 7 Aug 2026 09:57:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgpyw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6779vnma36766072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 09:57:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1645A2004B;
	Fri,  7 Aug 2026 09:57:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82AE620040;
	Fri,  7 Aug 2026 09:57:48 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.87.136.120])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 09:57:48 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 07 Aug 2026 11:57:47 +0200
Subject: [PATCH 6/6] KVM: s390: vsie: Create constant SCB_ALIGNMENT_SHIFT
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-vsie-cleanup-202607-v1-6-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2358;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=OYX5T7du9B8oAkGWWa6cKTEL/bSSwxFGIeQ+FZ/gyGM=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmlayRyOSb6Cn0webbM7LPOJ13+1JTVsnfaPH3u5008U
 Pz+fvPUjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACbCEsDwzyCg8an9D62qSwnb
 PgXuP2R5zKvJMvFnOPvljb0zTvbXxDH8j13zct5v/drgmL5uIc5jGpGHZ3V8u8JwpfpY+fGcvUd
 NGAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfXzboNLtJwDjbZ
 vTgHGONz1FCRcALmWVBQ/IwV5HWTUSpWBQwn0hDTrlbqLyijJ2Yhp9/rcoKmHtZ9B3I4aWREbAy
 as2G1FJ99MoWHWrnY7MNnd4xBcUNxgmCv5PWecGmfUkUqH+QsPWXZn5G2Z6xIXsWRPAD6WQC+l8
 ZdBVcvIyHav5Eed2zRE25gG4RdFmE7W8KVoe0BZFS6U4h82f78k2mar0Qxu+u3o1ZEZY2VQG5Hk
 yVu+LF6+jF0BVCIxMeD2jCM1FEOzMyhV9gq/hZRd6AIBZSvYsGsm9wVLoOndX1GSEI/eyTAJmEb
 FJsMZ26njwLaOUs3oq1RPmEOm276o70WgAqI/talRaPePbi40CTjHBhBrs9jCMdA3f61JYiJYp5
 y5I2o9olzu3wMTqezN/05ajpA1zyHEpkN3spTZSbLCTRfS6su42qtKzP8JxKWwpm2+VDmn9sK9F
 AFPI0uWW9b36pjL97hg==
X-Proofpoint-ORIG-GUID: HG2R5P19SEZDdOEAdgZOHjf83irkaNMa
X-Proofpoint-GUID: HG2R5P19SEZDdOEAdgZOHjf83irkaNMa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfX8pDwZSUrl0u9
 M5SKOIWDUGNMCakc6lKlwh5sbdw5FKFEq7wxcg7IDliUZB/J3ELTgOO2hf3D0HPbA5iavhaFVSF
 1hpQydH6tRvmj4NAf+3sG/5rKJag0rU=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75ac22 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Z7me16eTwNshJqsTfFoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070074

Create a simple constant for the SCB alignment shift.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_types.h | 2 ++
 arch/s390/kvm/vsie.c                   | 9 +++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_types.h
index 3f50942bdfe6..ac82dd09fce5 100644
--- a/arch/s390/include/asm/kvm_host_types.h
+++ b/arch/s390/include/asm/kvm_host_types.h
@@ -9,6 +9,8 @@
 #define KVM_S390_BSCA_CPU_SLOTS 64
 #define KVM_S390_ESCA_CPU_SLOTS 248
 
+#define SCB_ALIGNMENT_SHIFT 9
+
 #define SIGP_CTRL_C		0x80
 #define SIGP_CTRL_SCN_MASK	0x3f
 
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index c9392460edca..eb60a359d0aa 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1485,7 +1485,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	int nr_vcpus;
 
 	rcu_read_lock();
-	vsie_page = radix_tree_lookup(&kvm->arch.vsie.addr_to_page, addr >> 9);
+	vsie_page = radix_tree_lookup(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT);
 	rcu_read_unlock();
 	if (vsie_page) {
 		if (try_get_vsie_page(vsie_page)) {
@@ -1526,13 +1526,14 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 		}
 		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
-					  vsie_page->scb_gpa >> 9);
+					  vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
 	}
 	/* Mark it as invalid until it resides in the tree. */
 	vsie_page->scb_gpa = ULONG_MAX;
 
 	/* Double use of the same address or allocation failure. */
-	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, vsie_page)) {
+	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT,
+			      vsie_page)) {
 		put_vsie_page(vsie_page);
 		mutex_unlock(&kvm->arch.vsie.mutex);
 		return NULL;
@@ -1630,7 +1631,7 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 		/* free the radix tree entry */
 		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
-					  vsie_page->scb_gpa >> 9);
+					  vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
 		free_page((unsigned long)vsie_page);
 	}
 	kvm->arch.vsie.page_count = 0;

-- 
2.55.0

