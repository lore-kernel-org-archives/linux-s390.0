Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456B22AE45;
	Wed,  5 Feb 2025 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738750725; cv=none; b=P2xMOGVPTaCHwSB6rGnMRui2v214IepmS81hbbtHhiRkIc8rasIr6B7Kc1jmKhx7eSLEymJGtegQIftlm77GeARX0V8BMsMf15Z81tqH5C7ELQAV+WPttgXUJTumZA0XTTaeW3uwvMzqFLBzZBVLoGYNxUoLq+AtZzfAyhXKBO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738750725; c=relaxed/simple;
	bh=Gh/nB2ep1SDZc6egQaYd5NkmctEi0wJflmLTA3TGxxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3Dt+H6+3OB3MdKySsXW5SXtdAx5rTPKzlrjH+2gDJFuM5pzuORMebZ1Fbu1CKHMTy+IznVIPgDqVbUdoIB1gYSapInTRP1XS7Z9tJPpS+NDAp7pkvQRsLlq51lqXDWMq9eHbkrrcYz2o+V2lGbdpyxA+4oR7OG+ykvQTbmWkTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mdQqfljT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mdQqfljT"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5152bPYN028870;
	Wed, 5 Feb 2025 10:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F6IWE4ooEVT6epgJ1
	ZXEltVjosjahwesKG3d012Lxnw=; b=mdQqfljTymSsACciIhzgj1o7qKH8Wa6Fv
	DiIGiXDXVTkYEBlQcuhwM70HHx9htkgras+08J1iIXsVoh06zLpF/Vt0o1V9vO5F
	swgf+h/lnNA2suZyLf2/jftCP+q9n1R4+jWWsH6KgX2cWj51KF5XzHqyjy7toFgK
	TftWrVPWj7XBi3R6dSaFMPmUqk+Lq5MwKCnqcUb2vdk47lQkJNHWF7rkfBptfiFz
	XW6UhjdMlA689oxU/7Go4m5oKLij5aY6WrmUNThpo0FCi3FUJFMoIB79Aaaf2a/m
	zpGj8JUxDt3W+NIEQUJ0r3WJP3fPoYHEJpXTdXIPmGhxr4ZPXTxNw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44knqtvegs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:18:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 515ABesj001907;
	Wed, 5 Feb 2025 10:18:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44knqtvegk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:18:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5157nnq7007158;
	Wed, 5 Feb 2025 10:18:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxayrb9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:18:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515AITa438142354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 10:18:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2333F20071;
	Wed,  5 Feb 2025 10:18:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAAD520072;
	Wed,  5 Feb 2025 10:18:28 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 10:18:28 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2 v2] perf test: Hwmon align structure on boundary in union
Date: Wed,  5 Feb 2025 11:18:14 +0100
Message-ID: <20250205101814.2801701-3-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250205101814.2801701-1-tmricht@linux.ibm.com>
References: <20250205101814.2801701-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S11uHZPUSi1MxYouShFCere-Ub_79R75
X-Proofpoint-ORIG-GUID: 9Le854QWHyfR4jkoXu8iFfxkenKG2Wat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_04,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=830 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050080

Align both members in union hwmon_pmu_event_key to the same
boundary. Add unused structure members as sugguested.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hwmon_pmu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
index b3329774d2b2..748cf93a859c 100644
--- a/tools/perf/util/hwmon_pmu.h
+++ b/tools/perf/util/hwmon_pmu.h
@@ -104,6 +104,10 @@ union hwmon_pmu_event_key {
 	struct {
 		int num :16;
 		enum hwmon_type type :8;
+		int unused: 8;
+#if __SIZEOF_LONG__ == 8
+		int unused2;
+#endif
 	};
 };
 
-- 
2.48.1

