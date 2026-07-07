Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1413C062C;
	Tue,  7 Jul 2026 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414976; cv=none; b=sIp8gtHiFjb2R8F7g9femyDEZuDifLU0uRSdxeFnM7BwzbKEkuwdIv7LHW6qJaC0/Xf8qpVIUG4KdrokFnWSLJsyT+hK+4sg2rJMUgJ/6zGscIDP6ZSqiweJ7dX5jeu281OGk6iuuSaQP4TA7uVtTPnc5vVVudGt6ntTaBfdRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414976; c=relaxed/simple;
	bh=+CzQSt/VO1G5UX1bnr92NaCL6xKZ6ENpeOwU1E3bUh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLkrmHCYdw/0mUGV2DESkFEPCzTIT9XK27bMjhM8+C9G3hmpxLN805BPsUtRdD2wJvlD68RFve0LJ25T60ISEVR2mJR+PSPGWPhAPPPkTeDN/9ayT2g5pzxgasLd9+bE5YVt9ryGAbH3hfXqwC4JxQU0CtmNFoCICXwNMIpylV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hbZU/MgU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hbZU/MgU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IDvG3342057;
	Tue, 7 Jul 2026 09:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ntQx+JMjMgnFzs5Xw
	i67mj52J4P3J4uHdCFhoBHM/s8=; b=hbZU/MgUkn8PrZIJb49lItITeiZvjePR2
	a7lSLBi0bfKopG0MWGyxFQ48MYbFkMm7BJ1wTJuMB4cql5NkWbNnFdb4i6xx6YdP
	lWUBPNCUMLX27SVf4wfrT7ZU2oxdeCJhIH0YqPuVO9NvnaHpmdp3nN0iZA0jTM3O
	NWp7Lax9sOnJsPw0ry8bCkbS+MvUx1iLqJA77vkcTwy6Fj45RtjVm0WIejcjfT7Y
	j0D4GWzu0LV7UkuoWwh+mmq2G1Y9K/Nn4jhxT15wWaEval7ZELBsaiTTi+9JXPx3
	x21HF2JXlMZt5DTVTyPzWvCskW8FZRrdEhrCUyEq78bbmZFPgawhA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqnyr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678nkTh029003;
	Tue, 7 Jul 2026 09:02:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg1q3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792kNE29098746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AFE058056;
	Tue,  7 Jul 2026 09:02:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4EFB58060;
	Tue,  7 Jul 2026 09:02:44 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:44 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 14/15] s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
Date: Tue,  7 Jul 2026 05:02:16 -0400
Message-ID: <20260707090226.3206695-15-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX5EU6Ri5WYaUs
 KYkDWkZFQCk7a6HLLuLGmn2Z4oMNbjPcq/npy8G7Nj9oOQ6KPhG9lWhuBUbGXkxOUn5FBrK30Aw
 2vLIUmeUT0vTaEGOvbs9EK4e33DQIL0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX4R8s9nQDwcGR
 R1sRuQ2W+GENMQ71tAkliVsw+JOUGMKF3zfLKzgGbt669Lm/5paEYYztx5KPxN+Ao/pBQ06v2tN
 dlQhTQCGbta36NBaNpuh1e7hz/7BF9XNdtHFA0CD2jy4TaKHcWVLCCiRspDKGxAR+Ja7USzkeo8
 ex1AqwstRrc0TVuE358URblZaosO0xQHVGf7Agy+RMz5IWnshGE2gIdSigwsNnufykOgeywlyXX
 GyARUTd28H9i8kIGOHF1iosBjoVrIdy0U1MJoAs8aS/GuQGnISXIvzjHMm5GaGhlf9lzfU99DQY
 LvbfGCDbZsQQnAPSv5pGpnd8g+IYvy4DqNi0tjyKJwd1nrJE3nVXM817MD6cxwNRgq0R7GLiI8p
 WFzlfsxqxBkqq3TGq6wL2RQ4Bnr2QYTw1NOCwbvvciELPcf/xR0OKmxxa6dM3ppvkeoqN34YrOv
 44jqGfTS+O24+71U0KA==
X-Proofpoint-GUID: fdOIiKGxcdgvQlJ3Go6_1eRKyc1h0uSu
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4cc0b8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=CB_8iKbeFirw2v3l3xgA:9
X-Proofpoint-ORIG-GUID: fdOIiKGxcdgvQlJ3Go6_1eRKyc1h0uSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

Add the 'migratable' feature to the features provided by the sysfs
/sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
of vfio devices is supported.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index fd7394d81880..d2fc3598cd24 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -26,9 +26,11 @@ MODULE_LICENSE("GPL v2");
 struct ap_matrix_dev *matrix_dev;
 debug_info_t *vfio_ap_dbf_info;
 
+#define FEATURES "guest_matrix hotplug ap_config migratable"
+
 static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
+	return sysfs_emit(buf, "%s\n", FEATURES);
 }
 static DEVICE_ATTR_RO(features);
 
-- 
2.53.0

