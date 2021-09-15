Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451FAC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 15 Sep 2021 04:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206C061166
	for <linux-s390@archiver.kernel.org>; Wed, 15 Sep 2021 04:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhIOEld (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Sep 2021 00:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhIOElc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Sep 2021 00:41:32 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81127C061574;
        Tue, 14 Sep 2021 21:40:14 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso1833749otr.13;
        Tue, 14 Sep 2021 21:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIjgnD6llWLecWS9URuZLYevsrhl82ycmqOPmbjPpGA=;
        b=aHCo58/7pgnyS8W/eH3M8NbQJRCTuDmU00wx/ZizM6zUGWRmvZ75gJ0bm85FQrxR3I
         SYMKvUNm0ap3AutIGbbvA5LgCTgm92MWXewwhtDUfeWyM2PN8P4LUEKrI8Yjo3VUDMCp
         wjcST5c28d87FVkQiPIETOztje0li0lV9+DsKu+9Qv3p99pzQYkPkIBuziJrcdFtX5E9
         tS/kTz6z4V6+pUPlb0bTp6qutMHMvZ/tak70zvxLsNTnCWfKVbPfVOJrWT62bguZy/ni
         ORfvX7e/W0cWZ0APeyqPDy2IutZ1HvcGBWRCCL9mPmKlFrUVIOOf6NWjY2U1DQddon6v
         00pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vIjgnD6llWLecWS9URuZLYevsrhl82ycmqOPmbjPpGA=;
        b=nZp68VTzghvPOcLB0wQvH62q2aPCfecvPHE0FcTkpi0qEpOXzQ9Wp6hDNhzmmIt5uK
         jHWR3ybCeP3BtAuWPA/T6GwpDednRw6Hq3YSkZPRfugzaPWvIaat+We4N8OTiu9VWjDV
         cYHSplobyn3AwV0xqMirN2ck8QFdsBs/jWRgIbgy2LDqOfK+m2OFlNGih0QEU4xJzFCp
         6hUFrGJXopHGxVd8BboYmNLWixzNo2S4C8c7jV6BU+M7P/GkvUi4ksEiG97strCqMO9N
         JfNgl4E7TiG2fDA+MbbdlA3ATOueCp5Vdv3ItDvh9Zl7dNYawo4EOIdVWl3ssuXQxLFL
         R5Og==
X-Gm-Message-State: AOAM5335h5gkFOdT6CbapKoqcvWeEOs8Qnsj/kZCq11/t+6zn7m7XxyP
        6vtbs/FZK+dZyuENjlrphaQ=
X-Google-Smtp-Source: ABdhPJwEy2wdlTzeCrHUmbGshHdzuLJsJ11MpmFsV+r4hpH9fc3sf/3Rn5evNGwSXx2+X4kvTs/jYQ==
X-Received: by 2002:a05:6830:1b78:: with SMTP id d24mr17657592ote.197.1631680813695;
        Tue, 14 Sep 2021 21:40:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r26sm3072921otn.77.2021.09.14.21.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 21:40:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] s390: Add WARN_DYNAMIC_STACK dependencies
Date:   Tue, 14 Sep 2021 21:40:10 -0700
Message-Id: <20210915044010.640499-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

s390:allmodconfig fails to build with the following errors.

arch/s390/kernel/syscall.c: In function '__do_syscall':
arch/s390/kernel/syscall.c:168:1: error:
	'__do_syscall' uses dynamic stack allocation

lib/test_kasan.c: In function 'kasan_alloca_oob_right':
lib/test_kasan.c:782:1: error:
	'kasan_alloca_oob_right' uses dynamic stack allocation

lib/test_kasan.c: In function 'kasan_alloca_oob_left':
lib/test_kasan.c:767:1: error:
	'kasan_alloca_oob_left' uses dynamic stack allocation

The first error is seen if RANDOMIZE_KSTACK_OFFSET_DEFAULT,
WARN_DYNAMIC_STACK, and WERROR are enabled. The other problems
are seen if KASAN_KUNIT_TEST, WARN_DYNAMIC_STACK, and WERROR
are enabled.

It does not make sense to abort a build in that situation.
If either RANDOMIZE_KSTACK_OFFSET_DEFAULT or KASAN_KUNIT_TEST
is enabled, dynamic stack allocation is on purpose and should
not fail the build. Add dependencies to reflect that situation.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2bd90c51efd3..776b730e2d15 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -688,6 +688,7 @@ config STACK_GUARD
 config WARN_DYNAMIC_STACK
 	def_bool n
 	prompt "Emit compiler warnings for function with dynamic stack usage"
+	depends on !WERROR || (!RANDOMIZE_KSTACK_OFFSET_DEFAULT && !KASAN_KUNIT_TEST)
 	help
 	  This option enables the compiler option -mwarn-dynamicstack. If the
 	  compiler supports this options generates warnings for functions
-- 
2.33.0

