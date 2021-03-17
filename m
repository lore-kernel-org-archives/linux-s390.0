Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008B1C433E0
	for <linux-s390@archiver.kernel.org>; Wed, 17 Mar 2021 13:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EB464F67
	for <linux-s390@archiver.kernel.org>; Wed, 17 Mar 2021 13:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhCQN5d (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhCQN5D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Mar 2021 09:57:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4D6C06175F
        for <linux-s390@vger.kernel.org>; Wed, 17 Mar 2021 06:57:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b16so2373583eds.7
        for <linux-s390@vger.kernel.org>; Wed, 17 Mar 2021 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=i1gCxZGZSMzxgSNyMhX3tkzSKQY+iuylSLD+XBIGr7E=;
        b=uPpwp0XTkSDTqp8X40Pz+t3UZRCUltGqTvZDsNQbzXq8G8U/Dg4D2LLYmDPOgaMEgl
         g/nq4Lyt6AqSZnJD5HL28jRY9HsffEiQFeTC4Le2wjPAXxnFJq/Wl+s0v8bFv7uHRlCn
         j+Uy3y7vezbK4BPj7UAzkvHk/yTm6ek0dsnzVdaw75imafDv4zZkxeD+aoJHaJQQCKN5
         ldkLSAN0nAT0SIwVruZEklALtrJ81hqKKAezgGxwuaevq0oHwiCMOMNYkO4yakE96dPt
         JmHHOSfi0je1HqRaJBIaQPrdY0NVw6TVcBjkdqL2XAkQCVhmoyN4WOp96l3fwkVeWrqB
         zfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=i1gCxZGZSMzxgSNyMhX3tkzSKQY+iuylSLD+XBIGr7E=;
        b=o4MHwYVNU4cE2wQxNdvyzDzRA2WCMQTM9/ft+PLuSxYYXs17PJHdorxpFHk4C4a6fW
         t2rdieXftWKTz4BR9w4X75xkX+0/NIciz81+QnQox/zPe1WpjtpxmmHzjuJ1gi4Mrxe8
         IpuKT1Lo3lc9W3qh/OBWdNMjY9coBRp4KTrETOku+ye7tUJhSrLK5zOqSS+6NWZcOPqu
         9Im0AZuMxxcg0HRUXLo6UJi6ayLbC13FVMd9cERa4mz4gtu+ihLgpi7b8C520YE0CEov
         snsaJhEMUVA2wdqhgRA95X1xWXTRA3bdkbZcuswaqaGPNoj6zY/zsgRqwbAIVVFonFsO
         PgdA==
X-Gm-Message-State: AOAM530fE/sSm5416/cj1xmYjUjZo5VfeRQISTZ3KmzfRfTIMLTABzjf
        G5md1KWDwAvNEsW6wVQfBt1r2lZFqht8xV9r0XxSExdoH9GD9xGg
X-Google-Smtp-Source: ABdhPJzkWhVM8jqQi9BXdesgx5DtxP+Xvg1AmdN0Gv4go/Gz3YU0cgIo+Hur9+9mYwuhVnYzAdLOOsgHTAMJJQP+qZE=
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr42917252edd.78.1615989420684;
 Wed, 17 Mar 2021 06:57:00 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Mar 2021 19:26:49 +0530
Message-ID: <CA+G9fYtBw0HAv5OOAycK2rZ_m2Sj73krXPJ0iDzT+O8qtc19SQ@mail.gmail.com>
Subject: s390: kernel/entry.o: in function `sys_call_table_emu':
 (.rodata+0x1bc0): undefined reference to `__s390_'
To:     linux-s390@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        lkft-triage@lists.linaro.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Nixiaoming <nixiaoming@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Linux next 20210317 tag building s390 architecture failed.
 - s390 (defconfig) with gcc-8 - Failed
 - s390 (defconfig) with gcc-9 - Failed
 - s390 (defconfig) with gcc-10 - Failed

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=s390
CROSS_COMPILE=s390x-linux-gnu- 'CC=sccache s390x-linux-gnu-gcc'
'HOSTCC=sccache gcc'
s390x-linux-gnu-ld: arch/s390/kernel/entry.o: in function `sys_call_table_emu':
(.rodata+0x1bc0): undefined reference to `__s390_'
make[1]: *** [/builds/linux/Makefile:1212: vmlinux] Error 1

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

steps to reproduce:
--------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime podman --target-arch s390 --toolchain gcc-9
--kconfig defconfig

-- 
Linaro LKFT
https://lkft.linaro.org
