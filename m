Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439076AbfJXLlw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:41:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBc062108156
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:41:52 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vu9nxm0gx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:41:51 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:41:49 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 01/37] DOCUMENTATION: protvirt: Protected virtual machine introduction
Date: Thu, 24 Oct 2019 07:40:23 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-2-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

Introduction to Protected VMs.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 Documentation/virtual/kvm/s390-pv.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/virtual/kvm/s390-pv.txt

diff --git a/Documentation/virtual/kvm/s390-pv.txt b/Documentation/virtual/kvm/s390-pv.txt
new file mode 100644
index 000000000000..86ed95f36759
--- /dev/null
+++ b/Documentation/virtual/kvm/s390-pv.txt
@@ -0,0 +1,23 @@
+Ultravisor and Protected VMs
+===========================
+
+Summary:
+
+Protected VMs (PVM) are KVM VMs, where KVM can't access the VM's state
+like guest memory and guest registers anymore. Instead the PVMs are
+mostly managed by a new entity called Ultravisor (UV), which provides
+an API, so KVM and the PVM can request management actions.
+
+Each guest starts in the non-protected mode and then transitions into
+protected mode. On transition KVM registers the guest and its VCPUs
+with the Ultravisor and prepares everything for running it.
+
+The Ultravisor will secure and decrypt the guest's boot memory
+(i.e. kernel/initrd). It will safeguard state changes like VCPU
+starts/stops and injected interrupts while the guest is running.
+
+As access to the guest's state, like the SIE state description is
+normally needed to be able to run a VM, some changes have been made in
+SIE behavior and fields have different meaning for a PVM. SIE exits
+are minimized as much as possible to improve speed and reduce exposed
+guest state.
-- 
2.20.1
