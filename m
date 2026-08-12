Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAB45C704;
	Wed, 12 Aug 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542774; cv=none; b=Dkxb1ZiKpxj2MSw3ILgrJgefJ+UBAQEPBECNX1Y5xyttBl3gRUVL1hGcERZFwQNVCVKmaXL6Uw6zJ1z/xfRFNdL3evb9ZN19cvfjott4T3K4gIUS10U4fjGLCn2KRek1yNvChFbiRv4GRPMI9VXAE6PHaHPwHHDcFfNJssf3rKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542774; c=relaxed/simple;
	bh=KpV5VpFYNabX0aq3Qi59oEXL5dnLfHXjmSbeyrqd6s8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyfocFDUBXZ84EvNpPvd7FdSvV6l88Ek3S8lewbVZKwiUR20SLOEpjXI+cm1mvf7+wyEhxu7vorp793w6kPymErn/bGpaC0ek4SOhu4RWhpww8x1XW0+6XC3iTIKaun+DfvMZ+5BUB5kR7k8pAW1qQzMS7tsa++pFFUFdCHAJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OEfOEYem; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OEfOEYem"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB47pm3215098;
	Wed, 12 Aug 2026 13:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HsDFBU
	bBSlN/t5KoX9wnn+wjTb7sUrz30/oVXBeittI=; b=OEfOEYemHImeNz5H+84olq
	6+CpqUkcs2mYWy2xKtytNEUtwhc7HxjrPV3Exal48Jjwd6kh6wsIE5WBMN8Sqah9
	6dzgV+kahj2RCpCCboQAZ/LuLfyS/RTijZATdD3EndTrf6IaDm3rUs7y/CIRll8u
	LjiK2yDV+Ar1D2rwbuO7jYU6UKYbEKqGeqUX09lD/xulYJThfkpo8Pd3HVyff2Te
	VAMwRV65SsRbnitF3k+rbnUIkZ7vXrlVyHytMDNbXzTsJGVhqmYXeBUmGnyyy9Wa
	TLpmgfRrQVrU495GVYzmVBm9hShLikYyqDakj6HFdDX9IBU898OmKbz9VoEx0g4g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp31wqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDfdF2022787;
	Wed, 12 Aug 2026 13:52:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjx8dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqcCH30605814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF7EC20040;
	Wed, 12 Aug 2026 13:52:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3EEB20043;
	Wed, 12 Aug 2026 13:52:38 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:38 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:39 +0200
Subject: [PATCH v4 10/20] KVM: s390: vsie: Add helper to release gmap
 shadow
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-10-f19e49666315@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=KpV5VpFYNabX0aq3Qi59oEXL5dnLfHXjmSbeyrqd6s8=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VYuLFi9u3PTZ5GMAf09Fymzt//w21/6UXHjzTN/65
 xafA05LO0pZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZjIVWdGhqV2i46dv8V1xs7Z
 KHPF9TmbxQ7vTbNk5D2WH51nyyy4tovhf1apU0Ohg69hw1v12XuKJFxEuDe/OrEzefVubd3NTts
 e8AAA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c7aab cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=520cwpyMf__qVmlIlYMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: f_MRXU0auFNtUIqRd5jCsvc4ZcyIxza4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX8FxbjldpNe86
 smxQ9Nda8YU0cvBYrxnbUoUga3fUnvijmmynoqtZMzRtSdKhAVP6W479Od1ysCSZNKhzgbUz+pg
 3v74S7e3pooM9Z187qzALYscEGChLZoox8rDbOtNNJLrV38edp8oUNpc/bz+KXNa3W3o4nFseRw
 fSw9JuOhro0kO9a9aBRim/u0JkNynyv2HEvkqz0DyooD2qHie5oRXfEVPYt58lR6vIda7cEhioO
 4+xwk5p4acR5QDJlZV+Y+o3bg8qWzxWm2O6N5T/3myf5GcJb53ZCb5yfmGBfTh95hJEIWIwLMxx
 gM4hd7/3GNrLIDsDsmIAgy0OkMfp8J6qV2Qbs6e7ZZMwipzFRQ2SRm6vK23gy2iYKTJPpf9GOX5
 39V+6STIQt+dLwnd4/m41HNylcaS9OLsGyGq+kOCxQVlnt8F36elLaL6xCgC1fztmHujCPQX5Ty
 EE6XTHYIerJcY2EQ6OQ==
X-Proofpoint-ORIG-GUID: f_MRXU0auFNtUIqRd5jCsvc4ZcyIxza4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX+JiWKmUKyS+K
 G3FSmujzVHXxSRGkR7n7lyjvoOyhQj2wybfgiAT5kMIjbtgmYOj29/KLlcJrn2jY9J5db4b2k/f
 yTBJX7j9UtgK9ALrpwNJf/X5ZUgjodw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120110

Create a helper method release_gmap_shadow_safe() to simplify releasing
the gmap shadow of a vsie_page.
Will be called from multiple places in upcoming patches.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 569054552b83..d2582519b3ec 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -165,6 +165,15 @@ static void release_gmap_shadow(struct vsie_page *vsie_page)
 	}
 }
 
+static void release_gmap_shadow_safe(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	if (vsie_page->gmap_cache.gmap) {
+		guard(spinlock)(&kvm->arch.gmap->children_lock);
+		if (vsie_page->gmap_cache.gmap)
+			release_gmap_shadow(vsie_page);
+	}
+}
+
 static struct gmap *acquire_gmap_shadow(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	union ctlreg0 cr0;
@@ -1586,11 +1595,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
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

-- 
2.55.0

