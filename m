Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C519DF62
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607243; cv=none; b=ULlKYOnuHbqmQlvN2VzlOK+xEmy278v0nmIPAzCMt3VtuyxeZdR9AZX4XJG2PCTFCl+4qbWbLaHxbL1sl7J5OikBZgOqYMOs00q6D4cpSB5tmSP1Tcywq7nCaybGqW9kPzI45BS44wbjZqll9a8rWRjwV0XwWJRmfjMdm3KnDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607243; c=relaxed/simple;
	bh=gA32zlPoEu6e1jg0ltkX3t61PpBC5IbSxgQmyiJnKbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrPXkb1F9mGGM2/DkDXQYm6+boo0UiVWk5qL9Q5wFzPAJswAVgaCIl1LUGFCcOSkugsyPEdWt7vjy6sLTBa5x/2zEMMuX8hw0N1OX6YszeFG5V9LUQTqSwzZORcHdDfNtZPNuKcSfAKJ6qcctrd0Cxk5zhNyBbVhHkbJKPvNEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LHIUqaFb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LHIUqaFb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671Fo7pf1003261
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8QchLCv5rwguRtuOZ
	GFYpD8E/v0RGHeP/v8cBeUZiXk=; b=LHIUqaFbccumYTPWJKjKGHoNp8mzkrxyh
	qqUJzXMCOMD17TwCGK7IjSf5WxRhA+/O6aOTi9+SNG4yX+d6yHoEvf0v5rnqZD/P
	jHV45IxJVS+yLj1Z03IrHuK+fET2NdittJvHHG22GmqAoaDzAlK3wAnLi1TeMwop
	KoyERW46qPXxSEmusFfawGgqHQfS0QHGhNH8uhKNXrKKHuYUQ2VipYegJiR/jNDS
	8ClyChXF2izEcmF0fC70LV0rGc+GoplUM57LoNPW5b6AqdLwjnkmDmgwhHS5Q7WW
	RH6unP635IDrCKF8lrnKXr/RFY5Dho/Y7Qf+CF+kiE/++XDWdKkow==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eu9y76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HuKbK027452
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwmvfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0aOm49348970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4975120040;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 312142004D;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 01/19] s390/dasd: Do not complete a failed ESE read as successful
Date: Sat,  1 Aug 2026 20:00:15 +0200
Message-ID: <20260801180033.3679412-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801180033.3679412-1-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UsbfE46mLPoUXffqbuO8hpx5ibIjDyHN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX8PUw1E2OwRTc
 x4YpWLW1dXIlY6vBxAkVL6QbZ6HdqHfcMOnq3XcHlLUptqE9fI1G7kTReHIVh5GAOOErxr+HqKD
 ZHYV3/zdXf1sa36GL14WG4SiLDwKQq0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfXzCc3CNxuqg3M
 50x+LGSUt1qADq08doN5QWuz/u8SF10sE4P6hyn68DCzznyQRJXix1ff5b2CtLZZKsfDJXZg4qg
 edU4cCsWbWgtaMxpdJLqCThe8/zlyK92HAQARRnGKFmmCUXR8OgvFnl4gQoMKeelZ/xWDuaiXDm
 OeNYP9VzHsUzi+PpiznWCwqUlvc0F+Qju0zi1rFh7tLnURZN3c3rPVtPsehNPAmDPlgcPsSnoS2
 8vF0JbWC/Oe8coXUMIpSvB+feXu2kANXH7OHEhNV00eZomnZ3Zs2dhYo74j0MeRDV4RYDQih8sy
 tV8z1LkxSzcYJ7z/9Ica6p9HwRstOf3NVlpE7RbadRS7I93ZiEN0nNjxjhOqeu6O2Et1i6zxFJq
 jqZ9mt1jpY/lNkQ7aVcdbToHuky2ZNRia+Up89DKugVu1wlK2ayT7n59txoIjSCZEi5Pqt0rUn4
 B9rK7ZWWL550v81kvvA==
X-Proofpoint-GUID: UsbfE46mLPoUXffqbuO8hpx5ibIjDyHN
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a6e3448 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=1SqTnHJJj3MAIbOAUaAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010143

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

