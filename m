Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D07A3C9EEB;
	Tue, 28 Apr 2026 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364144; cv=none; b=Tvr/E3TXnzAJqcPS0gdQq3INd7rcfQBb7SGUmUajZ5TLPXPfEovSgZLaWKiVxr/ZXWhd0hxDnBeAdXrnQ8C7/F7Bcn5xzrrb30pPBajaRDbPiP1fA30QwL28GjLVeFAnaQjgZZEQapSrXBcvQHcbzK7+Ne+mo8wazgpyDeIVL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364144; c=relaxed/simple;
	bh=Y3uYHvJJ/7NzkeVsnIdFVehCI1FbP5IfjMDGyXuREdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZOu1dr6vsypP/5vwNnag8jD+ropj3m3f+1w0ra6SelP4jgxWhB9iX+0dzceBspH2e2ITrAMDm5SSTE1BEBypgE5+E/Oq/r4NT7R5A12OFU7C0KPbUjbkbCZWyCvV3IS55IIeOwi5eZatR2HoDHYKXxeeCIWeKm766YtpQU7S8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SjBhW0nE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SjBhW0nE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S2BB2d1888684;
	Tue, 28 Apr 2026 08:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cSQpbY
	YGz6Hz0NV3ggarRXoHKgNlKa7MK4XKTK6ycl4=; b=SjBhW0nEROp8TzCBmD6OeW
	NJ4dQeWKxM802qmXP+ec/ky+4HaiK1z7P9yEp1KyQP3QgkCN+fHqrY2qyKTCyy4B
	sB81b7xUW8XeZgCN6kN6EYSo7KNCAqwMP6QpAYj58I5dj1bKXVvJqk93QhD1M8/C
	jTggZWHx5FLpvdXrMl+yl3uompnuKCsCbkQWh1I3/ct5SrLQmkUpAyBWdht3szS0
	T5ET657OG57x2DpCZWKTVEu7y84hqEZxB/zfc/pPjOi1CYnZI1m5su4xLf+ljkbG
	185PboVYDJKxuqGp2eDv+gMfFU74pcr6o79EfSHbGNGVz27sNsde5CNDLuERMSAw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vba5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S88shB021036;
	Tue, 28 Apr 2026 08:15:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy8k2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63S8FYtN49414584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 08:15:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 049202004F;
	Tue, 28 Apr 2026 08:15:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0C8220043;
	Tue, 28 Apr 2026 08:15:33 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 08:15:33 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 28 Apr 2026 10:15:23 +0200
Subject: [kvm-unit-tests PATCH v5 2/6] s390x: sclp: Remove unnecessary
 padding from struct sclp_facilities
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-vsie-stfle-fac-v5-2-34c5933a218c@linux.ibm.com>
References: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
In-Reply-To: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
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
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJkfcpZoV52ZG86u9euC6+87uVs+ZgV28SlaH3v8gm3R5
 NXTkr5t6ihlYRDjYpAVU2SpFrfOq+prXTrnoOU1mDmsTCBDGLg4BWAiD/sZ/mdmKjxtNQ1YsOHt
 gaRp5YzFzLY+qhxiAa/PuLT5r3ll+ofhr9zn/Ak/BOW04q8anWNKsKyaatJp/PmAfNH1Z1fnLli
 iyAsA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f06caa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=LqyZBc1Dag7_ZHf_o-UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JM4QpS0VNci6Lo3OowwohGwNJ2xqnhXt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3MSBTYWx0ZWRfX1+ObqoSbwjHc
 K+d7pBIXTpm/2rZhoJwnPc0RM7v0p3r3VscMMXFQnyx8MRT6o9ObCCff61Qt23JBXLbl2gmaq5g
 GwYz+KgWjOcOBicnIf5NDtOD/NI6XP5BTUzn4fa1RNIwHoNpdDnHSS2MXaXllbWQaUSReAb/lOV
 2G6eY1qA0ndktFcucpwT4PV48Bbax4Ptqm9yfqohKJnrE9kMVMaTOpWoHwzSZuFHi/EGE3yl5nO
 88avQ/0awSs8Nh+SCiP0GQEl7tMb43fPS2jGHjdwZl+YqRo/Zj+/t+BOxYtFedNfGaYvoDrG3c/
 4Jz46cZgzpAK/UlGxhEhIFth4zhRvyGJrtdErbCTwcXNVaSNy3NCL9+skw/z9uRvFuXhNqCksdQ
 Q0/AHbHiX7mV8THNo6x79dwI+9Ogsu7TbX/6HEh94pDaOgFq1oajy6iOPwSsvLuLnJHkVUjFMhj
 1Dt9Ie6MUPnkXJs7ehQ==
X-Proofpoint-GUID: JM4QpS0VNci6Lo3OowwohGwNJ2xqnhXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280071

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

