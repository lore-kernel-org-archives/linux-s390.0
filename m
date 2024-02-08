Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C7823A7;
	Thu,  8 Feb 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410581; cv=none; b=pCyLG+R+fn2flUB6ErNrS0PSVvuVQdAhNnMbYpUgDJZlUEI7vLhwf8k0vVZvEGhVSXcL9JlWI6JgDBSNKUJkgUbC8ObdcnU70pdaXnaebW6y+p+nlv7prF7Soh/hymaKOjcO9E23ZOKNsGq9by6frv/mpTIK8DhzWNLMTLDi6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410581; c=relaxed/simple;
	bh=astuKLTibLQmz9iMk99vXO21EaiYUIyw68f7mniA86U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHNSN7C6b7HinZMiYJGO5KiQ9+phsualpS/62I1yM6gv045EMCWAgv1F2tbaS4WR4Qv9P/oNW5pwpjqU65bKh4R4vyx9k5GFIAHFhbnRZDFx0OOgyjP7Xixj67yIHg4LiS1ACMituYdrYTsM6Ap4x5sRsLaTKFqXhVJCtKvlf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lmbo8LT9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lmbo8LT9"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418GRFFT029445;
	Thu, 8 Feb 2024 16:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=KDRM1YIH/JHR08EauKRUfvNfcs6qbcrMuJjYaVdOxrI=;
 b=lmbo8LT9OjlK7lOYNy0794fUVBe3wnidpcS/6x2bFrDwI4DO4pN8UaU+Ipy3LLfXlPsf
 CHC+2ucOwav171ehrAci3G7ed56fw5GB+Q835jmzUU+Aa9mxx9aVl6IGo/r9inE9Psly
 uxaMf5o88shY0XB5femA1Ag5Oh2Oa0KjEG+74QUmGzkpAmcmLVnpXPZLMwCwOoQ5QYAr
 u6MbIUvaZ9Q065Kvtlzm9vGjuaIeXfec7ErIpUj057tT0Q6lMhp0v6phQAu7bftDeSC5
 Ec3C8Fit9txRbrI/xM6wsGycmxKDrjspMAeUwgp+L33pwGa0EbmPoB7OgCuaSD8TGIsL Xg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w50qv3kqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:54 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418EOThu020383;
	Thu, 8 Feb 2024 16:42:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1yttdwuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418GgmZl38666878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 16:42:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B03A2004F;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A28B2004D;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 3F933E04E8; Thu,  8 Feb 2024 17:42:48 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>
Subject: [PATCH RESEND 01/11] s390/dasd: Simplify uid string generation
Date: Thu,  8 Feb 2024 17:42:40 +0100
Message-Id: <20240208164248.540985-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240208164248.540985-1-sth@linux.ibm.com>
References: <20240208164248.540985-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F4VPfxBR1h-ub3yN2_64e-Ja1XdB-Pfw
X-Proofpoint-GUID: F4VPfxBR1h-ub3yN2_64e-Ja1XdB-Pfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080088

From: Jan Höppner <hoeppner@linux.ibm.com>

There are two variants of the device uid string. One containing the
virtual device unit information table (vduit) identifying the device as
a virtual device located on a real device in a z/VM environment. The
other variant does not contain those additional information.

Simplify the string generation with a shorter check of an existing vduit
embedded in the snprintf() calls.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 12 +++---------
 drivers/s390/block/dasd_eckd.c   | 16 ++++------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index c4e36650c426..6297dfe6bc67 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1412,15 +1412,9 @@ dasd_uid_show(struct device *dev, struct device_attribute *attr, char *buf)
 			break;
 		}
 
-		if (strlen(uid.vduit) > 0)
-			snprintf(uid_string, sizeof(uid_string),
-				 "%s.%s.%04x.%s.%s",
-				 uid.vendor, uid.serial, uid.ssid, ua_string,
-				 uid.vduit);
-		else
-			snprintf(uid_string, sizeof(uid_string),
-				 "%s.%s.%04x.%s",
-				 uid.vendor, uid.serial, uid.ssid, ua_string);
+		snprintf(uid_string, sizeof(uid_string), "%s.%s.%04x.%s%s%s",
+			 uid.vendor, uid.serial, uid.ssid, ua_string,
+			 uid.vduit[0] ? "." : "", uid.vduit);
 	}
 	dasd_put_device(device);
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index bd89b032968a..229f23a30c5b 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1072,22 +1072,14 @@ static void dasd_eckd_read_fc_security(struct dasd_device *device)
 	}
 }
 
-static void dasd_eckd_get_uid_string(struct dasd_conf *conf,
-				     char *print_uid)
+static void dasd_eckd_get_uid_string(struct dasd_conf *conf, char *print_uid)
 {
 	struct dasd_uid uid;
 
 	create_uid(conf, &uid);
-	if (strlen(uid.vduit) > 0)
-		snprintf(print_uid, DASD_UID_STRLEN,
-			 "%s.%s.%04x.%02x.%s",
-			 uid.vendor, uid.serial, uid.ssid,
-			 uid.real_unit_addr, uid.vduit);
-	else
-		snprintf(print_uid, DASD_UID_STRLEN,
-			 "%s.%s.%04x.%02x",
-			 uid.vendor, uid.serial, uid.ssid,
-			 uid.real_unit_addr);
+	snprintf(print_uid, DASD_UID_STRLEN, "%s.%s.%04x.%02x%s%s",
+		 uid.vendor, uid.serial, uid.ssid, uid.real_unit_addr,
+		 uid.vduit[0] ? "." : "", uid.vduit);
 }
 
 static int dasd_eckd_check_cabling(struct dasd_device *device,
-- 
2.40.1

