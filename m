Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733010AbfJXLmn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBb71h127935
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:42 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vua4vav9m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:42 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:40 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 30/37] DOCUMENTATION: protvirt: Diag 308 IPL
Date: Thu, 24 Oct 2019 07:40:52 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-31-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

Description of changes that are necessary to move a KVM VM into
Protected Virtualization mode.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 Documentation/virtual/kvm/s390-pv-boot.txt | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/virtual/kvm/s390-pv-boot.txt

diff --git a/Documentation/virtual/kvm/s390-pv-boot.txt b/Documentation/virtual/kvm/s390-pv-boot.txt
new file mode 100644
index 000000000000..af883c928c08
--- /dev/null
+++ b/Documentation/virtual/kvm/s390-pv-boot.txt
@@ -0,0 +1,62 @@
+Boot/IPL of Protected VMs
+========================
+
+Summary:
+
+Protected VMs are encrypted while not running. On IPL a small
+plaintext bootloader is started which provides information about the
+encrypted components and necessary metadata to KVM to decrypt it.
+
+Based on this data, KVM will make the PV known to the Ultravisor and
+instruct it to secure its memory, decrypt the components and verify
+the data and address list hashes, to ensure integrity. Afterwards KVM
+can run the PV via SIE which the UV will intercept and execute on
+KVM's behalf.
+
+The switch into PV mode lets us load encrypted guest executables and
+data via every available method (network, dasd, scsi, direct kernel,
+...) without the need to change the boot process.
+
+
+Diag308:
+
+This diagnose instruction is the basis vor VM IPL. The VM can set and
+retrieve IPL information blocks, that specify the IPL method/devices
+and request VM memory and subsystem resets, as well as IPLs.
+
+For PVs this concept has been continued with new subcodes:
+
+Subcode 8: Set an IPL Information Block of type 5.
+Subcode 9: Store the saved block in guest memory
+Subcode 10: Move into Protected Virtualization mode
+
+The new PV load-device-specific-parameters field specifies all data,
+that is necessary to move into PV mode.
+
+* PV Header origin
+* PV Header length
+* List of Components composed of:
+  * AES-XTS Tweak prefix
+  * Origin
+  * Size
+
+The PV header contains the keys and hashes, which the UV will use to
+decrypt and verify the PV, as well as control flags and a start PSW.
+
+The components are for instance an encrypted kernel, kernel cmd and
+initrd. The components are decrypted by the UV.
+
+All non-decrypted data of the non-PV guest instance are zero on first
+access of the PV.
+
+
+When running in a protected mode some subcodes will result in
+exceptions or return error codes.
+
+Subcodes 4 and 7 will result in specification exceptions.
+When removing a secure VM, the UV will clear all memory, so we can't
+have non-clearing IPL subcodes.
+
+Subcodes 8, 9, 10 will result in specification exceptions.
+Re-IPL into a protected mode is only possible via a detour into non
+protected mode.
-- 
2.20.1
