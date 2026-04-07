Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56F387372;
	Tue,  7 Apr 2026 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595101; cv=none; b=Lof4bGmWBG0qPuHcIUNz5FqR8JQGgkSRMPbYDwn/d1+rvn/FL3JakTFeUaRdf1q07Dy6C925zu7QQq/hBw5hcz0/GGtNDKw/IsSg+0yYFZGGLoPAWCfll0pAt0pRSQpGs6e0guW6cmSjx7zONBCjeWP+wse4vdjVFpFt5T3KZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595101; c=relaxed/simple;
	bh=a0uh7tTUtIQmTJQw6NaktQIH5Zy5PL9DuRmKGPFjvjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxhVZFCCGZWUgnElxYI/JAzYBKHO20WujdUaTJ05Yc+ziGj9JM/9FtKyY7T55elIQPpyne+A+s39dkJM03/w12Pd3NCnrlL6a75dsxMLswDv80LLFqA5xRybe8+KgBA7rJEfMOOtbKMG3glfZDPBmvpJSZLgtC5pbyXMm8r/Vxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jo43lrqn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jo43lrqn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Dhg1L2594684;
	Tue, 7 Apr 2026 20:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2Dr1b8PvrV9rKmSoL
	jFgKghy3uX1xqE3OtIkEtAFooQ=; b=Jo43lrqnbVxi1NpdoRaT2Kj5ZO+aqOaP3
	vb+PEsAtnL4iVwVoe1NXaYTBxrflKpMV6d7e6FVDW/Aq03oo2UulIQpom+HZAt/g
	Ro6hhzXH/2R4N1ZfKD5nN8538T0nt515GSqQGPDqSYKXE0Pob55HhTqxGZ1iYqQg
	GUwiDc1OXQGuPwmXrStb+3wLKIXsnBzHTkYiKjI3KgxiSW3GzZ5QGhOGZdiAjlEc
	iqHyoaeeDRlLK6pLg3lN2L5gL7yvel4KkL9Vk5EXD/5BEOnzbxqndSmCaEk+8f0t
	vVue+LstEy5bg77EBhyNZFRlpewqJiGajhnodLCn7lyJxm8lFOdCg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e53bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637IeqAn013844;
	Tue, 7 Apr 2026 20:51:32 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf44up5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:32 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637KpVwV30016000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ECEF58059;
	Tue,  7 Apr 2026 20:51:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E24258058;
	Tue,  7 Apr 2026 20:51:29 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:29 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 16/16] s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst
Date: Tue,  7 Apr 2026 16:50:32 -0400
Message-ID: <20260407205100.331150-17-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407205100.331150-1-akrowiak@linux.ibm.com>
References: <20260407205100.331150-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vBWqccBhYgHK2llBRjY9l2LMBBF7wUJW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfXxP2rne8rSc7B
 1TQUm71kC+3aLPqRnj2E70Ac9hO5XXtG7aoItjOC7UW4sG46jKl5cAdLfHsSia7wO8hbX/WlQLU
 MIOIbwVCBrVAm+aowM8hPBJ1wjMf+Nic0TzRm1PL65kNAPWSKWrXATHSSmIFq5q2gQFWyn8lG3O
 Z55Iu1RnTokwvQyyvMc2x2ppM3QofJ2oHee+2XZAsZlUYobFCwuFkMeh+Ak1YwGTiiAQRBXJfn+
 Kz5MK+d6uS3e95UfBFiXCMVU26iUCGSywR8Ejt6+vM3tAkvANwQryrLXGdWhVAcriQwgF1YeWle
 QGODSVRdQTYmZMqnXdlBK6RigeqiXeAI4n4UJ6p0vBodFsNP0zsaPTPwFjIb6XqNouMPplwVKn7
 XZS4rNWXO7RsnXB0fd+05x6KYh6/N7vknY/wDE/+4EsysCLlieX4afdJ/LrT7pr169/EdYfD38q
 ON70Ei0lXbMXUJCGpPA==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d56e55 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ymCyIV2yq4vNEUg3yzkA:9
