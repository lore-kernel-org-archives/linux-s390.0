Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E6315D46;
	Thu, 26 Mar 2026 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531060; cv=none; b=pWbqFerZhZzO5tFqEPKWQfrO3UVhQAAHpgiaLUx1vdKTbTaMV7UQgxKJ5vAYYa7Jwq4LoPTp9xIvWegte4EI4XOqLrmRneuw7QF7P5l8NqHSOCwK4F+LIyof/1SerqFcexwJHsMdIKKBYGlAsYXM5gTPElqTSpmZJa7FXpzyakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531060; c=relaxed/simple;
	bh=MHdHLXyH7iuszd98LWnqBxEDGf2GEpHU/fgdAeQvjjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTy1JcAVldyQ0QDcxujItM7vyYv+r2kwsbaPYS1EJtEoxHo6zmxnt1fdHCkjNG/YZahTBHK1jYGg2zC+wTrdzt7Up+B3QgnoNsXe5uAqU8k6QzEXzxznQiep6R3E7r4r69NN46IM1uBYs4ST6MneIibgsd0kt+kwfYwHSvZX7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ij/9/8d1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ij/9/8d1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QCQSlO3655956;
	Thu, 26 Mar 2026 13:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vT3yYaXEv73JcuJ65
	PY4vf5XD+MWDZsakgN4+t2qViA=; b=ij/9/8d1R9CXltAk0YStqPD11HoTxLl5S
	euwoBt4q+x+Wlh0DZS3dw0MptNAdpPnGMQl3PFQnaGMiXDUMROJ9X8S8XHbHDTwT
	SdC/BueQLUNASQC1O5wSyOUbxuytV/3fVnqhIG1cuzLPZjxpuVHVqcZG4Uc3xh5n
	VQwt9tXvrwRcYLe3JXfcX1g7M2fzGT8h26JPClJGlT3kZN0g96lZpAPSxlTr4FYC
	7PzlVjgSvW3CWYBrpLCul2AW4gqWMtPgZPT9mTwh6z+El9fyRRy+BU2R+lsLkN9/
	k/fzqCi1jWVM9nD06vMTCOr47UN75DVP9nmSjh5p+1kni0qWSXWTw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0c9qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QAuMND031631;
	Thu, 26 Mar 2026 13:17:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nt36u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QDHVG652494710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 13:17:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36CC120043;
	Thu, 26 Mar 2026 13:17:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA0972004B;
	Thu, 26 Mar 2026 13:17:29 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.23.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 13:17:29 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v5 07/10] KVM: s390: vsie: Fix refcount overflow for shadow gmaps
Date: Thu, 26 Mar 2026 14:17:16 +0100
Message-ID: <20260326131719.98229-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326131719.98229-1-imbrenda@linux.ibm.com>
References: <20260326131719.98229-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA4OSBTYWx0ZWRfX9RXxF2HKiqk/
 QZ820ChJHhGkiCW4sVCrwGDM0IoQQho+zpIAweSDtV4fvmdn+6LMcxYNeiKM3h0mfjWUWSFcYNc
 RnqTLbuKhXwSbcasBbz2QS+RpH5V3/h55VFxUHk8vj51x4uhsS3VyC26BTbBzM1nxoj+rSUIREm
 tGFOw0E6PT1prjVGRSk3VOTuT7dxInR7EAoL/qeJCZHac+0rFIQwRggsH34FhmwV+pAHEdrqc8g
 QdjX5EwVbmSdtN29/rYXz/XbQZbU7SCahqvcOH+L+6Bo1fxfZFSZ1pTe/dRoeYsvWh5BJn6Of9K
 CBJZy/2ukI5titPlS/SHFgUkehpawNLKAsPJ9MA8vRcX6o5ED70sArOgns2PjOh7DbyBLJe4YbJ
 WaCmbZE9CCo1nNMJYIUlqp6FSbXqphpn8jsjZNFp2N2MMPkLU8WwhFHSgZzzeqLW9+xZQxE6JKc
 /EacTGKeNETR13bprTA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c531ef cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=h1h-QmE6hYAJ3QnyM7YA:9
X-Proofpoint-ORIG-GUID: KW8qg7Cm8SK72yZx2_PfjScOL5yXPqla
X-Proofpoint-GUID: KW8qg7Cm8SK72yZx2_PfjScOL5yXPqla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260089

In most cases gmap_put() was not called when it should have.

Add the missing gmap_put() in vsie_run().

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 0330829b4046..72895dddc39a 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1328,7 +1328,7 @@ static void unregister_shadow_scb(struct kvm_vcpu *vcpu)
 static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	struct gmap *sg;
+	struct gmap *sg = NULL;
 	int rc = 0;
 
 	while (1) {
@@ -1368,6 +1368,8 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			sg = gmap_put(sg);
 		cond_resched();
 	}
+	if (sg)
+		sg = gmap_put(sg);
 
 	if (rc == -EFAULT) {
 		/*
-- 
2.53.0

