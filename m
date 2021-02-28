Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EC1C433E0
	for <linux-s390@archiver.kernel.org>; Sun, 28 Feb 2021 17:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B39F64EB7
	for <linux-s390@archiver.kernel.org>; Sun, 28 Feb 2021 17:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhB1RAm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 28 Feb 2021 12:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhB1RAk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 28 Feb 2021 12:00:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C57C061756;
        Sun, 28 Feb 2021 08:59:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id h10so17479462edl.6;
        Sun, 28 Feb 2021 08:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CPEIN09wDGtkCb8Hq6OIvTK/905Oh/m5CADJ4r6c2LE=;
        b=fyKtar+RwTLgcYg3W6FUSj+8SNXTeYykG6lcex3qg1BBqkYOEkQOrElxX+MpRTc0HB
         miKBiChfz6+yGPADlIpDjKRMEW3WqtFsxsEA2d2WVXylHfxM6jtneLguIbP/iPTdLoJB
         xMHRgYf5DPPre9esQtSbOlrfzMv9NjkFzGIDUPXk5jIEf4u/ZuBHtEL/JJC1Up58AKsR
         1TNRG9878R3kglrt8KnWdrlbfgfNYzpzI1aGAQg7JeydfoFcaQBNcthL5i76o9fFfk1J
         ye1uad5TZQ7JeRFHa8ctKHwYt+hZMmMItGvoUjuTGxeCsFpziyw1I20sGo5AOmGxNpch
         RhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CPEIN09wDGtkCb8Hq6OIvTK/905Oh/m5CADJ4r6c2LE=;
        b=RqqBJHBginKdnakOFRNj5L06JFTH8jfhlMwyCbIWWnWmvLul/qGRQCX8Y7fc0+Evf6
         NQwx76uZp5Ntz4Kq5nS9bE9sFEv9i8OrIYpsTbYsOdb1Bp46bo+n1W+mFhP8vTP3UM78
         9I0X/ydatAaDsNCIQBNH4F/8RetBd/f6c3jD+H7IzE/N5mQE5i3o0f0jojzdl80djADZ
         dST+T5TvH/zz7wvim/+BBr8wrGI/Xmq5XX7q+hnP9WV89/LRzSvOxOr7qMYnI2EcliIo
         yk8Z3lpU2Aw/sp+e1zU6ICXDU0FDxQlnk0GkDLrgmnCizBMrxK4cs59iAvQL9kIlkgN/
         1K4w==
X-Gm-Message-State: AOAM533Id99J4sb9r4LwtQiClLXeWgXBfbJY/ZVtoXCAYlXA/w+CaAoV
        N9sfhsMsV1xYB5qF4MUczQ==
X-Google-Smtp-Source: ABdhPJzwqO2LSvZzxq4LaDuPWLZtnlIleqfdCl7EVK2Fwtjrk/uAIBWF+mQ0fLbsNkxPwoeUeLQxNw==
X-Received: by 2002:a05:6402:30a5:: with SMTP id df5mr13018630edb.24.1614531598536;
        Sun, 28 Feb 2021 08:59:58 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.223])
        by smtp.gmail.com with ESMTPSA id m14sm4715188edd.63.2021.02.28.08.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 08:59:58 -0800 (PST)
Date:   Sun, 28 Feb 2021 19:59:56 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH 03/11] pragma once: convert arch/s390/tools/gen_facilities.c
Message-ID: <YDvMDFKvpL0864fF@localhost.localdomain>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From 45622ce1e4db512ad603dd90f959e61285b7541a Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 9 Feb 2021 14:43:52 +0300
Subject: [PATCH 03/11] pragma once: convert arch/s390/tools/gen_facilities.c

Generate arch/s390/include/generated/asm/facility-defs.h without include
guard.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/s390/tools/gen_facilities.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 61ce5b59b828..cd5055994206 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -157,8 +157,7 @@ static void print_facility_lists(void)
 
 int main(int argc, char **argv)
 {
-	printf("#ifndef __ASM_S390_FACILITY_DEFS__\n");
-	printf("#define __ASM_S390_FACILITY_DEFS__\n");
+	printf("#pragma once\n");
 	printf("/*\n");
 	printf(" * DO NOT MODIFY.\n");
 	printf(" *\n");
@@ -166,6 +165,6 @@ int main(int argc, char **argv)
 	printf(" */\n\n");
 	printf("#include <linux/const.h>\n\n");
 	print_facility_lists();
-	printf("\n#endif\n");
+	printf("\n");
 	return 0;
 }
-- 
2.29.2

