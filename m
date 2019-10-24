Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439118AbfJXLl7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:41:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBb7hJ002445
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:41:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vub6gg9vj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:41:58 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:41:56 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 05/37] s390: KVM: Export PV handle to gmap
Date: Thu, 24 Oct 2019 07:40:27 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-6-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

We need it in the next patch, when doing memory management for the
guest in the kernel's fault handler, where otherwise we wouldn't have
access to the handle.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/gmap.h | 1 +
 arch/s390/kvm/pv.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 37f96b6f0e61..6efc0b501227 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -61,6 +61,7 @@ struct gmap {
 	spinlock_t shadow_lock;
 	struct gmap *parent;
 	unsigned long orig_asce;
+	unsigned long se_handle;
 	int edat_level;
 	bool removed;
 	bool initialized;
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 94cf16f40f25..80aecd5bea9e 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -169,6 +169,7 @@ int kvm_s390_pv_create_vm(struct kvm *kvm)
 		kvm_s390_pv_dealloc_vm(kvm);
 		return -EINVAL;
 	}
+	kvm->arch.gmap->se_handle = uvcb.guest_handle;
 	return rc;
 }
 
-- 
2.20.1
