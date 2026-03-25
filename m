Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3CE3CCFCE;
	Wed, 25 Mar 2026 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440416; cv=none; b=LcR61YMMhdbjDD4qauv/jdZnjRRlyJ54i4Hsqcyg5stRGST066B2wTUyPdihSCFCQakXz3/Oaju1QLc5dQBhsHHjXRY22dq19rCtjPCl8ybk/Z7vTyCUswlZlo8jJYQvR4GfhDKf/Xhl1OvVU+6YJiOcmktxP8gIc229s8OwSsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440416; c=relaxed/simple;
	bh=ENe4jRY9XdZW/UJB3vKfleIhctZYdKdLZe4zxRMCRGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw/GzXojMjtHimm9rf90exOoumzmkri9nXsBXkI3G12ix6pr2pkotzIZzq0eGYpw+E1DIDOBBfTYM3OXXDnZr2/u2pN83jIviiZVSj9PKWZRKyQnj3pdt8a9LrDBDegCEZMZ6rfx2OiWR1fyi/zke7RMmXeTPLx5H0rfbyavx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HyBjI2zK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HyBjI2zK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ONHsv43011996;
	Wed, 25 Mar 2026 12:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UorgpPrCMoiI5Xxam
	G8J+7lkf0D6rvJdsrLn0LheoeU=; b=HyBjI2zKbrXwPGkHmwNoIblLc+tAnYZfF
	cdn1DiqxKoWYROYqtR9bRukw4W7g0gR2ntFfOxZUie7DNRyzc1gONNOtYP19l6r8
	uFTlGPA5Lb2d+vfboEYX5xUsLshrYKI66uVvRt7D150tga4vuZPDyjTHFIvM7nwf
	NCy0w1eIEUpEUfbmMI6e8Q2zm2C3fYlVK4/qX6gzZxcYf6xogQzYeTMnPQahDkqn
	Ikkl3l9DMRW674V0Xw/bKAasdG5hfkI8SQqScYmegLuca7nUqfldpS71/puSpc8y
	CAR5Fq0BM1ZAmVfUT1NxIQRROJDCi3GIZQSvHmOluNupn/SE5FW+A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqg9m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 12:06:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PAMtk0005964;
	Wed, 25 Mar 2026 12:06:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ypgxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 12:06:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PC6lRu30409184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 12:06:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96CB520043;
	Wed, 25 Mar 2026 12:06:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 595FA20040;
	Wed, 25 Mar 2026 12:06:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 12:06:47 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/3] perf config: Make symbol_conf::addr2line_disable_warn configurable
Date: Wed, 25 Mar 2026 13:06:25 +0100
Message-ID: <20260325120627.1841175-3-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325120627.1841175-1-tmricht@linux.ibm.com>
References: <20260325120627.1841175-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ZBvCw5AAOOP-xLvwTjB4q5K9FtTUxhKF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NCBTYWx0ZWRfX00OwpvzVyWuo
 XicWquzbYT0iBG4yez79TfCi9hY+Zu0ICK73sZmdoJN+pDVfsrnHflTOeJrsCbNmhclBNEPxl1x
 oS3n/AvFNguZJKYZsl5eMvNsbH7bNL28uMKrurqUc0GShgYFEni0mWzgAiPVFRutNsteukzD3r9
 SckOdbC07Q6KqMoWleSF55J2aI/GqmqjUKQqb0QWPZAp514bVX3+UE8rbly+tCnZVJaRR/Yu+dd
 MzV9ks7eBjkAvUHPK/BwpzYIEhBcEePkNDpd0Pfp8y/DV8V2dsQYcKnvgi73HLnnTITSyWX5kCc
 98hO3tv/kW3JQ+S/lk/0w4e2eqDx+NSSoxFCg4sMO2NnGSCu5/Q+HFFmz0emSn0NhoCUoEKwA8A
 c6DB7cd0PLL+kmlJj24aKP5bR9lB+bskxiElPySoB0Z2ymvZQcc7b5R7hgDptIYEphatOU95xYu
 dQP6mEXcEHOVoUXCX/w==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c3cfdd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=UHmJGMnm0ijQcDfTD5IA:9
X-Proofpoint-GUID: n7PT7D3qYQBmBMwiie44QoNJ1OAdm6PX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250084

Make symbol_conf::addr2line_disable_warn configurable by reading
the perfconfig file. Use section core and addr2line-disable-warn =
value.

Example:
 # perf config -l
 core.addr2line-timeout=500
 core.addr2line-disable-warn=1
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/util/config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 0452fbc6c085..31541e03aab7 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -461,6 +461,9 @@ static int perf_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.addr2line-timeout"))
 		addr2line_timeout_ms = strtoul(value, NULL, 10);
 
+	if (!strcmp(var, "core.addr2line-disable-warn"))
+		symbol_conf.addr2line_disable_warn = strtoul(value, NULL, 10);
+
 	/* Add other config variables here. */
 	return 0;
 }
-- 
2.53.0

