Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE1FC4332F
	for <linux-s390@archiver.kernel.org>; Thu,  9 Sep 2021 15:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66BB611B0
	for <linux-s390@archiver.kernel.org>; Thu,  9 Sep 2021 15:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbhIIPCP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Sep 2021 11:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240122AbhIIPB6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Sep 2021 11:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631199648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHro6t2tN+PX+WrUKfBpgz4ptLtDy0pjdbBM71YmOAI=;
        b=AaSSsYABgEWv3QySaKUG7dNhLDguxrdaSPdOOsUne51Ga6sj+8b+eQdJwU6s3hLVhY105S
        3bKQz8zZmXtQG5ODKfCLaYO//QiIAlKIxkGYnPjetdB63QTjP3IGZLgxjZ3vYII9s3btnG
        Nx8PKYgYbariENE2SlimPBAoSmVYuiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-2CxvNUOjNx2ZjB9njiiu2g-1; Thu, 09 Sep 2021 11:00:47 -0400
X-MC-Unique: 2CxvNUOjNx2ZjB9njiiu2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22D0E10168CC;
        Thu,  9 Sep 2021 15:00:46 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0B6619E7E;
        Thu,  9 Sep 2021 15:00:44 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 8/9] s390/mm: optimize set_guest_storage_key()
Date:   Thu,  9 Sep 2021 16:59:44 +0200
Message-Id: <20210909145945.12192-9-david@redhat.com>
In-Reply-To: <20210909145945.12192-1-david@redhat.com>
References: <20210909145945.12192-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We already optimize get_guest_storage_key() to assume that if we don't have
a PTE table and don't have a huge page mapped that the storage key is 0.

Similarly, optimize set_guest_storage_key() to simply do nothing in case
the key to set is 0.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/pgtable.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 4e77b8ebdcc5..534939a3eca5 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -792,13 +792,23 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	if (pmd_lookup(mm, addr, &pmdp))
+	/*
+	 * If we don't have a PTE table and if there is no huge page mapped,
+	 * we can ignore attempts to set the key to 0, because it already is 0.
+	 */
+	switch (pmd_lookup(mm, addr, &pmdp)) {
+	case -ENOENT:
+		return key ? -EFAULT : 0;
+	case 0:
+		break;
+	default:
 		return -EFAULT;
+	}
 
 	ptl = pmd_lock(mm, pmdp);
 	if (!pmd_present(*pmdp)) {
 		spin_unlock(ptl);
-		return -EFAULT;
+		return key ? -EFAULT : 0;
 	}
 
 	if (pmd_large(*pmdp)) {
-- 
2.31.1

