Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E4331A5B;
	Tue,  7 Jul 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414960; cv=none; b=JHu60nZLo9CHtkfnDsvBQ8bZaKy0WkzqEWVvCs2DAI/55XjxoIfEIM64Wk/keQb/q9WKR0XRyQpMyZop4WCoVmwzMIu1opWdrbAA/XYYuje/VJuP5ElCOYNVPd9pfiLjF0IDb29KsYx2j0sA5iIKbgBoUS2Kcf798xWEmV7P4VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414960; c=relaxed/simple;
	bh=1s4beF7AUJtgUKAJTio1L984Gbc4oaNU5NglgSK1RX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1PEA9edv9yaRuZWYRBNLXIrcPselwRvjiZ0XxKi3aOxa7APHoozZSJZ2f9WVqdbe2AHksp1n5YILOwX0DBq0t90CC+fkeRMoOe5nT5hnIQY8PxdtRxhKmPpXX5IHC2TFL/SIy0WJo0hbW3T/CecTiZak75UXjwO8fUIKw1KBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gSfcQc58; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gSfcQc58"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678ICl33342048;
	Tue, 7 Jul 2026 09:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qRRr17gzgKP7yb8yZ
	FVvzVBAWOspssSggHtlOCAu1DQ=; b=gSfcQc58lLK3g7Blv7exbINVeeEwPiYXp
	qGO3JDO8FFGi0q6VBVCoIvePYwUJ4viWQW4vspon9smEtxVFj4cO0FxSx59keSGL
	SUQXrl1m7CEf1TLIgQVNeOrxP2V+1rJN/BE6vrWfZNNiq6Ke1e5OYhSBpyDZ4xIB
	2b8eB+cgiZsouBZC/EZBxBxFil2fUOsqISdaLp3mg4sw0tLQNwAs+E2uWfCVyxgL
	U3a6yScTo+NuNaZLA7YwpjzBxRUTP0RLb7JwMAFswATHToRwFzqbyfyLCvvUcrv4
	zHTkX0DzeGhy0is5XAicEA2R/PukSzTHF9ZPy2Lbcr2bHtP1Nocjw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqnypf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678nZCg028878;
	Tue, 7 Jul 2026 09:02:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg1q23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792TgV17629778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51C7D58056;
	Tue,  7 Jul 2026 09:02:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C8505803F;
	Tue,  7 Jul 2026 09:02:28 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:28 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 01/15] s390/vfio-ap: Provide function to get the number of queues assigned to mdev
Date: Tue,  7 Jul 2026 05:02:03 -0400
Message-ID: <20260707090226.3206695-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX1xC+7EsmjFov
 wZYoknSUdJw3H4iGTfc6WmvK2xQlPed/i2zFgj8lAVIxn9/ljqGwUCsLr6QyZ7mE6vrxC96ohUT
 /mV6leTzcDTeyB1haMSUcUF+fGjXAKk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX99Y9UmZ8akV0
 2h3rAvIXWcBEEibHcmhJpntrjgdTaCeRg/ATb6Kbpp8DuHVji8gNEF87/Ir7oxF0dBt6JbAJ8FT
 9ZPf2p1+I3u4o48fue6jniaKyi+Vf6Zr678iL35OZJ21x2tUKF3wXect4wii3vUfR59KUmqbdK2
 ceMhKanC5DDJ3HM7LISExudDSjf8T66gyv//dbe8vRUNPe3/GiHVTMXVAkLguFR0VNkvEtfa/to
 mGoJ7YKU6DmFEp0J+47rIDmac02IkrhT/6Lpq+LbAx6Q7jlIvOISMTzFKYCUsjRfnxyTIjtEG4D
 V/9WW9QYIMWPKfcHB/G4J/21uxBL/HX2MI+kE/YG3/z3I2b9XslXArKT7REZyJlucCkK4mQbws1
 btvdmoAiuIvC+2+pYUHi5wUsTKor8NCQM/hq71jKtewKlOIN56PPTLF4Ys8FhLtxyIYAkMiZEvm
 FfyCzkPyH5hvMmLti/w==
X-Proofpoint-GUID: 4dVwoPzvYzBI_Aj370xNXpkXL0hrLgzx
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4cc0a7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=X0LuQLNI_Dy_l-hxe5EA:9
X-Proofpoint-ORIG-GUID: 4dVwoPzvYzBI_Aj370xNXpkXL0hrLgzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

Provides a function that returns the number of queues that are or will be
passed through to a guest when the mdev is attached to a guest.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 14 ++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..71d3e2c2e07c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2098,6 +2098,20 @@ static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
 	release_update_locks_for_mdev(matrix_mdev);
 }
 
+int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix)
+{
+	unsigned long apid, apqi;
+	int num_queues = 0;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	for_each_set_bit_inv(apid, ap_matrix->apm, AP_DEVICES)
+		for_each_set_bit_inv(apqi, ap_matrix->aqm, AP_DOMAINS)
+			num_queues++;
+
+	return num_queues;
+}
+
 static int vfio_ap_mdev_get_device_info(unsigned long arg)
 {
 	unsigned long minsz;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 9bff666b0b35..9677e49554d7 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -152,6 +152,8 @@ struct vfio_ap_queue {
 	struct work_struct reset_work;
 };
 
+int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix);
+
 int vfio_ap_mdev_register(void);
 void vfio_ap_mdev_unregister(void);
 
-- 
2.53.0

