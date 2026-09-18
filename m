Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D764FECD9;
	Fri, 18 Sep 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744180; cv=none; b=bJkYqrvY5th/TNKCWaj56GHnchVIV/sSTXTXD8/JZ5v4s5Lp5DZKamTZXzzVpfX7v+89Pm/8tmWFePH5OMmY9Le++L2E5lG/n6+Fv+yHsjDEdYaEJ8y7CDyglJPGYlhqDJm0NxGHUX4L1sXILqjgXAulh5T7Yr3vcxXN6iI7/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744180; c=relaxed/simple;
	bh=GGMbtyEuxzIWuM9bBkuwnluaQBjqdO1ctV3RbbWb7OQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3lP7V2x2vueSihk31RV2Rs3dFZdNZmQzdl8XXNgc8SxdC3nrrZu4LyDsqatksi6snth/+bcJtUJgMCk8o/O03bCzady285fOKCvDtf9iyZcm8n1H/BytNyEejyjYNdgImVT7ALdDlEDfScvLMqI5GqEGPnfrtjfmKr1Cr0LWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LqnLirlj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LqnLirlj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVYHq1235759;
	Fri, 18 Sep 2026 15:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MT+Rbw
	P/QlHzq7dx/FEVabIZ9enBy18WWWj/Tnk6Gj8=; b=LqnLirljNNlGCXKancCxJn
	9SNAASjFEDJ2GT6ClEsbkbMYI4H0GYY6z+qloAq0X02AXfD0u548odsNgwAMyOvB
	WMNMY/cxrtXkyQ4ZsAzE/qxMcKqpTaqCMGKzYw2HqQLb25c9UvZkHOP5R/k3T3qg
	7ENNlItV5sN+5jdRCoJG+U8JMol2NKypHBdsT+q7hi8FEguhVA8BibeMlo1ptdYO
	6Y3+i8rzw7p4uXZ+7ABmKJdFYSnziq6FDM+VRk6vvlIMHTe3xxnArj3+FdY47DlU
	88FTNZPspqSSUpKSfParcqeoThKd3alPRDNJhnfUSMX3yr6Ep4acrRqe2AgS4FBA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j8gee-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDOCAj695830;
	Fri, 18 Sep 2026 15:09:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fexf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9Rrr43909496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DC7D20040;
	Fri, 18 Sep 2026 15:09:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB5C52004D;
	Fri, 18 Sep 2026 15:09:26 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:26 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:24 +0200
Subject: [PATCH v7 07/21] KVM: s390: vsie: Move release/acquire gmap shadow
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-7-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4854;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=GGMbtyEuxzIWuM9bBkuwnluaQBjqdO1ctV3RbbWb7OQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQxQD3Mo8X6me6xfkTpn2Q/tKQptR+4ufPesORz79e
 L5u6bN1HaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzE7S3Df997yq3aUpaKjMa1
 6bPeZ1ZPWNiXcuruvDAHi+cCpbt2LGNkeHTyuqn4/YAlER8v5N08W911/IEfk4JR09LGFyeN/Q7
 cYAYA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX9eh/+KEtylIh
 8Pez+qeAOC0+ThFHgbn3aL38qkiLS5+94Y2c9Ky++Cad/fUNaMgZfPC4rl5F0VDuXFZN6hgi9Vd
 5mfx4Ipd0QPwbRX1RCqJlRAv8phKeC1Ql4rhdxT3pCTgIxCHoc+1ROr9BVHbDf1P+u6lX1ftbtM
 EBcvdsFXDJM27QBeRkApOwc9l4W/IGvAjBhVB6PgY0g7SD9Aow7WUizR00c2Z2kzkMFJzYz/S8p
 scewTzhf91rKjkNj8q+2OtGlV0uG6NnPiSL+xKuVTwFIInoPKrAk/v7gQUW4dvGBsVv9wo14oRs
 IHDEMdVEB9+QlrbTjhDHBkCma3nJ+mWWhWZo+SXrhlqu0Gid4Ha8IdvJfQN6TErXQSTIdxdU5p2
 HMRMeobvqoYP6Avhsm0uvVOnaINrOgles+zvee5gQdAiZqzGb04SL7qJW6o7ly+9Kne9v5Oldr0
 F8WUIyFDU6f+5A4tuWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX/tu4wy6402eg
 ap99SfRW3lnkmeqYC4wOsEo4sWl19CoPg44zgNI8beNLOXC2236xb9W2gpUD2LisBJY8sGWm6+Z
 2mmLebnLNWQud+tTiEhriu/OhR3iktA=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aad542c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=_7pECfS6dbZ_FIWTgVQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ag6gX-ouEEwveqPBaKz7Xf8eVc_OGrlw
X-Proofpoint-GUID: 5SlDDg2M00c453bdemKBRGyyaNasg6Qa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180214

Move {release,acquire}_gmap_shadow() up in preparation for the next patch.
No change intended.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 130 +++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 55e9399b9b30..afc2e56fcabf 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -149,6 +149,71 @@ static int prefix_is_mapped(struct vsie_page *vsie_page)
 	return !(atomic_read(&vsie_page->scb_s.prog20) & PROG_REQUEST);
 }
 
