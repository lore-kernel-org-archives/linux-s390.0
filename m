Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6B139578
	for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032258; cv=none; b=qe6ElWXcZU69+esk9FzmILuswzYdIrX3jBSOlSaHzgrBer3VnI7jHdL0YEL9c9Rr1++w73mXchX/Wvdf9Om/yW4ugXtsegxSHfbUmCk6OuMN6tjbIvRSl4DF0UzqGnVCjqMB4WCY3aPtcKwUMGkh4GBPgpZO8qzdyb9yfswOJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032258; c=relaxed/simple;
	bh=xry+WaKilr/02uNr1YK8GZQa/FXdBwI7DmGZAcKOIJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P5ZE/xiGZky7nUUtVITNu9HAygI4shTuTz7xGep9MmotDGyTGXbxaciqt/TlqJkywCsi8aD0PvWa0jc9AYtdq4d9D8dxjwfxBCYgRU2rgDFxXVxNtphLESJEWeQcmGFj30TaCfbiM6KutEYDHea9JE0VZMUCtwB6qlu42tPM+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UUIe9Vsn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UUIe9Vsn"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AEwpRX000808
	for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2024 15:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=zdjjMU/+35scgx9NoZZ85F8XcE
	gm+xyuASJk3PDoLbI=; b=UUIe9VsnAND4Ns5jJJGzKPUwF6oKFFZMNv0wdlBduQ
	ds1+Zi3XCr+gXCPSyqsiO8d9rY1pkCvAsVItFrTFDMJZuNICVylcfeJ+UHoCb0gd
	EWSLJbANVi54zfkx2KATdQ9CR00zeb8jvZw5AUp/aEsm0c1jjeC3eVZR/11X5iL3
	0QVac1aDUOt7dwU2Xa59cOLuN5UbGHm1RUWB0PKiz0TONDtrAcKljmvE1IlraoWM
	7CrF5akwAxIoL69e20Aq6NircIbogUCq88FqaJK0iJrh+NjFa7L/KIJQwuRBWs0w
	/dEqIckt7vfmhS0JZeQrKJWZlM12mRI1dsgC06lNhU9g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yp3qe011r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2024 15:10:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45ADb6n0027209
	for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2024 15:10:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn210gb15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2024 15:10:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45AFAmhQ45285684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 15:10:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 995DF2004B;
	Mon, 10 Jun 2024 15:10:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88D7120040;
	Mon, 10 Jun 2024 15:10:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 10 Jun 2024 15:10:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 22FAAE11CB; Mon, 10 Jun 2024 17:10:48 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH] s390/sclp: define commands for storage (un)assignment
Date: Mon, 10 Jun 2024 17:10:48 +0200
Message-Id: <20240610151048.2548428-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B3pGgNECvDh2EK1NZbS6iM4xdO6k_iSU
X-Proofpoint-GUID: B3pGgNECvDh2EK1NZbS6iM4xdO6k_iSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100113

Replace immediate values with SCLP_CMDW_UN|ASSIGN_STORAGE defines.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 drivers/s390/char/sclp_cmd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index 11c428f4c7cf..9741d849febb 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -29,6 +29,9 @@
 
 #include "sclp.h"
 
+#define SCLP_CMDW_ASSIGN_STORAGE	0x000d0001
+#define SCLP_CMDW_UNASSIGN_STORAGE	0x000c0001
+
 static void sclp_sync_callback(struct sclp_req *req, void *data)
 {
 	struct completion *completion = data;
@@ -223,7 +226,7 @@ static int sclp_assign_storage(u16 rn)
 	unsigned long long start;
 	int rc;
 
-	rc = do_assign_storage(0x000d0001, rn);
+	rc = do_assign_storage(SCLP_CMDW_ASSIGN_STORAGE, rn);
 	if (rc)
 		return rc;
 	start = rn2addr(rn);
@@ -233,7 +236,7 @@ static int sclp_assign_storage(u16 rn)
 
 static int sclp_unassign_storage(u16 rn)
 {
-	return do_assign_storage(0x000c0001, rn);
+	return do_assign_storage(SCLP_CMDW_UNASSIGN_STORAGE, rn);
 }
 
 struct attach_storage_sccb {
-- 
2.40.1

