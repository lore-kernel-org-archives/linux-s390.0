Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A1BC4320A
	for <linux-s390@archiver.kernel.org>; Tue, 17 Aug 2021 00:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497FB6056B
	for <linux-s390@archiver.kernel.org>; Tue, 17 Aug 2021 00:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhHQAVy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 16 Aug 2021 20:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbhHQAVy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 16 Aug 2021 20:21:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B99EC0613C1
        for <linux-s390@vger.kernel.org>; Mon, 16 Aug 2021 17:21:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso18601585ybg.11
        for <linux-s390@vger.kernel.org>; Mon, 16 Aug 2021 17:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GevpZaQQXx6uJazNaaL+jipz4XqGAMmvjabHC4B/TIQ=;
        b=MScZ8npAWuWl2n5WACKsqP8jI8+/lFmzfUiNk9uT7xhF6EzFjzIikN/4YhY3uTeZ2x
         K8coom07pnPTFK3+tFw60liHvWz6Z7w5kbuUiwgu7/cSpVlWzAR+pnpPZqSkCkVSzLR3
         tUNh36dKOSdq0S6zkfn4e6KjPFg2LJq97SrGIM8AiEmlF/j4TGZ3lnxHuJZnXZ+QAi6R
         R6hprfvD6Js8ESDZZYcfEkIW+qnf70q3gcHsRHViGriHkuwWDMDDgNPNiz1zrClzNxI7
         H2AWhD+4szOvfOVdzeOMaGyuEx/4GfP3AlsFPougYaSMIXQDQQYBtCXa4DbfQgBg+Aut
         zc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GevpZaQQXx6uJazNaaL+jipz4XqGAMmvjabHC4B/TIQ=;
        b=NNQr8wv12H4iuruM6gNwNF5xEnTO/jmXu6w7+nazwU2/yDFCvkQrdQfjr52VMz/xaI
         WsrzXpZc4gsIlA9zjv2oJ15W+RcwnGeYh4d1eGId2ACSE/D76DmTmKGT4msgm14nrPg5
         9xta2jC0td1rsxw74XszPeKXjwfaBkVGlwoOdT2hSsFqqt1w5QrfdypvjNOz3IHjMCkF
         MRzxr8pp4ck5ZoSbKVCIB5iKK2F4awsr1A/V7LSOJdyqKHPKqBWQiy6wdv18RcFnXPZv
         Mby/NlcIjjGF5qkAWgQjwzKtJZkRqaWwEQtinsQZW3EWyynbftANWIFFw0tXzzFCkdI0
         CxVQ==
X-Gm-Message-State: AOAM531m7bFLRFxpUhbGwIBwFGRkmthEMsM6ZtTRah+qgNOUCpF4yLH7
        WPlU+diiZoUSinj5Z2zRr0MihFcIX0rqwHouFG4=
X-Google-Smtp-Source: ABdhPJxL7VirAAAFQMCSntsswKKgERjdwzETy0eVm86bC90eEJ+t7AvAdwCfkOc72YkQySg3+82ZTFoLk2T9BRbqHBQ=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:478:6e44:5cf7:fcde])
 (user=ndesaulniers job=sendgmr) by 2002:a25:b845:: with SMTP id
 b5mr888141ybm.343.1629159681391; Mon, 16 Aug 2021 17:21:21 -0700 (PDT)
Date:   Mon, 16 Aug 2021 17:21:04 -0700
In-Reply-To: <20210817002109.2736222-1-ndesaulniers@google.com>
Message-Id: <20210817002109.2736222-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210817002109.2736222-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 2/7] s390: replace cc-option-yn uses with cc-option
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

cc-option-yn can be replaced with cc-option. ie.
Checking for support:
ifeq ($(call cc-option-yn,$(FLAG)),y)
becomes:
ifneq ($(call cc-option,$(FLAG)),)

Checking for lack of support:
ifeq ($(call cc-option-yn,$(FLAG)),n)
becomes:
ifeq ($(call cc-option,$(FLAG)),)

This allows us to pursue removing cc-option-yn.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/s390/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 17dc4f1ac4fa..a3cf33ad009f 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -70,7 +70,7 @@ cflags-y += -Wa,-I$(srctree)/arch/$(ARCH)/include
 #
 cflags-$(CONFIG_FRAME_POINTER) += -fno-optimize-sibling-calls
 
-ifeq ($(call cc-option-yn,-mpacked-stack -mbackchain -msoft-float),y)
+ifneq ($(call cc-option,-mpacked-stack -mbackchain -msoft-float),)
 cflags-$(CONFIG_PACK_STACK)  += -mpacked-stack -D__PACK_STACK
 aflags-$(CONFIG_PACK_STACK)  += -D__PACK_STACK
 endif
@@ -78,22 +78,22 @@ endif
 KBUILD_AFLAGS_DECOMPRESSOR += $(aflags-y)
 KBUILD_CFLAGS_DECOMPRESSOR += $(cflags-y)
 
-ifeq ($(call cc-option-yn,-mstack-size=8192 -mstack-guard=128),y)
+ifneq ($(call cc-option,-mstack-size=8192 -mstack-guard=128),)
 cflags-$(CONFIG_CHECK_STACK) += -mstack-size=$(STACK_SIZE)
-ifneq ($(call cc-option-yn,-mstack-size=8192),y)
+ifeq ($(call cc-option,-mstack-size=8192),)
 cflags-$(CONFIG_CHECK_STACK) += -mstack-guard=$(CONFIG_STACK_GUARD)
 endif
 endif
 
 ifdef CONFIG_WARN_DYNAMIC_STACK
-  ifeq ($(call cc-option-yn,-mwarn-dynamicstack),y)
+  ifneq ($(call cc-option,-mwarn-dynamicstack),)
     KBUILD_CFLAGS += -mwarn-dynamicstack
     KBUILD_CFLAGS_DECOMPRESSOR += -mwarn-dynamicstack
   endif
 endif
 
 ifdef CONFIG_EXPOLINE
-  ifeq ($(call cc-option-yn,$(CC_FLAGS_MARCH) -mindirect-branch=thunk),y)
+  ifneq ($(call cc-option,$(CC_FLAGS_MARCH) -mindirect-branch=thunk),)
     CC_FLAGS_EXPOLINE := -mindirect-branch=thunk
     CC_FLAGS_EXPOLINE += -mfunction-return=thunk
     CC_FLAGS_EXPOLINE += -mindirect-branch-table
@@ -104,10 +104,10 @@ ifdef CONFIG_EXPOLINE
 endif
 
 ifdef CONFIG_FUNCTION_TRACER
-  ifeq ($(call cc-option-yn,-mfentry -mnop-mcount),n)
+  ifeq ($(call cc-option,-mfentry -mnop-mcount),)
     # make use of hotpatch feature if the compiler supports it
     cc_hotpatch	:= -mhotpatch=0,3
-    ifeq ($(call cc-option-yn,$(cc_hotpatch)),y)
+    ifneq ($(call cc-option,$(cc_hotpatch)),)
       CC_FLAGS_FTRACE := $(cc_hotpatch)
       KBUILD_AFLAGS	+= -DCC_USING_HOTPATCH
       KBUILD_CFLAGS	+= -DCC_USING_HOTPATCH
-- 
2.33.0.rc1.237.g0d66db33f3-goog

