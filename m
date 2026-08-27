Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6463D488233;
	Thu, 27 Aug 2026 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845992; cv=none; b=JzFYX1ScPQcuL5M29Xw2Q8zzu0E6YWTjuo9SxqkF3XJN/2osYD5zavK/8chnRDub+VAw7nh6+31BT+7ZWzd7lagJif75BHImen1G+kxw4VkoNoV84RIdO99SR7geDR/bZkEoRWcAkaiPqI2D+vdWveosd5ACJ3FIlj4ocJ+rHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845992; c=relaxed/simple;
	bh=3ISA+GddFojxUU2v2CUzfwLCCzz2AX0OTr/H/Qd3XIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b2Th8XUZsKqdvEFt+b0qTWYFs+g4p/zFFPLPDUu89DMNoCuzP225AdMAVHAeYOoUdmDTvwSL56i1nWSPNPRSfVFD9ufG7biWnkaUjzuRjXQQc3W6AlhK2tJfanO3nmGPPsQCiyULqj/lKQKvdhsfZqa6Le59aEerpnC60qcUddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cev1VcOM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cev1VcOM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF58591478410;
	Thu, 27 Aug 2026 15:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MkIt57
	sA0lOAnb5RQJCAO5ScI0tf4xW9qOrLcFx/NmQ=; b=Cev1VcOMEoP38xIYeTxBrh
	WYgHD7XFPxxzJcZQL/HVNQt6oZF3LZ+GUuce4LQzQzWkwz3NFFTroRj4piatKJDO
	6lbR7383ZAslkxsQlqUUmL1tlTc5bUXSGygZMN5ufLlDdxORN9woA9HWEEkpUwZ3
	P9p5+oPUUfeLtWUjx2uBJcYuGgsx9NoWmGCpbCjkJcD97j280d3t1DeDwGMBtnvr
	BVyjG4VodeN/2k29mcJC8YuNXxJe6M9U1+EGHBd4xT7V6NNM41jfG53QA9moMCmd
	Onrxm4jK+8uVHezpfvN0ipzO+3mkycuDv0U2mdgE49aTM/0hG5ZEhgC2PU2gSo1g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er6b90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFfeGr008831;
	Thu, 27 Aug 2026 15:53:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsygm9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFr29p36438380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:53:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB2F320043;
	Thu, 27 Aug 2026 15:53:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 105752004F;
	Thu, 27 Aug 2026 15:53:02 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:53:01 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:51 +0200
Subject: [PATCH v6 11/21] KVM: s390: vsie: Add helper reset_vsie_page() and
 unshadow_intercept()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-11-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
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
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoPnt7yu8r40P2LtypNdD1Z92NYmzP926o59DMesh
 Hj3HBds7ShlYRDjYpAVU2SpFrfOq+prXTrnoOU1mDmsTCBDGLg4BWAihYEMf3j81n0QUaiYeSPs
 0PYTLSePhobO9TnXdr3ao73Nb1P1+rWMDKuDHuxPer7PesrX8v/X/1qVnSteGLE1uSEp9kLqmdl
 TfvAAAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: OlgjpafPyYVu8xSOLw2Y2V3FkKQGV9ep
X-Proofpoint-ORIG-GUID: mz4hJSZCXofe89YAukSpnxstODvYxfBe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX5sFbA2Fn8QBG
 jB11/DmmoeNoojhl/o1rzECjMEVa/Z6FVW1IiDsd8bMVnYCSJu4ptDQR9Qc8NtwESj8xroDLuYa
 czom+3HgXAu7kodvM01xuwq8yeIzu0a6PDXkrI7/s2YaHP/fV4kZhraPFVGKjRH0RyLoOuYYYYr
 tES9cUL0FWHKsSEtNrW/qTPwsV2noZ38ruPyvG1sZzSgXvzhI4CxZM8jV/9F9BM5dNCaqQF7fAV
 6VFhlmu4TjV+WYx2aae1sS25O+oqanSFL/1H4HpNuOSmW24lYuCx3XsMRbkmizm4I/8mkp+vHWz
 32gw6DQ5hCMxrmJl9W2MOmBQtlyT4mOxwlsh50v4MhHPndbTRAJWE9HNAR9qXbw0QorJ/LUdYCX
 JeGVkeMRrchKF1GqVuv7KkSnaN7pOJSUYwK7LgXbbfoOqjhj4gVjQGSiODPayx0J/fxj8y1/7zR
 fbi8H/7eAaMUioR5UhQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a905d64 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=BT4YM3xfTWJAqdQ5kpwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX/n4EXF3AV7m1
 3DKXQHCe+3tSCrh/KVFmJLyxfKhyu9VrDdXgdWR+3Hp4CDfd5HyBPEVqwF3qzgWlcYK1QC4DA+v
 XmjRU4yUq8fsr1QMELGxdPeyyI2lDME=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

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

