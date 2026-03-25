Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A838F638;
	Wed, 25 Mar 2026 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472550; cv=none; b=M7Ienhubd5eg/2hWUN0pz0F0QKhHpyGJ4XcXSvJ0O58mj2X2xZbsHjk9PbOtrGHQ3cLSHlspNSeKj6/TC9io8Ls7aKHj17ThBMgXH+srEvep1VkBQ9e9D1qmO/7Hq2FaRRDkOQySJ8BB3iTt4kdzdZhELn7m22NgcjL7nEiBgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472550; c=relaxed/simple;
	bh=I/wWZ9C0shTDrsq8fuNsIdndXcbIv7ccuWuwLKjWqr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHF8cn2O07ADpbHVncJEHNvZfObQwJ9JJLpIw35qnfZq2v19WlszmAyKTelRocYlxmrPphtpEaOlj0tWnH3s0IPGT64ovBJvlw98Xy6OlQgFqqFmFpprFth6TlmLFFdEPJK6eb64Qwad8G3jSlfT0rCOYiC2UBbIkrbYlCcViAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ADD8botm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ADD8botm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PIUhas3819926;
	Wed, 25 Mar 2026 21:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gXuvojxTJHljWArPR
	minBWWRAB18H+vkJf9CV9BRxZc=; b=ADD8botmOwfZEWTvfCoOiVtRieDBrzKFV
	Jar1OobtqyfNc40F5MYSYAY5fgy3iQtzNgAsv929fxnpCbkDRPvVr7DeM1ti14KI
	wjyU+ksB0CuW5Ah1XRRSOeZUCjsD+5amE/5tVigW/Z1EzdZcKqPQC87aJwBZaBqt
	7IzEL89d2bZie9K6rrPZTh/cNTAMCWyg5gdVNQQFbxISBQM/9EeAlAzFpP+K0a5U
	z8MldHiTXcRn3L6hE01odPZtPucfAdltb0mbcdyQA1k7a8v7Jt2HZg2/QIgvH+WK
	H3zU/44TatwsejU/eMudVtGLk/SQSYtUfcs80OD9l6hl9FlYKLNZQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty2cbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PKTq4x012203;
	Wed, 25 Mar 2026 21:02:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk818e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:20 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL2IUv5112696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:18 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C2D95805D;
	Wed, 25 Mar 2026 21:02:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2281658052;
	Wed, 25 Mar 2026 21:02:17 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:17 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 24/24] s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst
Date: Wed, 25 Mar 2026 17:01:11 -0400
Message-ID: <20260325210149.888028-25-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c44d5d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ymCyIV2yq4vNEUg3yzkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX0Zu+UG2o7g9J
 ohe7nid3mY1yfDBsocEnPeLC5C/MYDtaYJB4CTBr5EhFBAgErHoeVu6pM+3RyYr4Bv43DxHGotj
 hpKeaIoxui0BXlAYtX0ivqephVvWNOinlYLRPF0mn21w7tt3+GJnqZ2gvHICZNtnGB+kUn86vjl
 MMDsQEgYeINrEjblHIRrsv0ije33dXCTKCaTBid9Vt/C3U5R2AJBOriUL3XR+RSgwecGvljPXsd
 UcqDIHPwRkD8Q2kslmD9mn2OKVxRNvrVf3j3qHmU0YUPTmaDZNEFmQri2Q/K2nq5yt+FkNUkFX0
 0f9IxsyLlJ3s0e29wjw6RMynh49G8WTkm0G/FBZSr7mZwOnszDJ97ujiCdSkqB5DpdN+gfJRuAx
 UIdl+IHk6qgL8ZHHqIDBHKbkJ1k1g3znZQ+AQtcsa4mW4wg76oRZKDolXyIcP6HKnIdxwpid/iE
 ZyMFKjQYNYaPP6WkfxQ==
