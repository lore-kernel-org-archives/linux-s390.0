Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728114AbgBNW1l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:41 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 37/42] s390/uv: Fix handling of length extensions (already in s390 tree)
Date: Fri, 14 Feb 2020 17:26:53 -0500
Message-Id: <20200214222658.12946-38-borntraeger@de.ibm.com>
In-Reply-To: <20200214222658.12946-1-borntraeger@de.ibm.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, stable@vger.kernel.org

The query parameter block might contain additional information and can
be extended in the future. If the size of the block does not suffice we
get an error code of rc=0x100.  The buffer will contain all information
up to the specified size and the hypervisor/guest simply do not need the
additional information as they do not know about the new data.  That
means that we can (and must) accept rc=0x100 as success.

Cc: stable@vger.kernel.org
Fixes: 5abb9351dfd9 ("s390/uv: introduce guest side ultravisor code")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/boot/uv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
index af9e1cc93c68..c003593664cd 100644
--- a/arch/s390/boot/uv.c
+++ b/arch/s390/boot/uv.c
@@ -21,7 +21,7 @@ void uv_query_info(void)
 	if (!test_facility(158))
 		return;
 
-	if (uv_call(0, (uint64_t)&uvcb))
+	if (uv_call(0, (uint64_t)&uvcb) && uvcb.header.rc != 0x100)
 		return;
 
 	if (IS_ENABLED(CONFIG_KVM)) {
-- 
2.25.0
