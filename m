Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE223358D6;
	Wed, 25 Mar 2026 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472531; cv=none; b=OnjjFmgzU59pqpU+VfZcGIu0vi1B4hEs1/26XlnUBfDYydQ7m230pOpgMiLSqyO4y8AL9VNya7R8sQ/yL8cLs99NXr51rfaS8IFVJOQeUXHGB9UuoeZ9SR8HHTsay4lU+2CDLH0/K68ZhUx3awIXYUbr9vz3g1eYaoLcEiceCdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472531; c=relaxed/simple;
	bh=Qv4p7AyHFLvqFpaNj2gh19V8Lp6RSO+suHmyJvAO7d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2X6Pqyjd/CtxAXOZceIeTe9r5aeVlZN795EBE8halVlHbaJ7SxIy4VgB1lC5G9kSFzYve4COI9pmZUJpEcILRgn6knAsCc3cSgKrU9Q2+Ie9TmLlPmZu8A/A6zD4Qaeu8vSAchOa0Evq2y/q4548xzHQF0ud8CEEKOjhP/rGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tb8U/qsw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tb8U/qsw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PFj5fg2969041;
	Wed, 25 Mar 2026 21:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TYIEND5dhh+b75WgB
	e8kOpp81wHwKnGDTtTxcUzNu5M=; b=Tb8U/qswBvWnDzA2YbxWQhi4HiMuMl7EQ
	h0agn5iAz/6HRi02eAGgkybJPygrsApp1nBJNyR8eNbM6Jm6sGplfcx7IFIUz2va
	B/Lkn4FLBfwEArblGZfU8qrLjILLKIXVN/vG0uv6bYhqzQJicUHfIcllLjkm5nhp
	FOCRhrFlg3Su1bQzSk+XQphwrXcN2rFKNS+08R+pi2OIL1PMC7gE8CX7uKWODZo8
	j5dHap2hyKmyHJr0psto2T4nC+MnkskFnI1DU5+g8bm3w8Hi2rAVJl/fuJUGys4T
	QTPHuhk3Do9izvuToRSQ2e900qJBVyyYY5mej9K31GR8cUq7+LFPw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty2car-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PKC8F7026900;
	Wed, 25 Mar 2026 21:02:03 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m0532-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:03 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL21QW29098580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F66058067;
	Wed, 25 Mar 2026 21:02:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 772A858056;
	Wed, 25 Mar 2026 21:02:00 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:00 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 09/24] s390/vfio-ap: Return value of sysfs migratable attribute from VFIO_DEVICE_GET_INFO ioctl
Date: Wed, 25 Mar 2026 17:00:56 -0400
Message-ID: <20260325210149.888028-10-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c44d4c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=boy5AC6DYhcG1jmkY4oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX+Wc75xC/U0Dq
 wncv9JCyx09NDpkTe5C0f/QRml6PkWlP39KlqgmN8d9knX3cElNeeeSBN89hIOve0QbQK4ScZ1i
 uTK443ubuEXs7Jj8RiZkrW6H2rfHxeMXaFhNbxk4t6M1CppzqPN0wpRdFQd9z0jyT35Mby79/C/
 Q06TOFn6ZKIpI4U+RjGdk3SXJVDFzAk2/oglFPalM3UfRzxCRMvXF/XJ3AMAq/k8oQ+kkVXfbKO
 wYvUH21WcLpKJHxsTHYJIj65zk8BTyAEiAKBjySPHcy+OctQe5DLbWdbUfKl+KKiQ6AyJBjEqcm
 tJM0g2AM50lw0uyoZnQMUi7aI7B99+aMQW3iMKDNlciwOpGhcZjdxuGXNKwz511l7PkyQzYUPXi
 MN1g+lp8uqvuJ36FPAaJFw3JlBcX+GAwbHoBOdB2j7/oFjlKdvoFiHkx1uCJeSUoYsUiCc+0IVt
 2iGPtiQGes5PU1DX+Ug==
