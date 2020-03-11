Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728559AbgCKIdN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Mar 2020 04:33:13 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02B8WxLL067907
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 04:33:12 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ypvjtr0ek-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 04:33:12 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 11 Mar 2020 08:33:09 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] KVM: s390: mark sie block as 512 byte aligned
Date: Wed, 11 Mar 2020 09:33:04 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200311083304.3725276-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>

The sie block must be aligned to 512 bytes. Mark it as such.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 0ea82152d2f7..2d50f6c432e2 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -344,7 +344,7 @@ struct kvm_s390_sie_block {
 	__u64	itdba;			/* 0x01e8 */
 	__u64   riccbd;			/* 0x01f0 */
 	__u64	gvrd;			/* 0x01f8 */
-} __attribute__((packed));
+} __packed __aligned(512);
 
 struct kvm_s390_itdb {
 	__u8	data[256];
-- 
2.24.1
