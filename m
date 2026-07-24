Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863353B47E0;
	Fri, 24 Jul 2026 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909698; cv=none; b=uHGvw+ZlP9ZcqXaMoW2NIorl3QnhH22XtnPuCx+oM23InLy8G5RkAh5f9SyTV8oruU4zgGaGV+NpX3B/AdbnPLuF2hEnNte/NM5Z1gAZZREuy9JOo5yz9rn2vtwTZrJRVTGuJaryzwVNJcOLYyi4NegvQNx3Dyo755E91EqOX00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909698; c=relaxed/simple;
	bh=1s4beF7AUJtgUKAJTio1L984Gbc4oaNU5NglgSK1RX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQqg05/P4oDxGa2alQylhAmlod7mmUX/PRSRLoyo8HeW8akddHV8zMJ1+9LUGnFL3QIMfTzvA104CWXTu7nCme6e4xeeYDsH7Wz8JuCXxzkZei3x0gEF2ghbXg2/Dv8EePQA9JEwzs2bgYTq/xMjeWBkFLDr/aP2nAfv0xPbzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mt1KpOCx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mt1KpOCx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfeMI100436;
	Fri, 24 Jul 2026 16:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qRRr17gzgKP7yb8yZ
	FVvzVBAWOspssSggHtlOCAu1DQ=; b=Mt1KpOCxoVde+6NGGOqYPUTvz4wB3OD+9
	HPL/slwMq0QOvblAXNaARPyl32inCiuZZE0A8tmUg4kjwtGwBTPMhxJ1zVZ6ugoD
	pUBDqI4FvMx9gZiS2sxaxpDIC952JCDWDr6UM44SSPNsYuk4MGVNmo2SS86zdvhQ
	pqooL216Sb0dIFfQR/w9RjINgJdww/9NP21Ls+9EkLe8gSKb5swnYjZKT3lZOgoZ
	idZWNUGa3FWdHXt+tL4IcJYgYgjVrbDplmIVPwg8apxd57FSANveB0alwFWk1/q+
	B+7P9cS0urSuP3/hjQ5XqC04LtLuBBvjIq4qLuGgPR6/95/WqX0Pw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs8u49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:13:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4jmW025395;
	Fri, 24 Jul 2026 16:13:57 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahhknq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:13:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGDt9p8585738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:13:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C84C658054;
	Fri, 24 Jul 2026 16:13:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45FB15803F;
	Fri, 24 Jul 2026 16:13:54 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.50.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:13:54 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 01/15] s390/vfio-ap: Provide function to get the number of queues assigned to mdev
Date: Fri, 24 Jul 2026 12:13:37 -0400
Message-ID: <20260724161351.1802644-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX/oFwh4a/IM6a
 hIY3U4GYe+/K3qGtAZRTxph6Qrb/sI8HpOXPhWNssSUGkj6AcyPTsOuYNlezERZCXMJQ+4N9qto
 G/46PjXyx4Nd2z5H+4/84cuFeTRR6bA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX9EuBhDF0+aa0
 0/FSJ1jZYXvOLe+h4DE3riiFeFg3RNWMXlp2uDne3m8r5n/X9ka84MeUc3jaiOJYklM9alfdNbh
 AktLFVGiL6+V/BIXBh4EJ1BcCR60UXhlTGcePyrpdoqonavoq8HuW36EeTtPtZuxyMgozg7EUDJ
 oPJChAwNwrdbGJZ92XuKP0ArD+P97qyiDLflGKRxf2Am+l+w/VENLzQYLkgyACBxaSsWD2iw0FB
 q+/aALl9J/K/64wfcid3t9Qfhufd5FIlbZratH6s24k3YReOEbps3efAdRbXNTYqX+zPhFEwto+
 18HTZApu4mGjjg2CvjUHzGzIIwesoXzcpKCOVQ0C/OWw8T33IIY1QJN9Wiv7h8cdBEyjbu/qqZ6
 8e9xPGRKQblVN0U1W3fzAgroLcrzNWW3KxxRWOPfMQWGysoMJClIlIAQ1PWijddCb8PilL+CI6F
 AaHjchbiOFDw+2y/Qhw==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a638f46 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=X0LuQLNI_Dy_l-hxe5EA:9
X-Proofpoint-ORIG-GUID: ORJxeYqobaHOx1ToSqZpoQdiABO5jaPe
X-Proofpoint-GUID: ORJxeYqobaHOx1ToSqZpoQdiABO5jaPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240145

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