X-Proofpoint-GUID: vBWqccBhYgHK2llBRjY9l2LMBBF7wUJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

Add a 'Live Guest Migration' chapter to the
Documentation/arch/s390/vfio-ap.rst document to describe the details for
initiating live guest migration for a guest to which AP adapters, domains
and control domains have been passed through.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 Documentation/arch/s390/vfio-ap.rst | 325 ++++++++++++++++++++--------
 1 file changed, 231 insertions(+), 94 deletions(-)

diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
index eba1991fbdba..8684d5ff87e4 100644
--- a/Documentation/arch/s390/vfio-ap.rst
+++ b/Documentation/arch/s390/vfio-ap.rst
@@ -1016,7 +1016,7 @@ guest_matrix dyn ap_config
 
 the following features are advertised:
 
----------------+---------------------------------------------------------------+
++--------------+---------------------------------------------------------------+
 | Flag         | Description                                                   |
 +==============+===============================================================+
 | guest_matrix | guest_matrix attribute exists. It reports the matrix of       |
@@ -1025,105 +1025,242 @@ the following features are advertised:
 +--------------+---------------------------------------------------------------+
 | dyn          | Indicates hot plug/unplug of AP adapters, domains and control |
 |              | domains for a guest to which the mdev is attached.            |
-+------------+-----------------------------------------------------------------+
++--------------+---------------------------------------------------------------+
 | ap_config    | ap_config interface for one-shot modifications to mdev config |
 +--------------+---------------------------------------------------------------+
+| migratable   | Indicates that live guest migration is supported for guests   |
+|              | to which crypto devices are passed through                    |
++--------------+---------------------------------------------------------------+
 
-Limitations
-===========
-Live guest migration is not supported for guests using AP devices without
-intervention by a system administrator. Before a KVM guest can be migrated,
-the vfio_ap mediated device must be removed. Unfortunately, it can not be
-removed manually (i.e., echo 1 > /sys/devices/vfio_ap/matrix/$UUID/remove) while
-the mdev is in use by a KVM guest. If the guest is being emulated by QEMU,
-its mdev can be hot unplugged from the guest in one of two ways:
-
-1. If the KVM guest was started with libvirt, you can hot unplug the mdev via
-   the following commands:
-
-      virsh detach-device <guestname> <path-to-device-xml>
-
-      For example, to hot unplug mdev 62177883-f1bb-47f0-914d-32a22e3a8804 from
-      the guest named 'my-guest':
-
-         virsh detach-device my-guest ~/config/my-guest-hostdev.xml
-
-            The contents of my-guest-hostdev.xml:
-
-.. code-block:: xml
-
-            <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-ap'>
-              <source>
-                <address uuid='62177883-f1bb-47f0-914d-32a22e3a8804'/>
-              </source>
-            </hostdev>
-
-
-      virsh qemu-monitor-command <guest-name> --hmp "device-del <device-id>"
-
-      For example, to hot unplug the vfio_ap mediated device identified on the
-      qemu command line with 'id=hostdev0' from the guest named 'my-guest':
-
-.. code-block:: sh
-
-         virsh qemu-monitor-command my-guest --hmp "device_del hostdev0"
-
-2. A vfio_ap mediated device can be hot unplugged by attaching the qemu monitor
-   to the guest and using the following qemu monitor command:
-
-      (QEMU) device-del id=<device-id>
-
-      For example, to hot unplug the vfio_ap mediated device that was specified
-      on the qemu command line with 'id=hostdev0' when the guest was started:
-
-         (QEMU) device-del id=hostdev0
-
-After live migration of the KVM guest completes, an AP configuration can be
-restored to the KVM guest by hot plugging a vfio_ap mediated device on the target
-system into the guest in one of two ways:
-
-1. If the KVM guest was started with libvirt, you can hot plug a matrix mediated
-   device into the guest via the following virsh commands:
-
-   virsh attach-device <guestname> <path-to-device-xml>
-
-      For example, to hot plug mdev 62177883-f1bb-47f0-914d-32a22e3a8804 into
-      the guest named 'my-guest':
-
-         virsh attach-device my-guest ~/config/my-guest-hostdev.xml
-
-            The contents of my-guest-hostdev.xml:
-
-.. code-block:: xml
-
-            <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-ap'>
-              <source>
-                <address uuid='62177883-f1bb-47f0-914d-32a22e3a8804'/>
-              </source>
-            </hostdev>
-
-
-   virsh qemu-monitor-command <guest-name> --hmp \
-   "device_add vfio-ap,sysfsdev=<path-to-mdev>,id=<device-id>"
+Live Guest Migration
+====================
+The VFIO AP mediated device is not used to provide userspace with direct access
+to a device as is the case with other devices that use the VFIO framework to
+pass them through to a guest. Instead, it manages AP configuration metadata
+identifying the AP adapters, domains, and control domains to which a guest will
+be granted access. These AP resources are configured by assigning them to a
+vfio-ap mediated device via its sysfs assignment interfaces. When the guest is
+started, the vfio_ap device driver sets the guest's AP configuration
+from the metadata stored with the mediated device. The AP devices
+are not accessed directly through the vfio_ap driver, so the driver has no
+internal device state to migrate. It's sole purpose during migration is to
+ensure that the AP configurations of the source and destination guests are
+compatible.
 
