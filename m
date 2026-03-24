Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60A40FD92;
	Tue, 24 Mar 2026 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374206; cv=none; b=SxadN1kCOY3IgDcvzsPerRXSiAychfONJXOM/5FM+SOl5JUH/UdjsQtPJRYQ+KNRdQvavo7be3a6p5XLsALH4o6eVvqfx0+ccIUvF4zK/xOLFCMmkcTqLZqOZZJUIp3AKcA/TVQfASA2SJytB/+QLM/IIzKCXEwMrjeqab/3m+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374206; c=relaxed/simple;
	bh=MHdHLXyH7iuszd98LWnqBxEDGf2GEpHU/fgdAeQvjjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pb+D/u2+77bd8Oki20sX2w1kWCQN6lZAIIxKe0N+hJ0kFBXMu5vVMz8dAN4AoHa9/7DGwb0sneGHRyHg19tKBbDqqdYEt5KDye8fq4qwy8sHxBYEHr0dMQR+9u4FRioOhcKJ1IZ+uz9L74lkmDfzPle4QlZE+AMBUbsOF70WSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lEtEaAUW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lEtEaAUW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ODWmR13255707;
	Tue, 24 Mar 2026 17:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vT3yYaXEv73JcuJ65
	PY4vf5XD+MWDZsakgN4+t2qViA=; b=lEtEaAUW46DsMEMIxqaLlJl2LJsS1pB9L
	vCqMaZvJsXc4OSYhNyTzIqPteJPe9vFb9NJlJGwdz26ci9/zRlCR2BXufRtrS2Si
	Utb5qXnh4olOc5UHxV28EdfVqYQrGLVrZrThbezDPMPAR2T/4isHWv4RllbIsSOx
	PyFtd5xTX6UBZmmzl2k5T+rvbFHP7M+EfUE6Rssk93LqYaBRfyq8i8zXoibwrFi5
	V8Cc9XUuNFUAESWex4s/nXp/ERVbhrt84egRCAo5SXpyB+eWCXE/knUADNgWfubJ
	vdqOon2gOz56BB2UylTQC/pKuATwTXamXhPmveMD+iBwMAdtFDpnQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kummb38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OFVmjC005996;
	Tue, 24 Mar 2026 17:43:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yk6yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OHhBdc61866418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:43:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91CF120043;
	Tue, 24 Mar 2026 17:43:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F1AB20040;
	Tue, 24 Mar 2026 17:43:10 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.26.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 17:43:10 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 6/9] KVM: s390: vsie: Fix refcount overflow for shadow gmaps
Date: Tue, 24 Mar 2026 18:42:58 +0100
Message-ID: <20260324174301.232921-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324174301.232921-1-imbrenda@linux.ibm.com>
References: <20260324174301.232921-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5APyQLQE2ZWC_LEL3f5YnGqVOMscAHEB
X-Proofpoint-ORIG-GUID: 5APyQLQE2ZWC_LEL3f5YnGqVOMscAHEB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzNCBTYWx0ZWRfXwvqmtl5qBFyN
 SJjHaB4PUzpodQ23DlJMVD3cSrMbZWxACHv8nbz1lorMLsZuT1s0cdNCKWH08KuCKcxLPqeKPu2
 5ujCjlbEaHKZFTtmwAxkkStGY65+9Jgg0uhZqQPCcOzIwJdDP+iKfKTLjMtwWNp7spmJFv5qohK
 mDNERRSqNTuArnCigZs7VOxvArpWtvJwOceNXkPLcnEr+5YhcxcpQ7cv2ekpqqkAbVGHuvHLnI5
 yZerrTSeiavtYgVta2Mu/1lTQPJ0nJ0f6uvS2Cm/uQDDW2XrSwRW9fiRZAWpVzPoQNFv0zygumU
 /ek9fB/u+dZ6zB1HZqbGnZp3VjWzTaOnEg6SLdpWYzDMpwfHtibrNKKUhS7B0I9XGUHs1KPXqrx
 GCHEtH58bj4CgY3q75wAVa1WiJG+h7/9fH0w2CYnVJDerE0SRrU3pVqmNuyQrekDP8MB2EH5yBp
 5XkapuES4qYDEFl5YXQ==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c2cd34 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=h1h-QmE6hYAJ3QnyM7YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240134

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

