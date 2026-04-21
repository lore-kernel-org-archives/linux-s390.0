Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2CB30E0EF;
	Tue, 21 Apr 2026 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771946; cv=none; b=Qf7wJ9Z4VePnDWXYvGlcsAHq1KiI3x9Zi6ZJ1gQQXOpn6KwSlngXMPK0yJmtLpYU7dRsLDbvKrD8Np498VnKr+H4OcBybO1jRSjtF+InXMOtd4YudIPsYh7BIjF+VgD5m3XhjnNNB+F6EPS4tJEhWi50YTUp+BzXnnAKBrDeLBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771946; c=relaxed/simple;
	bh=Y3uYHvJJ/7NzkeVsnIdFVehCI1FbP5IfjMDGyXuREdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgLS48ekCcHekhQl50hyZOwYCF65AdXszDfffRE062KDqwvKc1/xTKiyuQWyiBDM/SQ+DsBpmmzitaRQQJQtpqIDMqfOYDDLaRmqxZ/PKhVn9Qbjb8sMW5/7A3Z1XBGbs2hK4p6tD2UVlYj1izo2jtS+x8Ra7wj75uZpwTShBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RotZW3pb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RotZW3pb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJh4ZN1927822;
	Tue, 21 Apr 2026 11:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cSQpbY
	YGz6Hz0NV3ggarRXoHKgNlKa7MK4XKTK6ycl4=; b=RotZW3pb5f0rt8hCGHhwKF
	Ro/LeNgkC4RtlnS5FJ4+CUsnDSQnbQe6Vw1d3bz0L+yJcOWhLTugalKYYPsnr8bg
	0P9TvMta9k/oz8m3oQvV4r0HJOqzKAADb13vOITF/QZXYH2eDpIYGCKUl6Ua1FSu
	X5muecq7V36Ko4R5v5L3x3x/rz0FE4ZCRwqIhSP3fevMoZRSRNNq6U8qkMuDLEJx
	MODWoZramtZvrW8ZFXcNcZRNSRmf81X/EeiuKc48G37H2J4IJLeIk2HQ17Ao5fNG
	kMq46/uy0IFmzKm9yAXrRf1MJAJcPXWTfeAn0dv21Dh3PG3i1DmiLF1kvOLVNpWQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nf433x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LBZKCK027109;
	Tue, 21 Apr 2026 11:45:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpyy09by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LBjbrW51249634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 11:45:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F32C2004D;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10C722004B;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 21 Apr 2026 13:31:08 +0200
Subject: [kvm-unit-tests PATCH v3 2/6] s390x: sclp: Remove unnecessary
 padding from struct sclp_facilities
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-vsie-stfle-fac-v3-2-3cee84efefa3@linux.ibm.com>
References: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
In-Reply-To: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=789;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=Y3uYHvJJ/7NzkeVsnIdFVehCI1FbP5IfjMDGyXuREdE=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJnPkxMs9OYWBs9OUWc7vqw3Ys/y+kXLppz9HJzBHb11f
 8Ll1C+XOkpZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZjI9rmMDOverp4V8Kj9RPZi
 c+ljIX5zFM9ZfBesL75Yn1At9/PVYUFGhhuft/o8/Ogj1XZk/bVPD1l9dxew7lVaszS3zPOyamH
 rdzYA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6HcBgDjN7q4rO44mXqQYBbSMAk8a8XXQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMiBTYWx0ZWRfX7DyI6nSKPGkt
 qv5hylqweir9EBJbWmnsvQwcImvOHePVFiBfipDVCfSx0J3+ld1w07+6Y9C5H5wdlYM+eDDBb7k
 DZV9UWm88tu0buMUSoGsW7Z6/WGkjqftMtkyiRRUEsCkUS36waVfOOAcqhwNVRd57g5KuHQAU28
 rAkp/pad49r7khYc0ROMB4qJVNKAegeZTfeytYGvgP0kFTqSkO7Fua13MwBrqULN9vAh7tVD1u/
 5s3/XsvEx9JuqlqRKqvkli7b8qdUnMW2aeB+FAVLMJk8B+0fLyXm8qhjvp33eQNoLeepn8UuQZm
 6SMC5mmfBr6278y9CAcLO2YbN0z5CFT8tvVs3LwHwNjfr0mL3g5WLb7cHRL6V3QBWFMTNWZ5bKL
 JmJWApOiVS1g3og+0cCb9p5kqxHh5xEIXc7p+/32w33BJIl6GoveKyug8hCxGB71lWCtDu5MG3p
 rzxyqCEmpFZ9kVBBCew==
X-Proofpoint-GUID: 6HcBgDjN7q4rO44mXqQYBbSMAk8a8XXQ
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e76365 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=LqyZBc1Dag7_ZHf_o-UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210112

Struct sclp_facilities is only used within the guest to keep the facility
information. Nothing bad should happen when the struct size changes in the
future.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
---
 lib/s390x/sclp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 22f120d1b7ea..42a2f2e9f25a 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -132,7 +132,6 @@ struct sclp_facilities {
 	uint64_t has_kss : 1;
 	uint64_t has_pfmfi : 1;
 	uint64_t has_ibs : 1;
-	uint64_t : 64 - 15;
 };
 
 /* bit number within a certain byte */

-- 
2.53.0