-      For example, to hot plug the vfio_ap mediated device
-      62177883-f1bb-47f0-914d-32a22e3a8804 into the guest named 'my-guest' with
-      device-id hostdev0:
+To be considered compatible, the AP configuration for both the source and
+destination guests must meet these requirements:
 
-      virsh qemu-monitor-command my-guest --hmp \
-      "device_add vfio-ap,\
-      sysfsdev=/sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804,\
-      id=hostdev0"
+  * Must have the same number of APQNs
 
-2. A vfio_ap mediated device can be hot plugged by attaching the qemu monitor
-   to the guest and using the following qemu monitor command:
+  * Each APQN assigned to the source guest must also be assigned to the
+    destination guest
 
-      (qemu) device_add "vfio-ap,sysfsdev=<path-to-mdev>,id=<device-id>"
+  * Each APQN assigned to the source guest and destination guest must reference
+    a queue with compatible hardware capabilities:
 
-      For example, to plug the vfio_ap mediated device
-      62177883-f1bb-47f0-914d-32a22e3a8804 into the guest with the device-id
-      hostdev0:
++--------------+---------------------------------------------------------------+
+| Hardware     | Description                                                   |
+| Capabilities |                                                               |
++==============+===============================================================+
+| facilities   | * AP special command facility (APSC)                          |
+|              | * AP 4096-bit ME PKU commands facility (AP4KM)                |
+|              | * AP 4096-bit CRT PKU commands (AP4KC)                        |
++--------------+---------------------------------------------------------------+
+| mode         | * CCA-mode                                                    |
+|              | * Accelerator-mode                                            |
+|              | * XCP-mode (EP11)                                             |
++--------------+---------------------------------------------------------------+
+| AP extended  | APXA installed                                                |
+| addressing   |                                                               |
++--------------+---------------------------------------------------------------+
+| command      | Command filtering available                                   |
+| filtering    |                                                               |
++--------------+---------------------------------------------------------------+
+| functional   | * Full native card function                                   |
+| capabilities | * Only stateless functions                                    |
++--------------+---------------------------------------------------------------+
+| secure       | The guest running on the source host can not have any queues  |
+| execution    | bound or associated with it                                   |
++--------------+---------------------------------------------------------------+
+| AP type      | * No AP type                                                  |
+|              | * PCICC (Leeds-2)                                             |
+|              | * PCICA (Leeds-2 Lite)                                        |
+|              | * PCIXCC                                                      |
+|              | * CEX2A                                                       |
+|              | * CEX2C                                                       |
+|              | * CEX3A                                                       |
+|              | * CEX3C                                                       |
+|              | * CEX4S                                                       |
+|              | * CEX5S                                                       |
+|              | * CEX6S                                                       |
+|              | * CEX7S                                                       |
+|              | * CEX8S                                                       |
+|              |                                                               |
+|              | Note: The AP type on the source and destination guests can    |
+|              |       differ if the queue passed through to the target guest  |
+|              |       is a newer model (backwards compatible)                 |
++--------------+---------------------------------------------------------------+
 
