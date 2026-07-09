Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DEE36E47E;
	Thu,  9 Jul 2026 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610135; cv=none; b=vEj0WwFz4l/FqpAzpISQlP5s2648ZfpApnZOttWI6yqb1elhFXSsXlB6lTvdN4DgLb2BM83QVHWGCNV6zzCloHracMsAfv3QMPu+hP/BBIzhQ/Si/9k8w/ZNwvS0Aqu9pbIjbZ75Teikuay9Nr3ZGBGdRhEGUUPqWgyUEDEv7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610135; c=relaxed/simple;
	bh=ZMMvar/A7/UiRyqfL3L3CqYmbMkpqNsdA/l8lC+QX/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qHy8bQhEAxev5UuyxSS2mTnQH+70uzDWQeXwpe4VxKt5h1dIsGHRZ2kwLVrYwYjhWjuacyCIRhpRppQWY/6/OsazXVgGyBjyOsBydkDeIIf5sWoQ9HMTofQL21sKQ3pK4oLSBskaN11S33+4THwME2xQaeirpVqo++H1rODcaTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Js3l31RI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Js3l31RI"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIJmg1769770;
	Thu, 9 Jul 2026 15:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GhZZ+E
	n1Dz8gslA//8BZVBlRBc3rgnzcQNHUnlR9z0E=; b=Js3l31RItReEmdXky7WDEf
	9TPdE0tVro73v8d3aziMB6oNIai2OAh0pPTnK3Vo7oLMvNmWmagVDuhPd3qxz8mS
	E6aYAj9M3pVX0J9DAMacoDdngwe71vOtVsB8X5TbM+UvnLysZX9ywFZC1RbNp9T4
	7TeS+76YtzkSpFA+F6e/ms/QR4DzlFmCBLc5uZZU/jMnIKMOOgL3aa4jqfK9nQKq
	7Xx1nXXEpVefkeDshr6mxGtFi1CLSlr+hnk/mct77vH1azhFbnMShVUuZhHPTxSx
	xNttLYuG+SeLnOyuv8E38rHKskZLUfooZ2YvEwFbBVqJ8i/de6Jh85pn1dpUeYBA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke2pq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669F4afx009427;
	Thu, 9 Jul 2026 15:15:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgdfmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFQCa37618006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DA2F2004D;
	Thu,  9 Jul 2026 15:15:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DCD220043;
	Thu,  9 Jul 2026 15:15:25 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:25 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:10 +0200
Subject: [PATCH 10/21] KVM: s390: vsie: Move release/acquire gmap shadow
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-10-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4834;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=ZMMvar/A7/UiRyqfL3L3CqYmbMkpqNsdA/l8lC+QX/E=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u1mUjXd0FnjPn2AYsuSeQ2bMqWkv7zil/VJqi5hjx
 /D7vp18RykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABNZasrwT/WiutGjgzZqWw4q
 V0rOn39Nat7dkgbLbYJ6bms9N9YKnWf4n3hk2a3ze2r+/zJ+VXF7WXxG3X/eVJFsz2+7p2wOkGh
 v5QEA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4fbb12 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=_7pECfS6dbZ_FIWTgVQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX/ppg1mN4j6u5
 NTxMM/oxtyhQhVwJsteL1P+vUoYCvmn4bDxJY09kpWtG8QP2pYF0ejPBtasw4GoRkFxUH/3nPGB
 viE+unmF6PCJD4k1DInnugXckeooMjlAWDbi7y8ZEr9BG48IIUPRFY4OqP2bxqH1ZDwvIVVuwpH
 3x+Z4oI7LV4ciMks6MN0KYQOJxT6FZn3LJ2NdITQwIXb6FispvSLOsEYuI5DWYgKOcccxhMExeC
 yDX3V10S79Gv6an96HCzSnFv6MXKKIyxPC0AY7i2tAkD+8u8+XvbePZDF1hx8W/SI8tlOkJpx3U
 KiMa5H1IMiHZp+f8YeKdq/TAABjgM6LgrB9Erqcjwdkc0HMs+tpkxShOAJP7JAA+zOGZR1sF3jL
 5sFWlDaPQ+76dHuh3PkoaEDXCXm7Ih/6wFx93owCrmzfkRy/WNlqMQbww2+siOa2P/LWqCKMQXC
 sEwFv1pLJlpPouP5vIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX4EfLQ+5avoMR
 wTHyuSdyh+6Oi0HA47TlWw1YtpXPi2/Swmlns/SiF4/E59u0NM55eZtjxyMY5YWXoAWiuSF805f
 tG5yWDNNH4tyTTzRCrcYpbfACn8NSFc=
X-Proofpoint-GUID: 3ScslKVAHaMxlmG5dmIJIKkFXj481wf0
X-Proofpoint-ORIG-GUID: 3ScslKVAHaMxlmG5dmIJIKkFXj481wf0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

Move {release,acquire}_gmap_shadow() up in preparation for the next patch.
No change intended.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 130 +++++++++++++++++++++++++--------------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index cdf271eda88b..5bdd9385266f 100644
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

