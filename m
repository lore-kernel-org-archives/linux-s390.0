Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7933AC433ED
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 12:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4560C61185
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 12:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhECMNx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 May 2021 08:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229866AbhECMNx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 May 2021 08:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620043979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K5m+889p2sr3WAK7eV6x9Hap4sz6HqlhwTOj7+igDZ4=;
        b=hCAf6DlGQ/3q+GBZXcdv2vmaoyApAhLkpLshrqmGeUUY9LXe+GwA41ADq33vT4aSTQ+ak+
        f3GS0sYIqDOxyhaSPS4Xpgduz/gxm8VUzGYDjX0HK6gKLn9krHeN/mmtO6xEJ1i73d1Cgd
        D1/fQOaXl7m1RVbaL7oSftYW5SrF4OM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-DrS35qCnPX2TsdkQ7A7h4w-1; Mon, 03 May 2021 08:12:56 -0400
X-MC-Unique: DrS35qCnPX2TsdkQ7A7h4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A7C210060C7;
        Mon,  3 May 2021 12:12:55 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-244.ams2.redhat.com [10.36.113.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EE0C19C45;
        Mon,  3 May 2021 12:12:48 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390: fix detection of vector enhancements facility 1 vs. vector packed decimal facility
Date:   Mon,  3 May 2021 14:12:44 +0200
Message-Id: <20210503121244.25232-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The PoP documents:
	134: The vector packed decimal facility is installed in the
	     z/Architecture architectural mode. When bit 134 is
	     one, bit 129 is also one.
	135: The vector enhancements facility 1 is installed in
	     the z/Architecture architectural mode. When bit 135
	     is one, bit 129 is also one.

Looks like we confuse the vector enhancements facility 1 ("EXT") with the
Vector packed decimal facility ("BCD"). Let's fix the facility checks.

Detected while working on QEMU/tcg z14 support and only unlocking
the vector enhancements facility 1, but not the vector packed decimal
facility.

Fixes: 2583b848cad0 ("s390: report new vector facilities")
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 72134f9f6ff5..5aab59ad5688 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -937,9 +937,9 @@ static int __init setup_hwcaps(void)
 	if (MACHINE_HAS_VX) {
 		elf_hwcap |= HWCAP_S390_VXRS;
 		if (test_facility(134))
-			elf_hwcap |= HWCAP_S390_VXRS_EXT;
-		if (test_facility(135))
 			elf_hwcap |= HWCAP_S390_VXRS_BCD;
+		if (test_facility(135))
+			elf_hwcap |= HWCAP_S390_VXRS_EXT;
 		if (test_facility(148))
 			elf_hwcap |= HWCAP_S390_VXRS_EXT2;
 		if (test_facility(152))
-- 
2.30.2

