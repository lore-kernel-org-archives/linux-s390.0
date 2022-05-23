Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BB0C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 23 May 2022 19:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiEWTn7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 May 2022 15:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiEWTg5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 May 2022 15:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B5D0E15DC
        for <linux-s390@vger.kernel.org>; Mon, 23 May 2022 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653333866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=InjuNukk5AWJl2Wwz5sSwlsD5KfOc4voU8ewp772j2k=;
        b=GrNwTVKUyt1FTuEVBPp2ansDLgYFgC+mOAwx+vS91TkPWzrCM53tySTFNzrUrDM+VGDVJO
        dRE1rIDiEcb8K3K6LJQ92mO3r5RAaQCK3ZhIEkXz5Xz6GMdEp2txdEa59ssetmKVdpI9lm
        XB+DrFmTgnBkYQmWF/24WOjyqDEd/DU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-vlreVST7O8GEWgS7BFZBbw-1; Mon, 23 May 2022 15:24:20 -0400
X-MC-Unique: vlreVST7O8GEWgS7BFZBbw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C37F811E78;
        Mon, 23 May 2022 19:24:20 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4634D492C3B;
        Mon, 23 May 2022 19:24:20 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390/uv_uapi: depend on CONFIG_S390
Date:   Mon, 23 May 2022 15:24:20 -0400
Message-Id: <20220523192420.151184-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/s390/char/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
index ef8f41833c1a..108e8eb06249 100644
--- a/drivers/s390/char/Kconfig
+++ b/drivers/s390/char/Kconfig
@@ -103,6 +103,7 @@ config SCLP_OFB
 config S390_UV_UAPI
 	def_tristate m
 	prompt "Ultravisor userspace API"
+        depends on S390
 	help
 	  Selecting exposes parts of the UV interface to userspace
 	  by providing a misc character device at /dev/uv.
-- 
2.31.1

