Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BDA3C0A14;
	Tue,  7 Jul 2026 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414978; cv=none; b=lrZ5zkZEQxHBmpTElIybr/27eddSLkOKqBNgs1MxACuiyfbXdv3b/VpJpeOaBkXOPEtZLUZ6UU99pGg+S35QOSkTc3TkBBzGjaKxH1E10/1kg7fOQ0KNe+S+Cg8jvOjqUNeGKDSJtWG+rCgCiAeBjOlv249gVvcrP6NjXDyeR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414978; c=relaxed/simple;
	bh=lcV3Ic2b4jaFPFCtKj8W3bZy1Jo60enz6IUbFLabiVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7q2n6Ne8sLdHotCjmVxPzKJDp7SCZSnj8FQCYxV57jQYdAO0zn23Xl0hsOxcjYWP/g09JjFmGt1E1YhWOjX60/6uxnxJsl+qWXxMUeW/XUR7f4YTqDezBnM0rv1n5p1I/TkdEgtFC7vGHiIgOyRjZzyJF+aKmnH1sQzhA29D4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bFY45Z4w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bFY45Z4w"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IDvH3342057;
	Tue, 7 Jul 2026 09:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cUH+69wbHcBsiZack
	sRalunVut/JqF3ZiaM+xBaEqdQ=; b=bFY45Z4wdxm1CgFLBx2aSGazj/SIUzjHs
	v5R4V8QG9XQJRf++7QbK1D0Bl0sJJbK7MliKiGaBFepJ7l5B5W4MRZATrcPbakxx
	ArCTZbsxnkYKDZyJWWHrZbErU3bZzG1Q4Y6bgkPXm8M9wsi2Ws4lgqPd4TsbiKKY
	gLdAG1LG+wTH8B36+zrd7w4dgVmDQTkOm76vryQC+s+yZ+N6KZmwwCqjeSdOSnef
	xHFovU+3tdodW0ul3VjuNMpWn58a8vF6XBYlPkb5dzBxGLOaGVv8bjA6HxxEMIQm
	yNeSORGS03xXc3+g4dC7V2Sy840hZH1MoE8x/JU1dvsM2yt6fmTpQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqnyr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678YfqH027608;
	Tue, 7 Jul 2026 09:02:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h9u7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792liY51118512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64C8E58060;
	Tue,  7 Jul 2026 09:02:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 398E75805A;
	Tue,  7 Jul 2026 09:02:46 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:46 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 15/15] s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst
Date: Tue,  7 Jul 2026 05:02:17 -0400
Message-ID: <20260707090226.3206695-16-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX5AIwhJHzdb+A
 M2u/7NJEF2sSC9dI4+aEwa/Ij+Uv3V2GIxyObVHHkmQ8xgfoot85SSpshfyrzVMk100zNRiam0U
 /DOJdu3YP2IEYnHgfodY+16HxfrSFBA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX7XFhH/+apoa8
 NTa9uJ54GHvchV3HngwYvxi2SkoQh1cq1geYqyzXNwAlX6eN0x/JVIjNfESwSR7oBbC+ZNt9eCl
 zYyoxJo8MLtQH1cBPLDs/QLWcziJQmBYWuT++OP7F19VshIZDJDPJ3ACiiMHoee2dL85Yx9ye2v
 Uk6ZlDXxPfnmub1FyMCVrBHPNSWVsCzEdT6UqfFspFmlCN/pyfoMAMqN7eLovgiAc31a7mX3hEQ
 tNM5U5yk3D8FsBs4aayuV7uKuHXCHxP4YqzV9kIAclHbnrBHMmTPE7eoiBNuQBowl4AlknHOlr/
 5OVLqERTZZ+KnajahYx+oqYCQRrbHxKjejfsD5bvDTbNmgpmyRqClAnuDkiTz3YR2nrnBr4104i
 HwUhoE6G4bX5YrzfFzCQrPPl/G7mvocWE28dbZrKjTv2l0xHrWHzHIrnfHrRc16ioz5p/Fk6n6e
 BGTYP/WFvdQjLni3UkA==
X-Proofpoint-GUID: 93_eAIBsqgelODjGn1z0TQMcGv9MWHwW
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4cc0ba cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=5d5J1M8IJ0-sLZaSyWMA:9
X-Proofpoint-ORIG-GUID: 93_eAIBsqgelODjGn1z0TQMcGv9MWHwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