+static void release_gmap_shadow(struct vsie_page *vsie_page)
+{
+	struct gmap *gmap = vsie_page->gmap_cache.gmap;
+
+	lockdep_assert_held(&gmap->kvm->arch.gmap->children_lock);
+
+	list_del(&vsie_page->gmap_cache.list);
+	vsie_page->gmap_cache.gmap = NULL;
+	prefix_unmapped(vsie_page);
+
+	if (list_empty(&gmap->scb_users)) {
+		gmap_remove_child(gmap);
+		gmap_put(gmap);
+	}
+}
+
+static struct gmap *acquire_gmap_shadow(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	union ctlreg0 cr0;
+	struct gmap *gmap;
+	union asce asce;
+	int edat;
+
+	asce.val = vcpu->arch.sie_block->gcr[1];
+	cr0.val = vcpu->arch.sie_block->gcr[0];
+	edat = cr0.edat && test_kvm_facility(vcpu->kvm, 8);
+	edat += edat && test_kvm_facility(vcpu->kvm, 78);
+
+	scoped_guard(spinlock, &vcpu->kvm->arch.gmap->children_lock) {
+		gmap = vsie_page->gmap_cache.gmap;
+		if (gmap) {
+			/*
+			 * ASCE or EDAT could have changed since last icpt, or the gmap
+			 * we're holding has been unshadowed. If the gmap is still valid,
+			 * we can safely reuse it.
+			 */
+			if (gmap_is_shadow_valid(gmap, asce, edat)) {
+				vcpu->kvm->stat.gmap_shadow_reuse++;
+				gmap_get(gmap);
+				return gmap;
+			}
+			/* release the old shadow and mark the prefix as unmapped */
+			release_gmap_shadow(vsie_page);
+		}
+	}
+again:
+	gmap = gmap_create_shadow(vcpu->arch.mc, vcpu->kvm->arch.gmap, asce, edat);
+	if (IS_ERR(gmap))
+		return gmap;
+	scoped_guard(spinlock, &vcpu->kvm->arch.gmap->children_lock) {
+		/* unlikely race condition, remove the previous shadow */
+		if (vsie_page->gmap_cache.gmap)
+			release_gmap_shadow(vsie_page);
+		if (!gmap->parent) {
+			gmap_put(gmap);
+			goto again;
+		}
+		vcpu->kvm->stat.gmap_shadow_create++;
+		list_add(&vsie_page->gmap_cache.list, &gmap->scb_users);
+		vsie_page->gmap_cache.gmap = gmap;
+		prefix_unmapped(vsie_page);
+	}
+	return gmap;
+}
+
 /*
  * Pin the guest page given by gpa and set hpa to the pinned host address.
  * Will always be pinned writable.
@@ -1311,71 +1376,6 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
 	return rc;
 }
 
-static void release_gmap_shadow(struct vsie_page *vsie_page)
-{
-	struct gmap *gmap = vsie_page->gmap_cache.gmap;
-
-	lockdep_assert_held(&gmap->kvm->arch.gmap->children_lock);
-
-	list_del(&vsie_page->gmap_cache.list);
-	vsie_page->gmap_cache.gmap = NULL;
-	prefix_unmapped(vsie_page);
-
-	if (list_empty(&gmap->scb_users)) {
-		gmap_remove_child(gmap);
-		gmap_put(gmap);
-	}
-}
-
-static struct gmap *acquire_gmap_shadow(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
-{
-	union ctlreg0 cr0;
-	struct gmap *gmap;
-	union asce asce;
-	int edat;
-
-	asce.val = vcpu->arch.sie_block->gcr[1];
-	cr0.val = vcpu->arch.sie_block->gcr[0];
-	edat = cr0.edat && test_kvm_facility(vcpu->kvm, 8);
-	edat += edat && test_kvm_facility(vcpu->kvm, 78);
-
-	scoped_guard(spinlock, &vcpu->kvm->arch.gmap->children_lock) {
-		gmap = vsie_page->gmap_cache.gmap;
-		if (gmap) {
-			/*
-			 * ASCE or EDAT could have changed since last icpt, or the gmap
-			 * we're holding has been unshadowed. If the gmap is still valid,
-			 * we can safely reuse it.
-			 */
-			if (gmap_is_shadow_valid(gmap, asce, edat)) {
-				vcpu->kvm->stat.gmap_shadow_reuse++;
-				gmap_get(gmap);
-				return gmap;
-			}
-			/* release the old shadow and mark the prefix as unmapped */
-			release_gmap_shadow(vsie_page);
-		}
-	}
-again:
-	gmap = gmap_create_shadow(vcpu->arch.mc, vcpu->kvm->arch.gmap, asce, edat);
-	if (IS_ERR(gmap))
-		return gmap;
-	scoped_guard(spinlock, &vcpu->kvm->arch.gmap->children_lock) {
-		/* unlikely race condition, remove the previous shadow */
-		if (vsie_page->gmap_cache.gmap)
-			release_gmap_shadow(vsie_page);
-		if (!gmap->parent) {
-			gmap_put(gmap);
-			goto again;
-		}
-		vcpu->kvm->stat.gmap_shadow_create++;
-		list_add(&vsie_page->gmap_cache.list, &gmap->scb_users);
-		vsie_page->gmap_cache.gmap = gmap;
-		prefix_unmapped(vsie_page);
-	}
-	return gmap;
-}
-
 /*
  * Register the shadow scb at the VCPU, e.g. for kicking out of vsie.
  */

-- 
2.55.0

