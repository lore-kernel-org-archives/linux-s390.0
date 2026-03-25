Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F9329C7F;
	Wed, 25 Mar 2026 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472527; cv=none; b=JjCTCZM9Al5EGtRYwfNzP0f7enaNaEBjQA79useFWajU59byWrnVNMOUymw9vynmzFQ0FcjWl2C1gUBeVo/pGgl864daLRbVXJySJT1LFBE+qZPad09lefwgQ2PvVaLzvB3c0A7S0Qh8wGGOhBdqvwaslrSmiORdF57mFPX+rNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472527; c=relaxed/simple;
	bh=u4CaiVCrKNvlGyKoHcj35sUlKt6KR32/aT5GSDFNhUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tg+w0iLqU3S3unWx21iPaAhvzVeinOmBPgr4eMZlqSoBMbN4iUrlR0dHNMPEcPNNu61t/Z34IGImb8CwEBr41+5nWXeoF0sZfLgZjJh2yChZFofwSM9df1dJlO8aUy6lSlLXJhcrCbe36KF+quRF1pMn61x+0DGsfB3o5xQVvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Iwie2X/h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Iwie2X/h"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PCkDlZ755965;
	Wed, 25 Mar 2026 21:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8mmNKYydXdYtAcrLN
	CQrgPJbTDLmjEo3ArIPx112Q0M=; b=Iwie2X/h/M1AyApl76qM00Sl7252f5aVO
	/L+4NZScOMCf09MS/6n55p4k8YL575dyPEdcKoaid9XqRRwdWWWoJH9qsqOdCIKc
	JMe/fZf7oyP5PuiAnib6rg4BjjCEeWzqs4FK8Z/S/wSLWyH0vKl6qKV9uHzHftJq
	DDBN57jMzuOCVdb+w3XD1oUkMHXZa+HAr+4LUuOdU+Xgdf5pCoyeiNYa+4iXAkbj
	ilm2ccqdWMt8KcXi5tvzoobFlXnT+iWq4zf73wb0oGdQkwrDNloQn3PyR2gF2ysw
	3WSOypRslWNECrXz5DLRttXkPlb2ni1F+wGHrNB5tLuM/9gE0uVxA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty2cae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PImIJE006009;
	Wed, 25 Mar 2026 21:01:58 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yratf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:01:58 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL1vGp11272850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:01:57 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D8705805D;
	Wed, 25 Mar 2026 21:01:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DB2858056;
	Wed, 25 Mar 2026 21:01:56 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:01:55 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 05/24] MAINTAINERS: Add new header file for the S390 VFIO AP DRIVER maintainers
Date: Wed, 25 Mar 2026 17:00:52 -0400
Message-ID: <20260325210149.888028-6-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c44d48 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=lhH0Bl395LoeofpH:21 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=dFtATCiH9KAnvEo0D2wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX6fmfHIjAAO69
 t0DiW/jQ/s3eMJpi1i5LzCheIIkGPYHXq0exh639tb5sMJVuHEk0ZEVdZbg7qAJO0BnDBkO4u62
 Ba1PaObCEKQDbU8TDkONMF09GOS45KPgpjBn3WU9ob/nl7ZXiH+2ELo2ijSxYEK9PymaddVRCiK
 IsckBjlc9Rwo3JwXJs9N3JDY9PquNdoDal+4nbOuiyZ2glCZvesZFvyl9FknpG1cj2jjhsHjCUA
 llnZPGuqMYp/MDqt3Ni+QPLIvcDUhX+cx7yUN4Thb8iwxTUiLruLfSvyt3nkYAI10volwDzYGov
 Y6fCxznqxbU3lB2woKhn8RipVc3y7ddtAzHk4nRmGoNNUITPBPFrstyoJDP0NKvd4d0Siu8cQ5t
 NXtHYnB9xy8RDPkRqrWaXToxEnGnpdtegfCLUXvE0wS5XHUKbU1S8PP6RfIcZ5uvaUiJz/11+hz
 ssh1ztg/1Dga+X0KG5A==
X-Proofpoint-GUID: DwRV3PjEELbnPJV3tP40uaZb4qUEcH4y
X-Proofpoint-ORIG-GUID: DwRV3PjEELbnPJV3tP40uaZb4qUEcH4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

Add new header file include/uapi/linux/vfio_ap.h for the S390 VFIO AP
DRIVER maintainers.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d10988cbc62..b84896648860 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23339,6 +23339,7 @@ L:	linux-s390@vger.kernel.org
 S:	Supported
 F:	Documentation/arch/s390/vfio-ap*
 F:	drivers/s390/crypto/vfio_ap*
+F:	include/uapi/linux/vfio_ap.h
 
 S390 VFIO-CCW DRIVER
 M:	Eric Farman <farman@linux.ibm.com>
-- 
2.52.0

