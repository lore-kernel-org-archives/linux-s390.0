Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5901C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 06:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78C360C41
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 06:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhJKGT4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Oct 2021 02:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbhJKGTz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Oct 2021 02:19:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59220C061762
        for <linux-s390@vger.kernel.org>; Sun, 10 Oct 2021 23:17:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d9so39477293edh.5
        for <linux-s390@vger.kernel.org>; Sun, 10 Oct 2021 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JgZFL1gbaLa9EwP6bgcRPQEmNK/hbPIe9fBJ0qz2WNE=;
        b=Wn1NP/SCh1lD8vj0hwMTgkYtoME/EeJPlAmzpOBMrfg7wY3yiSCN0Ffgy7EGhmHRPC
         zRP7m0Y/4+Rm7SZybudj81DF38xcOAVc8Nyg3mIMTy+wAEqIGuqXG8NeBGPaZ6OLFpoU
         ln5kLnnhFqGos7H5t7+iF1Ul0zQEwfYjTOeMKPAj6lU+wf/Qp3F9r1F7eNjOZIXxaGEg
         KoZ6nAO/xYkS7A8NBVh3x52f7ZK4SkdCPQSLHl1wumnP0378CA8BmoNLmuA6iHfK3zou
         t4Z9Bry2XRLH0Uqzprc/zZppCg6s1eUAXvjWeRavbxlmoe9wLpfxiATGoBwEq2F3hobE
         FheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JgZFL1gbaLa9EwP6bgcRPQEmNK/hbPIe9fBJ0qz2WNE=;
        b=F4V9ca2q3xJdJN+gh+hiPcJH3yFGVFN6rvbPMZt1J3yh2z5ZAB6Lr1cOmeIOPuElF9
         CGG3fPLQ6wsTE7BAPTZ3iZLcg4gNKUkz/L+zFw2Q9UNrQNxRkGIisV67Rs4S6ElakI2i
         Lleif3xn4pefEsB2zUuS21qcgj0xLHMYp/dGyxQezeoSvCGy0v0vRXqp7SXuxN+ED8T3
         UzeWVfQ98JWH004jsB403Z+MT4LwQA2Dx6TAILkBctMj2z5iNW5JjCy9ajQb3CsR7G+D
         TPkCgAAHcYAMQdMrZyyYLc2ANvUvsGxfTkUj34S0ScjDcB13hC7Nhk7ZN+8VHr4NNz1M
         y38Q==
X-Gm-Message-State: AOAM533I4H5sOmynk0JckJ9BBb4BYfgC178sjGOpeL08efLdbe2Ap5A5
        ipyX+WS8I1abOr1nqEsY2lSg35hJ++OlQXrewsrs7A==
X-Google-Smtp-Source: ABdhPJwoQalBJZOhb3Yo1GbsmrfZ+B7X+l1AbPRIvtMqw7LXKPPxvt4v8nMcKO6w2OoJWga+avsMf5+tN/Uwwug30zQ=
X-Received: by 2002:a17:906:c302:: with SMTP id s2mr22596326ejz.499.1633933073798;
 Sun, 10 Oct 2021 23:17:53 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 11 Oct 2021 11:47:42 +0530
Message-ID: <CA+G9fYuqwJD5bFO74vG6Mvbbt1G8rxzd_NDHg-gtOZ6rPjeu3A@mail.gmail.com>
Subject: clang-13: s390/kernel/head64.S:24:17: error: invalid operand for instruction
To:     llvm@lists.linux.dev, linux-s390@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

[Please ignore this email if it is already reported ]

Following s390 builds failed due to warnings / errors.

