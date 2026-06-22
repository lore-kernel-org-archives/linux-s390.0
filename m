Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466C3CB2F8;
	Mon, 22 Jun 2026 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144469; cv=none; b=D8rnnP8MjS1azqGarBfpuutQf6xBa+hEoLsf2+SwJ/yNa9WOEsrUxChySdP1MROefYnRGQKr5CKzJKq1Z4+rssVJE1s2jO1NsBLrXqEM4bVMGPdQ43QL3sbLh4/vqFAteFZYIVW1SfM5i6sDFRZOk8eVLFTtyFwlal3zbPdqcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144469; c=relaxed/simple;
	bh=iilyN/XdzzmzC2BPMd1sUsSiPTCD6WgAI8AIn5E10DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/CkqXAZfnlYwLyO2xG7s5j4Y4qAQ1hFy6gqs8iUzB35Th6Sm4p9ciW9CAwSzuJvgNHvyXauHKut4O5hjVjoYhVLbRzP35wMZfstyf2aD4n21YCLT+aNN5/hCRRrZs8mKT85Bz51bafiaFZ1JaIlxxrGpbxjAnxCHALMw6NLC+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WgxblJlW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WgxblJlW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmMUG3591787;
	Mon, 22 Jun 2026 16:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iCKeneeUC+/w5qyC0
	Z+7Raw7sHukH2h8vH++xh4wDzc=; b=WgxblJlWmtVlYsnxIxDjbQXIKNHb6WMDD
	Uoj4dOPVWdPx9R1g/qxg9Ou+B6cTzv7w8ODdaErnvfv4CCwd+4cStlCBU5lJdj7k
	NCFlpPDz6yxbH+/zGc3zXzQTBuR7hxPccamHh0wjH9KdUL1czPNmcHLyBL5kkbgW
	6uG1I+gmymwOi5qG0jijR5RoFxtT5NU9lb1CQ8Y2Z9pfM9j9aQS2Z+YJV0P291m8
	f0RwNzWrciURfPf+buEtIwW0+pvLwLjEXHIhuRS1F/UPsMFrMEhstaSEXf/Kd4H6
	hf5T/4dXQM+875o8xAo8O/KavOOWwifCXZCRVSoluOj9RG6mL6Nbw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqj3x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MG4j0W028244;
	Mon, 22 Jun 2026 16:07:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jw73vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MG7fbM7340488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 16:07:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 610AB20040;
	Mon, 22 Jun 2026 16:07:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3505B20049;
	Mon, 22 Jun 2026 16:07:41 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 16:07:41 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v5 5/9] KVM: s390: Fix handle_{sske,pfmf} under memory pressure
Date: Mon, 22 Jun 2026 18:07:35 +0200
Message-ID: <20260622160739.202044-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622160739.202044-1-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a395dd2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=tAqH__8HQhgemv6Xi3YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX4nGy4CADBj4K
 g/MKAknO67NOvBRRroWsZsA5hq0An9vpUDjIElemsWiuuJcKo3yDWAsdnLYA9ybiIc7phFwYGw6
 yIBqrmfW3gfNM7bIH46/+IdHVwivQgxNNryTHg8OX32zmnJWzZsXxJeQxHNZaQKYNqum4JB0UJs
 0T4nUpin5ptmIJK7zaaGUP1EJT+huoDpn39NYO0gpjaKMaB2yc/rzrV3zmt5XTCM9a7JaGCRY9Y
 tDAgq0JEMrzo+NjVEQPLJg2f7k+Ejrczfw/mplcymM7a9bVHaGnH7ggc8Zu9f7ij/f58m+P4zv0
 P6gR6k24GqKgXcQx/FrLgacTpYQrzzptlZY/uIHHWdSzaNvuDGoAm2kelAjGW2u+2ziWhByrShy
 1ettGyYUjgcJRGsgRo3m//K42xDfS8CYtwMGQP4rhNUyievUKwMoO9aeKWYm2NnMCfDVvIb17sH
 n3LwuuLeFSmD2XawhDw==
X-Proofpoint-GUID: 1eLRfbO8NMGxxgH8C-zTjWFNJSefLaLy
X-Proofpoint-ORIG-GUID: 1eLRfbO8NMGxxgH8C-zTjWFNJSefLaLy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX8SN6h6bWWzmx
 vzQoEqWlz2h7JW2/OOcHHqjA3u0qhPzPVENSwnDh2d1L+Jm8qfl/ugWu9UBr6guKWY94D8XSiB8
 S9AS4cQZhWCCkFDoM4cSsd9a/BX2FOs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220157

Under heavy memory pressure, handle_sske() and handle_pfmf() might
cause an endless loop if the mmu cache runs empty, the atomic
allocations fail, and the top-up function also fails. While quite
unlikely, that scenario is not impossible.

Fix the issue by not ignoring the return value of
kvm_s390_mmu_cache_topup(), and appropriately returning an error code
in case of failure.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 447ec7ed423d..9bc6fd02ff77 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -366,7 +366,9 @@ static int handle_sske(struct kvm_vcpu *vcpu)
 		if (rc > 1)
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		if (rc == -ENOMEM) {
-			kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+			rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+			if (rc)
+				return rc;
 			continue;
 		}
 		if (rc < 0)
@@ -1122,7 +1124,9 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 			if (rc > 1)
 				return kvm_s390_inject_program_int(vcpu, rc);
 			if (rc == -ENOMEM) {
-				kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+				rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+				if (rc)
+					return rc;
 				continue;
 			}
 			if (rc < 0)
-- 
2.54.0

