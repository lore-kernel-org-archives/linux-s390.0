Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD5376468
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560345; cv=none; b=Fh77oxgfXpzQF8FBzjBBI24C3gj9CJClx0q//NusxjOfP3jY+w6BXX7Nz3f/CitxwUkLoVuf8kklqLJhKHH7uOW7zA0qK7ivD4IPYR2JZ1zWceY7n6DevPO5kz66Tj77TaiHawaXUdYUZOB4G9vVRK16N4fVOfRfrSSuc7VS95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560345; c=relaxed/simple;
	bh=RpXwNl6pkvFQFt2u2t9qFklAXtvk+VqdblFHqZwwnlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REepHH+pZh3gVh4lD4YMwEgpXvsCYIRily5A83Kn2ZpYvrmGAE82OcHbWfUccVMofOeZ/CBHCSWz3L8mYxcJ47NSVVTSRw/Qr6wGZWw0TY2p0xkCgGWOv+IuVdcdyBmcWh+KhNIAminE+3KxzaQE4KmOD4QTieMgMWPh17Oz21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tuUk9iqi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tuUk9iqi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VQGg965714;
	Mon, 24 Aug 2026 08:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P3R2CJTeV5wkQovcm
	RGTdM4GZu1zsPmlr0Vw58s86a4=; b=tuUk9iqiQVdzON1zB22Xu31f3FfW702l1
	w1fD4xxGAmmXm2QiIe5vr9htyP9m36Tf+fo/TANb+LFXa/6l7hys67NG/L5tfehB
	gbOaqUGesv0zl86FnFbiOhj6U5vhLs0xI3EjYT34RYiRvK1XbLH+5F/iOtQYavmZ
	1dehjAasB8aZTPnqDTH1h9C63mGt3gnRGJC/qwEgeE6q4imHzoLygskBMEA53mnX
	VWkjp2Fx2rkrHOoQMFqHY4kZGTfOO6MAz50o88iPZTW1Xq/9VnT0IiIj9X7yeX+q
	RCv7XBzrRN0zmlwEifbY6FvoKDEscUpic6u7CbxabRza5I5AgODGg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4g26q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8QKQw029636;
	Mon, 24 Aug 2026 08:32:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag4mv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8W5R516908570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:32:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F31120043;
	Mon, 24 Aug 2026 08:32:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53A972004D;
	Mon, 24 Aug 2026 08:32:05 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.131.174])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:32:05 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v16 01/20] target/s390x: Fix missing privileged flag at PCKMO instruction
Date: Mon, 24 Aug 2026 10:31:45 +0200
Message-ID: <20260824083204.40877-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824083204.40877-1-freude@linux.ibm.com>
References: <20260824083204.40877-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o9jDu_-tzF8WLYsh9p__a12evV4BD6ph
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX0qV+xqK9BHrt
 7FAB4tyrqKticRtfcSxfyPx67XEw9fse0MwBo7f4BVXfh045JsmvSN8Z36VvtC5Tl4K5qf/rtB4
 SPjItIbxqkXSBNgxLBKqJs7P+q+unXY=
X-Proofpoint-GUID: o9jDu_-tzF8WLYsh9p__a12evV4BD6ph
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c018a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=B7scKulbZj0pNRMJRCIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX0rBOgYstvaYJ
 9QcAWG05lr243NZgb81msFSosZfvIGGxbDLm9uFskGLyn1SLDpYNCKUJvsnr0u0fdUwswsueu95
 pyXxDHUAPFpugJXgc0a5y5HxpjdNnkxX3nxjYDmeDYMwFPz47XZKlN8m3c04e/URPHWkC2EMs9L
 /LpwVBrTXEcJ2mLWNx/VjF5A5sjPf6I9SzKhEUt7ZKj4jjPPOOcJIiq2o4LNzwEj+rKgz8nJiZP
 gAT18FbDQhDyJThvKnWBifisY6C0vOnCyzdWoF0q9z3vo3OKWvGtqUCLlT+A2UlF30/DrDuLkdI
 UP6ZOwPuPqL6MGKZSeUHLJ/S0RdoiCfjI+BC5VWjrgttxeMuowGp4ruqfVvtOf9fm8ElXwNgeB+
 HI9CdDq1q78Pp1P7ninOrlV1i4GGU+E32zTt5EnzSWPw+noJHDlgyyPYfJfjFpIdBme2ToUMuNf
 1Clsdyn7RvcVbYptCGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240074

The CPACF instruction PCKMO is a privileged instruction. So set the
IF_PRIV flag in insn-data.h.inc to reflect this.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/insn-data.h.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 1ea72248a6..b2e402216b 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -1007,7 +1007,7 @@
 
 /* MSA Instructions */
     D(0xb91e, KMAC,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMAC)
-    D(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCKMO)
+    E(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCKMO, IF_PRIV)
     D(0xb92a, KMF,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMF)
     D(0xb92b, KMO,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMO)
     D(0xb92c, PCC,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCC)
-- 
2.43.0

