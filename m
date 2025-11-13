Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27AA2F3C3F;
	Thu, 13 Nov 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046484; cv=none; b=M2g3Nxy6TwMQpiNKqnAMDVenGK17broaLlTaT+KlIq8PcQpeuXS+QWu5Bwxw+1OsNPTPYTCVnczSiTkqulvKK5GZEtuwRctivaD4gb4ytmKtCENP0KERsaRxfFtGqra7SAtB3QI7EyO5r/jQBWjXTFxos9cLJdaiRoCpc+QDxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046484; c=relaxed/simple;
	bh=vVxo53vSl4vNNa3h1pRmqCHs0UCW3WG53zBAqX1k8ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plaxzs6ncJosMeevK8ULIu3hTXGIdEuA7QodjvUtKj5rafVlMAUnKpL3Z7VdVp/DTSCeGAi7kDitgzJT6iO4pbh9r9oyDnnzKJ8nqLihjEUpNKWmnKbYMOGBCsnvu9GIuMntZpmuk0dqkFPpPcnET8V//uLoSmWUfieTotJONCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mqMxtPPI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mqMxtPPI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD9dZ28005929;
	Thu, 13 Nov 2025 15:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tVu78ZgGQdLrSNhHy
	pJCNj9s/OFeKer38VxsTuK4pbw=; b=mqMxtPPI7YzLODbdD+4zazzTShAy304gU
	574Dcwa2uX5lR607gXvtiFLAzEZGgCLSEyHe/vt0HPYz8ymkOI8/xwH+5vQyJyKZ
	dTJZ4mKsRc3gFjGufzlHfBNxgSjtQgOZF/mo2QQDOHaXuF/QH4PQhL0D0xmvEOz4
	naLqJ+nyOlqOVApI3kOBXl5Vkc1iPNLBveB+o48za6mZbyJEE21kPXZRAbU17NNR
	VaU3aq3AWQizwgFscNl1QWAXqdr8lnFZKC2HwpQeUjJFDMO5dQF2JNneROzAtcNY
	fnFwZYS11VkrX3V9kcF2BEkXuIG2bYd1mNsuFZaTqr4mnSGVHBdEg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7grv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCj1ig011605;
	Thu, 13 Nov 2025 15:07:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1p40m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADF7Vtc39715096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 15:07:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7A5520040;
	Thu, 13 Nov 2025 15:07:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A26252004B;
	Thu, 13 Nov 2025 15:07:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 15:07:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/8] s390/kvm: Use psw32_t instead of psw_compat_t
Date: Thu, 13 Nov 2025 16:07:24 +0100
Message-ID: <20251113150731.2697279-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251113150731.2697279-1-hca@linux.ibm.com>
References: <20251113150731.2697279-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX6gr4t0L/yl4d
 TdEuAi4JquVA0ePQaOjpZ8I1jWAtaJ1TlI+vwpAgJEH5nt7FeUqNxNHdNi21Ium/xNAdvQR9MOD
 KlMf7q7MBuEeWLUoNGiOUjGAFOrsosW5aUTK1Prrv3sugwFvhEGeDt3Q0j6xyXcCns/vOoCseGy
 PuYCN4PFn4gEGhqK/KCZDkJD7ru4jLTBAJpW/qAh06uaC3f2m8BcN2mYYngXjdCErkm48/se8A+
 TmGOlHhhWYaAniYvNumAlQm25kg70lrfU4QVYfcASJbCiDSObEJ2Pzi68K9OcXxPyGoDLRjY+d6
 yex6nnQ83yvG6xRQlWuSBaCy1stHRAxXtRag9xcwShI/8Ung7Y0PHEoCz4B52eRwWhYQeQcjWKY
 JOCYV/xUcm4gjMkpLvQh9onwEuYyKg==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=6915f438 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=gR_8SojlSWN7whlt0LAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: DBh7kQzkOzGLZbSUm378SXFJwRfcTjF4
X-Proofpoint-ORIG-GUID: DBh7kQzkOzGLZbSUm378SXFJwRfcTjF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018

kvm_s390_handle_lpsw() make use of the psw_compat_t type even though
the code has nothing to do with CONFIG_COMPAT, for which the type is
supposed to be used. Use psw32_t instead.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9a71b6e00948..0b14d894f38a 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -754,7 +754,7 @@ int is_valid_psw(psw_t *psw)
 int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 {
 	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
-	psw_compat_t new_psw;
+	psw32_t new_psw;
 	u64 addr;
 	int rc;
 	u8 ar;
-- 
2.48.1

