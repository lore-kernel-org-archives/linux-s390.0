Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98344AB6B;
	Wed, 12 Aug 2026 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542773; cv=none; b=GOBM42ryC3tjZApBFXb+zLKKAx1hcq6xmRniPH9rsJYTkdXlI2s8JXI2MUn2qvEOEjRpU5jHbbVCD3DXSjrVo6tRTlc+pvyKp+cu4FVOosM5SzIJrUFIfuo/xxUmG1lHD2xp6md5ZLvuZYuzES5XkwqdTtXUQgy10XUDjkQCIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542773; c=relaxed/simple;
	bh=wdRRCzn4k0wVqr7C2Cp1JywEk/vD1CtZQinktazj96M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FoIaKWYNrBFLETfZdpPO5Ck0V2dzk3X943IKh2igTvEUSV/R3+S8wY8xHPyTVnt2qM9HioUSNeoHHp8Ue9Mk//vX5iYu1gX0V4P28/h5rvxxPfUaBsX76u7QfPHqO5Uf7NQsx93TcvmDG3yotzhn6ZB9A0zFnR8b082t/J4aPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qGFPh5G9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qGFPh5G9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3P5c1433800;
	Wed, 12 Aug 2026 13:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t/oPu3
	mGYeHiCVt2HPDHDApuQ6QXhzHGBYRFYm8Xli8=; b=qGFPh5G9v/BjtLEQzpwSVW
	bbi4U1GFi/Rsf0EDFtcK6I7Oic59H9mbbrqxyqq3w2VeB8db4QQ4B40xPFTkUutP
	RuMvb1Q0xRT6YQa0oOLdpFzvsI5m1RzwH/F35/0q52z4iJV3+1J0uyy5NIFYEzer
	lCkKBaykMkETFdvs3o72YLkFnPy0o8mP2090fTs+6XdMLfZFP354nJ+/OG9eh2I6
	W/kRomH06rycAlvaaVWMtYkwSxPLejpM8Q3xa1aR3qf+DiX1eLdjlS08zOBCDKgr
	eKhiw3mFL5dXd35IjhQb6hMYUY+L/RiDIhLoEBKdRTvkq9GkOIRNgy/LVulCyvHg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk02q0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDfi0I021303;
	Wed, 12 Aug 2026 13:52:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy61ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqbTN42009078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDD7A2004B;
	Wed, 12 Aug 2026 13:52:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1BB520043;
	Wed, 12 Aug 2026 13:52:37 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:37 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:34 +0200
Subject: [PATCH v4 05/20] KVM: s390: vsie: Move pin/unpin_scb methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-5-f19e49666315@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=wdRRCzn4k0wVqr7C2Cp1JywEk/vD1CtZQinktazj96M=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VYuKvvtM/+xaFfmS3euk1dWXEc7aITVGUzS0Iw0dm
 U3jj0ztKGVhEONikBVTZKkWt86r6mtdOueg5TWYOaxMIEMYuDgFYCKXMxn+WQaJuhyrOP9BWkxj
 heCmB2w+95dcu/6LdwPfjboPDxs/FDH8d7rGe3FfNWeuL9PjtMftaY68vZrKc1e/eFXQ3nGxIXI
 VLwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX35e98irYovYb
 MiYtvwi49fShI/50ORJ2nhLcAaVtmVC5bKpttTqwSoeHtJS5nIo98v4s6ZLJHUUTkmxEpxYy2ww
 3bIbUXlKQAHjifG0NQddkAUXE/F7kZJtA23pNo+QQSI5BMi5cvdz6AeLQ7zK9Wotq4iQlSLT8fm
 h5tNMXfDGAaqwbAfN5xUKsKaCDWHdlOohPHMEnPNHqfLF/h+OkLJU84FKvALdPEqyufLj7k57fS
 4qQSLaGkkQBVY5cuSJe8ily7PFIM5O1FxmTVVeCDDfLG9h1wZs8W0dUQiJ/6jaj1hwGRJy7QFT4
 fCuaY5kM5jz0sq2RJY7C4vUa2W2V+VEPP7uUD95fWcIUk9jlX1NRmvCut0SscvUBrdOh4fKM8wp
 encjt+G1lg4ueD0vZ/Yb24wR6pgrBKFx1XterjI17uwIRgBXTo/+2I4FY0gtC0G7+RNLJH6C404
 hGpqHjJ65uY+dTTBH8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX6l2ZV320QiCQ
 N5oJc20GwgDq29GiMpElNclh6wND6NrMjC5obQ3drE61e9XVnKDsMMjae7gzkPEmp1f7MLcwAgs
 TXuERbSJHC04KADi2nxcWJezzniR4Bs=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c7aaa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=7EIyOw4XjRUV76RzNM0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zNhPPQatKAv7G5C8pI3O1uMlRhQiHWe4
X-Proofpoint-ORIG-GUID: zNhPPQatKAv7G5C8pI3O1uMlRhQiHWe4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120110

Move {,un}pin_scb() up in preparation for the next patches.
No change intended.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 66 ++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index eea670530acb..4b67bde0535f 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -660,6 +660,39 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return rc;
 }
 
+/* unpin the scb provided by guest 2, marking it as dirty */
+static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+		      gpa_t gpa)
+{
+	hpa_t hpa = virt_to_phys(vsie_page->scb_o);
+
+	if (hpa)
+		unpin_guest_page(vcpu->kvm, gpa, hpa);
+	vsie_page->scb_o = NULL;
+}
+
+/*
+ * Pin the scb at gpa provided by guest 2 at vsie_page->scb_o.
+ *
+ * Returns: - 0 if the scb was pinned.
+ *          - > 0 if control has to be given to guest 2
+ */
+static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+		   gpa_t gpa)
+{
+	hpa_t hpa;
+	int rc;
+
+	rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+	if (rc) {
+		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		WARN_ON_ONCE(rc);
+		return 1;
+	}
+	vsie_page->scb_o = phys_to_virt(hpa);
+	return 0;
+}
+
 void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, gpa_t start, gpa_t end)
 {
 	struct vsie_page *cur, *next;
@@ -910,39 +943,6 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return rc;
 }
 
-/* unpin the scb provided by guest 2, marking it as dirty */
-static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
-		      gpa_t gpa)
-{
-	hpa_t hpa = virt_to_phys(vsie_page->scb_o);
-
-	if (hpa)
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
-	vsie_page->scb_o = NULL;
-}
-
-/*
- * Pin the scb at gpa provided by guest 2 at vsie_page->scb_o.
- *
- * Returns: - 0 if the scb was pinned.
- *          - > 0 if control has to be given to guest 2
- */
-static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
-		   gpa_t gpa)
-{
-	hpa_t hpa;
-	int rc;
-
-	rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-	if (rc) {
-		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		WARN_ON_ONCE(rc);
-		return 1;
-	}
-	vsie_page->scb_o = phys_to_virt(hpa);
-	return 0;
-}
-
 /*
  * Inject a fault into guest 2.
  *

-- 
2.55.0

