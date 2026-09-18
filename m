Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190314FDA7C;
	Fri, 18 Sep 2026 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744186; cv=none; b=aEIRqiJMLJpB+16sRWidLMer/T3g98VeVluIfib1UCH3c2m93fLjhpsXf77rrwCfIhEecMxHBgJVTOGnvLKAk+ssvCQHaeqF7jCdURnnLpR+6WEvZ7xhmwr/uB41NI2olOoQ7TpjJpBJqJvtM4204vrApK2NqOfPTiZfjDouW0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744186; c=relaxed/simple;
	bh=3ISA+GddFojxUU2v2CUzfwLCCzz2AX0OTr/H/Qd3XIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=le4/VH/h5So2jTrfyv7cgB0Zag3y0yMyssFSSMx0C7zL5wRWCftlyEMA6iQtbnh5HK2fGO1VvYST5n/qRe8rDZevvmvTl+FuhRcPBCOL1aZ5v5VY53qIP/CEwEkhwtcAtrBMTgCv5RwAJrEXow9n295UI0BZl4qeROaRm3c9oKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C8GF3W2e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C8GF3W2e"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVOEL3708366;
	Fri, 18 Sep 2026 15:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MkIt57
	sA0lOAnb5RQJCAO5ScI0tf4xW9qOrLcFx/NmQ=; b=C8GF3W2eldfCmVXuT9FrKZ
	3IwQO9XS/wUFlkBA/QhywsSpXcP4mUeZIDCLo9Be+U+Ve0qhEqaZNb/yeBAKxYbQ
	GFnTg0+pYnRJ1nXEgTequs5AlpLrxxcI9WtkGggc3bFzGIsY7TwjgLc8KTdo2JIU
	TfcnEU+F9FGH98cYj+OxUNGjE38+PqYZpsvpUKzjZ4wwULxvJwWXWwM8CB4eALMU
	Y8s+70It3li6F3AXwQByqh/qytj7N0QSQhquBud1j+/nzZ578fTBjQvUlCoFX6ba
	mMw+x7+ZJbeJtWZgNa8QsD5ME8xUwQ8PxHiIzleeXkW7ysejCc0XFB/czW0o/Qvg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqrsq4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNttP1684370;
	Fri, 18 Sep 2026 15:09:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gs4tv8puy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9TRI42008886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C16820040;
	Fri, 18 Sep 2026 15:09:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15F602004B;
	Fri, 18 Sep 2026 15:09:29 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:29 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:28 +0200
Subject: [PATCH v7 11/21] KVM: s390: vsie: Add helper reset_vsie_page() and
 unshadow_intercept()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-11-f39806eaae37@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=3ISA+GddFojxUU2v2CUzfwLCCzz2AX0OTr/H/Qd3XIk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQxRn5b6ec8XR/MzdiRybT5RuWWWZ8WXm2kusk+pne
 9x/VR6r11HKwiDGxSArpshSLW6dV9XXunTOQctrMHNYmUCGMHBxCsBEHJoZGSZd+TlL+Fagpdic
 kgrrfdbL7tmU6k2e5VRXbOOs3a17s4bhF9O6xfZP3Hb0aiTYJFiIXtCN1LAT9bXZ92fhJa1XJTM
 zeQE=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX/N5dbIntE2zU
 h+AUL4yRVZZeIAe6oShI6afnUcO+VtKvE9vD+SethyNX7wz3qNI6xbstZS3WaqF0XXXXTRjT4jn
 fEbE5ICan+AkJ4Ern3D/r7CrYVXolCESeEaRl6uozS6bVhlpKzACX1dFvOS3s4kKoQ3ETafM1GA
 J9FBhZpf40t8TSwAsLS1UPps/rcEtX0W1rcLURVctSyfZUAcTy1n1VGbseOhKnKDWD7xMNoQDZw
 hYcxjivdB41NwVhofrXWU6EIoRH46Pwvs0Wi/r9h5oZwEbCeODrLul7stuHex/IGft9PVIh87Mk
 YQBOKgj99KOvc0GMFl4RupVrCqeof16zVGq/TaIAb7oTSW+BpKYyCDy1ATfBqbBw5y8g7aXgzQf
 uWmREp2IsFAT8GZDRDOTyA19LEXKafj3GzNRMyJ5Wd4rLZI7HYxryJX2gALzjHn7F/9q5cpZjJU
 vwva+KAvTuX++3i/AHA==
X-Proofpoint-GUID: tqivQNofmKYU8SukqP1y2UUYwCas9G4p
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aad542e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=BT4YM3xfTWJAqdQ5kpwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IIASqdHfcRIJ4v-yq6ZNzeXEDwXQAxb2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX5nzx+sr/y6Iv
 ow7qSRSj3wHdS/KIGge4Wt7h4w3SkOM9DBTNphMCbtR01tSxPMy4uroglagn0KfsRbVjaEgzGMD
 3kni1xgd2/EiUkD+k2FqME38ajfzN6c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

Extract helper method from existing code to reuse in new code.

reset_vsie_page() clears and releases gmap related to vsie_page.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 78d59fc535f7..95baac9a1ccb 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -1530,6 +1530,16 @@ static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
 	return vsie_page;
 }
 
+/* Reset shadow state after a vsie_page has been (re)initialised for a new SCB. */
+static void reset_vsie_page(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
+	release_gmap_shadow_safe(kvm, vsie_page);
+	prefix_unmapped(vsie_page);
+	vsie_page->fault_addr = 0;
+	vsie_page->scb_s.ihcpu = 0xffffU;
+}
+
 /*
  * Get or create a vsie page for a scb address.
  *
@@ -1595,11 +1605,8 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	vsie_page->scb_gpa = addr;
 	mutex_unlock(&kvm->arch.vsie.mutex);
 
-	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
-	release_gmap_shadow_safe(kvm, vsie_page);
-	prefix_unmapped(vsie_page);
-	vsie_page->fault_addr = 0;
-	vsie_page->scb_s.ihcpu = 0xffffU;
+	reset_vsie_page(kvm, vsie_page);
+
 	return vsie_page;
 }
 

-- 
2.55.0