X-Proofpoint-GUID: GUHQsRgNDdQ4_Y-hCNgXFVMTbK_taun5
X-Proofpoint-ORIG-GUID: GUHQsRgNDdQ4_Y-hCNgXFVMTbK_taun5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

Add a 'Live Guest Migration' chapter to the
Documentation/arch/s390/vfio-ap.rst document to describe the details for
initiating live guest migration for a guest to which AP adapters, domains
and control domains have been passed through.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 Documentation/arch/s390/vfio-ap.rst | 339 ++++++++++++++++++++--------
 1 file changed, 246 insertions(+), 93 deletions(-)

diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
index eba1991fbdba..9df7614fd62b 100644
--- a/Documentation/arch/s390/vfio-ap.rst
+++ b/Documentation/arch/s390/vfio-ap.rst
@@ -1016,7 +1016,7 @@ guest_matrix dyn ap_config
 
 the following features are advertised:
 
----------------+---------------------------------------------------------------+
++--------------+---------------------------------------------------------------+
 | Flag         | Description                                                   |
 +==============+===============================================================+
 | guest_matrix | guest_matrix attribute exists. It reports the matrix of       |
@@ -1025,105 +1025,258 @@ the following features are advertised:
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
+Live Guest Migration
+====================
+A guest to which crypto devices (i.e., AP adapters, domains and control domains)
+have been passed through can be migrated to another system if both the source
+and destination guests meet the following requirements:
 
-   virsh qemu-monitor-command <guest-name> --hmp \
-   "device_add vfio-ap,sysfsdev=<path-to-mdev>,id=<device-id>"
+* The destination guest will be started with the same QEMU command line as the
+  source guest, so the mediated device supplying the AP configuration on both
+  the source and destination guests must have the same name (UUID).
 
-      For example, to hot plug the vfio_ap mediated device
-      62177883-f1bb-47f0-914d-32a22e3a8804 into the guest named 'my-guest' with
-      device-id hostdev0:
+* The AP configuration passed through to both the source and destination guests
+  must be compatible. As such, each AP configuration:
 
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
+Enabling and disabling live guest migration
+-------------------------------------------
+By default, live guest migration will be disabled for guests that use crypto
+devices. A r/w sysfs 'migratable' attribute for each mediated device is provided
+to enable/disable live guest migration for the guest to which the mediated
+device is attached. The valid values for this attribute are 1 (enable) and
+0 (disable).
+
+To enable live migration:
+
+	echo 1 /sys/bus/mdev/devices/$UUID/migratable
+
+To disable live migration:
+
+	echo 0 /sys/bus/mdev/devices/$UUID/migratable
+
+The 'migratable' attribute allows migration to be dynamically enabled or
+disabled for the guest to which the mediated device is attached; however,
+if migration of the vfio-ap device is already in progress, the operation will
+be rejected with a 'Device or resource busy' message.
+
+Live guest migration failures due to AP configuration errors
+------------------------------------------------------------
+The VFIO AP mediated device is not used to provide userspace with direct access
+to a device as is the case with other devices that use the VFIO framework to
+pass them through to a guest. The sole purpose of the VFIO AP mediated device
+is to manage an AP configuration for a guest. An AP configuration is comprised
+of the AP adapter IDs (APID), AP queue indexes (APQI) and domain numbers of the
+control domains to which a guest will be granted access. Once the VFIO AP
+mediated device is attached to the guest, its AP configuration is set by the
+vfio_ap device driver. Once set, all access to the AP devices is handled
+by the s390 Interpretive Execution facility; in other words, the vfio_ap device
+driver plays no role in providing direct access to these AP devices.
+
+The only role that the vfio_ap device driver plays in the migration process is
+to verify that the AP configuration for the source guest is compatible with the
+AP configuration of the destination guest. Incompatibility will result in a live
+guest migration failure. This section describes how to debug this type of
+failure.
+
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
-- 
2.52.0

