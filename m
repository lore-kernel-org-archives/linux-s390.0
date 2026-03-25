Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9EA3F7874;
	Wed, 25 Mar 2026 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458803; cv=none; b=boyEKS7q+Yy2RJcomkcRC04WFM2Ftl//istvt6UwAMLlF8yjOz3y5nC3cOy+Ydi4TUfHucdh1SPaRBhKjcPL9Px6LlyCW0TV4brGCbWZeXifousvtjPGmIt4hvDUQ1AZQexL9S7HloshAaW/bAPLF8qf/p5BFP0ZqHf15dPdHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458803; c=relaxed/simple;
	bh=MHdHLXyH7iuszd98LWnqBxEDGf2GEpHU/fgdAeQvjjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxIwGlzn2OROjUk+pGQ59fuTqyzknIOnec/Q8VO/qxFV3Rb2h1vqCrzjcwri5xa/3N/wKoPRaIk1Y2dAjLBcl60eS+o6VhyQyzcDgTzSRv2OxrpMm9olEd2s3kQmZuOmUtoF/bGzLMy/+2WSlkW93ixjv7nMysMuw+FwWkhAh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fd4LaAXw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fd4LaAXw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PC16LL819878;
	Wed, 25 Mar 2026 17:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vT3yYaXEv73JcuJ65
	PY4vf5XD+MWDZsakgN4+t2qViA=; b=Fd4LaAXwiaQFL9prED45BohYWNXHalQ2z
	cXCfZRfTZblABrVgmDDDLnfuNrLsb8R93fD4eBf0FtQXa5uGzKo/escEBvYZ2ZrR
	Ze95XvOHZbT+/+7m7+47P4AySZoE5kO9ugjEHqMdl/Os1ClqmTIo5+k1iTEd+BYt
	CpBSXnVRJICi8xC856jkOMYZ4uk/iUIuNXX7kCYCPWYincBkvDBFzUKPZFh+C+4K
	723HTQNBXFzElMag10d2f5V2Vo9KddAgI1yxmzd83zUO0kNtLK+WwlBw+yc87TmR
	0KM0b/TgguYNq5ZFlkIDafgHdu13nlAHgnfYS1miCs3v0Ctl6VYCg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumrs7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PH1jbK004398;
	Wed, 25 Mar 2026 17:13:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c277eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHDDXb50004262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:13:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D017320040;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 993DB2004B;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v4 07/10] KVM: s390: vsie: Fix refcount overflow for shadow gmaps
Date: Wed, 25 Mar 2026 18:13:08 +0100
Message-ID: <20260325171311.182210-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325171311.182210-1-imbrenda@linux.ibm.com>
References: <20260325171311.182210-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QZETVS9WpY0SnRo30DsNo3v7eM-3PfOr
X-Proofpoint-ORIG-GUID: QZETVS9WpY0SnRo30DsNo3v7eM-3PfOr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyMSBTYWx0ZWRfXwlI8S6hzHYQ/
 4TyzPP2dG1VxXxuMWYdDV+BVHzQwfhWToIvbjOLYcWr1D28ZcYyA6vexWkBxRuGByt0ohpEBpKv
 1aXjA03XGJ5fpHR32tEvR54WcWNwD5J2yorDaDVjx1WaFpJNaDwitzr1P0xyZ695RsFOJhoRv/k
 I65Iq66xEWnKbOD9bykwAreXziIq0gRG8I9ObKpIdYzJmqUEwSXq/niF7q+FyhoCGRF50WjOScL
 7WZN8wPkon/aK0WQwu+4fNRQNQxiZF4to4ksky7RPUX5Vh0zX4S2oNpZwodYEpRKYB8tv3mLRXm
 UnOXISTx4XzCOEtr2ZSN8y9LcFixxBkDa41pEKbU15l+1lnotav3CGD7wtQZJ/a34rzMykol+xD
 erJ7mnG2w4WaTD8hCg79qJzD6kaSifBDDH2lQTJq28EDhb7dbi2/uZ45gtRTfrdhwXXubfa+8JM
 X7jDwidHhA/tM8neGTw==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c417ae cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=h1h-QmE6hYAJ3QnyM7YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250121

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

