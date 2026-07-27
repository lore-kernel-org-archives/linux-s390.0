Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71343BDCC;
	Mon, 27 Jul 2026 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173602; cv=none; b=ac4SzINpUxFwyJLoFtrf3DKZ6xqQ3Hf5eW6sStCHrtO5Uq7N5Ksq1jGPA9PI9q7oA/Telmpp7EDG/76txio4ZpiNga7wjOIwLhQdRFqF+V8c+QZXG/ZtJK892tdSDkvJTOddYgagjkH+hxpb6cbL0Ywo8QfupobNx+cti+6bm8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173602; c=relaxed/simple;
	bh=lHAAwkMu4ySYnvbvcYOQDayqZmqSLiSH+6AtILrug28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhIMMR1j2qplbeVz8vxLEnYRiQ2JqZWCI6qluwf4hXipHyZ8+4kDQw999rq9VDXV8OZTmGWJvAtCD/DYRhEp1kdvpAo8pC3OvYT1l9jOa+Grtn+gIJlMoHw0hc5RlrE81otcZIpfg45WTsAGEZkCkC3YGFwhL6KWbNtjOEhuZlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U8mt9Mii; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U8mt9Mii"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmhOs2373177;
	Mon, 27 Jul 2026 17:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2bFwZwBmncIqk/Zef
	+MNjgmkis/BeEwp+wkQfIRG6Hg=; b=U8mt9MiiRyjcZ7XrgF9+FAverktdQD5c3
	d4lPS1NX/sgyERSvndkQLRR0WWGBj4ZRouJubK7ezKjVKgBPhzcCrSnWffirxYEq
	NiHHL6tHT+xluE0QHKW3J/XNrKWxk9l1sSKCpAbZhXNMVm//Uf4Ojm2cHv0s2iUJ
	QmsSMCWZenNWYgMCHb1F5NTuSeB3bUR+omb2nTrG2KCU0YJ/5pX9sePCy7OTXBsj
	2EGrh1IRRThRpeXfPwc1w3uyDddPA19hybuG9uCSaboG+6/QY9GPvVC12954BqUs
	Q4HMrHhf7HD15tizigTiGz4yPtrKClUZVNbpDeQWCd1dBciWWpKPQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw79a1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:33:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQFFj026639;
	Mon, 27 Jul 2026 17:33:12 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq6gwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:33:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHXAjd26673792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:33:10 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3661C58058;
	Mon, 27 Jul 2026 17:33:10 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7978558059;
	Mon, 27 Jul 2026 17:33:08 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:33:08 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 15/15] s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst
Date: Mon, 27 Jul 2026 13:32:39 -0400
Message-ID: <20260727173239.2420754-16-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: iml2S4WxXcoq62KviCY3ttjMEII26x_z
X-Proofpoint-ORIG-GUID: iml2S4WxXcoq62KviCY3ttjMEII26x_z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX/V1Vh6Lah994
 CRiFykL/kNHEEjtCw1DB8OVFL/FmvshtWwh8OdLe7k/bXtZNyLyENPsm9rddcM7v9HdBmgpI5nT
 xROqXHE6FVF/8wKXCnyWFEVHMPIIhsuFdxzKsapioHYJmSlpzx4Xy7dbBhvLdDQkq4EWxtbEd8W
 yUtOogp4LAYh7KkxtvSXEDMlGgSCmhbmkzUmd3C2OTD426DdeCtkRS/XO+I+ooIKkfnjj4wwIoX
 aYwKtpIhKMK2gvMv2DnkKvX7CjgVjgLoUws89hmW5LthbZkQXR5HrA4HDpehaLbPKJTFzOjUA2b
 hQr8eSfDuIXTfiiXYpIlpkhU6coqt7mjLK6lK0j2W86pCjTk7td/7soXFJ7Mp3Bw6UXbX6wDLuB
 8X21fUCQLNv9vQTC54tDMvk4vbeeD53vN4H3YHz7whTAxjRrtIFQZ5nCR6ASgTggu1QCNy3zZxB
 eYbIQ0UAleB+EPJHGHw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a679658 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=eqVRqZzbwv3K9eCZ3BEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX0Ahcyctu58X/
 uO424fI+pCAgaMXE8fsoXfL/ob6641vRdaTLcLoZfUr5lGI1wyiY4jSwhu8+qEdrkru5LydBRfX
 6g9/fJMWOOTmyDNk092f4GAMDPPfKsU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270160

