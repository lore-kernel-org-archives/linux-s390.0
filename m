Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024503F8254;
	Fri,  7 Aug 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096677; cv=none; b=KImZVpREMGStydN9mK3cpTJAAvJ4gBdV9pB+k1spCuJlR2Bu3xkSfc3KFxA8jO0aGlYg4Kcsemlzbr2EIlb/8iNxcEhvI3hEIqNDwHmdgKi2D/gdAY83YALZB00rNY2gf/kNQZ1Ksqe9ZdCCyWVRn7TtiM0NfYDfyuvb3OVD+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096677; c=relaxed/simple;
	bh=DIOt277fQNwm5JAp1ZP2HGLSy49Tmkgs4dgJsJEkQGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kCcOxpZ2DVhHt0PWB312g1RenBs1AgZQryqOnxOaPNN54eFSlWm4VTA29pO1+Zd1abw8sk9zyRFr/aWEdAhVIFnFDkzuosxX2Zoxe7CCSxiTibZG35G9TGB3xoJ/3z7rgS26E+zwthzE91PAp+oTm6LNw1O3ke44MJEpHKcjeno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZHYDhR9D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZHYDhR9D"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Ho4N4134302;
	Fri, 7 Aug 2026 09:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S1VoC7
	QfOEITCwTKeAhojUxNchlcPLdNwX6m0YpZ8KE=; b=ZHYDhR9DOMZRXIK3zOdW4g
	4d17ilD9IXox4nTFdAuR4ItpPsZjifZ85axGncYDLSkWg059qsn3RxNcnVEDi2EP
	NrC5ikoORhHkL82Sp9z3MUcWwggQfX+InDpjVgn6jufUaPzkLe/O9BHEWa6ePg+S
	Wxzq73bGI1v9WG5Azrd4mfhFFYt7ozo82/iOwnv2V3CmJj6CoC9a4DLHYaJNPZ7a
	2qQcsE2btG04V+n94dDtd3g6ETAHuCH5jRTF7ldLOPDvSNfcU6OftrwBr0IXg70/
	SeQMxfXVwXRv0jLGUpywFf5oDGSh1LmkzbKTMbANCvNCjfawMZYPHL1OQ0obwvAg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy043a8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6779uINR022002;
	Fri, 7 Aug 2026 09:57:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kf724-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6779vl1S40304896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 09:57:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D41F62004E;
	Fri,  7 Aug 2026 09:57:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 592FB20040;
	Fri,  7 Aug 2026 09:57:47 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.87.136.120])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 09:57:47 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 07 Aug 2026 11:57:45 +0200
Subject: [PATCH 4/6] KVM: s390: vsie: Assert mcck_info offset in vsie_page
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-vsie-cleanup-202607-v1-4-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=DIOt277fQNwm5JAp1ZP2HGLSy49Tmkgs4dgJsJEkQGI=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmlaySsha89bKhwfdmjJs/1dolQ+RoTTT7ma869vqn//
 W07wh06SlkYxLgYZMUUWarFrfOq+lqXzjloeQ1mDisTyBAGLk4BmEh2OSNDz9LT3rUHSr9seGdm
 a2iuKuTDu8L/0uFW8XBZBqbmA0GHGBn+8yl+jP8ikHZi3weB9ITbnTHKf1TivYOyD4ilHNydFMg
 IAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfX6AIzS9FfuhPA
 Ixlhx1OwVWPJLhavaHfHIGp2TQj7IPx36SdvpDLc1j/0GtqqD05gJrBNx/wATVTOSlM0/I/BLjD
 ZpA3tKTSPnMiTIqBfjfueelrDPRTGJSEkIJxsjnNnWu8rWM8La4Dy9HHoUYLWAao7KZYd1oWOxB
 QvRv8P/iCq9PNCnVzbbaiT+xue1hqcILwLofVBkkBodSYY68WtI6m0nA2Co3ifKhm9o+5uyPVrw
 l/2PDFS0PYiVI4BV1imU+i/LYBup9Y8x1nbZASap4Atisi7oGHw1CAcElbuzp5MHFTJGKfvXOwW
 Em1GNzXSl0Kou5hExdYVx/Xy8TZKHXY/y1JqGXeJadPG29d9x4vJh6m9Lco8/qOrUk+bTIMNZUq
 1TFssbhz3Z1nadQj9MZNlSkfjBoFOUnmkDbOvylTaynV1q1yr7/eLf4R2T7iv9j4WVRFlCBovuF
 BUkdgVXptN8YNxptHGA==
X-Proofpoint-ORIG-GUID: jfPPR3yaDYB8EswF9wEQMAd9M6W_6fRp
X-Proofpoint-GUID: jfPPR3yaDYB8EswF9wEQMAd9M6W_6fRp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfX+ErMVoa11NA+
 riKORVxxMcIpSF5tyvCJMbNJyWmemepNcUeVBsm7m9dDwvx4Sol2sgldC7eJAeUqZUmpMYwbJnp
 YXKXEAmCnHMFJJySRS8FTMq1fed0Zq0=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75ac21 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=uWJUxI356daEe9STLmkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070074

Ensure that the backup info for machine check is the same offset as that
in struct sie_page!

With the assertion in place we do not need the comment anymore.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 937f9c99bc00..7c3b5e11b301 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -33,10 +33,7 @@ enum vsie_page_flags {
 
 struct vsie_page {
 	struct kvm_s390_sie_block scb_s;	/* 0x0000 */
-	/*
-	 * the backup info for machine check. ensure it's at
-	 * the same offset as that in struct sie_page!
-	 */
+	/* backup info for machine check */
 	struct mcck_volatile_info mcck_info;    /* 0x0200 */
 	/*
 	 * The pinned original scb. Be aware that other VCPUs can modify
@@ -71,6 +68,7 @@ struct vsie_page {
 };
 
 static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
+static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
 
 /* trigger a validity icpt for the given scb */
 static int set_validity_icpt(struct kvm_s390_sie_block *scb,

-- 
2.55.0