Add a 'Live Guest Migration' chapter to the
Documentation/arch/s390/vfio-ap.rst document to describe the details for
initiating live guest migration for a guest to which AP adapters, domains
and control domains have been passed through.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 Documentation/arch/s390/vfio-ap.rst | 514 +++++++++++++++++++++++-----
 1 file changed, 433 insertions(+), 81 deletions(-)

diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
index ac0c07f76ddd..fc0707c0dffd 100644
--- a/Documentation/arch/s390/vfio-ap.rst
+++ b/Documentation/arch/s390/vfio-ap.rst
@@ -1012,7 +1012,7 @@ guest_matrix dyn ap_config
 
 the following features are advertised:
 
----------------+---------------------------------------------------------------+
++--------------+---------------------------------------------------------------+
 | Flag         | Description                                                   |
 +==============+===============================================================+
 | guest_matrix | guest_matrix attribute exists. It reports the matrix of       |
@@ -1021,105 +1021,457 @@ the following features are advertised:
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
+Live Guest Migration
+====================
+The VFIO AP mediated device is not used to provide userspace with direct
+access to a device as is the case with other devices that use the VFIO
+framework for device pass-through. Instead, it manages AP
+configuration metadata identifying the adapters, domains, and control
+domains to which a guest will be granted access. These AP resources are
+configured by assigning them to a vfio-ap mediated device via its sysfs
+assignment interfaces. When the guest is started, the vfio_ap device driver
+sets the guest's AP configuration from the metadata stored with the mediated
+device. The AP devices are not accessed directly through the vfio_ap driver,
+so the driver does not migrate the state of the AP devices themselves.
+Instead, it migrates the AP configuration metadata. The vfio_ap device
+driver on the destination host will then ensure that the AP configuration
+metadata migrated from the source host is compatible with the AP
+configuration available on the destination host and if
+so, will set the destination guest's AP configuration accordingly.
 
-      (QEMU) device-del id=<device-id>
+To be considered compatible, the AP configuration for the destination host must
+meet these requirements:
 
-      For example, to hot unplug the vfio_ap mediated device that was specified
-      on the qemu command line with 'id=hostdev0' when the guest was started:
+* Each AP adapter, domain and control domain number assigned to the source
+  guest's AP configuration must be in the destination host's AP
+  configuration. This can be verified as follows:
 
-         (QEMU) device-del id=hostdev0
+  * On the source host, display the AP configuration of the source guest:
 
-After live migration of the KVM guest completes, an AP configuration can be
-restored to the KVM guest by hot plugging a vfio_ap mediated device on the target
-system into the guest in one of two ways:
+    .. code-block:: bash
 
-1. If the KVM guest was started with libvirt, you can hot plug a matrix mediated
-   device into the guest via the following virsh commands:
+       cat /sys/devices/vfio_ap/matrix/$UUID/guest_matrix
+       cat /sys/devices/vfio_ap/matrix/$UUID/control_domains
 
-   virsh attach-device <guestname> <path-to-device-xml>
+    .. note::
+       Replace ``$UUID`` with the actual UUID of your mediated device.
 
-      For example, to hot plug mdev 62177883-f1bb-47f0-914d-32a22e3a8804 into
-      the guest named 'my-guest':
+  * Display the AP configuration of the destination host:
 
-         virsh attach-device my-guest ~/config/my-guest-hostdev.xml
+    .. code-block:: bash
 
-            The contents of my-guest-hostdev.xml:
+       lszcrypt -V
+       cat /sys/bus/ap/ap_control_domain_mask
 
-.. code-block:: xml
+    Note that each bit in the ap_control_domain_mask corresponds to
+    correspond to domain numbers 0-255. If a bit is set to one, then
+    the control domain is available on the destination host. For
+    example:
 
-            <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-ap'>
-              <source>
-                <address uuid='62177883-f1bb-47f0-914d-32a22e3a8804'/>
-              </source>
-            </hostdev>
+    .. code-block:: bash
 
+       0x0000000000001020000000000000000000000000000000000000000000000000
 
-   virsh qemu-monitor-command <guest-name> --hmp \
-   "device_add vfio-ap,sysfsdev=<path-to-mdev>,id=<device-id>"
+       This mask indicates that AP adapters 51 (0x33) and 58 (0x58) are
+       available on the host system.
 
-      For example, to hot plug the vfio_ap mediated device
-      62177883-f1bb-47f0-914d-32a22e3a8804 into the guest named 'my-guest' with
-      device-id hostdev0:
+  * Verify the configurations:
 
