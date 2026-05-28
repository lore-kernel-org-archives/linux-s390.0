Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E73CE4A7;
	Thu, 28 May 2026 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968859; cv=none; b=ujPQu8CihcmjyVad5LG+EmtY/01qn347ujUYXP7pSxNuLub/hKvyNHJcPCt+X72E2bd+mLZmt74m9GH52HQ3hQgArtBq7caNujcKz85nW1Jiga/8vFyU4SLSqF/QwKmFDdUxhNcVgdGMTe2dZWvDjSzeH3fY1fVETajPWKpc65s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968859; c=relaxed/simple;
	bh=q/4VAZUDR9wKIqDbkUpA49JakPieFRHX1ZGX+F9Tlk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4snp9Jd8KRWqqV1HvmOdASF+nuUgZMSG8kJAGlJG7DuIsMxQaLJqFrcAHAqP6Ir8BCLscRjNUxPYQbWN9YSy+X/T5x+GfiTqIur0jkVVFxefNLlWi3a78h9eMd5i/GMJhTibhXXUstY2aAW9p4GL3cEKhPoXzM/bUZ/TBQrQ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qXoN0sIh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qXoN0sIh"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL6Rgi2692044;
	Thu, 28 May 2026 11:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Q3ON+ZZRcqGRnrLY+
	eHwQpEqFpiLy7qpH+dy3PWXk0Y=; b=qXoN0sIhNbq8/A+RSPTnx6egznwnMX/Z7
	QiG6QkjHOyRBjW1rpbb/QojWyQq5sSl17n/+ra70mB9/JAceebgD7f7L5LJ5KM5V
	IFGbGR0HugOlP2R1hpdUiWaeOspPGUymB9HwxSzkCHiUYv3hrAo4611wr96rrvgH
	3NhwNCz+17kbnaazpEruCff9ny+mdJzi7AIa93IjlIzX8ETG6R8uMkN+46dsUxUV
	31rI1uCA+q2CxGobX6zFt4xn7QlD057mjYCtJxZlEDh8r0tvOq0UPkMcp8o3CSKT
	7u4yrmPoWljHNYV3tuYIXS1tL5I7XRCARnZQnw6nYhA+f8HEv14FQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884asvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SBd7CO028896;
	Thu, 28 May 2026 11:47:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbqw8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SBlSl243581888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 11:47:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC53A20040;
	Thu, 28 May 2026 11:47:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AAE820043;
	Thu, 28 May 2026 11:47:28 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 11:47:28 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 2/7] KVM: s390: Fix guest / virtual address confusion in _essa_clear_cbrl()
Date: Thu, 28 May 2026 13:47:22 +0200
Message-ID: <20260528114727.142178-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528114727.142178-1-imbrenda@linux.ibm.com>
References: <20260528114727.142178-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a182b58 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=DrbGolfmOjewO6_yJogA:9
X-Proofpoint-ORIG-GUID: T4V1krLK1xMTEw2Rp2OrGNmqw-_-3hhI
X-Proofpoint-GUID: T4V1krLK1xMTEw2Rp2OrGNmqw-_-3hhI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExNyBTYWx0ZWRfX1GPe0STKurPL
 5WrZ7FrtIYUhBMmrxHbNMfxRRw3WV4MQ5V5KmKfrpWG/xVfIkf5o+rpTRSKPRC6c4JS97/uPZ+o
 jDFTVMAMd+BmkTLK8hEWMKifHmZdhTq31Ii5UEkqDcDHbgKPrcohwfxB63TfcK3lTzOFPVU22a5
 KME4845ARYsEkdqEDn4wtJomEb/9oYWlHXN4wJw1NNXI3BV8SzK7ti/BqY63M6KhMjMDbsFw1uk
 YWclSycMijaPcvkWGJTU7ctig/wnbk0DVYOPSdq+OehUawdV8uR7hrnnan33Xi4i+N47BOnX8qr
 z4h6f2RveSrO1c0BMguhZKty7feiUSEb/E2wtnstdj8WTzPAYJGbKMUeIowmiRXvBLI7qZRdbmT
 5xOQuCXJxa/XzZ8llG3LJyM4gFDXGSmgK4cbfpZ8VYD01hMFfBJJfDGEtT/Kj+puEmurZjbbyWY
 UMOmCvio+TYBIoeS8tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280117

Until now, gmap_helper_zap_one_page() was being called with the guest
absolute address, but it expects a userspace virtual address.

This meant that in the best case the requested pages were not being
discarded, and in the worst case that the wrong pages were being
discarded.

Fix this by converting the guest absolute address to host virtual
before passing it to gmap_helper_zap_one_page().

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index cc0553da14cb..447ec7ed423d 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1188,6 +1188,7 @@ static void _essa_clear_cbrl(struct kvm_vcpu *vcpu, unsigned long *cbrl, int len
 	union crste *crstep;
 	union pgste pgste;
 	union pte *ptep;
+	hva_t hva;
 	int i;
 
 	lockdep_assert_held(&vcpu->kvm->mmu_lock);
@@ -1199,8 +1200,11 @@ static void _essa_clear_cbrl(struct kvm_vcpu *vcpu, unsigned long *cbrl, int len
 		if (!ptep || ptep->s.pr)
 			continue;
 		pgste = pgste_get_lock(ptep);
-		if (pgste.usage == PGSTE_GPS_USAGE_UNUSED || pgste.zero)
-			gmap_helper_zap_one_page(vcpu->kvm->mm, cbrl[i]);
+		if (pgste.usage == PGSTE_GPS_USAGE_UNUSED || pgste.zero) {
+			hva = gpa_to_hva(vcpu->kvm, cbrl[i]);
+			if (!kvm_is_error_hva(hva))
+				gmap_helper_zap_one_page(vcpu->kvm->mm, hva);
+		}
 		pgste_set_unlock(ptep, pgste);
 	}
 }
-- 
2.54.0

