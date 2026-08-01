Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D33BBFC9
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607246; cv=none; b=bUwOW4TYFpPdRRyj1Bciqxv01M+O85fFcg/gbAKNmR6hdoUkgIsEHbH+2M/FyqnDo6uS8coonV7JzAQW9lMsnhIzB/ubEuIK3ng42PbsT9UlEp/xemeth7NR7L235pIESn6uVzuzaTJ83Jzl5+wyu7QuHOOjWSg0SX4itRYf1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607246; c=relaxed/simple;
	bh=1nkbS4t0z/jNRIPvt15xVo/n2dUlxGg0BuXBYg2XhL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siM7m8pBQbjQq6u5yx9Jv+aoGpRcHwNlEcW6O3xWwTL3A8Nmn3+OuuUSV7ZmOu1yw9mTEzKLkY345ASzvaKiRHei6k8Y4A+JJeoBnJRvKF1GgD4sq0V2phr7tnTtbRLEn9eKhnHxrfyJeSQIHMTNuB8jX7iIoH78E9e1pnrHKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jnm7MJ8y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jnm7MJ8y"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671FlfRm875070
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qPeZ8L
	meuKfX5O8qbmPQCZbpm6RTF4pXptsGoiEH3rs=; b=Jnm7MJ8y3U2lRI+kT1xbpE
	xJQ/vh1nECDNpGRwn4VvZY6NSn1taMrCbQjSPXdMpWOd2Pzg25V8T2PGUuYKQ1Bm
	0CjvgoOel0nvHOSGyDOwYlnrXzwiy8XCugzZOXyeuq8l1wP9lHaw+TxAzYGaUxwK
	1dXhAX+c4jRVEnXLhVXxQggWBD+RIU9qCvEpTSGyTAP7AOR2Jyhono2yJ/j8Px5j
	ovoLZscFcsRVTawaQcw7lA36igNWk31F9NLFsuO+ABl1PJoOLZ59f4hzlhu+DhcM
	8gRoOLt413A19yh4GY8lHswaXzfwktKuBz1hTzjm/mzRHDBjXkzaM1+89i6i6MLw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67ha9sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HuITf027800
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ymfh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0aHF49348978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C51A420040;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3A272004F;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 05/19] s390/dasd: Optimize max blocks per request for track alignment
Date: Sat,  1 Aug 2026 20:00:19 +0200
Message-ID: <20260801180033.3679412-6-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801180033.3679412-1-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX+4m2Fwr1Ur5y
 zePI4XDX0MqjI0ZjSCgC8hwoUlUwl7l5EqLy1MYgSbbcEzh+6KoxY6ioTtGAjgTOX832fJPVlZy
 bJSAKGZSUw4NXiHZesq09SllLfFN6bg=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a6e3449 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=8f17mpASHZ0i51vZi0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX+FtxdXSYLdBZ
 SZZf/krmrHSzWlcwb5EBKLsgKTEupeV6z48cG4X7lG10eFw6fvQrhVUuCLsXEHHrINU9q95zC6/
 u1UxEq7BXW7GCFtSzHxB2/u4UQqGTK3wBl1UpSdt/0G21IEC5cVSb75KQV9oPmzq57Tc7Y6IfGU
 0VIWwefC62g/EK6+E2Hid0l4z9oBNNQrjqWcprAVTAVNDCFIFJaAc2BwqClLexrrp0ziRPvxZFX
 3QAZYJ37s2i6jBjqbWowQwIiHtRPXk6cfS5PFI/ECWbZ1Xgme8xD2tHe6Ayp8uPTRd3nyjnrjx0
 PlwCL0uJ/Bu03zgJ0Y95tSAVEVIumpj7nt4oN/gRadKy8SpHI3jLld2zppgdlKdv6vx1kJKbagQ
 UEpUJTSryzjVMNklO0eEb9k0mgn9vOOdyduHTbnjpEymE0gRJjSRP0AWcyfS6Hnlb21ja0V1ahd
 68VPqnIp3myhi59gLeA==
X-Proofpoint-ORIG-GUID: AfVskf6EJurlWfsF7W4ywtyk1JcGrAn9
X-Proofpoint-GUID: AfVskf6EJurlWfsF7W4ywtyk1JcGrAn9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010143

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

