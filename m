Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47443B6FC;
	Mon, 27 Jul 2026 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173596; cv=none; b=msRydQC7GHSojCHSmAhaDSjaWydi8MR3zXynvmDxldlZ6PhirwcdDodqMCsaX0DWEeQqqr0avfIustV8DewF5362fuDqxJ8Zr2HUMJAoXpSw7mfs/tvTpMsGJ8C1M6OdmMzZ9iJHLRHIAd3AKBPzd47UR9pyqSVRT7wT/0OVk64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173596; c=relaxed/simple;
	bh=Hal2jLpW9jwI4RpxS7uNTsEG8gypNxlL9fhMbAkxgr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyrOkv2TjrGc9rxu6mz3jXEDra3OCRyx1+RWt7dsbTmfEukax1GdLg/chGMX3mvBKOHrtO3Cg9PDzoQDRjUw/UGcUgZ80sh2GWo0TJSRl1srk5tjMVGW5v3SjeJ9BN5e8ouF0bBGp6oykd/H+6Sj+BAJRfNk21V4wIkVqhaT4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ATWJ5Nmn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ATWJ5Nmn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnceJ2412262;
	Mon, 27 Jul 2026 17:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MuFmywDxoSDjBBAjm
	Z7MnYtpHXmbfOsODaDcZdMsvkg=; b=ATWJ5NmnXiAYcKkSTdz2M9FjEu6jNOZFZ
	OEeyv6Bx+fLAwQXjnpnJtDez1LX3HAGOAyzpekQNJizmPJKFNaBxzeMpRan4Cjxc
	SeB8pYzczJ305f3zCfjSg9Vrn6lStcA0eG4N0cwTo8ik/iDdoGG6QlOJ3NggQN7/
	4tIiA26xSkX9XCnumm9T/1x/QaGRX9+Sk6CtT8Cp+Z4wKxyThI+iSTUP9FYtB6E1
	MPqFCj2tD/iTzJXu+USydXUh+a7chldJ/uq/lHDRhAEkbUYhRllbaXuDJTvBtXuk
	dpojQ8WU0bETKkwg5mO6cwDAfXMPD8Uj++IiPAazJfphRjLU/VZIg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcrv2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:33:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQFrc026642;
	Mon, 27 Jul 2026 17:33:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq6gw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:33:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHX8J921103182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:33:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C6B058058;
	Mon, 27 Jul 2026 17:33:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97E2158059;
	Mon, 27 Jul 2026 17:33:06 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:33:06 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 14/15] s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
Date: Mon, 27 Jul 2026 13:32:38 -0400
Message-ID: <20260727173239.2420754-15-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q0ggNsabw9oSTnRe4wHJd8L00Ddf7Fpf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX2IkvThpAbR/y
 EEe+J+qBaey7xxZp/G9MBOC8xksIG56GdM/wr7uzrz0IuoH8QOdjbnk7Tgo6Oa4E2XZj1nPi4QQ
 rUjFtd7Sc2V8/sLiMlLSG9hj1hA8pcQ=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a679656 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=CB_8iKbeFirw2v3l3xgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX57lILRSBvja3
 Jg1tjRmjS7rJTOQTEYlQV4kIVPPJ3hcLpyrzI249fCgGisdf6in7oJcOBfdh4xMvmkRjisUAglq
 1azDOiBF84bOihGUnYsNULiML0ZO9VN9rT2JnK5JDeRCFHK0JxHakD5qfYoVY2xb67dn2lzfXRl
 juXOtmottX/flL480ZS2A+jsasaAhaqTsoGaJYQY7A8eEifEJLP8GTULsoiQjL54XzGv/1IIrcA
 TCM/ieBVnrGMR6XUov0RRRpAmxm++SIWKZ8muqwFMxl+eFrUYBfs1vG/FbVcWRRamZJgdWSRTzL
 JSfQVQ70ZgZ6OgFtAdY1MLswZUEI3XL/ilpkbKvaYyz8rl6CcUnJn4BXlccO3GgzerEzwM0vv5W
 hp18FxVuzcmp/KIbMfjHm2VjWEy6BYeZ4xfRhXtsSKx5pKuP2D0TpLejYiCRE0hOZiZ3JIDjr3s
 0eZlSay6Leckcb+wYNA==
X-Proofpoint-GUID: Q0ggNsabw9oSTnRe4wHJd8L00Ddf7Fpf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270160

Add the 'migratable' feature to the features provided by the sysfs
/sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
of vfio devices is supported.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 8e69ed286bb9..4e973736522b 100644
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

