Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA6AEB64D7
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jun 2023 12:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjFWMzi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jun 2023 08:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjFWMzh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jun 2023 08:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193651713
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 05:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687524889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMJsEqZxFDEiOpUmf5NTUaCgnapiJoAxYbiFoSk82wQ=;
        b=Qs3ToNGJembbu0DSae6hmCgYUDLXgaFRJ8auP+MPj43M9y2zhfCw4uDoITGBRToInxEuUy
        OqH74vmcwFqki/TFCUkU1E4wPyQEqL10UAv/n/1/75hUhNQVmtgCvuNU3P/YvJziufGO5i
        gF4JH64n2lx6cRUk/pG15ry+3FzvvVQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-UhauKGHCN2CMcbORgDFUJg-1; Fri, 23 Jun 2023 08:54:43 -0400
X-MC-Unique: UhauKGHCN2CMcbORgDFUJg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 965728CC200;
        Fri, 23 Jun 2023 12:54:42 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AD80F5AC5;
        Fri, 23 Jun 2023 12:54:24 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Nico=20B=C3=B6hr?= <nrb@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Andrew Jones <andrew.jones@linux.dev>
Cc:     kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [kvm-unit-tests PATCH 2/2] Link with "-z noexecstack" to avoid warning from newer versions of ld
Date:   Fri, 23 Jun 2023 14:54:16 +0200
Message-Id: <20230623125416.481755-3-thuth@redhat.com>
In-Reply-To: <20230623125416.481755-1-thuth@redhat.com>
References: <20230623125416.481755-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Newer versions of ld (from binutils 2.40) complain on s390x and x86:

 ld: warning: s390x/cpu.o: missing .note.GNU-stack section implies
              executable stack
 ld: NOTE: This behaviour is deprecated and will be removed in a
           future version of the linker

We can silence these warnings by using "-z noexecstack" for linking
(which should not have any real influence on the kvm-unit-tests since
the information from the ELF header is not used here anyway, so it's
just cosmetics).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0e5d85a1..20f7137c 100644
--- a/Makefile
+++ b/Makefile
@@ -96,7 +96,7 @@ CFLAGS += -Woverride-init -Wmissing-prototypes -Wstrict-prototypes
 
 autodepend-flags = -MMD -MF $(dir $*).$(notdir $*).d
 
-LDFLAGS += -nostdlib
+LDFLAGS += -nostdlib -z noexecstack
 
 $(libcflat): $(cflatobjs)
 	$(AR) rcs $@ $^
-- 
2.39.3