-      virsh qemu-monitor-command my-guest --hmp \
-      "device_add vfio-ap,\
-      sysfsdev=/sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804,\
-      id=hostdev0"
+    * Each APQN in the guest's sysfs ``guest_matrix`` file must match an
+      APQN returned from the lszcrypt command on the destination host. It
+      is important to note the driver to which the queue is bound which
+      is displayed in the ``driver`` column. Queues not bound to the vfio_ap
+      driver are not available to the destination guest. That, however, does
+      not guarantee they can be used by the guest being migrated; for example,
+      migration will fail if any of these APQNs are assigned to a mediated
+      device other than the one being migrated.
 
-2. A vfio_ap mediated device can be hot plugged by attaching the qemu monitor
-   to the guest and using the following qemu monitor command:
+    * Each domain number from the source guest's sysfs
+      ``control_domains`` attribute must correspond to a bit set to one in
+      the destination host's ``ap_control_domain_mask``.
 
-      (qemu) device_add "vfio-ap,sysfsdev=<path-to-mdev>,id=<device-id>"
+* Each APQN assigned to the source guest and destination guest must
+  reference a queue device with compatible hardware capabilities:
 
-      For example, to plug the vfio_ap mediated device
-      62177883-f1bb-47f0-914d-32a22e3a8804 into the guest with the device-id
-      hostdev0:
++--------------+---------------------------------------------------------------+
+| Hardware     | Description                                                   |
+| Capabilities |                                                               |
++==============+===============================================================+
+| [1]          | * AP special command facility (APSC)                          |
+| Facilities   | * AP 4096-bit ME PKU commands facility (AP4KM)                |
+|              | * AP 4096-bit CRT PKU commands (AP4KC)                        |
++--------------+---------------------------------------------------------------+
+| [1] Mode     | * CCA-mode                                                    |
+|              | * Accelerator-mode                                            |
+|              | * XCP-mode (EP11)                                             |
++--------------+---------------------------------------------------------------+
+| [1] AP       |   APXA installed                                              |
+| extended     |                                                               |
+| addressing   |                                                               |
++--------------+---------------------------------------------------------------+
+| [1] Command  |   Command filtering available                                 |
+| filtering    |                                                               |
++--------------+---------------------------------------------------------------+
+| [2]          | * Full native card function                                   |
+| Functional   | * Only stateless functions                                    |
+| capabilities |                                                               |
++--------------+---------------------------------------------------------------+
+| [3] AP type  | * 10 (0x0a): CEX4                                             |
+|              | * 11 (0x0b): CEX5                                             |
+|              | * 12 (0x0c)  CEX6                                             |
+|              | * 13 (0x0d)  CEX7                                             |
+|              | * 14 (0x0e)  CEX8                                             |
++--------------+---------------------------------------------------------------+
 
