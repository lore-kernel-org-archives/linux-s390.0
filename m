Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01117BB08;
	Tue, 10 Sep 2024 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968088; cv=none; b=pdYV9mYC0//7EIxEz5iAykdwgmCWYBwEenbUpBwGBzIlRkqxzzofgVXmVtExlfp+cN6R3HaS5P/DDhxQeVdUKuTZshZLIQjflJKtqknoLJAdA/W0//X14Z/b8JaWKawHh5+O5lgewWjE/uUWjNey2lplt3xzQXiKeki8IBqtc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968088; c=relaxed/simple;
	bh=ERbXx5RE7KlaJmidB1eLisLhUg5Fqi/VT3Ka6Cft4/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCMAVYWF/R+yO1VoLUVVtSHwtMhtidlWXgbXzItmks+XNLT1LDgi0Vs9bv3HxzfX4JaYN3+TSuxtLz8eY3T70gl4cAWJDo83quViiYhZ/hM2KdMDFD4q2PgQPX+r/+Epb/3gGI7x7PeWUGQGjYixYw2acrpr0f02q45evtBOEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jtgfdaod; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jtgfdaod"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A0Dndr015345;
	Tue, 10 Sep 2024 11:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=ozd2VjT3Z9e2d1FwRYWjU0FvXx
	kv2UHK8MoAOAsjsqw=; b=JtgfdaodQYbrMH8eaCp6chU+4VNoEaJdbvV4vBtN1V
	1oGGH6FGBuPLWOL8sQ0FR/Wz8GWb0FFRSMEdGOCx/SH9hqbvcpyUBeheu0b9biAN
	yW913xanH1/BmbnjcZ2oN71z/ORWsd/Wx4kLlamnD3/Wd9KezuCUbIG1R6pl+Lih
	9dqFQI9g9E7K2WfJorod0gtcqpWfPasEJ7rZvyu0u6dLYRSlYEI8ZpYytfznVcdY
	yAVDFtYYWVCGLXZDDTGHVVHVdclAmRCnoVX0laIVGTzJD4TxXvhqI7JqhxQIjAjs
	Uh3AcbwSgSgcBIjIezf+nUtvppvaX+Hg5feNeBn013nA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyf28x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 11:34:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48A7q6AL032504;
	Tue, 10 Sep 2024 11:34:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h1j0kbyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 11:34:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48ABYgqZ22217246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 11:34:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CA3458053;
	Tue, 10 Sep 2024 11:34:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07A2D58043;
	Tue, 10 Sep 2024 11:34:41 +0000 (GMT)
Received: from jason-laptop.home.arpa (unknown [9.61.6.233])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Sep 2024 11:34:40 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, fiuczy@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: [PATCH v2] s390/vfio-ap: Driver feature advertisement
Date: Tue, 10 Sep 2024 07:34:40 -0400
Message-ID: <20240910113440.8107-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zx5hysJqgOt-weBxhkNFyEdwnIPAWjQH
X-Proofpoint-ORIG-GUID: zx5hysJqgOt-weBxhkNFyEdwnIPAWjQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=602 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100086

Advertise features of the driver for the benefit of automated tooling
like Libvirt and mdevctl.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
---
 Documentation/arch/s390/vfio-ap.rst | 34 +++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_drv.c   | 13 +++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
index ea744cbc8687..22f1965af500 100644
--- a/Documentation/arch/s390/vfio-ap.rst
+++ b/Documentation/arch/s390/vfio-ap.rst
@@ -999,6 +999,40 @@ the vfio_ap mediated device to which it is assigned as long as each new APQN
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
+Entries are \n delimited. Each entry contains a key value pair. The key is made
+up of a combination of alphanumeric and underscore characters. The separator
+consists of a space, a colon and then another space. The value consists of
+alphanumeric, space, and underscore characters.
+
+Example:
+cat /sys/bus/matrix/devices/matrix/features
+flags : guest_matrix dyn ap_config
+
+Presently only a single field named flags is defined. It is meant to advertise a
+list of features the driver provides. The flags fields advertises the following
+features:
+
+---------------+---------------------------------------------------------------+
+| Flag         | Description                                                   |
++==============+===============================================================+
+| guest_matrix | guest_matrix attribute exists. It reports the matrix of       |
+|              | adapters and domains that are or will be passed through to a  |
+|              | guest when the mdev is attached to it.                        |
++--------------+---------------------------------------------------------------+
+| hotplug      | Indicates hot plug/unplug of AP adapters, domains and control |
+|              | domains for a guest to which the mdev is attached.            |
++------------+-----------------------------------------------------------------+
+| ap_config    | ap_config interface for one-shot modifications to mdev config |
++--------------+---------------------------------------------------------------+
+
 Limitations
 ===========
 Live guest migration is not supported for guests using AP devices without
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 4aeb3e1213c7..e3fc444ff404 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -26,6 +26,18 @@ MODULE_LICENSE("GPL v2");
 struct ap_matrix_dev *matrix_dev;
 debug_info_t *vfio_ap_dbf_info;
 
+static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "flags : guest_matrix hotplug ap_config\n");
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

