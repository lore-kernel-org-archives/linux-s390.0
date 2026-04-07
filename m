Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0263E3B8BBB;
	Tue,  7 Apr 2026 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568309; cv=none; b=FG1KOFw6ypkj/h01V0URWyZlCJYjqBBL70W/cxX/5uYrk5Cl+FTOodRRIUJtjo2ZElNlKKMdWnunhSA2dTf6xnBiIKXyv6T0dof/8OeTpQfehF8CBnQEwDhmJF+OXeWqTx5c1RwpCgzhYosSTnSH6rrn4yPemXCtDT17BdWfpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568309; c=relaxed/simple;
	bh=O/1yfVXRBs+oyvm0+6VCCBj24N7Sl/Wrs7hNpLylzHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4AIMD2Xij1aiCFVhE/Z30M6VQfEf+wAcYcHHWeXOqkWyawU39x7HDSN4fXKhUkgD1GjTtqWc60TONPyXjpIM26vz8PI5o5W95CBWL3X0Tyg0aPfnitYz7b3McpYP+x9iEXm6Mt5Krdh15TR1uj1wXBFNXLOPhXr3fxO9Uf2Nl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hpX/fm4K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hpX/fm4K"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LlnCJ2297436;
	Tue, 7 Apr 2026 13:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OQX9xy
	0dseiFPGRnHRX8PrciEVvGdHCLqgmN6UtDDpw=; b=hpX/fm4KcklqWxvya/zZmw
	DUYUB/PIHxGRutkq1yTccmUo0kcA5m781GMn3II9MrVtJASAvCGc0NS4Zu3jzwUc
	QA4u4Rq9gafQsBRdkaRTEaxWjVOIn5Dt9dSRF1zl0V+04M+kT6/i5yQ8bHNcZNif
	dmHMdG7lA4X/0/tmUHltxz8GwSAWQn5TLb1unADFnEsck1FEtF+WPkCtynoX88GP
	LFXhR0EpJzOUDxFXfw3/sXzaqCgmOIGB29JkzRxdE19pee/HYfXSnAHzMTErVJ+0
	nSgQX30VZWg9GGOqZxbFLB9KpYruRU0P1z6CX8jhMOBTrAEkS1bzMdGuky9vnf0Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ftw0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:24:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BOm4Z007881;
	Tue, 7 Apr 2026 13:24:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2baaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:24:59 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637DOvZ931130126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 13:24:57 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60C745805A;
	Tue,  7 Apr 2026 13:24:57 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E40C58056;
	Tue,  7 Apr 2026 13:24:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 13:24:54 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 07 Apr 2026 15:24:45 +0200
Subject: [PATCH v8 1/2] docs: s390/pci: Improve and update PCI
 documentation
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-uid_slot-v8-1-15ae4409d2ce@linux.ibm.com>
References: <20260407-uid_slot-v8-0-15ae4409d2ce@linux.ibm.com>
In-Reply-To: <20260407-uid_slot-v8-0-15ae4409d2ce@linux.ibm.com>
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
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10292;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=O/1yfVXRBs+oyvm0+6VCCBj24N7Sl/Wrs7hNpLylzHc=;
 b=kA0DAAoW+x9tocCJ5FYByyZiAGnVBaHIDbf6iCsK3RvejsbTA9DtTmBGYfV5sLpG5SLsO9FrG
 4h1BAAWCgAdFiEEoopDTq5wlDW8Uo+I+x9tocCJ5FYFAmnVBaEACgkQ+x9tocCJ5Fa/3gD/cGZH
 Xa7LyEAtaf++RFX3ia/dTY/Hrpo5PMZuFK6qwPkA/09j1zdR3VmBGVpZ3aZUuCtI+HCqC6+ZceZ
 E/Mum7cgD
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d505ac cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=JfrnYn6hAAAA:8 a=TOD45aG0oo66aBzYHRIA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: w08_cbNC0HdW87aEDtVQaYDI_IAuQIVd
X-Proofpoint-GUID: BUYgZWeynwlWjU39dh8anUBtd_HXpNPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyNSBTYWx0ZWRfX/uKpAN4GXsdN
 MAjj/n0fPcTg/+fYm2OGZC87ZsktSwFg1vs6SmsLV3lW7UTcLBOIM4pPVcc1jlJ+iGT5suxnTvR
 DpRpiEofQ36558851UbLZM9/KWs0R/4oYHOGgpIuN3BMkh5hzigRqe/ze/agFCWOtq5XwO2ZoBy
 GXSFlZb4ojvWTj5rc3OtPsdc1EIaR3RLsEAVEjusPD2MoB+7CnRC+t05uG13vRD5v/pYf5qbSWq
 vbvsbHRXA/o718lCWYqk54MPrlY7Mli3kQTxOsV/QTNNmdcjrnJN6Pmb92fFORx6ZKyUtEjCEh2
 P2cI2/RcWLlNQfhCmJ2ND/Rp2cHv6Qydmzi/YzQDZ5TGFxFMDJ2A+MJQ7yS9dnrjXShQSs5Zq2K
 K6AcywmmigYXNcsD8PQCJ0mjLvIefB6nIfv1IYio0gyJ/ynWcQSdzOZRLGXhXW/xG75q3z4/Nwe
 EwBvXPYw/eAwepPUeTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070125