metadata:
    git_describe: v5.15-rc5
    git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    git_short_log: 64570fbc14f8 (\"Linux 5.15-rc5\")
    target_arch: s390
    toolchain: clang-13


Fail (2861 errors) s390 (tinyconfig) with clang-nightly
  @ https://builds.tuxbuild.com/1zL35IUSGhDGeVuyIrAp7eyzEUi/
Fail (2861 errors) s390 (tinyconfig) with clang-13
  @ https://builds.tuxbuild.com/1zL35Hn7wjErKsLDM6zAgh27BYJ/
Fail (4112 errors) s390 (allnoconfig) with clang-13
  @ https://builds.tuxbuild.com/1zL35HR60hSFvBmAcYJvKHm8Lko/
Fail (4112 errors) s390 (allnoconfig) with clang-nightly
  @ https://builds.tuxbuild.com/1zL35DTlrX9qRGCtGqgtmmMDjnQ/
Fail (23048 errors) s390 (defconfig) with clang-13
  @ https://builds.tuxbuild.com/1zL35DE2KWQUPxbbXeTbwIJaWXS/
Fail (23045 errors) s390 (defconfig) with clang-nightly
  @ https://builds.tuxbuild.com/1zL35EgeQfWQDXDupp4itkUO5At/


Build errors log:
----------------
arch/s390/kernel/head64.S:24:17: error: invalid operand for instruction
 lctlg %c0,%c15,.Lctl-.LPG1(%r13) # load control registers
                ^
arch/s390/kernel/head64.S:40:8: error: invalid operand for instruction
 lpswe .Ldw-.(%r13) # load disabled wait psw
       ^
make[3]: *** [scripts/Makefile.build:379: arch/s390/kernel/head64.o] Error 1
In file included from kernel/sched/cputime.c:5:
In file included from kernel/sched/sched.h:5:
In file included from include/linux/sched.h:14:
In file included from include/linux/pid.h:6:
In file included from include/linux/wait.h:9:
In file included from include/linux/spinlock.h:94:
arch/s390/include/asm/spinlock.h:89:3: error: expected absolute expression
                ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                ^
arch/s390/include/asm/alternative.h:111:2: note: expanded from macro
'ALTERNATIVE'
        ALTINSTR_REPLACEMENT(altinstr, 1)                               \
        ^
arch/s390/include/asm/alternative.h:106:2: note: expanded from macro
'ALTINSTR_REPLACEMENT'
        INSTR_LEN_SANITY_CHECK(altinstr_len(num))
        ^
arch/s390/include/asm/alternative.h:62:3: note: expanded from macro
'INSTR_LEN_SANITY_CHECK'
        ".if " len " > 254\n"                                           \
         ^
<inline asm>:5:5: note: instantiated into assembly here
.if 6651b-6641b > 254
    ^
In file included from kernel/sched/cputime.c:5:
In file included from kernel/sched/sched.h:5:
In file included from include/linux/sched.h:14:
In file included from include/linux/pid.h:6:
In file included from include/linux/wait.h:9:
In file included from include/linux/spinlock.h:94:
arch/s390/include/asm/spinlock.h:89:3: error: cpu alternatives does
not support instructions blocks > 254 bytes
                ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                ^
arch/s390/include/asm/alternative.h:111:2: note: expanded from macro
'ALTERNATIVE'
        ALTINSTR_REPLACEMENT(altinstr, 1)                               \
        ^
arch/s390/include/asm/alternative.h:106:2: note: expanded from macro
'ALTINSTR_REPLACEMENT'
        INSTR_LEN_SANITY_CHECK(altinstr_len(num))
        ^
arch/s390/include/asm/alternative.h:63:3: note: expanded from macro
'INSTR_LEN_SANITY_CHECK'
        "\t.error \"cpu alternatives does not support instructions "    \
         ^
<inline asm>:6:2: note: instantiated into assembly here
        .error "cpu alternatives does not support instructions blocks
> 254 bytes"
        ^
In file included from kernel/sched/cputime.c:5:
In file included from kernel/sched/sched.h:5:
In file included from include/linux/sched.h:14:
In file included from include/linux/pid.h:6:
In file included from include/linux/wait.h:9:
In file included from include/linux/spinlock.h:94:
arch/s390/include/asm/spinlock.h:89:3: error: expected absolute expression
                ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                ^
arch/s390/include/asm/alternative.h:111:2: note: expanded from macro
'ALTERNATIVE'
        ALTINSTR_REPLACEMENT(altinstr, 1)                               \
        ^
arch/s390/include/asm/alternative.h:106:2: note: expanded from macro
'ALTINSTR_REPLACEMENT'
        INSTR_LEN_SANITY_CHECK(altinstr_len(num))
        ^
arch/s390/include/asm/alternative.h:66:3: note: expanded from macro
'INSTR_LEN_SANITY_CHECK'
        ".if (" len ") %% 2\n"                                          \
         ^
<inline asm>:8:5: note: instantiated into assembly here
.if (6651b-6641b) % 2
    ^
In file included from kernel/sched/cputime.c:5:
In file included from kernel/sched/sched.h:5:
In file included from include/linux/sched.h:14:
In file included from include/linux/pid.h:6:
In file included from include/linux/wait.h:9:
In file included from include/linux/spinlock.h:94:
arch/s390/include/asm/spinlock.h:89:3: error: cpu alternatives
instructions length is odd
                ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                ^

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime podman --target-arch s390 --toolchain clang-13
--kconfig defconfig

-- 
Linaro LKFT
https://lkft.linaro.org
