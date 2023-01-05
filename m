Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023C4C3DA7A
	for <linux-s390@archiver.kernel.org>; Thu,  5 Jan 2023 16:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjAEQti (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 Jan 2023 11:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjAEQth (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Jan 2023 11:49:37 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1E050E76
        for <linux-s390@vger.kernel.org>; Thu,  5 Jan 2023 08:49:35 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id i185so5163272vsc.6
        for <linux-s390@vger.kernel.org>; Thu, 05 Jan 2023 08:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NP2Dg9YGoVI0aRQKZRKmk+2NtfJSRs4wKdvzmTJdN30=;
        b=RJeT9XepF5TTt/k0dUZV/SE5YL3hVU4D6mmbfEyA4pmwBB7u9Hos32VINgv35XTGab
         e1EXuv+4aVSIQ061+9zrQAbgzlhfggRsZKmpsPRyPT6cQRgiRsSJSnvXBa+4PG40zTNO
         00JGmopVss5r+0M6adjab+hKHQkwB2SUXfUXg9MzG2Or16N3U/ApampP8ko3k//fpf6s
         6OcTtIuf+RbrJsoHRYlVSFodrr9JJIv7aAGBgldqjq8vIrh6mD3/nhlVkwMkzMPkD/vb
         rR8Ff8MUNMLEtlbJhoALbRGIKZD6O0O/ULVVb6Khz/GuqpJZxjILWSz2pgplusYWSOXL
         GFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NP2Dg9YGoVI0aRQKZRKmk+2NtfJSRs4wKdvzmTJdN30=;
        b=rWX+UONAz479DdoUZhM+Pc+n1G7BlpsHUcmuy1GhbJaDnjOPh9u8s2Eis2No91UY1b
         0hg9up2hd4tut1/MZB6iDu5r0xkDz2z6KqtBjd4LRwiBWKxzXJ2dH53IQRZkgGifYihu
         s6WgPb7Dffai8F6ygSjKf0QzTVO9sE5VcktW4HUu3IrfBkVn3qqnoLjnJ6xp8joFovl9
         qFgV4UD4CTTq9DX4ObX0YlGrfr+jwrzw6xwuRs3k8yMXqqT4HWVVm1HrF/I2UIRH1tI+
         cf3mrNed7zpeGMI+bnlo9Y6RU6Wy8QlebPORqaS+nLBrzeCRlu9v1ZOSJ9mon/EL4kUY
         ZIiA==
X-Gm-Message-State: AFqh2kryQ1TNgKZxszQ13w8WOOiRvbhm0qnNumNDokT5gQwlmzypfKEN
        TgVEO0if5YKns/7aBUpVLWTZHyj4JIvcjbx23R9/Vgdl0Jmv1heM
X-Google-Smtp-Source: AMrXdXt4N8lhwv0Ijg2+gCVWyvzAM1F/iq8VgL5hQCW+zidR9kVMzq0d/GtKCdfAgZeULmnXAfCUBpSPOnUqtk9txS0=
X-Received: by 2002:a05:6102:3003:b0:3ce:c6d7:a4e3 with SMTP id
 s3-20020a056102300300b003cec6d7a4e3mr68204vsa.3.1672937374400; Thu, 05 Jan
 2023 08:49:34 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 5 Jan 2023 22:19:23 +0530
Message-ID: <CA+G9fYu6=N4OU11CcHqh5auVJ4WdrR4QmovHjni-z88N41y8zw@mail.gmail.com>
Subject: next: clang-15: s390x-linux-gnu-ld: BFD (GNU Binutils for Debian)
 2.35.2 assertion fail ../../bfd/elf64-s390.c:3349
To:     linux-s390@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The s390 clang-15 build failures on Linux next-20230105 due to following
errors / warnings.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

`.exit.text' referenced in section `__jump_table' of fs/fuse/inode.o:
defined in discarded section `.exit.text' of fs/fuse/inode.o
`.exit.text' referenced in section `__jump_table' of fs/fuse/inode.o:
defined in discarded section `.exit.text' of fs/fuse/inode.o
`.exit.text' referenced in section `__bug_table' of crypto/algboss.o:
defined in discarded section `.exit.text' of crypto/algboss.o
`.exit.text' referenced in section `__bug_table' of drivers/scsi/sd.o:
defined in discarded section `.exit.text' of drivers/scsi/sd.o
`.exit.text' referenced in section `__jump_table' of drivers/md/md.o:
defined in discarded section `.exit.text' of drivers/md/md.o
`.exit.text' referenced in section `__jump_table' of drivers/md/md.o:
defined in discarded section `.exit.text' of drivers/md/md.o
`.exit.text' referenced in section `.altinstructions' of
drivers/md/md.o: defined in discarded section `.exit.text' of
drivers/md/md.o
`.exit.text' referenced in section `.altinstructions' of
drivers/md/md.o: defined in discarded section `.exit.text' of
drivers/md/md.o
`.exit.text' referenced in section `.altinstructions' of
net/iucv/iucv.o: defined in discarded section `.exit.text' of
net/iucv/iucv.o
`.exit.text' referenced in section `__bug_table' of
drivers/s390/cio/qdio_thinint.o: defined in discarded section
`.exit.text' of drivers/s390/cio/qdio_thinint.o
`.exit.text' referenced in section `__bug_table' of
drivers/s390/net/qeth_l3_main.o: defined in discarded section
`.exit.text' of drivers/s390/net/qeth_l3_main.o
`.exit.text' referenced in section `__bug_table' of
drivers/s390/net/qeth_l3_main.o: defined in discarded section
`.exit.text' of drivers/s390/net/qeth_l3_main.o
s390x-linux-gnu-ld: BFD (GNU Binutils for Debian) 2.35.2 assertion
fail ../../bfd/elf64-s390.c:3349
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
make[2]: Target '__default' not remade because of errors.
make[1]: *** [Makefile:1252: vmlinux] Error 2

metadata:
--------
build_name: clang-15-defconfig
config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2JtJjVEWoJkAJtKsrWamxsxAQb2/config
git_describe: next-20230105
git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
git_sha: cc3c08b41a9c9402ead726ec6deb1217081d0d8b

build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2JtJjVEWoJkAJtKsrWamxsxAQb2/

Steps to reproduce with tuxmake:
--------------------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

 tuxmake --runtime podman --target-arch s390 --toolchain clang-15
--kconfig defconfig LLVM_IAS=0

--
Linaro LKFT
https://lkft.linaro.org
