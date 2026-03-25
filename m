Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D46432D0D4;
	Wed, 25 Mar 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472528; cv=none; b=GvfKZasmIeNXJ5nn8uVLi1HzcTC2jmN36idMpWOv5bYGhC68nm6g/MtSv8F5O5OnxiVrwz1XDHDtEPTuCyyW07fABWNJpPp1+cX1yzsL6AAJb+gGhGKqK9cTbSdSq07/9yux3ZPvWEXYOTmuQf8qGt1gXsVRNaUp4nw+dgpsUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472528; c=relaxed/simple;
	bh=qWk58MCyl06Gi/6BvcjfDCVv30z6KhS31oL6rE+tI6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgAS8P6s+yx1smwF3T/lx217+IB+MiDwvOsseJM0QWATWBVV0iPSDTyt5c6PtRQKjlp7Gjl0q5tUEuqicZVgtBR/DMV5MZDUoD7P2RH9kZdTEkemz5bF7JjlRXsLL4HHY/rcSxn1J0nhYCBZRDXGW8KPk5/CrQ7kRF29DOtaqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vls4bdCQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vls4bdCQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PD2r6c646583;
	Wed, 25 Mar 2026 21:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lRLZkMo7hL5smzrsL
	S0zL6G7KkjdnA9D7UD1/727aHs=; b=Vls4bdCQmfsd0gdZqKj00LFQ3Qww/9/Yd
	YadG4rhTgHkykMlywNt0W+ceCpuaB6y/Eqcg2vNQED+Qb1gZYo3PfwN/7A73WlL8
	WKhU2bo8riEvV+CZAFuzzxjm7uwTDNT/dPI5QaqXtSxSM3zEev871QClWu8fexxw
	FCwmj2z2wmOTNCJsgGd3YRMfoBa+MiAjuGPKjvnMP/N0zhdjRVH7ryXTF0WR32mV
	p1Xu4yoy/sek3BfIzJvlmrSeycrc0LL3sgM6qemusAiyTWOD+8zchdsAgN8j4d8w
	Uh0gl0Kx/swqMPkLZVXJ788pqm7HNKGElnGoXqE2DYjeMqGVVMZ9g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumsjr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:01:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PKTq4n012203;
	Wed, 25 Mar 2026 21:01:58 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk8161-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:01:58 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL1uvd61145366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:01:56 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E325558068;
	Wed, 25 Mar 2026 21:01:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB70958056;
	Wed, 25 Mar 2026 21:01:54 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:01:54 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 04/24] s390/vfio-ap: Add header file for xfer of vfio device caps to userspace
Date: Wed, 25 Mar 2026 17:00:51 -0400
Message-ID: <20260325210149.888028-5-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: PXps_1z3y-onma2ajD8hI8MDwTj6XHLN
X-Proofpoint-ORIG-GUID: PXps_1z3y-onma2ajD8hI8MDwTj6XHLN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX/UtMT/+3Cpb4
 bR/rsHovxIZm2NMCYSTGUwP5wrFJQXU6QIWK+Aw6wDRUFmPMRDTbwdorIZAUhF6Mw/WqWXoThmI
 JTghT+SKL6hGCBJyBIkovqb4W5JLAdIxBdA50Bxv1okm9rtwY2yUAZEJ/+mllt9fUWxBdKClmTf
 mdgP3EHpzyOZdzF6kBh11kdWsn1sqQPiWzGPSIIGL5h/gKRs9ChcgBtocnF2hfRZVqiqkwxPMdw
 aAkaD5N6ZjnzzJ6+h5oWZAZM1aKiwqDm+XcRptNgypvI3RX41pWFsDG35j5nX0tk4TskN994mAR
 D2f3ZNSsAg+wzXJsnCIU4lK1K/3GvaZkZfXACNiuOYIUTqTYtxF+O6wfWT8yG02gGDMJXNbiEMI
 icKcknWlq4GCp5xavEqaPy8lC7hBhssd9hL6gzw86HRTC8ULev5SM2bZ4+d1yVl/dB/4w/3aKug
 Xizj0sMAbAo2zhkjUMw==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c44d47 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=I-WApvqTOFCiUe7Gdr0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

Adds the vfio_ap.h file used to transfer vfio device capabilities to
userspace in response to the VFIO_DEVICE_GET_INFO ioctl. The device
capabilities includes an object specifying the vfio device attributes.
This object contains a flag indicating whether the vfio device is
migratable.

Note: The migratable flag could have been returned as a capability
      unto itself, but returning it as one attribute of a set of
      attributes allows for this capability to easily be extended
      to include additional attributes in the future if need be.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 include/uapi/linux/vfio_ap.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 include/uapi/linux/vfio_ap.h

diff --git a/include/uapi/linux/vfio_ap.h b/include/uapi/linux/vfio_ap.h
new file mode 100644
index 000000000000..9ee14f8649ed
--- /dev/null
+++ b/include/uapi/linux/vfio_ap.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Interfaces for vfio-ap
+ *
+ * Copyright IBM Corp. 2025
+ *
+ * Author(s): Anthony Krowiak <akrowiak@linux.ibm.com>
+ */
+
+#ifndef INCLUDE_UAPI_LINUX_VFIO_AP_H_
+#define INCLUDE_UAPI_LINUX_VFIO_AP_H_
+
+#include <linux/types.h>
+#include <linux/vfio.h>
+
+#define VFIO_DEVINFO_CAP_AP_ATTRS_VERSION	1
+#define VFIO_DEVINFO_CAP_AP_ATTRS_ID		1
+
+/**
+ * struct vfio_device_info_cap_ap_attrs - vfio device capability object used
+ *					  supply the device attributes to
+ *					  userspace.
+ *
+ * @header:	the header used to extend the struct vfio_device_info object
+ *		to provide the vfio device attributes to userspace
+ * @migratable:	indicates whether the vfio device is migratable (1) or
+ *		not (0).
+ */
+struct vfio_device_info_cap_ap_attrs {
+	struct	vfio_info_cap_header	header;
+	int				migratable;
+};
+
+#endif /* INCLUDE_UAPI_LINUX_VFIO_AP_H_ */
-- 
2.52.0

