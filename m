Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9073435512;
	Wed,  5 Aug 2026 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928592; cv=none; b=SydCapmMmpTZL+ivfBsCD99G0VejZvoGT7XgwlBgDJAuHO99OawaMBY35mWfNKy+tpN0sJ+NtSNOZo/4izZoeVBG1/VjRjqAVl1brcKgZ0b8I8DKXX0FZ4lS2zasuiDSfKCWX+8Jyh8NYSkJ9w3tWFcq2D75CxNNxF2P6TB46/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928592; c=relaxed/simple;
	bh=1nkbS4t0z/jNRIPvt15xVo/n2dUlxGg0BuXBYg2XhL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGOn3wpbq1sBFgeJD1b17EFT+mkm9BNSGn+YhqKBgs3c/vE9Six8yaiP7qL5xwn2mWgTI6qyZzTwyMIFtJiwl7ZgilcAbQ8OqCbupjlZpt2GrHht3mAdVK5K5AcylXjBdKxtTGtaXvY7v7vA0b8y4g0/F/VexE5xLhTqlWJQdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=loRwHMsA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="loRwHMsA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758m5NM3355781;
	Wed, 5 Aug 2026 11:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qPeZ8L
	meuKfX5O8qbmPQCZbpm6RTF4pXptsGoiEH3rs=; b=loRwHMsA9QvOpzjnaW456i
	30CpE0ujpDzidb26HHgLtNK5Je1GWrJn8ANr1/+oP7H1w9Hd/KcG1c3GW9vFVR2B
	9ZirBf1sbc/aqFcuE81tviw6ZjlHrg5ztkl0GRgQHsmteWqhYzlaw0GnIfCinozu
	XLg9f30NFrdLlDE/q38grqt+V+D2QSK4mW9+56TNQdF2LqFDVBgCcfXEZPavsB2n
	XzLdkASDnwygjZU7ddR2N0I6IYgwlAe1sXkJjy1VceOEe++NRzZb9AxYpjcrd1Ve
	USyQXcZMMYBluLrtEv56OkgtoVscB9+UAoHieY9bWfTukUdAIrSJ9StMNbgCqCPA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42prh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AfZPm006300;
	Wed, 5 Aug 2026 11:16:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k685g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGHKC45941120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C43920043;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45DF52005A;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 05/19] s390/dasd: Optimize max blocks per request for track alignment
Date: Wed,  5 Aug 2026 13:15:58 +0200
Message-ID: <20260805111612.1285190-6-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805111612.1285190-1-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a731b88 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=8f17mpASHZ0i51vZi0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eohPgSB3xjQpL-3mKLQWEnGLSYi6fr_q
X-Proofpoint-GUID: eohPgSB3xjQpL-3mKLQWEnGLSYi6fr_q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX/up+JZzU4IDL
 5bFMXzVXD+vMjxgOiBidu/lJQVDb1TRGRptA51VzYBghOWRifGbZ2tJRWWo+GejHw/d+FvvEcL+
 oOBj9nYv8J32YY7HzhBgUwduX4opqpg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXxDJhCRWX2N16
 LWiFTdVHLHQ8rXG1IDU2Exn4yOCje1gksma4oWXc/EtS8Gyg35KPyBQG9b5iyw/uQDhwL0GPSWP
 0NsJ4yJ737SCzYTYqadtYdg++Tb6HwPm35VxDSD4X6LYC53CtgzwKqmBhuTEHvqeuXcjv7jNOZl
 kDPv7Z332p715Y7jv6+zShUrSi8N9zSN2zjXVbfvUApeNZSCHmkqu0zByN3SbKFEkTgJDczmY7Y
 sFm/K+uLCTqZKsKrWwkADLmnZV0u/fd+fVVAQwil9bjD6R5nAEIDm+09bK8YMxwqjzUSHxypQvA
 LdCtGqIMAb4CQy5JHaQNyM4EhkFWLubEQUvhDwHC7xmFe+cbmT/Zd3pGGrB0Tv8BYNsmEjkNN5F
 qsFawjTu2w/t9b20jR88vAPx6b4FFCuzqBnkmsOvl9bzVs9JXrDtbq/H/h0qVoUH6SDw4lHggXc
 GD3h43FQJ8vo8nVR4hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

With 4096-byte blocks a full ECKD track holds exactly 12 records. Lower
DASD_ECKD_MAX_BLOCKS from 190 to 180 so requests align to track
boundaries (15 full tracks); full-track I/O is more efficient than
partial-track writes, and 190 had no alignment significance and could
let a request cross a track boundary.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
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

