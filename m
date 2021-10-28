Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9674C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 28 Oct 2021 14:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF6E61073
	for <linux-s390@archiver.kernel.org>; Thu, 28 Oct 2021 14:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhJ1OPq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 28 Oct 2021 10:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhJ1OPq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 28 Oct 2021 10:15:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A119C061767
        for <linux-s390@vger.kernel.org>; Thu, 28 Oct 2021 07:13:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 5so24763852edw.7
        for <linux-s390@vger.kernel.org>; Thu, 28 Oct 2021 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2HfodvIKsXmdxTtsXOvx0knfgEclU3IICQbU3Ulbeso=;
        b=AxlRapfPYendyh+fP+pokIB+ry3X22Nm37GimJ0AKBb11iO5dWGizMLp78HALEUXk4
         5FAPeUVpRwGjcTOVuKwWxCR2MyvHvIPneTVVvM4jfkMy1qGyfQcyQ8CbsIkQ0TgJxuY0
         f9b+K98dwgFwGBnkl3SHdudosMM3xssdoz0ppmjfbeHoxEEv8j2C9ALZnS1zMOIGz1SL
         lydnO4UoGLf4MpZrliUg/6zr+BpmEj0l5gh7AshzOBYdOWLVWdB/BuGRsYxvXJM3XW5h
         yujhp0vNBQLqfH1EAwxlbuqyfJ5p6dCNZ5PqRwKYcsBhtYqdMZ0jg9QWzndD2y6XStTe
         ZHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2HfodvIKsXmdxTtsXOvx0knfgEclU3IICQbU3Ulbeso=;
        b=akQZTbilLO1VEuj5SpbRIi3el+kLzmFiaS2C5IAIEmRVP5wqKB+11zSLEAXR+IPcF5
         MuyrJHdh1YuG0PStWpPKDdTaOKt3qLhdc3+ENoKni+4rNgMVT/PEPXQi6Ncg4VMOQNVs
         qbVrWzi5AVe8AAtobAW9LsktuGuJRwRJ51k98heLFX1UaK7jGSg1rZJBgDS/U3Bd2RvZ
         5I4D585/x2EkRNTYVEMc4wMzVoVsguwz/6e8gxpM89Qb8F1NbpGzpTyb52UhyjlUVAzM
         /uZXMxgstXoFjh4CSnJhBz0Vi++JJhO38MU/XNdlVj1ezswifrExAZZ5/+IYvZTEM2+2
         hdow==
X-Gm-Message-State: AOAM532+eZ2XfIQeh8F7YjHKwONxRPiwQ8vruM97fuKYB/3g3vt6PL8x
        fG4wPVYuhOro+YYbM+qHi9Xvc083uZvN/SUbrZQpyFJnAbOlDg==
X-Google-Smtp-Source: ABdhPJx7xbYO3adfzEdDBvMW/w1USw7c2rkLDD2FkHY1ila44wcCYWIIbjglpZRlhGy45J2a59Uh6OCPYkKbn37zQy4=
X-Received: by 2002:a17:906:c7c1:: with SMTP id dc1mr5908906ejb.6.1635430396601;
 Thu, 28 Oct 2021 07:13:16 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 28 Oct 2021 19:43:04 +0530
Message-ID: <CA+G9fYu=0pViKt-9bZA91qaq1WgHBYA4=o1kHz6VMNp_3EBM1g@mail.gmail.com>
Subject: s390: facility.h:98:22: error: implicit declaration of function
 'min_t' [-Werror=implicit-function-declaration]
To:     linux-s390@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Regression found on s390 gcc-11 built with defconfig
Following build warnings / errors reported on linux next 20211028.

metadata:
    git_describe: next-20211028
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_short_log: 503f375baa99 (\"Add linux-next specific files for 20211028\")
    target_arch: s390
    toolchain: gcc-11

build error :
--------------
<stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [-Wcpp]
In file included from arch/s390/pci/pci_insn.c:12:
arch/s390/include/asm/facility.h: In function '__stfle':
arch/s390/include/asm/facility.h:98:22: error: implicit declaration of
function 'min_t' [-Werror=implicit-function-declaration]
   98 |                 nr = min_t(unsigned long, (nr + 1) * 8, size * 8);
      |                      ^~~~~
arch/s390/include/asm/facility.h:98:28: error: expected expression
before 'unsigned'
   98 |                 nr = min_t(unsigned long, (nr + 1) * 8, size * 8);
      |                            ^~~~~~~~
cc1: some warnings being treated as errors


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build link:
-----------
https://builds.tuxbuild.com/208R0Wv3siu0646e0z4lUYcUQD3/build.log

build config:
-------------
https://builds.tuxbuild.com/208R0Wv3siu0646e0z4lUYcUQD3/config

# To install tuxmake on your system globally
# sudo pip3 install -U tuxmake
tuxmake --runtime podman --target-arch s390 --toolchain gcc-11
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org