Add a 'Live Guest Migration' chapter to the
Documentation/arch/s390/vfio-ap.rst document to describe the details for
initiating live guest migration for a guest to which AP adapters, domains
and control domains have been passed through.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 Documentation/arch/s390/vfio-ap.rst | 616 +++++++++++++++++++++++-----
 1 file changed, 517 insertions(+), 99 deletions(-)

diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
index ac0c07f76ddd..02d7cbe5e479 100644
--- a/Documentation/arch/s390/vfio-ap.rst
+++ b/Documentation/arch/s390/vfio-ap.rst
@@ -1012,7 +1012,7 @@ guest_matrix dyn ap_config
 
 the following features are advertised:
 
----------------+---------------------------------------------------------------+
++--------------+---------------------------------------------------------------+
 | Flag         | Description                                                   |
 +==============+===============================================================+
 | guest_matrix | guest_matrix attribute exists. It reports the matrix of       |
@@ -1021,105 +1021,523 @@ the following features are advertised:
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
-
-      For example, to hot plug the vfio_ap mediated device
-      62177883-f1bb-47f0-914d-32a22e3a8804 into the guest named 'my-guest' with
-      device-id hostdev0:
-
-      virsh qemu-monitor-command my-guest --hmp \
-      "device_add vfio-ap,\
-      sysfsdev=/sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804,\
-      id=hostdev0"
-
-2. A vfio_ap mediated device can be hot plugged by attaching the qemu monitor
-   to the guest and using the following qemu monitor command:
-
-      (qemu) device_add "vfio-ap,sysfsdev=<path-to-mdev>,id=<device-id>"
-
-      For example, to plug the vfio_ap mediated device
-      62177883-f1bb-47f0-914d-32a22e3a8804 into the guest with the device-id
-      hostdev0:
+Live Guest Migration
+====================
+The VFIO AP mediated device is not used to provide userspace with direct
+access to device memory as is the case with other devices that use the VFIO
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
 
