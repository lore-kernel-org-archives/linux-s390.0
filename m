Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232491AbhBIP6j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 10:58:39 -0500
From: Thomas Huth <thuth@redhat.com>
Subject: [kvm-unit-tests PATCH] Fix the length in the stsi check for the VM name
Date: Tue,  9 Feb 2021 16:57:05 +0100
Message-Id: <20210209155705.67601-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

sizeof(somepointer) results in the size of the pointer, i.e. 8 on a
64-bit system, so the

 memcmp(data->ext_names[0], vm_name_ext, sizeof(vm_name_ext))

only compared the first 8 characters of the VM name here. Switch
to a proper array to get the sizeof() right.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 s390x/stsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/s390x/stsi.c b/s390x/stsi.c
index 4109b8d..87d4804 100644
--- a/s390x/stsi.c
+++ b/s390x/stsi.c
@@ -106,7 +106,7 @@ static void test_3_2_2(void)
 				 0x00, 0x03 };
 	/* EBCDIC for "KVM/" */
 	const uint8_t cpi_kvm[] = { 0xd2, 0xe5, 0xd4, 0x61 };
-	const char *vm_name_ext = "kvm-unit-test";
+	const char vm_name_ext[] = "kvm-unit-test";
 	struct stsi_322 *data = (void *)pagebuf;
 
 	report_prefix_push("3.2.2");
-- 
2.27.0
