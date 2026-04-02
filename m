Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3B31F99E;
	Thu,  2 Apr 2026 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162119; cv=none; b=BqCVJEEdJFbPSQzQ9kE7tLRBWVZq4psnhWqXEXD9TXNV+svF8Rvs5JbTlEaxMxg/Hgp/Zqvy6iLCFeWrhojmEneet51kR6Xn/hHhZjKofAWC/1oev5KjYbfkOAN0DX6vXnRhkhnf7SsutH1j7nxsOI5bFgvd0HcUwKJQ7jMS+kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162119; c=relaxed/simple;
	bh=ZPeJMSL8ZluFfuH3mW+V/JFCdnUlTkPcHpFahh2C+DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jslNdNJAUsBHOeohAWSbcFrGBtCF/EsmmJ7XaHHaTAdbUYJ069ZModsgNcNzB5EpqE8Eyx6iWr4ZeTrX9hde1txXjRUCZL75iwtEmHWBjuFgNxskFvGfxCRbDI/dxSceJ21oF3T8LaIs6vK/NvtwYVl4leCZnxBZHwqL6C47hc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C8bDglBw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C8bDglBw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BZfBF3065805;
	Thu, 2 Apr 2026 20:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gqpk4/
	68Zyh9d+Cg7ojDx5buqM2Vor0CLaPaDv8et8g=; b=C8bDglBwl0JaD+A4tCq17l
	2AtRej5UOJp2ExUpn6oya+Q8tXg/VVDQEaL6xdu8AYC+HFzG3/Sx3vOqN2NrjygP
	9J+9q7ATEa21B2jIOG3RfDC9K7X4b8gEzGZQcHi3A4YZGnLn4QpQ+91Vt5ESwi6t
	Zz/2fDQrRdGrC+nkHA8kuY33tnbWPA4KStpta30Zt4QVT22lGTKx2xhSDJv9d/JC
	miarHm8DrdCEHzIFFG89ySWJaNkB3fnNGFnhNrf5RzK/ERr2buxwff+dZbZsoKIV
	N2rAG5y7+pf2vwrluvc1pz4wwd5xZpaOkgzoeNe/375nSwEncsLgfSWfmt5vNMXQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcnm1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:35:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632KLtEL022271;
	Thu, 2 Apr 2026 20:35:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tanbkw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:35:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632KZCN533227378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 20:35:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A33558056;
	Thu,  2 Apr 2026 20:35:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF57958052;
	Thu,  2 Apr 2026 20:35:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 20:35:09 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 02 Apr 2026 22:34:58 +0200
Subject: [PATCH v6 1/2] docs: s390/pci: Improve and update PCI
 documentation
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-uid_slot-v6-1-d5ea0a14ddb9@linux.ibm.com>
References: <20260402-uid_slot-v6-0-d5ea0a14ddb9@linux.ibm.com>
In-Reply-To: <20260402-uid_slot-v6-0-d5ea0a14ddb9@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lukas Wunner <lukas@wunner.de>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Farhan Ali <alifm@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9648;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=ZPeJMSL8ZluFfuH3mW+V/JFCdnUlTkPcHpFahh2C+DU=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDLPXfpZNXmna2p9ll/+up7cHmO9evH0yrffEk5dZhNdc
 uxWRfjijlIWBjEuBlkxRZZFXc5+6wqmmO4J6u+AmcPKBDKEgYtTACayN5Xhf4bXrl13MpjD1T7r
 s8qsP32T/cKHHxd+l2/RLN/P5GxadJXhv88fac8vnx//n7DI7dqHT4mdL/5ErI78K7pP6czyA8V
 xnawA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ced303 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=9RhT33yZKghZxMFRiMMA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: _obrgsEcZda8ze3oH19EDyAN3OcM5esF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE4MSBTYWx0ZWRfX+MuIMSIqTRwn
 H5yM+mp67WbtSKdaxQkoqr4QVQJMFrMJ2qgmvnv9PRwSaTd/iTd21FP7mL4ikJB/OnvTWoMbZD/
 Zgj8QIkfjW3NI1nk78ATLSY6DYJInwfD4k2CUqLFCmuwNhgG2J6FUvAfkmWV1Or4D+6g0AsO13U
 BUtVESALtTP1PkqTg2KaNfvmCaeIpAWadSHjDpzYbfDeZD8s4bdURCHg4A4cKlFcDSCzTqQBY12
 N35PV6heVA+WBF6uAHD4f3fHyER2MSmXQ2PPt6hzm+NZIdOsCWaxXwyIr40njckbDL3Mbbl9ssd
 j7nxIvcR3oeTnFU76iKHyQUAIkUwSne7kmVXcZqllWn3uNcMLcJWJ0DbztuK2it6MJBToSUUViQ
 +0SyIPTa1+yQp8nJcWUJFc4URIy3imU/wpMnsU4IMIfvbJIaj0Bg5e0copJrxeG8uZSvHmrN6ez
 uIEnqDkr6BY1LHkNclw==
