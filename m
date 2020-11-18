Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725964AbgKRJju (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 04:39:50 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/2] s390/uv: handle destroy page legacy interface
Date: Wed, 18 Nov 2020 10:39:41 +0100
Message-Id: <20201118093942.457191-2-borntraeger@de.ibm.com>
In-Reply-To: <20201118093942.457191-1-borntraeger@de.ibm.com>
References: <20201118093942.457191-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

Older firmware can return rc=0x107 rrc=0xd for destroy page if the
page is already non-secure. This should be handled like a success
as already done by newer firmware.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: 1a80b54d1ce1 ("s390/uv: add destroy page call")
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 14bd9d58edc9..883bfed9f5c2 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -129,8 +129,15 @@ int uv_destroy_page(unsigned long paddr)
 		.paddr = paddr
 	};
 
-	if (uv_call(0, (u64)&uvcb))
+	if (uv_call(0, (u64)&uvcb)) {
+		/*
+		 * Older firmware uses 107/d as an indication of a non secure
+		 * page. Let us emulate the newer variant (no-op).
+		 */
+		if (uvcb.header.rc == 0x107 && uvcb.header.rrc == 0xd)
+			return 0;
 		return -EINVAL;
+	}
 	return 0;
 }
 
-- 
2.28.0
