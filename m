Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90B47CC63;
	Tue, 16 Jun 2026 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628684; cv=none; b=Z0D70KRnj2HJWrSd5TDJ1nFNvEf0T+S9hsq6LeFfHf6f1bLUSOqtXTxdH9p7vzSknjzTWgaHJRlB2oIZfNiq3oDk1Z03GhuqTGtsmI2jrRLNK5Pbs4FgHU0ygLdX/BYgysUKQyJjdYpGpcfU9j6p1IYmPf4vk8QStWKy5MRJM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628684; c=relaxed/simple;
	bh=VsDOjn3RkmS1Xpe2BEbtHYTfFgMAnxU8eezQEc0ys+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUkFUR2odlaY83GgcTkE06Nv++VO0Z9oDE3mdyQXDqOIbe4clv1pRSva14/SIsuhl3PpdfeVEy9CA3wtdQCSzbcNRUmWxjjUI0bEVA7OC4RYFNMiXY+kmSqWB6/cEBGmpJfyXud73k8SxAiz+ENjs4v6N91ZrYiuCdVjyzcwS48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QU6IphBG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QU6IphBG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GFmeXE1840651;
	Tue, 16 Jun 2026 16:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RCzFqjsPt5CoignTr
	XJu/nHY2rVoY/77y64eamZAyZQ=; b=QU6IphBGMR/Ls5jsTd981F5SCv1i0Nxmw
	O4EtI0O9kxfBNKpAvqG8B/zZlNSkkHpoAYODZRj6Vi+jMxSxR2FjJvNi9jNGHAFQ
	2sU2n1o+sMIcyOO7RHVRDsM4DiZTVTJDELCASLO3X1anJTxu3pNv5Wgf8I25pJBu
	YgfKypihEtUY1TqGx0K5l5Jpg05v/dvi2mBXwtzVWrsSj4dqnS/zQmtIynecS70Z
	w0jh2vxnr+5stxFI0rKj4IO43hcvmrNbRntd9i9Rtq2S3LT+noEGy5paAu/CSejz
	dny0zMvjAoRQ8J1rTBdVNUUpael8H8k1QuVoGmit8TlnY5WXfYjdw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v2ecx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 16:51:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GGneYl009569;
	Tue, 16 Jun 2026 16:51:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhk4dap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 16:51:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GGpFwP51708200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 16:51:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E1FD20040;
	Tue, 16 Jun 2026 16:51:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77D6620043;
	Tue, 16 Jun 2026 16:51:14 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.66.4])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 16:51:14 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v3 3/4] KVM: s390: Do not set special large pages dirty
Date: Tue, 16 Jun 2026 18:51:09 +0200
Message-ID: <20260616165110.360921-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616165110.360921-1-imbrenda@linux.ibm.com>
References: <20260616165110.360921-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE3MyBTYWx0ZWRfX0b1vGCf/7Hd0
 zakFyOg6WyVqhx7WiKV2aPqoLSK8ZTmgeyaZOE/mQNHSfEeXpl5Dkn9ltPY+sVgqqgl0ombAB7Y
 desurVLMJqc5WkoUuKSAGjyN+oJDZss=
X-Proofpoint-GUID: -VJfpjn0r6aEoEFf20ZOnsJ30e6daDpd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE3MyBTYWx0ZWRfX0evDtGJrecZu
 a631J0Nf+o0eMcICvCiP3KzLg/Ozg1Pq4Vo7dMLdbWE8B4pDlFro4DCwlTnxaQwHlZ88THuvFtj
 mjxfK8UEiP669TItjWexc3ufhdlKWmyFsXYMtzFB6EeN/3VyuRzP43XGxumR79v0DFF3SD9RjHW
 g24iHGFnaWLF+NUQJZb9WLhR91Z8waCD8nBm4KSeg6Ok+G//RXf2OzVJpojPhIBgq9ILYfomM0f
 eJGkBmYfESiExFb3lVRf/fdqE390Hbvc/QPRZAORka2Gm2C+ZapNVm9lpGVRv3Es6Xv+HvyzDWh
 0km1XWXnMkVYl88m+I1gDiVfMeVVeaT1sYXlo4VbqgJeoERqF7HwAPylF2q6MBj3zjCR39JCG+g
 V0aWLu4tfsbgsX4JiFgHov9WnQqUuGXhq/06XpuUyp5GI3xcTY7Ke6hbZPtrLTyDiWYDq5CYCT1
 obe5V/0NZ+lX0yELeOw==
X-Proofpoint-ORIG-GUID: -VJfpjn0r6aEoEFf20ZOnsJ30e6daDpd
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a317f08 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=3gdv_IAxfr86PQWoa5IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160173

Special pages / folios should not be set dirty. This also applies to
large pages.

Add a missing check in gmap_clear_young_crste() to prevent setting the
large page dirty if it is a large page.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
---
 arch/s390/kvm/gmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 52d55ddea8d4..3192f610f696 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -327,7 +327,7 @@ static long gmap_clear_young_crste(union crste *crstep, gfn_t gfn, gfn_t end, st
 		new.h.i = 1;
 		new.s.fc1.y = 0;
 		new.s.fc1.prefix_notif = 0;
-		if (new.s.fc1.d || !new.h.p)
+		if ((new.s.fc1.d || !new.h.p) && !new.s.fc1.s)
 			folio_set_dirty(phys_to_folio(crste_origin_large(crste)));
 		new.s.fc1.d = 0;
 		new.h.p = 1;
-- 
2.54.0