X-Proofpoint-ORIG-GUID: BFQPlAVFDiGvbn_4OQELYRFILLMbEF_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020181

Update the s390 specific PCI documentation to better reflect current
behavior and terms such as the handling of Isolated VFs via commit
25f39d3dcb48 ("s390/pci: Ignore RID for isolated VFs").

Add a descriptions for /sys/firmware/clp/uid_is_unique which was added
in commit b043a81ce3ee ("s390/pci: Expose firmware provided UID Checking
state in sysfs") but missed documentation.

Similarly add documentation for the fidparm attribute added by commit
99ad39306a62 ("s390/pci: Expose FIDPARM attribute in sysfs") and
add a list of pft values and their names.

Finally improve formatting of the different attribute descriptions by
adding a separating colon.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 Documentation/arch/s390/pci.rst | 139 +++++++++++++++++++++++++++-------------
 1 file changed, 94 insertions(+), 45 deletions(-)

diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/pci.rst
index d5755484d8e75c7bf67a350e61bbe04f0452a2fa..31c24ed5506f1fc07f89821f67a814118514f441 100644
--- a/Documentation/arch/s390/pci.rst
+++ b/Documentation/arch/s390/pci.rst
@@ -6,6 +6,7 @@ S/390 PCI
 
 Authors:
         - Pierre Morel
+        - Niklas Schnelle
 
 Copyright, IBM Corp. 2020
 
@@ -27,7 +28,8 @@ Command line parameters
 debugfs entries
 ---------------
 
-The S/390 debug feature (s390dbf) generates views to hold various debug results in sysfs directories of the form:
+The S/390 debug feature (s390dbf) generates views to hold various debug results
+in sysfs directories of the form:
 
  * /sys/kernel/debug/s390dbf/pci_*/
 
@@ -47,87 +49,134 @@ Sysfs entries
 
 Entries specific to zPCI functions and entries that hold zPCI information.
 
-* /sys/bus/pci/slots/XXXXXXXX
+* /sys/bus/pci/slots/XXXXXXXX:
 
-  The slot entries are set up using the function identifier (FID) of the
-  PCI function. The format depicted as XXXXXXXX above is 8 hexadecimal digits
-  with 0 padding and lower case hexadecimal digits.
+  The slot entries are set up using the function identifier (FID) of the PCI
+  function as slot name. The format depicted as XXXXXXXX above is 8 hexadecimal
+  digits with 0 padding and lower case hexadecimal digits.
 
   - /sys/bus/pci/slots/XXXXXXXX/power
 
   A physical function that currently supports a virtual function cannot be
   powered off until all virtual functions are removed with:
-  echo 0 > /sys/bus/pci/devices/XXXX:XX:XX.X/sriov_numvf
+  echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvf
 
-* /sys/bus/pci/devices/XXXX:XX:XX.X/
+* /sys/bus/pci/devices/DDDD:BB:dd.f/:
 
-  - function_id
-    A zPCI function identifier that uniquely identifies the function in the Z server.
+  - function_id:
+    The zPCI function identifier (FID) is a 32 bit hexadecimal value that
+    uniquely identifies the PCI function. Unless the hypervisor provides
+    a virtual FID e.g. on KVM this identifier is unique across the machine even
+    between different partitions.
 
-  - function_handle
-    Low-level identifier used for a configured PCI function.
-    It might be useful for debugging.
+  - function_handle:
+    This 32 bit hexadecimal value is a low-level identifier used for a PCI
+    function. Note that the function handle may be changed and become invalid
+    on PCI events and when enabling/disabling the PCI function.
 
-  - pchid
-    Model-dependent location of the I/O adapter.
+  - pchid:
+    This 16 bit hexadecimal value encodes a model-dependent location for
+    the PCI function.
 
-  - pfgid
+  - pfgid:
     PCI function group ID, functions that share identical functionality
     use a common identifier.
     A PCI group defines interrupts, IOMMU, IOTLB, and DMA specifics.
 
-  - vfn
+  - vfn:
     The virtual function number, from 1 to N for virtual functions,
     0 for physical functions.
 
-  - pft
-    The PCI function type
+  - pft:
+    The PCI function type is an s390 specific type attribute. It indicates
+    a more general, usage oriented, type than PCI Specification
+    class/vendor/device identifiers. That is PCI functions with the same pft
+    value may be backed by different hardware implementations. At the same time
+    apart from unclassified functions (pft is 0x00) the same pft value
+    generally implies a similar usage model. At the same time the same
+    PCI hardware device may appear with different pft values when in a
+    different usage model. For example NETD and NETH VFs may be implemented
+    by the same PCI hardware device but in NETD the parent Physical Function
+    is user managed while with NETH it is platform managed.
 
-  - port
-    The port corresponds to the physical port the function is attached to.
-    It also gives an indication of the physical function a virtual function
-    is attached to.
+    Currently the following PFT values are defined:
 
-  - uid
-    The user identifier (UID) may be defined as part of the machine
-    configuration or the z/VM or KVM guest configuration. If the accompanying
-    uid_is_unique attribute is 1 the platform guarantees that the UID is unique
-    within that instance and no devices with the same UID can be attached
-    during the lifetime of the system.
+    - 0x00 (UNC): Unclassified
+    - 0x02 (ROCE): RoCE Express
+    - 0x05 (ISM): Internal Shared Memory
+    - 0x0a (ROC2): RoCE Express 2
+    - 0x0b (NVMe): NVMe
+    - 0x0c (NETH): Network Express hybrid
+    - 0x0d (CNW): Cloud Network Adapter
+    - 0x0f (NETD): Network Express direct
 
-  - uid_is_unique
-    Indicates whether the user identifier (UID) is guaranteed to be and remain
-    unique within this Linux instance.
+  - port:
+    The port is a decimal value corresponding to the physical port the function
+    is attached to. Virtual Functions (VFs) share the port with their parent
+    Physical Function (PF). A value of 0 indicates that the port attribute is
+    not applicable for that PCI function type.
 
-  - pfip/segmentX
+  - uid:
+    The user-defined identifier (UID) for a PCI function is a 32 bit
+    hexadecimal value. It is defined on a per instance basis as part of the
+    partition, KVM guest, or z/VM guest configuration. If UID Checking is
+    enabled the platform ensures that the UID is unique within that instance
+    and no two PCI functions with the same UID will be visible to the instance.
+
+    Independent of this guarantee and unlike the function ID (FID) the UID may
+    be the same in different partitions within the same machine. This allows to
+    create PCI configurations in multiple partitions to be identical in the
+    UID-namespace.
+
+  - uid_is_unique:
+    A 0 or 1 flag indicating whether the user-defined identifier (UID) is
+    guaranteed to be and remain unique within this Linux instance. This
+    platform feature is called UID Checking.
+
+  - pfip/segmentX:
     The segments determine the isolation of a function.
     They correspond to the physical path to the function.
     The more the segments are different, the more the functions are isolated.
 
+  - fidparm:
+    Contains an 8 bit per PCI function parameter field in hexadecimal provided
+    by the platform. The meaning of this field is PCI function type specific.
+    For NETH VFs a value of 0x01 indicates that the function supports
+    promiscuous mode.
+
+* /sys/firmware/clp/uid_is_unique:
+
+  In addition to the per-device uid_is_unique attribute this presents a
+  global indication of whether UID Checking is enabled. This allows users
+  to check for UID Checking even when no PCI functions are configured.
+
 Enumeration and hotplug
 =======================
 
 The PCI address consists of four parts: domain, bus, device and function,
-and is of this form: DDDD:BB:dd.f
+and is of this form: DDDD:BB:dd.f.
 
-* When not using multi-functions (norid is set, or the firmware does not
-  support multi-functions):
+* For a PCI function for which the platform does not expose the RID, the
+  pci=norid kernel parameter is used, or a so called isolated Virtual Function
+  which does have RID information but is used without its parent Physical
+  Function being part of the same PCI configuration:
 
   - There is only one function per domain.
 
-  - The domain is set from the zPCI function's UID as defined during the
-    LPAR creation.
+  - The domain is set from the zPCI function's UID if UID Checking is on
+    otherwise the domain ID is generated dynamically and is not stable
+    across reboots or hot plug.
 
-* When using multi-functions (norid parameter is not set),
-  zPCI functions are addressed differently:
+* For a PCI function for which the platform exposes the RID and which
+  is not an Isolated Virtual Function:
 
   - There is still only one bus per domain.
 
-  - There can be up to 256 functions per bus.
+  - There can be up to 256 PCI functions per bus.
 
-  - The domain part of the address of all functions for
-    a multi-Function device is set from the zPCI function's UID as defined
-    in the LPAR creation for the function zero.
+  - The domain part of the address of all functions within the same topology is
+    that of the configured PCI function with the lowest devfn within that
+    topology.
 
-  - New functions will only be ready for use after the function zero
-    (the function with devfn 0) has been enumerated.
+  - Virtual Functions generated by an SR-IOV capable Physical Function only
+    become visible once SR-IOV is enabled.

-- 
2.51.0