Update the s390 specific PCI documentation to better reflect current
behavior and terms such as the handling of Isolated VFs via commit
25f39d3dcb48 ("s390/pci: Ignore RID for isolated VFs").

Add a descriptions for /sys/firmware/clp/uid_checking which was added
in commit b043a81ce3ee ("s390/pci: Expose firmware provided UID Checking
state in sysfs") but missed documentation.

Similarly add documentation for the fidparm attribute added by commit
99ad39306a62 ("s390/pci: Expose FIDPARM attribute in sysfs") and
add a list of pft values and their names.

Finally improve formatting of the different attribute descriptions by
adding a separating colon.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 Documentation/arch/s390/pci.rst | 144 +++++++++++++++++++++++++++-------------
 1 file changed, 97 insertions(+), 47 deletions(-)

diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/pci.rst
index d5755484d8e75c7bf67a350e61bbe04f0452a2fa..c3476de4f03278d07099aa32cbea0f868b6e9c9c 100644
--- a/Documentation/arch/s390/pci.rst
+++ b/Documentation/arch/s390/pci.rst
@@ -6,6 +6,7 @@ S/390 PCI
 
 Authors:
         - Pierre Morel
+        - Niklas Schnelle
 
 Copyright, IBM Corp. 2020
 
@@ -27,14 +28,16 @@ Command line parameters
 debugfs entries
 ---------------
 
-The S/390 debug feature (s390dbf) generates views to hold various debug results in sysfs directories of the form:
+The S/390 debug feature (s390dbf) generates views to hold various debug results
+in sysfs directories of the form:
 
  * /sys/kernel/debug/s390dbf/pci_*/
 
 For example:
 
   - /sys/kernel/debug/s390dbf/pci_msg/sprintf
-    Holds messages from the processing of PCI events, like machine check handling
+
+    holds messages from the processing of PCI events, like machine check handling
     and setting of global functionality, like UID checking.
 
   Change the level of logging to be more or less verbose by piping
@@ -47,87 +50,134 @@ Sysfs entries
 
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
+    The zPCI function identifier (FID) is a 32-bit hexadecimal value that
+    uniquely identifies the PCI function. Unless the hypervisor provides
+    a virtual FID e.g. on KVM this identifier is unique across the machine even
+    between different partitions.
 
-  - function_handle
-    Low-level identifier used for a configured PCI function.
-    It might be useful for debugging.
+  - function_handle:
+    This 32-bit hexadecimal value is a low-level identifier used for a PCI
+    function. Note that the function handle may be changed and become invalid
+    on PCI events and when enabling/disabling the PCI function.
 
-  - pchid
-    Model-dependent location of the I/O adapter.
+  - pchid:
+    This 16-bit hexadecimal value encodes a model-dependent location for
+    the PCI function.
 
-  - pfgid
-    PCI function group ID, functions that share identical functionality
+  - pfgid:
+    PCI function group ID; functions that share identical functionality
     use a common identifier.
     A PCI group defines interrupts, IOMMU, IOTLB, and DMA specifics.
 
-  - vfn
+  - vfn:
     The virtual function number, from 1 to N for virtual functions,
     0 for physical functions.
 
-  - pft
-    The PCI function type
+  - pft:
+    The PCI function type is an s390-specific type attribute. It indicates
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
+    The user-defined identifier (UID) for a PCI function is a 32-bit
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
+    Contains an 8-bit-per-PCI function parameter field in hexadecimal provided
+    by the platform. The meaning of this field is PCI function type specific.
+    For NETH VFs a value of 0x01 indicates that the function supports
+    promiscuous mode.
+
+* /sys/firmware/clp/uid_checking:
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
+  pci=norid kernel parameter is used, or a so-called isolated Virtual Function
+  which does have RID information but is used without its parent Physical
+  Function being part of the same PCI configuration:
 
   - There is only one function per domain.
 
-  - The domain is set from the zPCI function's UID as defined during the
-    LPAR creation.
+  - The domain is set from the zPCI function's UID if UID Checking is on;
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

