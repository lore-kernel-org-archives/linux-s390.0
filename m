Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5619DF60;
	Thu,  5 Sep 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540240; cv=none; b=Pwjgu+GXWCRONSD5IVsTT+0q7hqkbtAw7tjELgJBQ9CWjKSHvEM1Ri0zVfCzfwoW9NcyYabm8S09+n1FGNUN9fNoqAOsU4cbgXs1JVTPHHJcMRsk3liykIGMcx8vyFpPicuJg6PP88xxoulTXWUU2NWkfPJ5Xixu5ajCAs4+LEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540240; c=relaxed/simple;
	bh=XBKvWtx/PanspbYdVpDPe9MXVQNzIktsSfdganzJ9sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvkdk3Fi5Tzvo6q5UaWSONsWB1YBLBHzcH2Sf9gYeUWJ2lfciFZBDR8Ce3lj6W222i7axfaWp1IdZXS2JNV1L12RUqEhpZiQ7Tfg4g2KT19sfQ5mwt5xc0cjyM+etKTwxVc65tPkmMSFJ+jEQ7OkOV0LjjZjNEKbGH7pKCV7lRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nJN09FrT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nJN09FrT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4854HFQT005789;
	Thu, 5 Sep 2024 12:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=7ib5d4dxf+8L4cuNwlXcKiFGYI
	hJm4oXhr4S8/BfFiU=; b=nJN09FrTd2i4r87bv9tBLXjuGMP0RC5oYmg7yQXH5/
	zfbVUy19H+nFSMRBl/Ehwf4AAvGzIaWUFUGLhYLIs8heFtANJTzOWQcPVTT10EAB
	hGrno4d3co5D7MPZNgpHkJi5Q0DnNwdA8w1oS02DEXQQ/bo0OIgTAfQPd16n+inq
	Gdfh6XEcb3sLWfnPA0xXvv/2i8Kj6GbCCZXEzGJX48iq0S8pSTJam4G5gT7rkDWj
	SkKpwnFprmgYkzeT1tgeMmiJ0O/sht+h6KTts7eM/WxnM5fA2vcoMmRu0pAVS6ht
	PX9+MIYa6BBBLXRAFBiDbwDKqOTc5FopdKac8IP35QSw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp9rta8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 12:43:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4859ZPe0018437;
	Thu, 5 Sep 2024 12:43:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw1cvsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 12:43:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 485Chrqe26083858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Sep 2024 12:43:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28AEB58059;
	Thu,  5 Sep 2024 12:43:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32E9B58043;
	Thu,  5 Sep 2024 12:43:52 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.61.133.224])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Sep 2024 12:43:52 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: [PATCH] s390/vfio-ap: Driver feature advertisement
Date: Thu,  5 Sep 2024 08:43:51 -0400
Message-ID: <20240905124351.14594-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5FC8CUt-rF1qZuoxGVoZIETtAKfQOVgt
X-Proofpoint-ORIG-GUID: 5FC8CUt-rF1qZuoxGVoZIETtAKfQOVgt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_07,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=569 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050093

Advertise features of the driver for the benefit of automated tooling
like Libvirt and mdevctl.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
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
index 4aeb3e1213c7..85b8094f5e69 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -26,6 +26,18 @@ MODULE_LICENSE("GPL v2");
 struct ap_matrix_dev *matrix_dev;
 debug_info_t *vfio_ap_dbf_info;
 
+static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "flags : guest_matrix hotplug ap_config\n");
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