-         (QEMU) device-add "vfio-ap,\
-         sysfsdev=/sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804,\
-         id=hostdev0"
+To be considered compatible, the AP configuration for the destination host must
+meet these requirements:
+
+* Each AP adapter, domain and control domain number assigned to the source
+  guest's AP configuration must be in the destination host's AP
+  configuration. This can be verified as follows:
+
+  * On the source host, display the AP configuration of the source guest
+    with the following two commands:
+
+    .. code-block:: bash
+
+       cat /sys/devices/vfio_ap/matrix/$UUID/guest_matrix
+       cat /sys/devices/vfio_ap/matrix/$UUID/control_domains
+
+    .. note::
+       Replace ``$UUID`` with the actual UUID of your mediated device.
+
+       The ``guest_matrix`` lists the APQNs of the queue devices assigned
+       to the mediated device; for example:
+
+       .. code-block:: bash
+
+          00.0033
+          00.003a
+
+       The ``control_domains`` lists the domain numbers of the control
+       domains; for example:
+
+       .. code-block:: bash
+
+          0033
+          003a
+
+  * Display the AP configuration of the destination host with the following
+    two commands:
+
+    .. code-block:: bash
+
+       lszcrypt -V
+       cat /sys/bus/ap/ap_control_domain_mask
+
+    .. note::
+       The ``lszcrypt -V`` command lists the AP cards (adapters) and queue
+       devices on the host system; for example:
+
+       .. code-block:: bash
+
+          =========== ===== ============ ==========
+          CARD.DOMAIN TYPE  MODE         DRIVER
+          =========== ===== ============ ==========
+          00          CEX5C CCA-Coproc   cex4card
+          00.0033     CEX5C CCA-Coproc   vfio_ap
+          00.003a     CEX5C CCA-Coproc   vfio_ap
+          =========== ===== ============ ==========
+
+       Each bit in the ap_control_domain_mask corresponds to
+       domain numbers 0-255. If a bit is set to one, then
+       the control domain is available on the source host. For
+       example:
+
+       .. code-block:: bash
+
+          0x0000000000001020000000000000000000000000000000000000000000000000
+
+       This mask indicates that AP control domains 51 (0x33) and 58 (0x3a) are
+       in the AP configuration of the host system.
+
+  * Verify the configurations:
+
+    * Each APQN in the guest's sysfs ``guest_matrix`` file must match an
+      APQN returned from the ``lszcrypt -V`` command on the destination host. It
+      is important to note the driver to which the queue is bound which
+      is displayed in the ``driver`` column. Queues not bound to the vfio_ap
+      driver are not available to the destination guest. Even if the APQNs are
+      available to the driver, that does not guarantee they can be used by the
+      guest being migrated; for example, migration will fail if any of these APQNs
+      are assigned to a mediated device other than the one being migrated.
+
+    * Each domain number from the source guest's sysfs
+      ``control_domains`` attribute must correspond to a bit set to one in
+      the destination host's ``ap_control_domain_mask``.
+
+
+* Each APQN assigned to the source guest and destination guest must
+  reference a queue device with compatible hardware capabilities:
+
+  +--------------+---------------------------------------------------------------+
+  | Hardware     | Description                                                   |
+  | Capabilities |                                                               |
+  +==============+===============================================================+
+  | [1]          | * AP special command facility (APSC)                          |
+  | Facilities   | * AP 4096-bit ME PKU commands facility (AP4KM)                |
+  |              | * AP 4096-bit CRT PKU commands (AP4KC)                        |
+  +--------------+---------------------------------------------------------------+
+  | [1] Mode     | * CCA-mode                                                    |
+  |              | * Accelerator-mode                                            |
+  |              | * XCP-mode (EP11)                                             |
+  +--------------+---------------------------------------------------------------+
+  | [1] AP       |   APXA installed                                              |
+  | extended     |                                                               |
+  | addressing   |                                                               |
+  +--------------+---------------------------------------------------------------+
+  | [1] Command  |   Command filtering available                                 |
+  | filtering    |                                                               |
+  +--------------+---------------------------------------------------------------+
+  | [2]          | * Full native card function                                   |
+  | Functional   | * Only stateless functions                                    |
+  | capabilities |                                                               |
+  +--------------+---------------------------------------------------------------+
+  | [3] AP type  | * 10 (0x0a): CEX4                                             |
+  |              | * 11 (0x0b): CEX5                                             |
+  |              | * 12 (0x0c)  CEX6                                             |
+  |              | * 13 (0x0d)  CEX7                                             |
+  |              | * 14 (0x0e)  CEX8                                             |
+  +--------------+---------------------------------------------------------------+
+
+  +-----------------------------------------------------------------------------+
+  | Table Keys                                                                  |
+  +=============================================================================+
+  |                                                                             |
+  | [1]        The hardware capability must be the same for both the source     |
+  |            and destination queue device.                                    |
+  |                                                                             |
+  | [2]        The source and destination queues must either both have          |
+  |            full native card function or both have stateless functions.      |
+  |            If the functional capabilities don't match, then the source      |
+  |            queue can have stateless capabilities since full native card     |
+  |            function can handle stateless functions; otherwise, migration    |
+  |            will fail.                                                       |
+  |                                                                             |
+  | [3]        The AP type on the source and destination guests can             |
+  |            differ if the queue passed through to the target guest is a      |
+  |            newer model (backwards compatible)                               |
+  +-----------------------------------------------------------------------------+
+
+  * To verify the hardware capabilities are compatible:
+
+    * On both the source and destination hosts, display the hardware capabilities
+      for each AP adapter in the AP configuration for that host:
+
+      .. code-block:: bash
+
+         cat /sys/bus/ap/devices/card$APID/ap_functions
+
+      .. note::
+         The ``$APID`` is the two-character adapter number in hexadecimal format;
+         for example, ``card02`` or ``card1f``. The ``/sys/bus/ap/devices`` directory
+         also lists the APQNs of the queue devices installed in the respective
+         host system with the first two characters being the APID; for example:
+         ``02.0004`` or ``00.0033`` .
+
+    * Verify the hardware capabilities for each AP adapter device on the source
+      and destination host are compatible. The ``ap_functions`` attribute is a
+      bitmask. The bits in the mask read from left to right starting with bit 0.
+      Each bit that is set to one indicates the corresponding hardware capability
+      is installed:
+
+      * Bits 0-2 are the facilities bits. Each bit value must match for the AP
+        devices on the source and destination systems. The values indicate the
+        following:
+
+        * bit-0: APSC is installed
+        * bit-1: AP4KM is installed
+        * bit-2: AP4KC is installed
+
+      * Bits 3-5 specify the adapter Modes. Only one of these bits will be set to
+        one and must be the same for both the source and destination adapter
+        devices:
+
+        * bit-3: CCA-mode
+        * bit-4: Accelerator-mode
+        * bit-5: XCP-mode (EP11)
+
+      * Bit 6 specifies whether APXA is installed and must be the same for both
+        the source and destination adapter devices.
+
+      * Bit 7 specifies whether command filtering is installed
+        and must be the same for both the source and destination adapter devices.
+
+      * Bits 8-15 are the classification bits. There are only two relevant
+        bits and only one of them will be set to one. For the source and destination
+        adapter devices to be considered compatible:
+
+        * Bit 8 may be set to 1 on both hosts (full native card function)
+        * Bit 9 may be set to 1 on both hosts (only stateless functions available)
+        * Bit 9 may be set to 1 on the source host and bit 8 may be set to 1 on
+          the destination host
+
+      * Bits 16-17 are the binding state bits which must be 00
+
+  * To verify the AP types are compatible:
+
+    * On both the source and destination hosts, display the hardware type
+      for each AP adapter in the AP configuration for that host to ensure the
+      source and destination adapter types are the same, or the source type is
+      less than the destination type::
+
+       cat /sys/bus/ap/devices/card$APID/hwtype
+
+      .. note::
+         The ``$APID`` is the two-character adapter number in hexadecimal format;
+         for example, ``card02`` or ``card1f``.
+
+Setting up for live guest migration on the destination host
+-----------------------------------------------------------
+To set up a host as the destination for live guest migration, do the
+following:
+
+1. Create a mediated device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+2. Reserve adapters and domains for the vfio_ap device driver's use
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Reserve the same adapters, and domains passed through to the source guest
+for the vfio_ap device driver on the destination host by clearing the
+adapter numbers from the ``/sys/bus/ap/apmask`` and/or the domain numbers
+from the ``/sys/bus/ap/aqmask`` files.
+
+For example, suppose adapters 0, 20 (0x14) and 22 (0x16) as well as
+domains 51 (0x33) and 58 (0x3a) are passed through to the source guest. To
+ensure they can be passed through to the destination guest, they must be
+made available to the vfio_ap device driver on the destination host. To
+make them available, do one or both of the following on the destination host:
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
+    * The Cartesian product of the adapters and domains reserved for the
+      vfio_ap device driver identifies the APQNs of the AP queue devices to be
+      bound to the vfio_ap device driver. If an APQN does not reference a
+      queue device installed in the system at the time of live guest migration,
+      the migration will fail.
+
+    * It is not necessary to configure the destination mediated device with
+      adapters, domains and control domains because the source guest's AP
+      configuration will overlay the destination guest's during migration.
+
+    * To verify that the queue devices are reserved for the vfio_ap
+      device driver, issue the ``lszcrypt -V`` command and you should
+      see ``vfio_ap`` in the ``DRIVER`` column of the output.
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
+**Destination host**
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
+One or more control domains are not available on the destination host
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The control domains passed through to the source guest are not installed on the
+destination host.
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
+**Destination host**
+
++--------------+----------------------------------------------------------------+
+| Kernel log:  | vfio_ap_mdev $UUID: Control domain $DOMAIN_NUM not available   |
+|              | on the destination host                                        |
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
+|              | queue $APQN on target host: rc=$RESPONSE-CODE                  |
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
+The AP configurations of the source guest and destination host not compatible
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

