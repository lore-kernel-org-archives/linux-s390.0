Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA12EAD1C;
	Thu, 19 Feb 2026 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501145; cv=none; b=Buhu1+D0GxmjzSSjDlq0nEfBJy7BsenvtFz3MozmM+KGWUu8BH6a7Z9OTqnZmA3s7ImW9ncVJa1A4uyxlIaqLUkYKFB3hpCgoYklWNRMaADRHKt4GWdbZQR9+j1Jv/yVRYwHn+jwu5WF10554vfKF+SyNTMYK7Ht7gl3OuomH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501145; c=relaxed/simple;
	bh=5z1w0XTVZWDpfG5y4IdNGsgYbQwszn225RRPIzE81lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJftGBDrIhtYPjP28XPGRJtZlnLgQvi61kzNxj9xFdwboFVXb4Z1wjNIPWOeStKggpQhQRNCnCfKJaCtj5D1GGcLiRyr27qF/KtDpUFNb2Q62ddojOw05RQW6Lyw0oagG+idN2f4TVUiK2RdgbszA/Jh9ZIL4+RW0FjDYKJ4uQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d0a3aBbq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d0a3aBbq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J9A8CJ1369990;
	Thu, 19 Feb 2026 11:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TNnSnses5Z3Yjgq/WYDGhn3P8WlDDBv7QCy5eRiEs
	Oc=; b=d0a3aBbq6yE+EuxVgWwg0R8wWDP6YGzHT5icPzqkcacrrpn7rw953vAFx
	d9u+LE3nLXANAjK568gJQVzJePCsM9/XyO5WqBQHnxUaQutPgmCt67YY/zgXei2q
	7jn2SP0P4QnIaAo/HZZGsn32wsuPozcrxNqevB+UaUQ8kdhiJMM5+lBh2D7Q+yHW
	hL0FI05T2lc8R3TkUHARjKBlcPpNEmAx8d3a8vZqkEU6VEQkR0CXTDpGuN6rspTC
	F34uf8bpKjPITT9G++tskC5mzZKFk3ocBd0qdJpvr9grT4DjhJYeW/flW+0mP5/4
	1Vi3ETtj86NbdCa0uKm5z7GK554oA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjmm5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 11:38:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61J7vGmQ012024;
	Thu, 19 Feb 2026 11:38:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb2741qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 11:38:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61JBcsaD19530036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 11:38:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9FEB20040;
	Thu, 19 Feb 2026 11:38:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 723012004B;
	Thu, 19 Feb 2026 11:38:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Feb 2026 11:38:54 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf symbol: Remove psw_idle() from list of idle symbols
Date: Thu, 19 Feb 2026 12:38:50 +0100
Message-ID: <20260219113850.354271-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6JahrWOM-vwb8iEvBWxGeYV7fh5lGUrh
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6996f653 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=keipoBE3hED_wQI-0boA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEwNiBTYWx0ZWRfX8u71k/CYI9+N
 5CM3cl1ypjr7bvolUOHWHcnPuMkghGolroYJeDUAbY6dxqL7ZGLx+ASq1MzW4037aZ3faCgq0nh
 ge8vd5c8Nr3c0pmqqbGwbvr/owZAVJ8vEpYR+mR8dZGl7BpP+1Pu+V6NReGdINv4BgaXQHXXLBj
 mwoIlHNzb9X0oE4fUYh1AbOL44+eTD2mUcTunQ+ItV4zF4Lr+m2zLelzo6WVNE0FT6a8W7vXy1l
 cfUSunr1zkVcvIeCdQ3OWvHAEt0FN4bb3z2A7fORiZCWZlVLQxUQnCen4DCVfZp9plgzl7jrYU/
 iuDeCpRFOeUC1r/4JSnUnXSO46NXrgRnq9++iS+/EEBXTDPI3sQizOdW9mlsUsqQ3HwgNNpnitc
 MFxll/0EXd1DD796/+4RnHH/wB1Sc6ciUzBc6/yhx53sxUFp7TYZManc0mHv0mJSHN5VC8tZ4l0
 W0a3OLSpZXARTUkyvuQ==
X-Proofpoint-GUID: 6JahrWOM-vwb8iEvBWxGeYV7fh5lGUrh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190106

Commit fa2ae4a377c0 ("s390/idle: Rewrite psw_idle() in C")

removes symbols psw_idle() and psw_idle_exit() from the linux
kernel for s390. Remove them in perf tool's list of idle
functions. They can not be detected anymore.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
---
 tools/perf/util/symbol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 814f960fa8f8..575951d98b1b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -752,8 +752,6 @@ static bool symbol__is_idle(const char *name)
 		"poll_idle",
 		"ppc64_runlatch_off",
 		"pseries_dedicated_idle_sleep",
-		"psw_idle",
-		"psw_idle_exit",
 		NULL
 	};
 	int i;
-- 
2.53.0

