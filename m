Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054844C64D;
	Wed, 26 Aug 2026 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756732; cv=none; b=ZeT5pJCzMKb5f065+Vi0BP262QVq/fXHkD0kjo3KSyZXF5LP9ddQs6pUgwIZvCtz6PXGpTvxyOAhyiOJd8C60kyqIaYt9Ap3OhWFgoX6hY83QyHmuIbDNUxpZz5phWis2XJOnrF3hW4j/YnE1As0Yzl6YKSK3BybKWUbJUVs7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756732; c=relaxed/simple;
	bh=To1sXLlxMyhBRYoXOILsRZRhKmeZs//23thXGIpQKrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZ/EnBRQ0G+Zrt+HZpe7UcZRAiQGnlroYv1rQAmoQKTbgA2BWXGPwM/OWd6aOoCOfQM4UEGUZdVIebZqQcVN2+rxd4ATeRdvP4uaPAd1WeqiyQPIbWKgcHP0a2I/0QtUPZL5X9qrtG1wxl+ux6/Qjlup1CEAg3qpip6kKBcVVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RSTBisC9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RSTBisC9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1gFc4099758;
	Wed, 26 Aug 2026 15:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NmBkdC
	qkhIhOtf6YAC4ft4zteuTDKLhrprq4fTkCHMk=; b=RSTBisC9Q7bQgApkCyPM7E
	K1lHrIbtL9y/W6e1jo82l3lKgnXr8ApSRaH3mKqnxqZIM2sq2MsPRYKdhkXgHZdC
	i6Xo9BfAlf6bTS7O/1BSWumXej8BQjb5DxDDofMZpy2fSr/XW8sAOZEyXg+zXbiN
	Le3OBlT0C2umxrdJPn5FeEjNOkgeKVqltPmkNFzyXbPTXiNtjAOw9qp7ndKwHwuJ
	VcXWUou7iWr/cLGtyTle7hP+bAXlDnkJmYGi7QJKlpPpdlWZOyfzdw/A/RLCEQcm
	AO/7SNv2mMtqNTQvlXlfreZ33sq3OXdi+rm2eaE/bSCsHKq61UQ+XFAX88BuXlSQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hyhkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuH83020643;
	Wed, 26 Aug 2026 15:05:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwaq21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5JMI44761522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0E0C20040;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C36EF2004B;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:12 +0200
Subject: [PATCH v5 10/21] KVM: s390: vsie: Refactor kvm_s390_vsie_destroy
 and extract reusable methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-10-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2806;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=To1sXLlxMyhBRYoXOILsRZRhKmeZs//23thXGIpQKrk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKvDXE6/113gFyNtZCK09x2fU3nav9femdO+bzZPv
 l51uiiyo5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgIk0FzMyLJ2uZqZu33CrK80v
 +tnBhuYJMcIr91/tDvy78FSS1GRtHUaGPambbes+yexeGbKTp/nNi7Y/8Uf/t7+SC/ucs+Vxg4E
 ZKwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfXzVlxJJ4pzVXJ
 5fJa8lzpmqKkas264B+SujEfIW6U/NGPzOzLO8LkXt9T7pcJhGRWh7lxIfC52kXwgfUXD/gYUQF
 iF3GdRpiY95ACeQEVLFLDeReJXVejT8=
