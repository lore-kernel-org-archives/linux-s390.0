Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5DAEB64DC
	for <linux-s390@archiver.kernel.org>; Thu,  6 Jul 2023 12:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjGFMGc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 6 Jul 2023 08:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjGFMGb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jul 2023 08:06:31 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA651726
        for <linux-s390@vger.kernel.org>; Thu,  6 Jul 2023 05:06:29 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-471b3ad20e1so162140e0c.1
        for <linux-s390@vger.kernel.org>; Thu, 06 Jul 2023 05:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688645188; x=1691237188;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+en178Cl6iQ5BRYxnHo5Dcr68jDKvEi3JCQZvb0sU/k=;
        b=ZuLvHFBG8JzTYHBEjdR6N8DQDxp63For0i8HE5cbrkX6TWJ6pNKXdID4DM8LbcCjU8
         k00BmpssqYrUgUcg5cbWq3js84amDzeVZ6mCkmIN+UOPmQPY8h8clGKQ6HXp7gScdKoJ
         Y0YBp8FhRMFkI/j2tSjF2Zwhvc9/1r3VGHea6D/J8qH2IedmfXJ4ejuh3ljEC3qahvnt
         9CUGGtfgs30+dJ1qy/p9cq3+D5OptrO2uAg6D613HFug1OGuRRNK2uwEAfSpOYfWcIW1
         unWvPPGR8Jdf6thB7lg3IvtWLDrwSpyC0jNcGTu87CouUsW2miLMyDVCrHI8lTixC72s
         mIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688645188; x=1691237188;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+en178Cl6iQ5BRYxnHo5Dcr68jDKvEi3JCQZvb0sU/k=;
        b=HwaesqAPaAJUc9F6o7Ihb67KL2f1wOVbGcSc9js+oBuaXm/G/KMTEJoBFzyyp9ewNO
         +id1/84U8lONjY4jxLVX441JiA1qFeMlpWHVAFHfGSc8q6m2pWqHgGircWp3owgGVT9z
         S8flrOE+z9zG6ijl1nl4teri6D/ySGzucdnJSkL7YbIMgCB0RkitZLUHOltO9vO7UmIT
         bSxpcbTZZgYawMpMWVKBIU5MZNJUu53eTHLhhNwPbT89Ejf3hf0604P9eaFQOEiunyod
         Bub/+d9EqmuDY0R1ibNGFB5mjBUL0ZDYDf7qRbjcar+4MpF+h7nC+sV2bmnKGE0hmg5a
         hS/Q==
X-Gm-Message-State: ABy/qLbDBpUx+b6WRn9Tz0/Yc1e3TlJmFUjiPqZIazBxDqbGxJZyfRr5
        6r3qiAm8+InyHHRys7lq1BLy6DXut8JnEQgzo7wkk/tfHaV6qBjCPAo=
X-Google-Smtp-Source: APBJJlEr+S/SxlC8on+YPoPgJVDUU6m84TPNtgPAoK/XkqVyGLTlYrf57fAHuu62UGciScrsqJMlt3NeMdEwc8xWYag=
X-Received: by 2002:a1f:6244:0:b0:471:4ceb:675f with SMTP id
 w65-20020a1f6244000000b004714ceb675fmr596732vkb.9.1688645188433; Thu, 06 Jul
 2023 05:06:28 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 6 Jul 2023 17:36:17 +0530
Message-ID: <CA+G9fYvHxcU-gdgFY6r6UrYpzA8bh262ChABZREkBQrmA-L91A@mail.gmail.com>
Subject: next: s390: arch/s390/kernel/machine_kexec.c:192:18: error: invalid
 use of undefined type 'struct kimage'
To:     linux-s390@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Following build regressions found on Linux next-20230706.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on s390:

 - build/gcc-8-tinyconfig
 - build/clang-nightly-allnoconfig
 - build/gcc-12-allnoconfig
 - build/gcc-12-tinyconfig
 - build/clang-nightly-tinyconfig
 - build/clang-16-allnoconfig
 - build/clang-16-tinyconfig
 - build/gcc-8-allnoconfig

Build error:
====
arch/s390/kernel/machine_kexec.c:120:37: warning: 'struct kimage'
declared inside parameter list will not be visible outside of this
definition or declaration
  120 | static bool kdump_csum_valid(struct kimage *image)
      |                                     ^~~~~~
arch/s390/kernel/machine_kexec.c:188:34: warning: 'struct kimage'
declared inside parameter list will not be visible outside of this
definition or declaration
  188 | int machine_kexec_prepare(struct kimage *image)
      |                                  ^~~~~~
arch/s390/kernel/machine_kexec.c: In function 'machine_kexec_prepare':
arch/s390/kernel/machine_kexec.c:192:18: error: invalid use of
undefined type 'struct kimage'
  192 |         if (image->type == KEXEC_TYPE_CRASH)
      |                  ^~
arch/s390/kernel/machine_kexec.c:192:28: error: 'KEXEC_TYPE_CRASH'
undeclared (first use in this function); did you mean
'KEXEC_ON_CRASH'?
  192 |         if (image->type == KEXEC_TYPE_CRASH)
      |                            ^~~~~~~~~~~~~~~~
      |                            KEXEC_ON_CRASH
arch/s390/kernel/machine_kexec.c:192:28: note: each undeclared
identifier is reported only once for each function it appears in
arch/s390/kernel/machine_kexec.c:196:18: error: invalid use of
undefined type 'struct kimage'
  196 |         if (image->type != KEXEC_TYPE_DEFAULT)
      |                  ^~
arch/s390/kernel/machine_kexec.c:196:28: error: 'KEXEC_TYPE_DEFAULT'
undeclared (first use in this function); did you mean
'KEXEC_ARCH_DEFAULT'?
  196 |         if (image->type != KEXEC_TYPE_DEFAULT)
      |                            ^~~~~~~~~~~~~~~~~~
      |                            KEXEC_ARCH_DEFAULT
In file included from arch/s390/include/asm/thread_info.h:31,
                 from include/linux/thread_info.h:60,
                 from arch/s390/include/asm/preempt.h:6,
                 from include/linux/preempt.h:79,
                 from arch/s390/include/asm/percpu.h:5,
                 from include/linux/irqflags.h:18,
                 from include/linux/rcupdate.h:26,
                 from include/linux/rculist.h:11,
                 from include/linux/pid.h:5,
                 from include/linux/sched.h:14,
                 from include/linux/ratelimit.h:6,
                 from include/linux/dev_printk.h:16,
                 from include/linux/device.h:15,
                 from arch/s390/kernel/machine_kexec.c:9:
arch/s390/kernel/machine_kexec.c:200:48: error: invalid use of
undefined type 'struct kimage'
  200 |         reboot_code_buffer = page_to_virt(image->control_code_page);
      |                                                ^~


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230706/testrun/18173978/suite/build/test/gcc-12-tinyconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230706/testrun/18173978/suite/build/test/gcc-12-tinyconfig/history/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2SBB5EGvx1egXcvg0fwoJIyLbSK/


--
Linaro LKFT
https://lkft.linaro.org
