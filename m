Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B7B1534FB;
	Mon, 16 Sep 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488092; cv=none; b=u3x5vha8FF58Tg0gAHgSS8EUJ/z3STxPek2qfAI22ACSbFVsR7unX648fHLfC0fzCnaKJA/149d/bhnqG73dJo6o0S4IYitwv1KWSJXdt4F+WDP/anSLEqfeszyaEIX1qz+U8TLL7ZEpEl2cdRwPgC/uOzGdLp8kjFykqSg29qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488092; c=relaxed/simple;
	bh=gr9yUSmOKcD1PH6L1wZ4eKMngyFNW7EkqL7p7uwVDIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhgemfICb+NQkjta2eyns9lLczp8EH0UrXNuGaZW25iCF6v3rICblPgD3ws2b8mjAcgnBkRW3Adrp46U/p3mdtGyM17MCb+DqjkDrtNCbtBIpsKOZcFCBx7gsE+13m0BVI82mP5FbM2RmJKyv18l/oXCtiTV75p7zrsoynwQEuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B6QtEIaO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B6QtEIaO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GBwCTX021168;
	Mon, 16 Sep 2024 12:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=/O8zEZJunPnQEdA6gOLkhL6v1s
	LdhwVUtgSjcf/pT+w=; b=B6QtEIaOpXidNx4YHDhwta+LGavwX08V7o1MtIM3yR
	WPGVhwkJxvLXYbPgMbHhab5xVe0N9352+rF/3eQk0o3merjWDixp9kr7WIPdv7qi
	XdXs6gzUJe4DwR2BCFYmUEqKmegTkEmRuvTQ5oDZd0n5Aarsyxd1xIIHe1EKPS5/
	hgZfWCBrvyFKOok1sW9ktzd5URPqI/i/ldzqDTtYOZ5TvG854e5MmDfRziOc9Odl
	UMPhmRvGoH138D+J69UscPCDw8Y9ye+skR+h3RwE0fov4c6t3SAFdfqueriF08Xk
	MvueEzhOY5C5NXY4AF5964U6VUG9LxZwbH8BxHzOAlyw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vnhfqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 12:01:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48GB3T1H000612;
	Mon, 16 Sep 2024 12:01:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nn70yd95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 12:01:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48GC1Ogb20906552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 12:01:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 322305805E;
	Mon, 16 Sep 2024 12:01:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8628158061;
	Mon, 16 Sep 2024 12:01:23 +0000 (GMT)
Received: from jason-laptop.home.arpa (unknown [9.61.14.174])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Sep 2024 12:01:23 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, fiuczy@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: [PATCH v3] s390/vfio-ap: Driver feature advertisement
Date: Mon, 16 Sep 2024 08:01:23 -0400
Message-ID: <20240916120123.11484-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LUtdNeLaPaCYZfh8AyM9jUhCdeEgqvC7
X-Proofpoint-GUID: LUtdNeLaPaCYZfh8AyM9jUhCdeEgqvC7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_08,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=849
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409160075

Advertise features of the driver for the benefit of automated tooling
like Libvirt and mdevctl.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
---
 Documentation/arch/s390/vfio-ap.rst | 30 +++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_drv.c   | 13 +++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
index ea744cbc8687..eba1991fbdba 100644
--- a/Documentation/arch/s390/vfio-ap.rst
+++ b/Documentation/arch/s390/vfio-ap.rst
@@ -999,6 +999,36 @@ the vfio_ap mediated device to which it is assigned as long as each new APQN
 resulting from plugging it in references a queue device bound to the vfio_ap
 device driver.
 
+Driver Features
+===============
+The vfio_ap driver exposes a sysfs file containing supported features.
+This exists so third party tools (like Libvirt and mdevctl) can query the
+availability of specific features.
+
+The features list can be found here: /sys/bus/matrix/devices/matrix/features
+
+Entries are space delimited. Each entry consists of a combination of
+alphanumeric and underscore characters.
+
+Example:
+cat /sys/bus/matrix/devices/matrix/features
+guest_matrix dyn ap_config
+
+the following features are advertised:
+
+---------------+---------------------------------------------------------------+
+| Flag         | Description                                                   |
++==============+===============================================================+
+| guest_matrix | guest_matrix attribute exists. It reports the matrix of       |
+|              | adapters and domains that are or will be passed through to a  |
+|              | guest when the mdev is attached to it.                        |
++--------------+---------------------------------------------------------------+
+| dyn          | Indicates hot plug/unplug of AP adapters, domains and control |
+|              | domains for a guest to which the mdev is attached.            |
++------------+-----------------------------------------------------------------+
+| ap_config    | ap_config interface for one-shot modifications to mdev config |
++--------------+---------------------------------------------------------------+
+
 Limitations
 ===========
 Live guest migration is not supported for guests using AP devices without
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 4aeb3e1213c7..67a807e2e75b 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -26,6 +26,18 @@ MODULE_LICENSE("GPL v2");
 struct ap_matrix_dev *matrix_dev;
 debug_info_t *vfio_ap_dbf_info;
 
+static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
+}
+static DEVICE_ATTR_RO(features);
+
+static struct attribute *matrix_dev_attrs[] = {
+	&dev_attr_features.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(matrix_dev);
+
 /* Only type 10 adapters (CEX4 and later) are supported
  * by the AP matrix device driver
  */
@@ -68,6 +80,7 @@ static struct device_driver matrix_driver = {
 	.name = "vfio_ap",
 	.bus = &matrix_bus,
 	.suppress_bind_attrs = true,
+	.dev_groups = matrix_dev_groups,
 };
 
 static int vfio_ap_matrix_dev_create(void)
-- 
2.46.0

