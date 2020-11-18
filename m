Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41934 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbgKRRBw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 12:01:52 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] MAINTAINERS: add uv.c also to KVM/s390
Date: Wed, 18 Nov 2020 18:01:16 +0100
Message-Id: <20201118170116.8239-3-borntraeger@de.ibm.com>
In-Reply-To: <20201118170116.8239-1-borntraeger@de.ibm.com>
References: <20201118170116.8239-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>

Most changes in uv.c are related to KVM. Involve also the KVM team
regarding changes to uv.c.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..06116d892a4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9674,6 +9674,7 @@ F:	Documentation/virt/kvm/s390*
 F:	arch/s390/include/asm/gmap.h
 F:	arch/s390/include/asm/kvm*
 F:	arch/s390/include/uapi/asm/kvm*
+F:	arch/s390/kernel/uv.c
 F:	arch/s390/kvm/
 F:	arch/s390/mm/gmap.c
 F:	tools/testing/selftests/kvm/*/s390x/
-- 
2.28.0
