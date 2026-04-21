Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C430FC34;
	Tue, 21 Apr 2026 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771947; cv=none; b=ouEo2qGEfyO/7BUngUUqS3IzozJYuPav3Vlh+zv7PLRNa03/RMlXbgXFqkUJA3aUc0jbApvt3lKldv8BB7kJTh5+PP9KqDkTyC0227OowFZO4tVDG3c/At5iSNwAh7pwOIc8/YqXKi+kXju8NOiI+PDj3fpaiDqaDaCk8fIvyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771947; c=relaxed/simple;
	bh=vrOLQfTro+9kePooS2m9eUKAO7WmYAoTyHYysUGi5Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+FJb+Qk910VFWK0/IL+OFEtIusuwefHDJRzr1hjDw/GTA+zsUm1TK45l4mGUbpUMOIVMuP3aE3KqARDVntSmeJ0iI1553iBcUKZiaEoAzUlDfY0VVd6mtChmycD727eT9F3iqNXLhH+Mk3WNwnNZE70vuGtq63n13HPV0/Gicg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lIzA86Kj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lIzA86Kj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJgXir2037127;
	Tue, 21 Apr 2026 11:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3KlAoP
	7dkrBx4ns8YTjhPL3GKTw0GG/bMsy5ZLCZqBM=; b=lIzA86KjlL/XI/fsSbI/AC
	nTbS9eCKanFx4QFmVlJXKzZ7F3ea2NKbcpphOF6y1lelPjd5kwHDKwQNzn8Li0GE
	T9s3slydN92iypVQrbH6AsJEZKU7ypQ11g14IEnk3hjJbCVsWsh1OO2S/qiAuK5l
	piGCElFEEWmuqIiKYVg9z63lxEkD1stl8Xbu58FHGNYfwq1lsgiQuZQaAbMYGqZd
	xCD0sAe11ZXmSv/Tm0fMKXkgr/RFCtjCLCDcsTP5BkP3Ll0XBIrrv2rW0Wxve961
	9UGd8cTbVFjUe7Kmqxsr3ls566TmZb7wEMqAEMa9o0E2qWCq31PgPr4w+kYUajmA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2h9kayf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LBZVrw013739;
	Tue, 21 Apr 2026 11:45:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9k0gd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LBjbEg51249640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 11:45:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9774D20040;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77C9F2004E;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 21 Apr 2026 13:31:11 +0200
Subject: [kvm-unit-tests PATCH v3 5/6] s390x: sclp: Add detection of
 alternate STFLE facilities
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-vsie-stfle-fac-v3-5-3cee84efefa3@linux.ibm.com>
References: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
In-Reply-To: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=ihDlUpmcnDh+sWmcPLVu+EitIuUVYJZcNdjPobA/TMQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJnPkxNM2NPY91TV7XXd4LZn2kK5D7UFaQESuXFf+h7zX
 ny53lO+o5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgImsZ2T4XzPNxNXeZMFij8Yf
 XSE+ukfPGelf0a0NeK5cVrPX5FM+H8P/1OWWTn1MnVwL9aOzrzuWiJ7K9LdW/BY+YZaWpelC70J
 uAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -wp7Oa_a55QuzroR6yTvGTWsyC9rwYOP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMiBTYWx0ZWRfX3Ot4ogSviSbN
 AU/6UONfaJK62irN7FGKiMFtGERheXpX97yCNuYrfNRXNObh8nFRNdXDgbBKCpYzSlBSb2bApcI
 pDOjLFf6fruzwhRr22SaowZ4VA3J+frUNwpKRin+hFpwVvhAvVEfG5ZuaU85XfDEBaDCP//f2rQ
 55cRHCV89rRsmxTuWyh1EyDmkmP1C0qXi8ULzWjTvKh83Y4vC/6UjKGJ6cKfueszWmIMYWIGT9A
 J5VU0tMPMk4cDn9gXzpDStJXT8/wOfqS610zifKF5pS0g53UsBLhyLdTOFKQwqWA4uUI98uGTe8
 ZR29pegzLExTnUevkazIais40xiR6mMZ1KPsnhGo+ouIhAbCUfjPD7bd9xirxOPgHK6IEEgnJXL
 u03Xo/6IkyVLL3ID/eGR0zZ8+ywdrxmrdu3EMYp4B2W7qZQs2qYFGgp4XlFmAaJPfxGRS6+U0n5
 ZvSpEjnFpKXlEaMk7aA==
X-Authority-Analysis: v=2.4 cv=XLYAjwhE c=1 sm=1 tr=0 ts=69e76366 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Dxa6YZADxO0mQfdHC30A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -wp7Oa_a55QuzroR6yTvGTWsyC9rwYOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210112

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Detect availability of alternate STFLE interpretive execution facilities
1 and 2.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/s390x/sclp.c | 5 +++++
 lib/s390x/sclp.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index ad2ba99ee1e1..d4e7eff66c31 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -181,12 +181,17 @@ void sclp_facilities_setup(void)
 	sclp_facilities.has_cmma = sclp_feat_check(116, SCLP_FEAT_116_BIT_CMMA);
 	sclp_facilities.has_64bscao = sclp_feat_check(116, SCLP_FEAT_116_BIT_64BSCAO);
 	sclp_facilities.has_esca = sclp_feat_check(116, SCLP_FEAT_116_BIT_ESCA);
+	sclp_facilities.has_astfleie1 = sclp_feat_check(116, SCLP_FEAT_116_BIT_ASTFLEIE1);
 	sclp_facilities.has_ibs = sclp_feat_check(117, SCLP_FEAT_117_BIT_IBS);
 	sclp_facilities.has_pfmfi = sclp_feat_check(117, SCLP_FEAT_117_BIT_PFMFI);
 
 	if (read_info->offset_cpu <= 134)
 		return;
 	sclp_facilities.has_diag318 = sclp_feat_check(134, SCLP_FEAT_134_BIT_DIAG318);
+
+	if (read_info->offset_cpu <= 139)
+		return;
+	sclp_facilities.has_astfleie2 = sclp_feat_check(139, SCLP_FEAT_139_BIT_ASTFLEIE2);
 }
 
 /* Perform service call. Return 0 on success, non-zero otherwise. */
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 87af429b5798..eb574350d678 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -129,9 +129,11 @@ struct sclp_facilities {
 	uint64_t has_cmma : 1;
 	uint64_t has_64bscao : 1;
 	uint64_t has_esca : 1;
+	uint64_t has_astfleie1 : 1;
 	uint64_t has_kss : 1;
 	uint64_t has_pfmfi : 1;
 	uint64_t has_ibs : 1;
+	uint64_t has_astfleie2 : 1;
 };
 
 /* bit number within a certain byte */
@@ -142,9 +144,11 @@ struct sclp_facilities {
 #define SCLP_FEAT_116_BIT_64BSCAO	0
 #define SCLP_FEAT_116_BIT_CMMA		1
 #define SCLP_FEAT_116_BIT_ESCA		4
+#define SCLP_FEAT_116_BIT_ASTFLEIE1	7
 #define SCLP_FEAT_117_BIT_PFMFI		1
 #define SCLP_FEAT_117_BIT_IBS		2
 #define SCLP_FEAT_134_BIT_DIAG318	0
+#define SCLP_FEAT_139_BIT_ASTFLEIE2	1
 
 typedef struct ReadInfo {
 	SCCBHeader h;

-- 
2.53.0

