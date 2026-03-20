Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515E3CFF54;
	Fri, 20 Mar 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023353; cv=none; b=TgdAxituMzh83BQ2bl3LuWCG8S3z8eG+NScKZwi77KA5Sl7YCruppLTo+VG82OX5S1c85i5zAcXle2IwCCcl8eDeAX3CinvKveeOAhKXypKKNcDQlw9+YqgLoT61XiszpYy9wsOprGomhzYYlaSGxDo9v7EpB0v1ZjVPXfXT1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023353; c=relaxed/simple;
	bh=7HHoViA5UaeAvDtI2DNpgB8NR4rP/baKjtC52YUZChY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZrcl2zN/WeLqrfNliv2MfMDwIRjXnd/xDd39Q1oxWHYtKxSMTFF2QXFF5wHT1CXzQyBSdJMf1ywfPSysMWAUMYZE0IDB9MLShk9LQOrf/mcnRbCne7E89cEMTcuqrHePyMp3ndZbTtTGj1lenskk5zQ1hHVZRiwdO4T+2ldd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NYWbp2Zx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NYWbp2Zx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KDp5BG3931551;
	Fri, 20 Mar 2026 16:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0fwhjDUsim/8FQiFH
	USqVbqoW3hpMGVBUv+3UM6jGGw=; b=NYWbp2ZxHjde0qOpsJUB4YMMrDJNjsaGu
	7VgUIqWEAkueFGhuyAnNl6E+7/2/MTLmu1MCOKBWSfOdYLSttyS5w+9c2NQkT40G
	wgYjjSBQlSXYOpczWvgzwDRcLPVhaWhbPHwMiALGNYZf75cyuMXJlTWN4NpUCuqB
	xQssC25jYZ4FdvJPTd7qJGxy+jiIPMp9UB6S2XGw0U7rbpw6mEXxlVNpIvcGKjTQ
	T3U9MuL0eSMF2RqOOsbRYUgt/gHvoUz8y5fBYzE1uPZcF/qWaUIoXkTPGr4CR48X
	cVqNMV5IsBYZoNkR/o/EzYQGkGrkDtMtN9L2lgMMUcrFbec9/NE7g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauuf8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KBf6Hg004737;
	Fri, 20 Mar 2026 16:15:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sr0de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KGFhD425821644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:15:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F2CB20040;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 316422004B;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 5/8] KVM: s390: vsie: Fix refcount overflow for shadow gmaps
Date: Fri, 20 Mar 2026 17:15:39 +0100
Message-ID: <20260320161542.202913-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320161542.202913-1-imbrenda@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEzMCBTYWx0ZWRfXztVFzqE1t4l9
 3yUgz36AyDwYwaMF8sRYOrKgo7aA5r8aWnBwUQFKz80DVdJF5mN7waL9ZzJunQfeP6itKzeE1gJ
 QHRUaNQwcM47UTMuk0ph+J6MOzAwBUTKFAs2y7g3WZvOdayvso6FcOMBPZmbKWW86f7BSVxnTz/
 GUS7JP54vP2sFBJg3iZ4hxXRvDGJQY9kOQTAiwvXlclY850tHfEUPTVtnTMirMJPd91oXZpR9I+
 OnJO7plI/n+TrX9QUhKAUQlN8EhK7wDp+2RI+8uB4Ws2IsZ+84kTvP2UFnRj8CEP3U0haco6Tlu
 lWBsUgNxsznKjY0Dq1v9AU/6RrHvsO9uq8lpxjnITq8xi4YbVPHOvUhlABmbAEEsuTYLuclk16s
 4WozaXtIxsYbpLxoDbSYO1jU2PKsYviYfW0XE/5f83JShnL8w/99bWZsVTBHy+k83w1i2HcpafP
 CQY6HYTTagd3ptTwNOw==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bd72b4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=v6tYtx9Y7d4DOqc1eGoA:9
X-Proofpoint-ORIG-GUID: pa8iitXycZTV1t9tl37mZ6b7QOthg6RR
X-Proofpoint-GUID: pa8iitXycZTV1t9tl37mZ6b7QOthg6RR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200130

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

