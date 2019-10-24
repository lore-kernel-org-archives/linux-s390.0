Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409238AbfJXLmL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBb7XZ127892
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:11 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vua4vaun5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:10 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:08 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 11/37] DOCUMENTATION: protvirt: Interrupt injection
Date: Thu, 24 Oct 2019 07:40:33 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-12-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

Interrupt injection has changed a lot for protected guests, as KVM
can't access the cpus' lowcores. New fields in the state description,
like the interrupt injection control, and masked values safeguard the
guest from KVM.

Let's add some documentation to the interrupt injection basics for
protected guests.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 Documentation/virtual/kvm/s390-pv.txt | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/virtual/kvm/s390-pv.txt b/Documentation/virtual/kvm/s390-pv.txt
index 86ed95f36759..e09f2dc5f164 100644
--- a/Documentation/virtual/kvm/s390-pv.txt
+++ b/Documentation/virtual/kvm/s390-pv.txt
@@ -21,3 +21,30 @@ normally needed to be able to run a VM, some changes have been made in
 SIE behavior and fields have different meaning for a PVM. SIE exits
 are minimized as much as possible to improve speed and reduce exposed
 guest state.
+
+
+Interrupt injection:
+
+Interrupt injection is safeguarded by the Ultravisor and, as KVM lost
+access to the VCPUs' lowcores, is handled via the format 4 state
+description.
+
+Machine check, external, IO and restart interruptions each can be
+injected on SIE entry via a bit in the interrupt injection control
+field (offset 0x54). If the guest cpu is not enabled for the interrupt
+at the time of injection, a validity interception is recognized. The
+interrupt's data is transported via parts of the interception data
+block.
+
+Program and Service Call exceptions have another layer of
+safeguarding, they are only injectable, when instructions have
+intercepted into KVM and such an exception can be an emulation result.
+
+
+Mask notification interceptions:
+As a replacement for the lctl(g) and lpsw(e) interception, two new
+interception codes have been introduced. One which tells us that CRs
+0, 6 or 14 have been changed and therefore interrupt masking might
+have changed. And one for PSW bit 13 changes. The CRs and the PSW in
+the state description only contain the mask bits and no further info
+like the current instruction address.
-- 
2.20.1
