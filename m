Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B541A921;
	Mon, 24 Aug 2026 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582308; cv=none; b=T8WgqG/KQwpcpNx0K0lZqGOmfCCXtFafS/jlSxBGRsmttpvtjsNjVs/4EKN5QpWHoQ0TQOaq5krQO2wxpJqL7mpr1Jmim4pXrI8+7TjZkx3RjUPiB0MlKCjpZ6NVMwfw3QMEh6IUUNIDhydX6UlcRhbMPB7fQ0kqUGYcGWjbyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582308; c=relaxed/simple;
	bh=lKXDd/NnOmoSYPSve2ky6ZBuvd7bvdwEvy2GK/i3jn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIGasyq8oVuyIlMtrlHO9HBGE0ubXxb9jlHt2wr9aSt0hqe8CK3a/PcHe2X390WR+lNw3JBnZXnYUxcG/7zwqr6iwCvGUWz5W5doBtahUVRNMZGpLr/C78f0wM95cXLPKL8nTKFYnrylzW98595E+T78zrHMz0+mBddOkEeeoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ALVKBRh7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ALVKBRh7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1ZRY1935896;
	Mon, 24 Aug 2026 14:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+ANcOhC0eu6NLgDtE
	UxvoiANMVNLVlXEj/JKhwDaxtQ=; b=ALVKBRh720qQjoxVw79b2oCW163++LEnS
	UuysYqWaaCZP+csAe4TUDvAWWktpx65jEAJnS67cqWqWv5/lz9fgrXj7Y5CWJnmQ
	LwpkVIv+EIV1C9HREp3zILWYJfdOsrk9Jgbbgs81Y+LI+UizsFCcYjM3rC+haBGT
	u+JDj2YUrN3+sFHWE2SA3jbMIH4mCZlvTBsaD1Kdn78DV+hjcEj1P947Ukvua/+M
	EOblptryopTvI32tplBR0e1mipxu0uCZMuYJRz8auPHuuL5zitU/TYqkKViKcU/d
	dR3ctCvQPnox5kcHAua6QegtD2IGwHdeiWBhmBVofMcj5/5DE4lHA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393t1py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQH8i029709;
	Mon, 24 Aug 2026 14:38:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jpj51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcHtZ33620302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0997820043;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCA622004E;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 09/13] s390x: sclp: Add detection of alternate STFLE facilities
Date: Mon, 24 Aug 2026 14:35:41 +0000
Message-ID: <20260824143740.291583-10-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824143740.291583-1-frankja@linux.ibm.com>
References: <20260824143740.291583-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kAlivt2imKLSl79BwrHKesmYfCsv-hfX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX5Ei2UXJ1aQMO
 z9Ne/tJuIefqzXhMcqvpRk7Qpq+ufe69T32PMc4wn35ZFzDxswNsi6tbJU/wDCUZt8hCtYIw+tu
 G20lSjq24Utc0+O/RVc0lasMjSiyOXQJhxTpfvpH9oyuYkzgWe6O7bUCn9Sca6tcSq/c/xuQ/l3
 nrqxhmpgTKQJr5ftxiQkLKc2mfMcg5p9Y4RncgzEXLX07nr9QAtO0eueAfqPWP9YHcCy0Z8PaBU
 0ST4eeVZjGWS/9WdieZgvVaQ5f3aTSEn2NO1A4AocA7n09CPkDUW+NnJkWC/FNYHtnbFC+YqbBx
 xYZNoAGMT1aM+vYQZHRMrT8DxEK/fjH9UyOuDdCeYhkNPNtOWkt8SWCqVZDnSp3K+oJeZawcbHE
 nPuwhF1sKdLOfR7HGV3eseFlUswY8mJ98YrBpNf1O27092c/dScni+Zj+cfUvU7CdaGNIoJH1iH
 IAGxFStgxmmTOKMQIkA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c5760 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=jhiYOCp1ZGrQtAn_9xAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX5+TgZNZ2Or7Q
 78HvyBGstkRwEsOW+4Zy6xbo6tJw2JIT2+oioP4Eq/ybTHsJIpb7S5GIcSJyAUssMt0gP3J0MI8
 DE+0manrzTwfj+w16ifdj7UqzjtWetU=
X-Proofpoint-ORIG-GUID: kAlivt2imKLSl79BwrHKesmYfCsv-hfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Detect availability of alternate STFLE interpretive execution facilities
1 and 2.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/sclp.c | 2 ++
 lib/s390x/sclp.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 9d9fd3cb..850cf432 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -162,11 +162,13 @@ void sclp_facilities_setup(void)
 	sclp_facilities.has_esop = sclp_feat_check(85, SCLP_FEAT_85_BIT_ESOP);
 	sclp_facilities.has_kss = sclp_feat_check(98, SCLP_FEAT_98_BIT_KSS);
 	sclp_facilities.has_cmma = sclp_feat_check(116, SCLP_FEAT_116_BIT_CMMA);
+	sclp_facilities.has_astfleie1 = sclp_feat_check(116, SCLP_FEAT_116_BIT_ASTFLEIE1);
 	sclp_facilities.has_64bscao = sclp_feat_check(116, SCLP_FEAT_116_BIT_64BSCAO);
 	sclp_facilities.has_esca = sclp_feat_check(116, SCLP_FEAT_116_BIT_ESCA);
 	sclp_facilities.has_ibs = sclp_feat_check(117, SCLP_FEAT_117_BIT_IBS);
 	sclp_facilities.has_pfmfi = sclp_feat_check(117, SCLP_FEAT_117_BIT_PFMFI);
 	sclp_facilities.has_diag318 = sclp_feat_check(134, SCLP_FEAT_134_BIT_DIAG318);
+	sclp_facilities.has_astfleie2 = sclp_feat_check(139, SCLP_FEAT_139_BIT_ASTFLEIE2);
 
 	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
 		/*
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 87af429b..eb574350 100644
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

