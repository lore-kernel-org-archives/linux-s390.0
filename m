Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FDB37EFEC;
	Mon, 27 Jul 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162542; cv=none; b=iC/Etso39cMenuF0s2i8YiiYKiCGJ/gKNhAoBPud8aTbQA2Fk9Cuq292F7ZZyrBhJFr2SlZqJYIF7aqp7xG7vt8WM1m4osIp1bqTeFe7CukKeoUt8fcDswa2JGd+aWfg/HPuUnVL1QG06CNG9LXwf5fTFf4GefYQeTZlZ4eihPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162542; c=relaxed/simple;
	bh=yiibBTkivwRw4DOGzOaO3IoKVvZNoTx7hNyCbyzNsQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhQaGqjsJvPcIwpppkmBqnOt4fCsfFv1a/FG8yN8pVSWB/Euv6mD88CzUabWl2qsSnxdPC1Z02kc7rMiRYfnVk075C7vd+KWu7U0ovbeOI5bS6m4vm8NURpve1UmIpA+AOIjZyzceOTF1QPfTTpLgHWTEWiEnpoquYWfSKMvY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gcv0/IKH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gcv0/IKH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDn9w32407986;
	Mon, 27 Jul 2026 14:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Fohw0A
	liHraUciOinHAZHqStTtUicqP/oS2W1TC5kGA=; b=gcv0/IKH45sq9IONGkPrwZ
	IuPW6ej2dhSY9qoNbHNrhvSMJ+e20kaxBPC5M/4bKJGO3pFRN0aPbKhc8eUE4ksC
	U+xeH3ScUKTAOKDdsxmsoktdzRNLVbkpHxzIcOmkxWUH5JJC2A55MKzEshvEbpWD
	/qIpphxldEPjv5xuf0tIyGwsYLEWDhJbjHs7gQY1LBzIr5yjSp4pXEY/kMzCkOJ/
	vsR6b03MHFdncmjwoHw2PHfrDKFI2HkZVxk2wQ+yYNUjdFgXw2kOIDhRmXkgnh8W
	VpYYlIZg/wMl4potJf8JyBKtJQp67OkY7eZp7jcM+N3lVxof+Hyg85EdH+eLtFVA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xggaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:28:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REQEa7013991;
	Mon, 27 Jul 2026 14:28:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg5had-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:28:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RESn5F50331966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:28:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77452200C8;
	Mon, 27 Jul 2026 14:28:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59EC520103;
	Mon, 27 Jul 2026 14:28:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 14:28:49 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/3] s390/dasd: Fix path verification interrupted by concurrent dasd_sleep_on_immediatly
Date: Mon, 27 Jul 2026 16:28:38 +0200
Message-ID: <20260727142840.567286-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727142840.567286-1-sth@linux.ibm.com>
References: <20260727142840.567286-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yoOf-eoerU8nZkuWVrtm_XJ0_BrYbwFf
X-Proofpoint-ORIG-GUID: yoOf-eoerU8nZkuWVrtm_XJ0_BrYbwFf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX6s0VboH3DS04
 0DoF0gqgunHVERQucWmzWfs+BlhhB1lwR1UCjisjz6aYoI7tYquFef3XYQQPO09HsZOhuoY+QdR
 TEANh+3ojX4sGdXX7K1eKceHGecdYpA=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a676b28 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Wy_majLh4fx_fQ3wRLAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX8mx4BMv7nU4I
 60Eegvp2JOAxq2+14UJy4GHYnll0O6rOUh95gY1HfvtsrTLmXbmKr2C96MzFENpIiNOjFzPFklt
 hJifScDtYoRvxMXIy+XUYnChmpKP64i+FErpEtb3nG9t4LA7o2O0407HD40Joytb7eHPa6BIywL
 Qe9ECxS8n0FuYIwdXIpu4+F6jkes4En6clDAa7GqSZeycUhfMQ67BwWc65aw3oyZECqafMgPqii
 n5O0FZC0DfQTqPiuAfrFVlEHOsVqEi3ZVaSBmxw4oNBAoq26cFq9exlwSO5sDEBCV/qLyxMX2NU
 m8+CCwJ5iPN/oYeL5OCWeK2ThuaEAE1cPN6ojxWqgb7JEG9T7F/hMuw25R1yACb4a332DoBJpdc
 E/iV7cAXHbLylJPZdkFCr+x8ZOvP+6JQiv99RbY6XUetNS2XScNtODkXRsrfn8cr5VCRvYwBocW
 RPiZwvX2SVCPHctRcJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

When all channel paths to a DASD device are lost and subsequently
recovered, the path event handler starts one IO per path via
dasd_sleep_on_immediatly() to execute read configuration data (RCD) with
high priority.

dasd_sleep_on_immediatly() works by terminating the currently running
request before inserting the new request.
If a concurrent caller, such as the attention handler
dasd_eckd_check_attention_work() or the summary unit
check handler summary_unit_check_handling_work(), also calls
dasd_sleep_on_immediatly() while a path verification RCD is in progress,
the RCD gets terminated.

The problem is that a terminated request transitions from CLEARED to
TERMINATED without going through the normal retry path in
__dasd_device_process_ccw_queue.

The RCD therefore returns -EIO, and the affected paths remain
non-operational after recovery. RCD CQRs used for path verification
already carry the DASD_CQR_VERIFY_PATH flag.

Extend _dasd_term_running_cqr() to check this flag: instead of terminating
such a request, return -EAGAIN. In dasd_sleep_on_immediatly(), loop on
-EAGAIN with a short sleep, waiting for the path verification request to
complete before inserting the new request.

This is consistent with the already indefinite wait_event() that
dasd_sleep_on_immediatly() uses for its own request, and all other callers
(attention handler, summary unit check handler, reserve/release/steal-lock)
benefit automatically without requiring changes.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 3181c06d91ce..d8d912a3b3fe 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -21,6 +21,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
+#include <linux/delay.h>
 
 #include <asm/machine.h>
 #include <asm/ccwdev.h>
@@ -2511,6 +2512,13 @@ static inline int _dasd_term_running_cqr(struct dasd_device *device)
 	if (list_empty(&device->ccw_queue))
 		return 0;
 	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, devlist);
+	/*
+	 * Path verification requests must not be terminated. They are critical
+	 * for bringing paths back online. Terminating them would cause rc=-EIO
+	 * because CLEARED requests skip the retry path.
+	 */
+	if (test_bit(DASD_CQR_VERIFY_PATH, &cqr->flags))
+		return -EAGAIN;
 	rc = device->discipline->term_IO(cqr);
 	if (!rc)
 		/*
@@ -2535,7 +2543,11 @@ int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
 		return -EIO;
 	}
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	rc = _dasd_term_running_cqr(device);
+	while ((rc = _dasd_term_running_cqr(device)) == -EAGAIN) {
+		spin_unlock_irq(get_ccwdev_lock(device->cdev));
+		msleep(1);
+		spin_lock_irq(get_ccwdev_lock(device->cdev));
+	}
 	if (rc) {
 		spin_unlock_irq(get_ccwdev_lock(device->cdev));
 		return rc;
-- 
2.53.0

