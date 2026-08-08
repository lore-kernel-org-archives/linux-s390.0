Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB18397B02;
	Sat,  8 Aug 2026 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208845; cv=none; b=Ik9EsKwDhEXfrAp2tusGoCtwn0iY7v9V+uotZ1ODkb88+DZjGZr155DayBkXORYnr67256qj6iFA/pVBxmy/qJBVvLQWiel3rbXBimESXao0aO9Xtucjd3cHQ6pjT0pF15m96dkXTKVFGV362V+Dbp0AAqUAtTph7Kf5aYmZCZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208845; c=relaxed/simple;
	bh=sp851rKcjACvmA4idI1Vzv+6+lvy2OGsAjfNlN8mTIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tT3PK4rappSBSh98CtQvi3KwhsEmm4Auj2vUs8rmnSHbwm9P1cXDpIIUkQJmMTJhu9bReOo8hJc+7LZfeCuQYbqcqUPTVEv0ft9bP13AQPoAaC6TG6Cyz7eM70xRuak780+bL+WUK+Q5FLqBgyaY7l1tfnie7tqkp41cnEr5Pe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RRBIIalF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RRBIIalF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678H1ebD625481;
	Sat, 8 Aug 2026 17:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Cbfw1pahnu31h+7Er
	d33ZjAfOVNEsK7X1JFcNQj/0L0=; b=RRBIIalFlNh0+J6W1kYdDCxtkVwDu/g2a
	13772441d2fn3//Y0NGrXRpFxsQVgFGtyQKXf9nOOXNNmBw1AB5Jqyt1hFOvMTlZ
	443bpItJ+/vNqQ3gcQ5L9PjhkXR3kAoWw/Ci/atRvWyDzn3f398o5udUFrMPnjJV
	J+9BYTK3BYNqHIGphLR8rOKUkTF2eZTZe6Pg3gMgXY43uHxClt2cgYao4Bb5K8/Y
	s8VxVecUDncicDJ6eMRd7CuV/L6NiznIVSnYNHqfOJStBeajESxNZwOzB4iqndNt
	ABQddFvW06aLYlp8eHUfmR3EKFaI4AHrACBI6lENLlqdblERCrwJg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2hn1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 17:07:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678GujXe015862;
	Sat, 8 Aug 2026 17:07:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4km4ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 17:07:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678H7GE858458538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 17:07:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCCB358052;
	Sat,  8 Aug 2026 17:07:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2721558045;
	Sat,  8 Aug 2026 17:07:15 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.94.189])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Aug 2026 17:07:15 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 1/5] s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove
Date: Sat,  8 Aug 2026 13:07:08 -0400
Message-ID: <20260808170712.839066-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808170712.839066-1-akrowiak@linux.ibm.com>
References: <20260808170712.839066-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a776246 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dlTjfeu_wqJGreSUTgMA:9
X-Proofpoint-GUID: 0fD-k0eye_LITg1rfWrT2DRMOD0pbIFY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE0NiBTYWx0ZWRfX7itLkES0f4lW
 W59SLYtBiMBwyqcoD2vKBgPpbOyopiorkkoIDjrOVguNz6SxZDmkP1mwAt27+D1DHZF0rtEZhm+
 LnPd1w4sXj7qVcJ0HGhnZLDcL0/l170FHr0l5Vg36ghOadJd8evJzrs/S1dLF8Sb4rnXauFtXbL
 iN9+1qzl6G8bsIVOjoyoHWdivDjgaj6NQ5zs71BXX6dgELBHq3g6fV7zs6pyRqi5K91XvoPi6P+
 HW9oAFWHcHqufsY/rCmP5wJQ6nwzKbG/lz0MesWItqMdCJkaKjnLUZu3LA+MAS6exKv3pTzh7Ze
 nU1uJPzvSdXLuyplAMhUY0lvFP+aPF+uGWPgMn4JxoaLyVZQUUbdSi+oGARK95RLlR5HSK4C3iv
 cwq7lUyPAjW07sExbaxXJQK9BvAmB/rO60y6qrhiKECLQBn9KIKJBaA+8+NMMwd4c/oQjyUYKHX
 uquc2qCDxZL2T71tnFQ==
X-Proofpoint-ORIG-GUID: 0fD-k0eye_LITg1rfWrT2DRMOD0pbIFY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE0NiBTYWx0ZWRfX4n/siw4d3aaf
 AgFCEbamDLnRdS++u1tDbqI8apibgsHEFRTAn/rZw6wTva+OTXPDeMFBIq8sLZFWGCP9if3csx4
 ktwawsYsKu974k69WbbzKSNFLt90Jcg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080146

The do_remove flag in vfio_ap_mdev_cfg_remove() is initialised to zero
before the loop that iterates over the list of matrix mdevs, but is
never reset at the start of each iteration. Since do_remove is
OR-accumulated across iterations, a positive result from one mdev
carries over to subsequent mdevs.

The fix is to set the do_remove flag with the first call to bitmap_and;
for example: do_remove = bitmap_an rather than do_remove |= bitmap_and.

Fixes: eeb386aeb5b7 ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..845c86ba8bc3 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2603,15 +2603,15 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 	DECLARE_BITMAP(aprem, AP_DEVICES);
 	DECLARE_BITMAP(aqrem, AP_DOMAINS);
 	DECLARE_BITMAP(cdrem, AP_DOMAINS);
-	int do_remove = 0;
+	int do_remove;
 
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
 		mutex_lock(&matrix_mdev->kvm->lock);
 		mutex_lock(&matrix_dev->mdevs_lock);
 
-		do_remove |= bitmap_and(aprem, ap_remove,
-					  matrix_mdev->matrix.apm,
-					  AP_DEVICES);
+		do_remove = bitmap_and(aprem, ap_remove,
+				       matrix_mdev->matrix.apm,
+				       AP_DEVICES);
 		do_remove |= bitmap_and(aqrem, aq_remove,
 					  matrix_mdev->matrix.aqm,
 					  AP_DOMAINS);
-- 
2.53.0

