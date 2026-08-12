Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B8367285;
	Wed, 12 Aug 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542768; cv=none; b=STBFhPqIhepk3RRamtyONjAD0ALxeyb/WfaBdJHmSjwEfsFPWOvArU59S1c+t/zU3J7nZMSDdOd72TNaUlUUgvStfG/7p0V7/CtcY9cQD3CFrUj+3S7HLARzBl4Jyn2S6wDnRuCxIkQJPUiXk98/KeUeMRUSX3dn7JkzEdMe8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542768; c=relaxed/simple;
	bh=wGObvfPMBu4bOA1DMewjytH08EOEk3bikjh37p4G1pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXmdrTpFamfUq3UpGwnMjCJiLsstODxUkXlD8LU5QAseB5UlgKokboV8u//OVCFAut16Q0md1wWu2sTsbazE93uu6fVS7VOKNSpXZFv31BvTlestOzuRzQaiXaCcUxi9UJzSnQHWnwEEQcavsuqBDyHZqMd/uxtP51BRtMMtGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ofN+D4yR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ofN+D4yR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3aI43334253;
	Wed, 12 Aug 2026 13:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UaYz8u
	mc/9ZvhGCZnEpDvwiVfOSCSkWyKix99m2xYIE=; b=ofN+D4yRYsT/fKtSrWNKfp
	pxgEuQTFphpWWetZfps7kQD82einAWAABu4cGx/nmr3yDAQDQTFbcduZjjTahL5v
	Y686F6Nr9tSilFoXvQ3BPHuC5hfR9X12ben0NWBvogZ5czfYFwaF5+Xc7/qeYMnV
	GZnlOsGITFHYV7mTx42TubxwFMS88T9IhFVkhCi6X7etJSQ2hnsO/8xtCvORRGpq
	hxAxe60OhmVB+PE6qsjHYqAoDE042mJgS0K4U1SPcjRelMJ4rRMftDGwlbKGQVIs
	gnx/7coJq3gBiGUD5FufobYcpbi+G6WSqeq+j9A+bfg670GdZDAoEXWNHzUSGTmg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw9we4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDffpm011709;
	Wed, 12 Aug 2026 13:52:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h66dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqcfW33947974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D5B92004B;
	Wed, 12 Aug 2026 13:52:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E7B72004E;
	Wed, 12 Aug 2026 13:52:38 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:38 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:36 +0200
Subject: [PATCH v4 07/20] KVM: s390: vsie: Move release/acquire gmap shadow
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-7-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4834;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=wGObvfPMBu4bOA1DMewjytH08EOEk3bikjh37p4G1pk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VYvMjBUz9k66WuvVHmDLdmGZ5w2FVQ9fPo6vbNmld
 Vikttulo5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgImsiWNk6N/asu+vb+mmzHi7
 SS13VCrOC//4YPPZzeN4+cx1UX36WxkZPtm/eXew4iSXz7omBakzOZkeV3cu2VG0OHHG/PZfE5Z
 sZwEA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c7aaa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=_7pECfS6dbZ_FIWTgVQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mUg3m3HK8lIrBdaQAeoXo47qWiXGCQl_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX0ErNaylIDNOM
 pXm90/jh2N0W/NtfvB+V5f3/f6FbBShtaAiYI9R8HAAhJqt073hVGd6eUPp8tUZNV0a/beOuFKm
 vfCciAWOGhoMV/vEL7ThWzmVtGTFCE93K3ZjwyYJsjqQgnlGvrZArxygntA56FthFKXOkzFQFuY
 fQi/NAHIhfeFxrybaq/alpxyXdgo1FEPuJZI8Op57gQr3CpgWYFCjzp5Dmmm61k2vozP8hAOmky
 DsvyRugB5QgRFE5oiwDmC2iP++mF9QWV/mQOpnJoGEqi7ifzbjOK29bkReavOUULD2WNGORjGXU
 aD1YqYpY3cDq+jBhgErUXe5gZGj/UkrzTs/MFMVJhK/N1/kzi2wvK7eqvAWR6FnFnNDb5cc1z31
 Hhf1fW89TzykeicrtiW16baX4rQQ8vkdXJYYdTQyEwRJ8dIDZfGsghiahcRC56ORXYMat6wF6m5
 ePClFlA0Rapr4t5LW7Q==
X-Proofpoint-ORIG-GUID: mUg3m3HK8lIrBdaQAeoXo47qWiXGCQl_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX5+a215dkwnNV
 NKtogvgkVhXKfRUlVcxrAPoH3bmNLqYKyRhl0IAJ9m1BobrZQazmeaYoM6xdX6lUQPSu02f+3+Y
 7A851eF4ukWx3h9wZn2RDFR1mieF3ZY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120110

Move {release,acquire}_gmap_shadow() up in preparation for the next patch.
No change intended.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 130 +++++++++++++++++++++++++--------------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 1b4f6b1691a2..c935a375f57c 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -150,6 +150,71 @@ static int prefix_is_mapped(struct vsie_page *vsie_page)
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

