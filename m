Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EF53D9DD3;
	Wed, 18 Mar 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842944; cv=none; b=rLvj1SIPKCTKwaa6McdcNbUlTpub95/CK4fjs9XNlXdDFZb2bKPJkXAWttR+AxZE3VkCIQVnJiuXiWmMSFRmRtlqahOZESkIQ3utbD2zbxxgMjyfKEYgD+9rddDZah4jOj/ECIucRTpP9DtxiNtbSCnSqYTPNTbu8FCqsw0qJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842944; c=relaxed/simple;
	bh=7HHoViA5UaeAvDtI2DNpgB8NR4rP/baKjtC52YUZChY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwLV9IAFmV4sxy1tDkftp9JyIpJ+uqojVERDnjy/9TLbpG4Vn9gokeQbFUkOFTg5xjsa0hE8cecvrPMxFMxM1WQH6rc24Wu600xTez1Hb2ZfspIDDCgocHPuqxiIfHLJ52oq0VThEqnhI+0/x3/DtRAtzPR7+1V1ISO1OeDGrlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C5i3kDE1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C5i3kDE1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I6MZXm4022659;
	Wed, 18 Mar 2026 14:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0fwhjDUsim/8FQiFH
	USqVbqoW3hpMGVBUv+3UM6jGGw=; b=C5i3kDE1pZHKClXqwvNg7Nw/ENjKe+Nw9
	NbeQEZq9mh8vFeRoDUxge8csWCu+eRhXBOkmkPr0q3F+Q4ngpR4Igz1ROysPNgI4
	xP1OJvu2V3b6nPCA4cLJO8YWWtff3/66QRvvR+Bw4hYfaDhW9eAX5cHWzUxsRLix
	bbduOTRRVUngT/6uwLTMlLsrrryT5hDop5enpGnW0Zbw6CfbIJmzm3CrY4G2rTf5
	jg66sVrPnZYuC7KvZTzQBfnJAYBvzM2akOXaTDS+OFPYfb6GleuDxz1nrsCxEmHC
	gkxWwnyfYEOZJr254grQ32ENGZTzHLuAJm35r67YVT3ElbXS5C9Xg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybsaaj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:08:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IADZ6v028510;
	Wed, 18 Mar 2026 14:08:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1e2wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:08:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IE8tmD31195444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 14:08:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5338620040;
	Wed, 18 Mar 2026 14:08:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13CBA2004D;
	Wed, 18 Mar 2026 14:08:55 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 14:08:55 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nsg@linux.ibm.com,
        nrb@linux.ibm.com, seiden@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v1 4/7] KVM: s390: vsie: Fix refcount overflow for shadow gmaps
Date: Wed, 18 Mar 2026 15:08:50 +0100
Message-ID: <20260318140853.119460-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140853.119460-1-imbrenda@linux.ibm.com>
References: <20260318140853.119460-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bab1fc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=v6tYtx9Y7d4DOqc1eGoA:9
X-Proofpoint-ORIG-GUID: uPXr6-JW9oXNUZGBOZEkAFhC975Wjk93
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfXzbRKgwpwzeyL
 QghN/3IfXkQfOH04k4/SZYUUdHh/3erX5VQAZTzSTh6ta4ig93Zrods/MRoF1uFNKmq4xhtkder
 2tfn8DPZ0JhHxzgvTXdsUsZCFzko78TLO3U8Z1SI2U0Fbk4xSkv51XCdb3cEy101UGnk0qTxN1s
 PZ+LUoiclSDkDj2j6dNLB0U6USmtjXUlNBCi18bA4XkfzqIJP5j1ood1yQzsDF7Qjhp0GfmuXTy
 uWAEJ8RTAjcaEe1r4L1olZTGeQ7Vpu2G7/B6SD6RfIoWnCAjWvxqYDGKoghA8HXouDw7mPWWEvU
 nEV42mMirAHFgfOD1jXnNa9VoRysTLhkyPpmHIOpA5cHiQMkgUstW5BPUYnuX3ERiSpGGIG/lVx
 L50i4da0Cqgy+5aHqk30o4fkuuh2LuubyfmBcDAaLxL9xJOP5bisuxC349x2heShRMwgJYz2/tA
 cpC6O+JE/dwaFu880MA==
X-Proofpoint-GUID: uPXr6-JW9oXNUZGBOZEkAFhC975Wjk93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180116

In most cases gmap_put() was not called when it should have.

Add the missing gmap_put() in vsie_run().

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
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

