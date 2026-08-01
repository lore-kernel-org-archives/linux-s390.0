Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2E3812EC
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582624; cv=none; b=q5hSK9tLa2fUrHi2fn/8Md7ows9XpHZI3VvrnByo7fiirQ66rcQVhV5V2bchONqjASmaV/hsWA7rG3d6FYjrQzzLFKoCFdwzeex5tuQmF6EIoqtnyrvGdlJhXsnl9Uy9Yad4RdCTWIX+SWgIdI3smRwP/VznS7OvaXhgz7E3en8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582624; c=relaxed/simple;
	bh=gA32zlPoEu6e1jg0ltkX3t61PpBC5IbSxgQmyiJnKbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFsgMX/z/wNqgDZeRVa3CVne8mXIGY0lMs8uHKX/ic7VmD+TOBrbgb94VobqFjSnUIWqmeavPbje8RrynC1AmOUMz//BiCGqm2Bvzi4lNYUQt8v9Yy0Ipym4NIu7HZhfynEPA+ycOkoyYJTmvYhnKNQOexQalSrgFl6/olIIKcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eZCcasbg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eZCcasbg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6711W5PU3409606
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8QchLCv5rwguRtuOZ
	GFYpD8E/v0RGHeP/v8cBeUZiXk=; b=eZCcasbgmdhaR4zb3zY95v52HTXqekAWE
	przmndwpUBf680T4OlLOzmq59qOZk+CVQcEOb/hxY76+q7YXcKY+yBdFJyggmdE6
	4+cPPhbRXj8bgiqYCzk54mRo556PF3qv10Vo1JVekqS1ke3cat/G9CIUialtT38w
	qgRIQcemWJrfcw5NTQVeGLW0A5KXlD8sK3y1UO/JVLeEMyeuE+44iGu834cmBWDI
	jWZmaGS2u3UOu0ZdoYxDoqQNx6J7pP0KrLuoRhHdKkF48snOcL4LmuMCa1vPbYdE
	nXRffBl3JjFknHbOrSdmRNa3LzmoIMkqdbN9P8EuUEShehyUFswyw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fs8ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AuPhB008250
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fquvb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAG3U32178682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B62FE20043;
	Sat,  1 Aug 2026 11:10:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B9B92004D;
	Sat,  1 Aug 2026 11:10:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:16 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 01/18] s390/dasd: Do not complete a failed ESE read as successful
Date: Sat,  1 Aug 2026 13:09:51 +0200
Message-ID: <20260801111008.3391031-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801111008.3391031-1-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX5/WtxBGlCIha
 auCfPmL4T6OgyrQN7YMk3K7BwHjNtzeN5FylwFgG1CqnIk5DHs3YZ4lDzlSSrZgPb6ew9JH759f
 bXmHZ7VoQDvCf5C8gXxKIJZ5c4/spzQO/gaMvO258irJFOFrsm2YxQuQfba+/eFemju36Kc4/xb
 Fln/5EtYwOXtAcy+ymloFRehsKTX3hxvw4sTmtqkFpXJk9PHwyiAEHQvW8nWQ8ZizX6dV1/GdcG
 ymRizVSfgKC5uAVhkM95k3nq4v98fZDxXfwTWO+IIn8XTJmJF36x98qj28UauYNM7+A4xUPiZB0
 x3Q9nS+530FOTJx5bUO3ikysujnbpHk8hP/n0K43lfhO4C8+cEdoLfMVxrDycFJnDHaFfolCH5p
 01R0fte74IjW9DPQ7slbF3brGrDgT031T+8paeP/2QsRcqUxEHeEG2rvSlyiiBklKDnIQLWXlr2
 IWurG6UEuZxthhF7fBg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a6dd41d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=1SqTnHJJj3MAIbOAUaAA:9
X-Proofpoint-GUID: BgKNoUjfYhd-OK4-ydCNV5GgvIYDh_kF
X-Proofpoint-ORIG-GUID: BgKNoUjfYhd-OK4-ydCNV5GgvIYDh_kF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX60Vwn+eR1ORk
 Ntot/mcpQvQcLykvDg9qBxSjKIf66glqRPDjRztecmXvv0t2ayraGrIFwCMAEJABMhes6YsWuNI
 us87o+JowecTWqUHUkk8PMyAzGixKWQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010083

dasd_int_handler() completes an NRF read of an unallocated ESE track by
calling ese_read() and unconditionally marking the request
DASD_CQR_SUCCESS. dasd_eckd_ese_read() can return an error before it has
zeroed the destination buffer: a failed sense-data parse or a current
track outside the requested range both return early, leaving the
destination pages untouched. The request is still completed successfully,
so the block layer is handed stale / uninitialized memory instead of
zeros.

Check the ese_read() return value and fail the request through the normal
error path instead of forcing DASD_CQR_SUCCESS.

Fixes: 5e6bdd37c552 ("s390/dasd: fix data corruption for thin provisioned devices")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index dc1c6d5ab3be..e9f0722af104 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1698,8 +1698,10 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 			return;
 		}
 		if (rq_data_dir(req) == READ) {
-			device->discipline->ese_read(cqr, irb);
-			cqr->status = DASD_CQR_SUCCESS;
+			if (device->discipline->ese_read(cqr, irb))
+				cqr->status = DASD_CQR_ERROR;
+			else
+				cqr->status = DASD_CQR_SUCCESS;
 			cqr->stopclk = now;
 			dasd_device_clear_timer(device);
 			dasd_schedule_device_bh(device);
-- 
2.53.0