-         (QEMU) device-add "vfio-ap,\
-         sysfsdev=/sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804,\
-         id=hostdev0"
++-----------------------------------------------------------------------------+
+| Table Keys                                                                  |
++=============================================================================+
+|                                                                             |
+| [1]        The hardware capability must be the same for both the source     |
+|            and destination queue device.                                    |
+|                                                                             |
+| [2]        The source and destination queues must either both have          |
+|            full native card function or both have stateless functions.      |
+|            If the functional capabilities don't match, then the source      |
+|            queue can have stateless capabilities since full native card     |
+|            function can handle stateless functions; otherwise, migration    |
+|            will fail.                                                       |
+|                                                                             |
+| [3]        The AP type on the source and destination guests can             |
+|            differ if the queue passed through to the target guest is a      |
+|            newer model (backwards compatible)                               |
++--------------+--------------------------------------------------------------+
+
+* To verify the hardware capabilities are compatible:
+
+  * On both the source and destination hosts, display the hardware capabilities
+    for each AP adapter in the AP configuration for that host::
+
+       cat /sys/bus/ap/devices/card$APID/ap_functions
+
+    .. note::
+       The ``$APID`` is the two-character adapter number in hexidecimal format;
+       for example, card02 or card1f. The ``/sys/bus/ap/devices`` directory
+       also lists the APQNs of the queue devices installed in the respective
+       host system with the first two characters being the APID.
+
+  * Verify the hardware capabilities for each AP adapter device on the source
+    and destination host are compatible. The ``ap_functions`` attribute is a
+    bitmask. The bits in the mask read from left to right starting with bit 0.
+    Each bit that is set to one indicates the corresponding hardware capability
+    is installed:
+
+    * Bits 0-3 are the facilities bits. Each bit value must match for the AP
+      devices on the source and destination systems. The values indicate the
+      following:
+      * bit-0: APSC is installed
+      * bit-1: AP4KM is installed
+      * bit-2: AP4KC is installed
+
+    * Bits 3-5 specify the adapter Modes. Only one of these bits will be set to
+      one and must be the same for both the source and destination adapter
+      devices:
+      * bit-3: CCA-mode
+      * bit-4: Accelerator-mode
+      * bit-5: XCP-mode (EP11)
+
+    * Bit 6 specifies whether APXA is installed and must be the same for both
+      the source and destination adapter devices.
+
+    * Bit 7 specifies command whether command filtering is installed
+      and must be the same for both the source and destination adapter devices.
+
+    * Bits 8-15 are the classification bits. There are only two relevant
+      bits and only one of them will be set to one. For the source and destination
+      adapter devices to be considered compatible:
+
+      * Bit 8 may be set to 1 on both hosts (full native card function)
+      * Bit 9 may be set to 1 on both hosts (only stateless functions available)
+      * Bit 9 may be set to 1 on the source host and bit 8 may be set to 1 on
+        the destination host
+
+    * Bits 16-17 are the binding state bits which must be 00
+
+* To verify the AP types are compatible:
+
+  * On both the source and destination hosts, display the hardware type
+    for each AP adapter in the AP configuration for that host to ensure the
+    source and destination adapter types are the same, or the source type is
+    less than the destination type::
+
+       cat /sys/bus/ap/devices/card$APID/hwtype
+
+    .. note::
+       The ``$APID`` is the two-character adapter number in hexidecimal format;
+       for example, card02 or card1f.
+
+Setting up for live guest migration on the destination host
+-----------------------------------------------------------
+To set up a host as the destination for live guest migration, do the
+following:
+
+Create a mediated device
+~~~~~~~~~~~~~~~~~~~~~~~~
+Create a mediated device with the same name (UUID) as the mediated device
+used to supply the AP configuration to the source guest. For example, if
+the mediated device on the source guest is named
+62177883-f1bb-47f0-914d-32a22e3a8804:
+
+.. code-block:: bash
+
+   echo 62177883-f1bb-47f0-914d-32a22e3a8804 > \
+     /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/create
+
+Reserve adapters and domains for the vfio_ap device driver's use
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Reserve the same adapters and domains passed through to the source guest
+for the vfio_ap device driver on the destination host by clearing the
+adapter numbers from the ``/sys/bus/ap/ap_mask`` and/or the domain numbers
+from the ``/sys/bus/ap/aqmask`` files.
+
+For example, suppose adapters 0, 20 (0x14) and 22 (0x16) as well as
+domains 51 (0x33) and 58 (0x3a) are passed through to the source guest. To
+ensure they can be passed through to the destination guest, they must be
+made available to the vfio_ap device driver. To make them available, do one
+or both of the following on the destination host:
+
+.. code-block:: bash
+
+   echo -0,-0x14,-22 > /sys/bus/ap/apmask
+   echo -0,-0x33,-0x3a > /sys/bus/ap/aqmask
+
+.. note::
+
+    * It is not necessary to reserve both the adapters and domains.
+      Reserving an adapter implicitly allows the vfio_ap driver to assign
+      each of the domains available on the system along with the reserved
+      adapters to a guest's AP configuration and vice versa.
+
+    * Reserving adapters and/or domains will result in binding the queue
+      devices referenced by the APQNs derived from the Cartesian product of
+      the adapters and domains made available to the vfio_ap device driver
+      with one caveat; an APQN does not necessarily have to reference a
+      queue device installed in the system in order to reserve it for the
+      vfio_ap device driver; however, if the APQN does not reference a
+      queue device installed on the destination host, migration will fail.
+
+    * It is not necessary to configure the destination mediated device with
+      adapters, domains and control domains because the source guest's AP
+      configuration will overlay the destination guest's during migration.
+
+    * To verify that the queue devices are reserved for the vfio_ap
+      device driver, issue the ``lszcrypt -V`` command and you should
+      see ``vfio_ap`` in the ``driver`` column of the output.
+
+Live guest migration failures due to AP configuration errors
+------------------------------------------------------------
+This section describes the errors that may occur during live guest migration
+when the AP configuration of the source guest and destination host are not
+compatible and where to look for problem determination.
+
+The destination host is missing the mediated device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This error occurs when a mediated device with the same name (UUID) as the
+mediated device being migrated has not been created on the destination host.
+
+**Source host**
+
++--------------+----------------------------------------------------------------+
+| Log          | Message                                                        |
++==============+================================================================+
+| Console log: | error: device not found: mediated device '$UUID' not           |
+|              | found                                                          |
++--------------+----------------------------------------------------------------+
+| QEMU log:    | initiating migration                                           |
+|              | qemu-system-s390x: Sibling indicated error 1                   |
++--------------+----------------------------------------------------------------+
+
+.. note::
+   $UUID is the UUID of the mediated device being migrated from the source host.
+
+
+One or more queues are not bound to the vfio_ap driver on the destination host
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The queue devices passed through to the source guest are not installed in the
+destination host or are not bound to its vfio_ap device driver.
+
+**Source host**
+
++--------------+----------------------------------------------------------------+
+| Log          | Message                                                        |
++==============+================================================================+
+| Console log: | error: operation failed: migration failed. Message from the    |
+|              | source host: operation failed: job 'migration out' failed:     |
+|              | Sibling indicated error 1. Message from the destination host:  |
+|              | operation failed: job 'migration in' failed: load of migration |
+|              | failed: No such device: Failed to load vmstate version_id: 1,  |
+|              | ret: -19                                                       |
++--------------+----------------------------------------------------------------+
+
+**Destinaton host**
+
++--------------+----------------------------------------------------------------+
+| Kernel log:  | vfio_ap_mdev $UUID: Queue $APID.$APQI not available to         |
+|              | vfio_ap driver on target host                                  |
++--------------+----------------------------------------------------------------+
+| QEMU log:    | shutting down, reason=failed                                   |
+|              | qemu-system-s390x: terminating on signal $SIGNAL_NUM from      |
+|              | pid $PID $DAEMON                                               |
++--------------+----------------------------------------------------------------+
+
+
+.. note::
+   * $UUID is the UUID of the mediated device being migrated from the source host.
+   * $APID.$APQI is adapter number and queue index (domain number) comprising the
+     $APQN (for example, 00.0033) of the queue device that is not available.
+   * $SIGNAL_NUM is the signal number that caused the QEMU process to terminate.
+   * $PID is the process ID of the QEMU process on the destination host.
+   * $DAEMON is the name of the QEMU daemon process.
+   * This message will be logged for each queue for which this error is detected.
+
+Failure to get hardware information for a queue device on destination host
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The vfio_ap device driver on the destination host will execute an AP instruction
+to get the hardware information for a queue device to perform queue compatibility
+checks. The instruction can fail for a number of reasons in which case the
+migration will be terminated.
+
+**Source host**
+
++--------------+----------------------------------------------------------------+
+| Log          | Message                                                        |
++==============+================================================================+
+| Console log: | error: operation failed: migration failed. Message from the    |
+|              | source host: operation failed: job 'migration out' failed:     |
+|              | Sibling indicated error 1. Message from the destination host:  |
+|              | operation failed: job 'migration in' failed: load of migration |
+|              | failed: failed to get hardware information for queue device    |
+|              | $APQN                                                          |
++--------------+----------------------------------------------------------------+
+
+**Destination host**
+
++--------------+----------------------------------------------------------------+
+| Log          | Message                                                        |
++==============+================================================================+
+| Console log: | vfio_ap_mdev $UUID: migration failed: Failed to get hwinfo for |
+|              | queue $APQN on target host: rc=$RESPONSE-CODE"                 |
++--------------+----------------------------------------------------------------+
+| QEMU log:    | shutting down, reason=failed                                   |
+|              | qemu-system-s390x: terminating on signal $SIGNAL-ID from pid   |
+|              | $PID $DAEMON                                                   |
++--------------+----------------------------------------------------------------+
+
+.. note::
+   * $UUID is the UUID of the mediated device being migrated from the source host.
+   * $APQN (for example, 00.0033) of the queue device that is not compatible.
+   * $RESPONSE_CODE is the response code from the AP instruction.
+   * $SIGNAL_NUM is the signal number of the signal that caused the QEMU process
+     to terminate.
+   * $PID is the process ID of the QEMU process on the destination host.
+   * $DAEMON is the name of the QEMU daemon process.
+   * This message will be logged for each queue for which this error is detected.
+
+The AP configurations of the source guest and destination host not incompatible
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The functional capabilities or facilities available on one or more of the queues
+passed through to the source guest are not compatible with the queue device with
+the same APQN on the destination system (see the Hardware Capabilities table above)
+
+**Source host**
+
++--------------+----------------------------------------------------------------+
+| Log          | Message                                                        |
++==============+================================================================+
+| Console log: | error: operation failed: migration failed. Message from the    |
+|              | source host: operation failed: job 'migration out' failed:     |
+|              | Sibling indicated error 1. Message from the destination host:  |
+|              | operation failed: job 'migration in' failed: load of migration |
+|              | failed: No such device: Failed to load vmstate version_id: 1,  |
+|              | ret: -19                                                       |
++--------------+----------------------------------------------------------------+
+| Kernel log:  | N/A                                                            |
++--------------+----------------------------------------------------------------+
+| QEMU log:    | *initiating migration*                                         |
+|              |                                                                |
+|              | *qemu-system-s390x: Sibling indicated error 1*                 |
++--------------+----------------------------------------------------------------+
+
+**Destination host**
+
++--------------+----------------------------------------------------------------+
+| Log          | Message                                                        |
++==============+================================================================+
+| Console log: | N/A                                                            |
++--------------+----------------------------------------------------------------+
+| Kernel log:  | *vfio_ap_mdev $UUID: Migration failed: Source and target       |
+|              | queue ($APQN) not compatible*                                  |
+|              |                                                                |
+|              | The message above will be followed by one or more messages     |
+|              | enumerating the incompatible features; for example:            |
+|              |                                                                |
+|              | ``vfio_ap_mdev $UUID: APSC facility installed in source queue  |
+|              | $APQN``                                                        |
+|              | ``vfio_ap_mdev $UUID: APSC facility not installed in target    |
+|              | queue $APQN``                                                  |
+|              |                                                                |
+|              | ``AP type of source ($APTYPE1) not compatible with target      |
+|              | ($APTYPE2)`` ...                                               |
++--------------+----------------------------------------------------------------+
+| QEMU log:    | *initiating migration*                                         |
+|              |                                                                |
+|              | *qemu-system-s390x: error while loading state section id ...*  |
+|              |                                                                |
+|              | *shutting down, reason=failed*                                 |
+|              |                                                                |
+|              | *terminating on signal $SIGNAL-ID from pid $PID $DAEMON*       |
++--------------+----------------------------------------------------------------+
+
+.. note::
+   * $UUID is the UUID of the mediated device being migrated from the source host.
+   * $APQN (for example, 00.0033) of the queue device that is incompatible.
+   * $APTYPE1 is the type of the source queue device.
+   * $APTYPE2 is the type of the target queue device.
+   * $SIGNAL-ID is the signal number of the signal that caused the QEMU process
+     to terminate.
+   * $PROCESS-ID is the process ID of the QEMU process on the source host.
+   * $PID is the process ID of the QEMU process on the destination host.
+   * $DAEMON is the name of the QEMU daemon process.
+   * Each follow-on message logging the incompatibility will be logged for each
+     error detected for the specified queue device.
+
+AP Configuration Management
+---------------------------
+The AP configurations of the source guest and destination host must be kept
+in synchronization or live guest migration will likely fail due to potential
+incompatibilities introduced by such changes. In particular, changing adapter
+or domain reservations via the sysfs ``apmask`` or ``aqmask`` attributes on
+either the source or destination host without coordinating such changes between
+the two hosts -especially while a migration is taking place - can result in
+migration failures.
+
+Configuration stability is an orchestration-layer or system administrator
+responsibility, which is consistent with other VFIO device types. The vfio_ap
+device driver will validate source and destination configurations and provide
+clear diagnostics when incompatibilities are detected, enabling orchestration
+tools to implement appropriate policies; for example, blocking migration when
+such changes are to be made.
+
+Master Key administration
+--------------------------
+It is imperative that s390 Common Cryptographic Architecture (CCA) master key
+administration be performed on both the source and destination AP
+devices to synchronize the key values prior to allowing live guest
+migration. If the master keys do not match, then crypto applications that
+rely on secure keys wrapped by a CCA master key will fail when the guest on
+which they are running is migrated to the destination host. Again, this is
+an orchestration-layer or system administrator responsibility and migration must
+be blocked while master key administration is being performed.
-- 
2.53.0

