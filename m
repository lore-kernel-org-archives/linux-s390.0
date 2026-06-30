Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB643F0ABB;
	Tue, 30 Jun 2026 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816104; cv=none; b=UD8b0j5c7yNx0fACQWG/Lthh4oFYSNlggaaPAYhiQxkiwk/+ZGTNK6J4syyrZhB80K/2YT6qsHwV4TMbftrANLgdwmZ/rAKZjx9IAemQjszU2YkoaUChkvJzpqINpwZ5PV5TGMQLmrgD0vrfYz04nqeSePhvP5JAt7KMVfr/vrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816104; c=relaxed/simple;
	bh=1s4beF7AUJtgUKAJTio1L984Gbc4oaNU5NglgSK1RX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ebo6lQPhJ+ei3RVUxa6YnbfG5g2K2qE5LR32zTH7RHKNehqZ+89aCmzn0MbjpMvmu9b9ZxIpATVPl/qsOxEcpB6cHZpzgBK7MegmaxFAy+PGZu4tFG6Lb1zT3QImas3OVHqAvw+/t+A6eLH8g+PzgqSJ7s8NE2PsPE4g+yQ6V1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nT2PSF0J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nT2PSF0J"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9o5Ea1537033;
	Tue, 30 Jun 2026 10:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qRRr17gzgKP7yb8yZ
	FVvzVBAWOspssSggHtlOCAu1DQ=; b=nT2PSF0JkuvD257IeZUhR0ryx1xexfHRw
	IAmFuxjuktai8F/rTtjCsQTCRC1baAu70mV8vcVpxy8foturkCrQoneg5j8wpUVB
	IZr7vvkfshB8lI4Qi9/JvrvWrwfqunNejYAnMVo4iNHyPK2RHFM6mNO3Td6AbSB8
	xO95jklKhc87dBS+7It5aa+P2rObCcPfb8gaDRLxN/RG2pz7/bEafZbVKc5qi+6q
	NkjWTmeOcLqnrlu+sHao1rnAtqPQBcTJTQ0zBLPYyzdgSEUifkm3NXcPDhCp7YBv
	T9axWrMn8tQ2L6Sk0aQMKL/pWziTaMzH8hHAFTYVIMoqE7JPmvrHg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjnww2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYa3K024031;
	Tue, 30 Jun 2026 10:41:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq9wcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAf2wE9044638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:41:02 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6432A58065;
	Tue, 30 Jun 2026 10:41:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BB1C58052;
	Tue, 30 Jun 2026 10:41:34 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.135.84])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:41:34 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 01/15] s390/vfio-ap: Provide function to get the number of queues assigned to mdev
Date: Tue, 30 Jun 2026 06:41:11 -0400
Message-ID: <20260630104132.1598851-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfXxN8YoqoobeOg
 L9iGR7jf2A8dw0znL/UBZZnWPu1FAkL1Slqu96teLYsJykyqWucP0LzpZ1aTLpJololYK+L8NsY
 64GNiOCT4D1nnV9qrGpzwoTBf+J8gL7n81eRZASmB19c1+zcJ/0xvemhxlHZ3VmbzJ4c62MQnSC
 0LgaN0C2fH3Dbj9ahoW3lqhakbKWJF5fhEEToDEnljua3BSme6FfpX5sWvfOovtglOANX04d/O9
 74E6OEyR8C3eqODJN9rHEQHQnUqDpNFlqtbgdFR3/UbPMXWc9f6e4dXUoAp8bFM/8vja3qOK+9U
 OJsr9fXPJO1Z8uK2lrnaNt2imiNxAv7//1fNG+lbgz+lUN5viF4lGCjGrGmcWPjPCyeI4s8Rj4i
 OsPv95yyqYpao9ppl2KZZaeh92IhS7AeGiURYeI4d2UWaFAvd2eft4z9fv7pxlSnKmrKufaSQSs
 OfLQhHtfClgZeaz3S0A==
X-Proofpoint-GUID: 3HLA3iPku_TEFEDemZlR7xVuTXiVFYp2
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a439d62 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=X0LuQLNI_Dy_l-hxe5EA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX15aLAsKJvnKH
 6cMqO3I5n0VUze4O8MSXxfGKXd+tC0DTORi9wasnVPt0OolQOoiKfimjfCrO51kMGPPkjon6xNZ
 0iqc4TN/+WuJ+/GThEwBAf72CMcD0cY=
X-Proofpoint-ORIG-GUID: 3HLA3iPku_TEFEDemZlR7xVuTXiVFYp2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

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