-         (QEMU) device-add "vfio-ap,\
-         sysfsdev=/sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804,\
-         id=hostdev0"
+Live guest migration failures due to AP configuration errors
+------------------------------------------------------------
+The destination host is missing the mediated device with the same name as the
+mdev attached to the source guest
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+**Source host**
+
++--------------+--------------------------------------------------------------------+
+| Log          | Message                                                            |
++==============+====================================================================+
+| Console log: | *error: device not found: mediated device '$UUID' not found*       |
++--------------+--------------------------------------------------------------------+
+
+The source guest is not enabled for migration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+**Source host**
+
++--------------+--------------------------------------------------------------------+
+| Log          | Message                                                            |
++==============+====================================================================+
+| Console log: | *error: Requested operation is not valid:                          |
+|              | cannot migrate domain: $UUID: Migration is disabled for VFIO       |
+|              | device*                                                            |
++--------------+--------------------------------------------------------------------+
+
+
+The AP configuration of the source and destination guests are not compatible
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+**Source host**
+
++--------------+--------------------------------------------------------------------+
+| Log          | Message                                                            |
++==============+====================================================================+
+| Console log: | *error: operation failed: job 'migration in' failed: load of       |
+|              | migration failed: Bad address*                                     |
++--------------+--------------------------------------------------------------------+
+| Kernel log:  | N/A                                                                |
++--------------+--------------------------------------------------------------------+
+| QEMU log:    | *initiating migration*                                             |
+|              |                                                                    |
+|              | *qemu-system-s390x: Sibling indicated error 1*                     |
++--------------+--------------------------------------------------------------------+
+
+**Destination host**
+
++--------------+--------------------------------------------------------------------+
+| Log          | Message                                                            |
++==============+====================================================================+
+| Console log: | N/A                                                                |
++--------------+--------------------------------------------------------------------+
+| Kernel log:  | *vfio_ap_mdev $UUID: Migration failed: Source and target queues    |
+|              | ($APQN) are not compatible*                                        |
+|              |                                                                    |
+|              | The message above will be followed by one or more messages         |
+|              | enumerating the incompatible features; for example:                |
+|              |                                                                    |
+|              | *vfio_ap_mdev $UUID: APSC facility installed in source queue $APQN*|
+|              |                                                                    |
+|              | *vfio_ap_mdev $UUID: APSC facility not installed in target queue   |
+|              | $APQN*                                                             |
+|              |                                                                    |
+|              | *AP type of source ($APTYPE) not compatible with target ($APTYPE)* |
++--------------+--------------------------------------------------------------------+
+| QEMU log:    | *initiating migration*                                             |
+|              |                                                                    |
+|              | *qemu-system-s390x: error while loading state section id ...*      |
+|              |                                                                    |
+|              | *shutting down, reason=failed*                                     |
+|              |                                                                    |
+|              | *terminating on signal 15 from pid 1196 (/usr/sbin/virtqemud)*     |
++--------------+--------------------------------------------------------------------+
+
+The AP configuration of the source guest has more APQNS than the destination guest
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+**Source host**
+
++--------------+--------------------------------------------------------------------+
+| Log          | Message                                                            |
++==============+====================================================================+
+| Console log: | *error: operation f1e166ee77e6failed: job 'migration in' failed: load of       |
+|              | migration failed: Input/output error*                              |
++--------------+--------------------------------------------------------------------+
+| Kernel log:  | N/A                                                                |
++--------------+--------------------------------------------------------------------+
+| QEMU log:    | *initiating migration*                                             |
+|              |                                                                    |
+|              | *qemu-system-s390x: Sibling indicated error 1*                     |
++--------------+--------------------------------------------------------------------+
+
+**Destination host**
+
++--------------+--------------------------------------------------------------------+
+| Log          | Message                                                            |
++==============+====================================================================+
+| Console log: | N/A                                                                |
++--------------+--------------------------------------------------------------------+
+| Kernel log:  | *vfio_ap_mdev $UUID:                                               |
+|              | migration failed: source guest's AP config size (xx) larger than   |
+|              | target's (yy)*                                                     |
++--------------+--------------------------------------------------------------------+
+| QEMU log:    | *initiating migration*                                             |
+|              |                                                                    |
+|              | *qemu-system-s390x: error while loading state section id ...*      |
+|              |                                                                    |
+|              | *shutting down, reason=failed*                                     |
+|              |                                                                    |
+|              | *terminating on signal 15 from pid 1196 (/usr/sbin/virtqemud)*     |
++--------------+--------------------------------------------------------------------+
+
+The AP configuration of the source guest has fewer APQNS than the destination guest
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+**Source host**
+
++--------------+--------------------------------------------------------------------+
+| Log          | Message                                                            |
++==============+====================================================================+
+| Console log: | *error: operation failed: job 'migration in' failed: load of       |
+|              | migration failed: No such device*                                  |
++--------------+--------------------------------------------------------------------+
+| Kernel log:  | N/A                                                                |
++--------------+--------------------------------------------------------------------+
+| QEMU log:    | *initiating migration*                                             |
+|              |                                                                    |
+|              | *qemu-system-s390x: Sibling indicated error 1*                     |
++--------------+--------------------------------------------------------------------+
+
+**Destination host**
+
++--------------+--------------------------------------------------------------------+
+| Log          | Message                                                            |
++==============+====================================================================+
+| Console log: | N/A                                                                |
++--------------+--------------------------------------------------------------------+
+| Kernel log:  | *vfio_ap_mdev $UUID:                                               |
+|              | migration failed: number of queues on source (x) and target (y)    |
+|              | guests differ*                                                     |
++--------------+--------------------------------------------------------------------+
+| QEMU log:    | *initiating migration*                                             |
+|              |                                                                    |
+|              | *qemu-system-s390x: error while loading state section id ...*      |
+|              |                                                                    |
+|              | *shutting down, reason=failed*                                     |
+|              |                                                                    |
+|              | *terminating on signal 15 from pid 1196 (/usr/sbin/virtqemud)*     |
++--------------+--------------------------------------------------------------------+
+
+AP Configuration Management
+---------------------------
+The AP configurations of the source and destination guests must be synchronized or
+live guest migration will likely fail due to incompatibility. In particular, it is
+imperative that such changes are not made during migration. Configuration stability
+is an orchestration-layer or system administrator responsibility, consistent with
+other VFIO device types. The vfio_ap driver's role is to validate configurations
+and provide clear diagnostics when incompatibilities are detected, enabling
+orchestration tools to implement appropriate policies.
+
+Note that s390 Common Cryptographic Architecture (CCA) master key administration
+must to be performed on both the source and destination AP devices to synchronize
+the key values prior to allowing live guest migration. If the master keys do not
+match, then crypto applications that rely on secure keys wrapped by a CCA master
+key will fail when the guest on which they are running is migrated to the
+destination host.
-- 
2.52.0

