Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E551449999;
	Wed, 26 Aug 2026 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756730; cv=none; b=kTWQYyzw5bYVbaVD5wxkJj4mJVTk4Lp351BHcg0no4DqSt11cdFwqe/5mCFbFqx7plFOY+Cy55iQ9CNqRBuz6aMUrHPf+StOHrfFbLSlBacg9qy6C9z9XFO38MT6e5LTZSawae1C3ycd45FD/gTCHTwh3G6NQhUw2aFhUieTv5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756730; c=relaxed/simple;
	bh=GGMbtyEuxzIWuM9bBkuwnluaQBjqdO1ctV3RbbWb7OQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ACzKeAISFsTo+C3Or4LsWF0Mba69e63usv12o7sVhY1oQgFgUofwTMXLa5rTPXMEmG73uQ7W6BFSpLxyaguVZ6mSVsK9Qmweki/v8yZgTzoMh59FSAM2rGmVb8uqRDaGOwwv+Ay+deLmY3huVyEw8+JX4n2otE+mVUXgie+ODqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=efgBt/ss; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="efgBt/ss"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1fu14099687;
	Wed, 26 Aug 2026 15:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MT+Rbw
	P/QlHzq7dx/FEVabIZ9enBy18WWWj/Tnk6Gj8=; b=efgBt/ssbDnCRR6Lx2d0Na
	152A+BIKtKleDlGg5g8WxHeDa6JLmU569xRg1X59jrFgNtZVOi5JFFGY8qDxXRxA
	1isLrbluc5/NCz9Vd2X9s9eerRC039zEjBVKnWOAoGc2jHbniDKnauo3Ru2c+esT
	3Yn/o/ZUFozDx7Sh00u4BHaFxKn3RFeW97jaq/hUMDvsZZYWGZkN76JD6w+n6RRR
	RnAZBDn4DTbYuLBzAfGEI00y0HAixQ5OlAfIJUQLiObkoZz6kUlTkxPIlSmeD2vj
	RB9PO/MS+qWQCwGiXuWK+3yqwbwPIR/LrvqZdbrcefmBOEtgBo6/WNSiJ+TfHlXA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hyhkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuHFg020657;
	Wed, 26 Aug 2026 15:05:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwaq1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5ItN45089068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AF892004D;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DE372004B;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:09 +0200
Subject: [PATCH v5 07/21] KVM: s390: vsie: Move release/acquire gmap shadow
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-7-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
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
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKuavj5PFeL9/2BudpO36NYiy20Cgl8sP+zJybz33
 +iz3+K0jlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACZStIPhD9/uBiPl0+LzdZyV
 NsW4sjwNT+PfNY0v77qp/dOjD17ceMTwT+lnksZbtcvrZc62ZPZJ97rkMEju9fN5tnadGt/D0o8
 8LAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfXyntInEdXKVsd
 QRtP9PhjfowNpzZmpRgUoh7YJmtrfvn4cQnAop5Kz0u7zpe1i/1szADetW0STccqp0XuZ4o0vzi
 mH/0eauvPXNAWH0IeLEIDo+EIohqwpo=
X-Proofpoint-GUID: WZVHMKtCqo7Jk82GAVimcVRj4JY0QIZB
X-Proofpoint-ORIG-GUID: waqHagr0TUY4cjvSa26M-KoYvscEjG4C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX6MQTQr/NZoCs
 tYablfGFj6EHTpft/PpRh4BBeGVG1cLiopFWMvAdF4N1CxfYku1DJ2HS+Ghe6amqs4m4tAcc6gw
 1GzYxdTxE8KxTrs60/tuBsYwjViOrflX1qRHmqCHUBBxyWb4od7RUQf6+jq7KTQ3tl6+pN3XRfU
 bl1NJalMQ1LPi1RgZliJPvj61/Y7eCm54SRpYkOROwsw4NM3pOZd+wUMMK4C8fzcVW8HF3jmdzu
 THXfrIUtDgeUSMYp1z1lLEArPg8pugWrogyh8G+mzW9YoBup9znGK/EdsMhXoZ0gZ0Nzmndym3Q
 7HEEe2fEYIJmBvu8ezBwWA57zkgqVlGIrA8/4iOK2FVsCEXRD+iw5hjiFcwbPhgyeZlVaO5u92V
 RAw9qO1GERNDyfo3VmmdS/oDCwSkwCeZDNcfpz1uMdXb80BBp6KqPXO9wfEL+0rUEpOWvq5k8Cg
 vrwRXbOfhWzEdjXIEFg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f00b3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=_7pECfS6dbZ_FIWTgVQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

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

