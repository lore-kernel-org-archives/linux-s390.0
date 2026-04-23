Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145473264F1;
	Thu, 23 Apr 2026 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954433; cv=none; b=lxykMQQUZ0D6jpkATAnndtnassn1e/pOCMhFCdh250wZ2gZFYq5zK0E7H1jq1zI//hhz7YC964g8J/ua9lWWqXC0hilR1zdhAdLUOmFNn2aJg7IPUTkfm1zBKKxl0PSsP7DihyLjkOP++EPsgqBvH0VPwyeEnN7RF0JwSHco2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954433; c=relaxed/simple;
	bh=ERTWty1Ai1EhGSWJCyPVT82JbMW/oE8GQdh0FdE/GQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bsS8fHtQO0Tnc7FusO0IF7sRYV6Da8d3X891+c8AlDaIJidO4qsdpeTuYSic+XH5DecKUyUPg0KxZ7Xqhw4BrzmQ71egFOxKYjQpPoAGbxH182tD33jlJr8bkY0UhSwddaTkGX3f4Q78Gsr/caxI6x30IJ4a7AH34H4YPkQ+gQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DDCuwmku; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DDCuwmku"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8ofa83514994;
	Thu, 23 Apr 2026 14:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9hPMAy
	bmzm4k6Vcy4ffQJKREp77xtzHE/sGJTQC6piY=; b=DDCuwmkuPe+CpRUMSrwHkX
	QymtiOx5NzkFidX1raZ9bcnBEH1n6jtyylsp8axJ1Gr1s8wV3sCSqi3NbEEkBWGB
	KhJRQYF4DnEGj3ZzZ+fdkLU6hThrweGXjdfLOyvvDQygJx3/CrP+ELenqQiKsvzn
	YMyY/EFeFkom9UD/u6u2w8IHqbS1rIAC1eLKQiCmSeco75LA7NrDSs9F+oePXiMV
	42JHPZFVR+hySFntjOt9XACPvhh52TOFgVG7FuGhngL9s1vDcN5yJjaQr0IZB5Jw
	Vt8gcVlgzaH4wv+gr2xAf7Fqlc00wUGyfzvX/5mz+6htFEynLgO2Aw/4tOhMZ1CA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu294k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:27:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEKVf4000732;
	Thu, 23 Apr 2026 14:27:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxxxe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:27:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NER1Tp31719738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 14:27:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5F3F20043;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A33CE2004F;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 23 Apr 2026 16:26:47 +0200
Subject: [kvm-unit-tests PATCH v4 3/6] s390x: sclp: Check sclp byte before
 reading feature bits
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-vsie-stfle-fac-v4-3-32943fe43394@linux.ibm.com>
References: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
In-Reply-To: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=719;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=ERTWty1Ai1EhGSWJCyPVT82JbMW/oE8GQdh0FdE/GQ4=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmvdEwqnV9t1uaLzVCU04pJ+/5M/P8+Le7ji75Fqa58J
 l7AlNzRUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwET2f2D4xdy8Sv+eYUUj+5Yk
 +d+R/bFTevt/fIzdmrN+YtKsVzss2Bn+17+In7zs+d9fQgL5KsEFfrazQjYGtyRfzjrNt+iG51Q
 FFgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0MiBTYWx0ZWRfX907dNBY/9yfz
 p7ylgAq9vEsAKuC6jOVTUUBv1RNDBK2r6PajfW4yVKELP4O6/Tr4Vq1B+gNRmk70ztC63+31iQu
 c99vwAHzQD2iRAubJPgiEm2R6LKyCkrNrtLQrY9/pYWAg4AMTSLr9fWRWM1+VeNduXC6WBTvO6o
 k8z5+A7KmXhmLti79Qy6MhdB44ftMdBj5IKHps0TOTAWLlsgKBEtQlaYKyg88/jlh3Npdb6N4MH
 TBuWsc/GeT9bqX/SVGgFQYqr3+sR74Ccp4Z0lguBlS1LbtC5dYPu6PPka3n5rK+xm+9CWrlbWqn
 8auh61VuJQFJbTkvUSQmtg/e+B8b6w89AdUjD00PoERQLpiQ31Rd6PFv5TcJjtRzjjOowRE+uvN
 UtQKrs/AtrAtXxQl51Y3x5fr5hECIh7Ql9sl0RgsYZCPKQibtbwGBMXVwgZQtRenBE+bXbrCFhs
 8RsxsKX4jZqx2ZBqmnw==
X-Proofpoint-ORIG-GUID: b71JSfGOOPiunMmxESQKKsQTLTOr1_wZ
X-Proofpoint-GUID: b71JSfGOOPiunMmxESQKKsQTLTOr1_wZ
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69ea2c3a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=h1e9RfFzl8Kq3L4puskA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230142

Improve the readability and simplicity of the code in
sclp_facilities_setup() by moving the check for availabity of feature bits
into sclp_feat_check().

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/s390x/sclp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 2f902e39e785..1ffcf448e558 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -142,6 +142,9 @@ static bool sclp_feat_check(int byte, int bit)
 {
 	uint8_t *rib = (uint8_t *)read_info;
 
+	if (read_info->offset_cpu <= byte)
+		return false;
+
 	return !!(rib[byte] & (0x80 >> bit));
 }
 

-- 
2.53.0

