Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70899632;
	Sun, 16 Jun 2024 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718498853; cv=none; b=cUbaJoQ2oSoj2eiFASGZWKn+Q9LrOMtKnnIWi/dy05+SJUsrh+n50N8PoMtmfSRM9aY7IBnqZQbe37J5udLZJhl1BJDVz9YZ8kMHvpphbpVwIfngTeOHmyR1EeH0qO871OOcWxYJWL3cJrjQakZQpec/3MK1WCaUZkIWxAylwJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718498853; c=relaxed/simple;
	bh=OufLWNUT3SY6JH5wRwvhFIIt2iEpfLM7MnO9DzkH/DY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nNmhJNPwHuv0jg5sT2p+b8dBzrhPwlG1VUNpkc0cco5SDC2E5QkUobpa9KE58psT+NwSDTS+x/xmCY2T2WHIfXATGFjANkZdJr/KtOiaaB7zVw5iLPSvossHg5AggtCBKNm/kbzCPSTa7HJ3JSztIYTfuVr/n2zr2a0SElszbbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X6p8z9EF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X6p8z9EF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45G0Tn2m019782;
	Sun, 16 Jun 2024 00:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=r48b80W06AbF4+Cs+ge1K8
	cav37NNq7obPO6DVOdEws=; b=X6p8z9EFFU9LxBq1uk97TzA6bxMyZyEdtSWo8z
	8g8j8FmcZAQVjZHpe/YTRs9+KNzvQxiA4N1qDUUPJO8w+NFmzFQ2ELEug16Cs0/Q
	O0o69PaY9ZWTOTKzJM1Hey2SJ30o34khtW8QKkOdvv5Kwgz+Z3B4otwkhzkWfD+8
	o7jh771oeYTFeIQ9kb8fONMn6Ahn33NRtp+htz4tLnFDW/8ZrgMG4tXsXJlK8mnO
	TLVfB+sNVykQVUM6gcqxq41WkMbNQnCkdA52geQS+mSuVscW2rWtldcBtHMYLG06
	Q6qvq76yPMXdcMRumtaQvaWQX/19LBCz8ISwxhCoyP1vUgVw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys488s5ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 00:47:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45G0lSIc017716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 00:47:28 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 17:47:27 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 15 Jun 2024 17:47:26 -0700
Subject: [PATCH] s390/lib: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240615-md-s390-arch-s390-lib-v1-1-d7424b943973@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAB02bmYC/yXMywrCMBCF4Vcps3YgjUmLvoq4yGU0A22UmSqF0
 nc36u58i/NvoCRMCuduA6E3Kz9qQ3/oIJVQ74Scm8Ea68zQe5wz6vFkMEgq/zVxxMH7mHN24+g
 stO9T6Mbrr3u5NseghFFCTeVbm7i+VpyDLiSw7x/3AvFshgAAAA==
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
	<borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
CC: <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: trEKEZffITh7EG4YJaAY66pDHAtNAKTI
X-Proofpoint-ORIG-GUID: trEKEZffITh7EG4YJaAY66pDHAtNAKTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_18,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=922 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406160004

With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/s390/lib/test_kprobes_s390.o
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/s390/lib/test_unwind.o
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/s390/lib/test_modules.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/s390/lib/test_kprobes.c | 1 +
 arch/s390/lib/test_modules.c | 1 +
 arch/s390/lib/test_unwind.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/s390/lib/test_kprobes.c b/arch/s390/lib/test_kprobes.c
index 9e62d62812e5..9021298c3e8a 100644
--- a/arch/s390/lib/test_kprobes.c
+++ b/arch/s390/lib/test_kprobes.c
@@ -72,4 +72,5 @@ static struct kunit_suite kprobes_test_suite = {
 
 kunit_test_suites(&kprobes_test_suite);
 
+MODULE_DESCRIPTION("KUnit tests for kprobes");
 MODULE_LICENSE("GPL");
diff --git a/arch/s390/lib/test_modules.c b/arch/s390/lib/test_modules.c
index 9894009fc1f2..f96b6a3737e7 100644
--- a/arch/s390/lib/test_modules.c
+++ b/arch/s390/lib/test_modules.c
@@ -29,4 +29,5 @@ static struct kunit_suite modules_test_suite = {
 
 kunit_test_suites(&modules_test_suite);
 
+MODULE_DESCRIPTION("KUnit test that modules with many relocations are loaded properly");
 MODULE_LICENSE("GPL");
diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index 2848e3fb2ff5..98440f9d01af 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -519,4 +519,5 @@ static struct kunit_suite test_unwind_suite = {
 
 kunit_test_suites(&test_unwind_suite);
 
+MODULE_DESCRIPTION("KUnit test for unwind_for_each_frame");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240615-md-s390-arch-s390-lib-655bddd47742

