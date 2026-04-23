Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C432573F;
	Thu, 23 Apr 2026 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954432; cv=none; b=b/gnoOkdvletJ05FA6V/c2Qci/MYIpj0oUqeeNtsAC4QhT1DBPddOI2JpQjWwR8GbhnNVYxYt6B7nzge5/9qX735a6/e1fiYYzYFiGg+nm1zcm9XLJZhYZHSTZQfy00RRTive76pU/3kkKIAUL0SWPX42JBonAzN/XRfPYchx3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954432; c=relaxed/simple;
	bh=Y3uYHvJJ/7NzkeVsnIdFVehCI1FbP5IfjMDGyXuREdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hK7WCbr01nLCKPT4Gw7cKg87JGH/ITEkDgEvvazUpHyAy7gHukzAAucPb5x24JntE60odstSMSdbfoMNWYsnWKjwyEpn5FlYgSizL9JiHM/OaE4+/g/2Ll37DsLLXWJcOfFZUIK3oacqhtftGIlqwQc/IWkKIZoha3Jd5XhtxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KsmMxOc3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KsmMxOc3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N7n8vN3229288;
	Thu, 23 Apr 2026 14:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cSQpbY
	YGz6Hz0NV3ggarRXoHKgNlKa7MK4XKTK6ycl4=; b=KsmMxOc31sKaz7YKgqTEd/
	qbEJR3toq+P34ONMLcvtfXpamvSJ62/qQvPW2Nl/VxMd9U9tjYEPklCwCONchZ73
	SDUKZnTIjQLA8IGR5KilpvzWkN2ij2XTE/Atgc3Ltr+l1zCuVXma+rd31x0iWsuD
	0dbp4i/wtEW58SqYPZIJShOb3VT6HKfXDdMIIqXsctwZznBoal8ZrozqT5HwoDZM
	L/VHcVr7KOqE/qa7kpNVPa6jGEDphxWIGJ4Zf5Hwx3hHF/DQVmnSv4LOH4OhFy+a
	4F6I8eqnNUWFi80l8BbRsylgLIp3pWhSkA5lJEu3ZFTYiiKcgvZrMzZ6RoigmKeQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu293tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:27:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEKG8p020341;
	Thu, 23 Apr 2026 14:27:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky6xry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:27:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NER1Ao31719736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 14:27:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A07ED2004D;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CD6320040;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 23 Apr 2026 16:26:46 +0200
Subject: [kvm-unit-tests PATCH v4 2/6] s390x: sclp: Remove unnecessary
 padding from struct sclp_facilities
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-vsie-stfle-fac-v4-2-32943fe43394@linux.ibm.com>
References: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
In-Reply-To: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=789;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=Y3uYHvJJ/7NzkeVsnIdFVehCI1FbP5IfjMDGyXuREdE=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmvdEyuJrfd9b3H02hbn/KU0ezxF4ne9YJs95TfebV/r
 3Vmevi+o5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgImEBzEy7LR/KLqPZ+eROx1n
 tMSdlI4sDeSUKw57K+nm3xDCpSftyMjwj8/45IwVG349/tmZ0fBnVo/6zUNP1298eSNw8VoX7ww
 /HgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5L4wck_sC51RJqReS0VosFG8NvqFsjpr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0MiBTYWx0ZWRfXywK6RysL2COa
 Chs17Cd+kiQEw0vTbQvpqRCUzSrG+s5HgGZfshCV+/YOQIeAtg+u8bVdvIVU02R/6k7WbkIa9YB
 Pvlcv6epS7T33zYMEM9uZA2cO3Z5MXYZCbRDR3AgxGDwjfKPO+i8lJMXFGJEx1TxuNIR2dEGxZz
 MaOO/7LhUXj9QYWhNqqYhgJc+6piGN8LV+3+wr3cnIhBCmnrmxgniDjrtJh34DnI2X6P+hmuxAn
 ZYqe+81do33+QVsjuI8eXDQWGN8DGN/0VpFxIOi/33fKn/pUNInMWjdkJn4UIKo5at2MgpVnl1N
 Xgd2V/wdhCHGodV+TsgV3osv/c9dtbt2JKJqQNQtgnCYWo4JoGOE0rERdqxKSFxqMC31evoIWEx
 zbH6TQ9gxfcLUiK5uhQBiEmCG/LkLiGOCHffT+u4UTkpOGqvI9VNycasRyLA6YZDTPtWPmFvzH1
 vJN+b/0boK8iyTVWhdg==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ea2c3a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=LqyZBc1Dag7_ZHf_o-UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5L4wck_sC51RJqReS0VosFG8NvqFsjpr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230142

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