X-Proofpoint-GUID: rOYcLK78lB5YvXxe5cnRRr9Xs7Q-DS3o
X-Proofpoint-ORIG-GUID: rOYcLK78lB5YvXxe5cnRRr9Xs7Q-DS3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

Extends the 'vfio_device_info' object passed to the VFIO_DEVICE_GET_INFO
ioctl to include a vfio device capability specifying the value of the
mdev's sysfs 'migratable' attribute. This value may be used to enable or
block live guest migration when the vfio device is realized in userspace.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 75 ++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 213832263dc9..d487628027c7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -19,6 +19,7 @@
 #include <linux/uuid.h>
 #include <asm/kvm.h>
 #include <asm/zcrypt.h>
+#include <uapi/linux/vfio_ap.h>
 
 #include "vfio_ap_private.h"
 #include "vfio_ap_debug.h"
@@ -2183,11 +2184,75 @@ int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix)
 	return num_queues;
 }
 
-static int vfio_ap_mdev_get_device_info(unsigned long arg)
+static int vfio_ap_add_caps_to_dev_info(struct vfio_device_info *dev_info,
+					unsigned long arg,
+					struct vfio_info_cap *caps)
 {
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (caps->size) {
+		dev_info->flags |= VFIO_DEVICE_FLAGS_CAPS;
+		if (dev_info->argsz < sizeof(*dev_info) + caps->size) {
+			dev_info->argsz = sizeof(*dev_info) + caps->size;
+		} else {
+			vfio_info_cap_shift(caps, sizeof(*dev_info));
+
+			if (copy_to_user((void __user *)arg + sizeof(*dev_info),
+					 caps->buf, caps->size)) {
+				kfree(caps->buf);
+				return -EFAULT;
+			}
+
+			dev_info->cap_offset = sizeof(*dev_info);
+		}
+
+		kfree(caps->buf);
+	}
+
+	return 0;
+}
+
+static int vfio_ap_add_attrs_cap_to_caps(struct ap_matrix_mdev *matrix_mdev,
+					 struct vfio_info_cap *caps)
+{
+	struct vfio_device_info_cap_ap_attrs cap;
+
+	lockdep_assert_held(matrix_dev->mdevs_lock);
+	cap.migratable = matrix_mdev->migratable;
+	cap.header.id = VFIO_DEVINFO_CAP_AP_ATTRS_ID;
+	cap.header.version = VFIO_DEVINFO_CAP_AP_ATTRS_VERSION;
+
+	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
+}
+
+static int vfio_ap_add_caps(struct ap_matrix_mdev *matrix_mdev,
+			    unsigned long arg,
+			    struct vfio_device_info *dev_info)
+{
+	struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
+	int ret = 0;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	ret = vfio_ap_add_attrs_cap_to_caps(matrix_mdev, &caps);
+	if (ret)
+		return ret;
+
+	ret = vfio_ap_add_caps_to_dev_info(dev_info, arg, &caps);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int vfio_ap_mdev_get_device_info(struct ap_matrix_mdev *matrix_mdev,
+					unsigned long arg)
+{
+	int ret;
 	unsigned long minsz;
 	struct vfio_device_info info;
 
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
 	minsz = offsetofend(struct vfio_device_info, num_irqs);
 
 	if (copy_from_user(&info, (void __user *)arg, minsz))
@@ -2200,6 +2265,12 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
 	info.num_regions = 0;
 	info.num_irqs = VFIO_AP_NUM_IRQS;
 
+	ret = vfio_ap_add_caps(matrix_mdev, arg, &info);
+	if (ret)
+		return ret;
+
+	minsz = min_t(size_t, info.argsz, sizeof(info));
+
 	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
 }
 
@@ -2395,7 +2466,7 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 	mutex_lock(&matrix_dev->mdevs_lock);
 	switch (cmd) {
 	case VFIO_DEVICE_GET_INFO:
-		ret = vfio_ap_mdev_get_device_info(arg);
+		ret = vfio_ap_mdev_get_device_info(matrix_mdev, arg);
 		break;
 	case VFIO_DEVICE_RESET:
 		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
-- 
2.52.0