X-Proofpoint-GUID: dWOTAbwR7QUNM4sFA-8YtvUZtR8yXNns
X-Proofpoint-ORIG-GUID: 7-6k7s17gJAkCAXerkkRZiS7r6pww5Vp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX5CMCR7/eVZlU
 JSN23KmoiOmQQRYpra5NDAGX1r5h7y80i7R0ZXRQIvQTYWL+hCPIxa7GadcqDQLA487yL7uu72B
 YThZ+w4AMnWO4gzBnihlbdQvEENHs7X3BUrOEHHcXjSbl3gBG2l4RJjQBmkZGhF61a7n3nJa5Cj
 F6gnfE6Px5f/shybqnMOu5eJlOq+vVnTmRb/wFptVlfsdilBHyd35T4qjlhubB+3Q5BGu7UXv4T
 n3YhkAvBWdubZ3R/QGi5LaPQN15LVG0t93XWjvo6E6HAtjg+MAhqPxNe4fryH0a83sPv89LKu7L
 RpmUsL7LqrxJeNyu2o7qe8jzJJuNHwN/tAHLrG3aTlLkx4llimTvP8GPgZri3tKFEXYWPjAMACM
 Qz6D/g2coj00KgSSvGOXh9NyD35IEyALf8fSl/la2yluD2A2NwC2tBBgAccCQfQLn63FzjHtly0
 nSRnR7S0gXTH5h+yiCw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f00b3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=uT_qwtk1aseIMH_8CH0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

Create a helper method release_gmap_shadow_safe() to simplify releasing
the gmap shadow of a vsie_page and a method kvm_s390_vsie_destroy_page()
reduce nesting.
Both methods will be called from multiple places in upcoming patches.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 75676f493ab2..5e41dd151f8e 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -164,6 +164,17 @@ static void release_gmap_shadow(struct vsie_page *vsie_page)
 	}
 }
 
+static void release_gmap_shadow_safe(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	if (!vsie_page->gmap_cache.gmap)
+		return;
+
+	guard(spinlock)(&kvm->arch.gmap->children_lock);
+
+	if (vsie_page->gmap_cache.gmap)
+		release_gmap_shadow(vsie_page);
+}
+
 static struct gmap *acquire_gmap_shadow(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	union ctlreg0 cr0;
@@ -1585,11 +1596,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	mutex_unlock(&kvm->arch.vsie.mutex);
 
 	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
-	if (vsie_page->gmap_cache.gmap) {
-		scoped_guard(spinlock, &kvm->arch.gmap->children_lock)
-			if (vsie_page->gmap_cache.gmap)
-				release_gmap_shadow(vsie_page);
-	}
+	release_gmap_shadow_safe(kvm, vsie_page);
 	prefix_unmapped(vsie_page);
 	vsie_page->fault_addr = 0;
 	vsie_page->scb_s.ihcpu = 0xffffU;
@@ -1658,24 +1665,29 @@ void kvm_s390_vsie_init(struct kvm *kvm)
 	xa_init_flags(&kvm->arch.vsie.addr_to_page, XA_FLAGS_ACCOUNT);
 }
 
+static void kvm_s390_vsie_destroy_page(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	unpin_scb(kvm, vsie_page);
+	release_gmap_shadow_safe(kvm, vsie_page);
+	free_vsie_page(vsie_page);
+}
+
 /* Destroy the vsie data structures. To be called when a vm is destroyed. */
 void kvm_s390_vsie_destroy(struct kvm *kvm)
 {
 	struct vsie_page *vsie_page;
 	int i;
 
-	mutex_lock(&kvm->arch.vsie.mutex);
+	guard(mutex)(&kvm->arch.vsie.mutex);
+
 	for (i = 0; i < kvm->arch.vsie.page_count; i++) {
 		vsie_page = kvm->arch.vsie.pages[i];
-		scoped_guard(spinlock, &kvm->arch.gmap->children_lock)
-			if (vsie_page->gmap_cache.gmap)
-				release_gmap_shadow(vsie_page);
 		kvm->arch.vsie.pages[i] = NULL;
-		free_vsie_page(vsie_page);
+		kvm_s390_vsie_destroy_page(kvm, vsie_page);
 	}
-	xa_destroy(&kvm->arch.vsie.addr_to_page);
+
 	kvm->arch.vsie.page_count = 0;
-	mutex_unlock(&kvm->arch.vsie.mutex);
+	xa_destroy(&kvm->arch.vsie.addr_to_page);
 }
 
 void kvm_s390_vsie_kick(struct kvm_vcpu *vcpu)

-- 
2.55.0

