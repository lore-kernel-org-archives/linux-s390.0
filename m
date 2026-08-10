Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7193314C2;
	Mon, 10 Aug 2026 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377267; cv=none; b=H92FSbgxkh6t8MnJXOZY6wnjNJzuZBy5N9f4RiwLmns9VI7SV1Bio+r7JJ71VieaOBKhEyo/nBXPz7oQd1siKxnhDycilgmGW51PzwxGktIyuvtlvqkwK3/ytc7FDRkafwcKSr7vf4VgTKvqfcLW55qZa4qnJiY7bChdFA43+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377267; c=relaxed/simple;
	bh=jXOLWB5f1cgQW/6GwGN0QmN+rI/oxMzIx5r/y309RWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htJ1LPH3xEptDdZU6S6QLzrXRCJ9xAzsptcNRaptOrx3g4VkxcqP3rqtN2Bcmces7QtEx+1xGXenNhMmO9zWHC7eECGgrr1TnKlGEp1OQyD3Zl7ipmO5dYIp+kNG093tG1CdxWFhdEdLNafRK6BOFVnwyAtcUeMpxf6GfL3l2ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NXShJGtU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NXShJGtU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWiDl2026096;
	Mon, 10 Aug 2026 15:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QcqoVL
	YvbxWno3e25HVTF28WDDDWnr1DPJ2iDy6GeVs=; b=NXShJGtUAon1xwSfqXMJZK
	lOiqIOJI3EDkFVyNYeC4Br34VE7arqP5YKaOWY4vg+oTcW8zJVRU1yu7Otn+Pv/m
	t3J33saFHGbHkhKBE0E0zRvdkjTibiR2ZHNckWa8Vw9jX7lZQ7Q0Idi5f3cKiOY/
	24HugUmE9FwWtnUV8xocf49S/UgjZ95ESzaYw/esnBwol8ia3Ts7VcezgO1i/024
	7QspiFU7f/N+/KtNTFSYsYiVdTp0PhaqSIDZJZHRZ7oI1PUXbIesBnZDnF1UyyoJ
	fGR8cM+H7LNXb/kpqFuW+7aRJ7OXWXMWeYzZiE6MDy4HObmQRCtR6dGu5eaI24AA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9gua0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgZj9016515;
	Mon, 10 Aug 2026 15:54:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gwbsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsHgk52167050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D2FA20049;
	Mon, 10 Aug 2026 15:54:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F58B20040;
	Mon, 10 Aug 2026 15:54:16 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:16 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:53:55 +0200
Subject: [PATCH v2 07/20] KVM: s390: vsie: Move release/acquire gmap shadow
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-vsie-sigpi-v2-7-e8d59a2f2f70@linux.ibm.com>
References: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
In-Reply-To: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
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
 bh=jXOLWB5f1cgQW/6GwGN0QmN+rI/oxMzIx5r/y309RWU=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVXxQ9WtbLvVGQu+L5c53drQq1x5s+ef45dGfzpLy8m
 1Oc29OWdpSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjCR5U2MDJsDDdjrNtQJPBLy
 v/ROx4NzBtvdlypqgtlBXIYFnUtNahj+qS9c0f39zxnNWokra7zY0ufK7C/yy7sUcu2363LlSrP
 3nAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX+uggHHcc5Qwc
 d95Zh+jKaHJtbrXUgHYebrVk5u8euezl0PV+D1lDqJOwUyJYwVXAs13XJB29mXEazY0JDsnyuNo
 JDyDwbnAoI315uMnMoDE28FSFSXawaeaz8bL8qWaUV5Vn6WNwmbVs01JhrYcwiFDI3UFwkKrzTp
 Vezxwlu682ZRTrsiAdwH0XHj47JtA8Ognt/eQu2Jv4ZZ0mwRgw7/z1u5ZH/H1Ee1ao736kkeBvG
 StS0de+CNmVpTe8kDYuxHxpuKrcl/LcMChYAaj1l6UyuDgsybpqL53uqDshnYPZ5eqQI7pcpl4H
 4XX/loDzeth5kzWxTEcntFDj1N8JWwZRPbO71YRrasa4WVK/WR+vOwuDHEnKIeSAIQZz75j/S0m
 atxh7vhnaemuHISepyHc1/QMRDpiGUu4hUaHmD7ELpZteWELxR0/U/itg7cA3jGe3tK2oWgEEzU
 2ystTy58Eht21GzItSQ==
X-Proofpoint-ORIG-GUID: r8mqI99xmnGASeL4MPZgxzApojHftIIL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX/fXaN0Bfj6xX
 coUaq2J2gtXgHRtvCZsK+TtSk06Y+Be1qjINFh0FSW/Y/jErJ76SMXm29Wpf2MMa3632oe9FhdM
 boey5TWgxYKSXMvSL8/67IGCOcznPq8=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a79f42e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=_7pECfS6dbZ_FIWTgVQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: r8mqI99xmnGASeL4MPZgxzApojHftIIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100134

Move {release,acquire}_gmap_shadow() up in preparation for the next patch.
No change intended.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 130 +++++++++++++++++++++++++--------------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 0e32d1543ae2..86e1c605f4ce 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
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
@@ -1310,71 +1375,6 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
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

