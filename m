Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A31471D00
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814478; cv=none; b=V+a/U6Bcldv4YpXJuiNIaXybXPxJR+gByFpddCSw9NGvYh4oVw4CW4aOCn8RYvgupaVqdiLV69/bJoZS37hxEBzi4ilVdTgX/C73aSNTo46Xw0QzsOUIL91gmtM15a/mWWVX4Um/ALQP5GYG1E+Mz+swJfeu+F8R+cmTWXloLzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814478; c=relaxed/simple;
	bh=QhG+NFs27ZsFK9nm2RQF3OkUg18j3RPf2/LCiNCQ4fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhlrnUNyjFzCpFKyYiNHmoMPT5ddyq3XtS51YOYMvU8jQnYrr3PsRCJyoWFP7d039CWNDhqd9UE68prw0YYaFDjPKpzcyMCiBAntldsb3osRIvrRoOGbrK4U5iyqxqJ5+e1RQgGY76C7PozRxMoWHWqOg2ubxW8ommtuFuO5LpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lLXZH98W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lLXZH98W"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBiRt3094723
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XeMoIoJJP868E5Fet
	iRBfbaMbOggXs/uaT/PACNuuWc=; b=lLXZH98W1V3UOjUUa6LEF2fcyOyikFhmZ
	9vmg+vSYTW+nofMxL75qYoxsBGGlSwyIfISwWuu7WKiLcKAT2Jr5ZGpn9QvaNZ6s
	T8KN4qgfuqYXD34GUrI5TGQNZWtSM9RqHEGoamwKTBCaRYwYrBNhRfmfc0OPx74G
	NmY5UyMALXc/VgRHCk8TZrjB2M50CjzqEfvMmPdYN/prcvreGm8ulKipr2BZvDvy
	gQai9m+k6dhGWz0o49OCi336dxUEeakb+Q3RGEgfNMJAmQ0Yd75jsArr+houJEHX
	ANiqY+sszcMXXF2JExdy4ftYphFV5FRq5zDfxDsil37YCCEdqcTQg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahf7bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDYZnR025818
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk4du9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NDll2530343770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:47:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE01D20043;
	Thu, 23 Jul 2026 13:47:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 985792004E;
	Thu, 23 Jul 2026 13:47:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:47:47 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v3 01/13] s390/dasd: Optimize max blocks per request for track alignment
Date: Thu, 23 Jul 2026 15:47:31 +0200
Message-ID: <20260723134743.672413-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723134743.672413-1-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uiIfLuuzQsdWXi8zXQjK0Bx7IyLpmc-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX7QLSAiienuvM
 2fXedCbBzh2PzSXK084SlFnasGD8uG1+EiloOfXvXObWcC0B5M39qVFloLWA2VIfGEV5z7O1weU
 jewW37ooop7Hlq3L2hShLtQujeoCJWlR3YeNfmySFnLlc6RaoZ9RuS9iHqw++413rjk0bppXcvA
 Wgm0Jx9T1nlcPUjAbmhGTUesHrhJQSTXjp8iMleBdCqlVagtCLtiGCny9M1LexXNVPol/o9drD0
 SKItO+Ap+efSTlfAUg2yI32uMmtArLZPz63cZSxHpCjVF5pPtM6duQVzMQQ20w7FXIkVAhJ18SX
 E39zZEK9RSb/tW5wbNtCPvm5HD3mRVZ83sgNuBZSM6vqkMfg4TvLp8kgU0BGK1v+wdTfnN7NxUT
 VIDcUSwwEshXZWsbDqA3FbaXw/2MpnXwv7kGMn+XlvIYN5W9l8GbmwL1wRxtxlvSYmo7WbWLiFY
 NHZQDLavauQO6AGXYfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX+eHOTrj7kORa
 dYJzkd+NV8En/UX792fj/ckFF4IaMGObnM/JhGLEoh2UYEaKIpfGHezbGs4GZZn5gZxyj45A3A1
 c9jGbYjYZhVGYWSLHKdxmYB6Or7mBik=
X-Proofpoint-GUID: uiIfLuuzQsdWXi8zXQjK0Bx7IyLpmc-4
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a621b88 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=8f17mpASHZ0i51vZi0YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230135

With 4096-byte blocks a full ECKD track holds exactly 12 records. Lower
DASD_ECKD_MAX_BLOCKS from 190 to 180 so requests align to track
boundaries (15 full tracks); full-track I/O is more efficient than
partial-track writes, and 190 had no alignment significance and could
let a request cross a track boundary.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index f9299bd184ba..763733bcc4d2 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -131,7 +131,7 @@
 /*
  * Maximum number of blocks to be chained
  */
-#define DASD_ECKD_MAX_BLOCKS		 190
+#define DASD_ECKD_MAX_BLOCKS		 180
 #define DASD_ECKD_MAX_BLOCKS_RAW	 256
 
 /*****************************************************************************
-- 
2.53.0

