Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37839C432BE
	for <linux-s390@archiver.kernel.org>; Thu,  5 Aug 2021 07:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF0061008
	for <linux-s390@archiver.kernel.org>; Thu,  5 Aug 2021 07:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbhHEHuw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbhHEHuv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Aug 2021 03:50:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E9EC0613D5
        for <linux-s390@vger.kernel.org>; Thu,  5 Aug 2021 00:50:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b13so5275524wrs.3
        for <linux-s390@vger.kernel.org>; Thu, 05 Aug 2021 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Os9VBo5ol0/OE/zsUlv+66XdPO6lV3sKgplzYRLLhU=;
        b=dthuYtFBHhD3kr3ForYIFvZSUVRL+g4AvqqJ5MqApy7GwqLEWJD3FrctTfuA/tYCpx
         sNlgxyx8sXHQzq89b9u747HAwdEzj71m31DAEjlOG4IqiLXyya660ZghaSD7+gnKMnU7
         CHSvH2cOEP9AnKaBxJCKZ0NlqS7ZaSFDoptZ9EgPjxRwVWbSl/2PJ56sjS6SUkW+X0O6
         Ev2dNvflaVoteEN2KzSSdFNpcJpkxuD3jT9ftBEozrIwoGOSjpGgiyC7agZv6GyQQhpF
         DLkjSoc0Xat8zqIdRl9NoSFJ5NLqQoX9ttPJ8DWoB97sP3VtcZzD/pkBZHXH7KMl1fKB
         GcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Os9VBo5ol0/OE/zsUlv+66XdPO6lV3sKgplzYRLLhU=;
        b=dGLqyyzefDoI9BmhHArnqzA1s4XvbLTeDkF8PkOXGTUsDamQ+Z6WrIOBeNg8BBzrnT
         Jmr4eF+mtn2leSlBio/ubKg9uOQXezU3ZPQVjFk6ZMpICyGpa8WTT7kDL76UT6krQDYS
         fEkzbvLLiYV+QFDrZbP8OvO7wb462Z6qWiaWIk6Vq5mmFNIMO9cAl3ymBwM3KzSPO42v
         TqlsPEmh+X7lOl537Yx9FLetCHl9UPDyfQ8iGuJeAP6r7q0snxaqcBhxeT0gAlNicsfE
         u6wustELZeJ6uqsPky9jyCa4qUSUoql6ZrGw4xUeTjpXBhqXkGIX/Tj5AB3qY3FP3P8t
         gs/w==
X-Gm-Message-State: AOAM530SUVPBor5mEqCEmAbPVKRd93YTXuMNX4u6reZRqGPN07j11TrV
        VUdlWznEzJuCbNgsVea4jtf7HQ==
X-Google-Smtp-Source: ABdhPJw8HrMNDFxDvHEKsrTuUr73DV6B7ZEHdGYK/OgbJyv26WO2sghDmY9iYMdlRWWqluqCuDH5CA==
X-Received: by 2002:adf:ed4f:: with SMTP id u15mr3439300wro.423.1628149836117;
        Thu, 05 Aug 2021 00:50:36 -0700 (PDT)
Received: from localhost.localdomain ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id h16sm5154491wre.52.2021.08.05.00.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 00:50:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Chris Zankel <chris@zankel.net>,
        "David S . Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>, John Crispin <john@phrozen.org>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>, openrisc@lists.librecores.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 0/3] power: reset: Convert Power-Off driver to tristate
Date:   Thu,  5 Aug 2021 08:50:29 +0100
Message-Id: <20210805075032.723037-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Provide support to compile the Power-Off driver as a module.

Elliot Berman (2):
  reboot: Export reboot_mode
  power: reset: Enable tristate on restart power-off driver

Lee Jones (1):
  arch: Export machine_restart() instances so they can be called from
    modules

 arch/arc/kernel/reset.c            | 1 +
 arch/arm/kernel/reboot.c           | 1 +
 arch/arm64/kernel/process.c        | 1 +
 arch/csky/kernel/power.c           | 1 +
 arch/h8300/kernel/process.c        | 1 +
 arch/hexagon/kernel/reset.c        | 1 +
 arch/m68k/kernel/process.c         | 1 +
 arch/microblaze/kernel/reset.c     | 1 +
 arch/mips/kernel/reset.c           | 1 +
 arch/mips/lantiq/falcon/reset.c    | 1 +
 arch/mips/sgi-ip27/ip27-reset.c    | 1 +
 arch/nios2/kernel/process.c        | 1 +
 arch/openrisc/kernel/process.c     | 1 +
 arch/parisc/kernel/process.c       | 1 +
 arch/powerpc/kernel/setup-common.c | 1 +
 arch/riscv/kernel/reset.c          | 1 +
 arch/s390/kernel/setup.c           | 1 +
 arch/sh/kernel/reboot.c            | 1 +
 arch/sparc/kernel/process_32.c     | 1 +
 arch/sparc/kernel/reboot.c         | 1 +
 arch/um/kernel/reboot.c            | 1 +
 arch/x86/kernel/reboot.c           | 1 +
 arch/xtensa/kernel/setup.c         | 1 +
 drivers/power/reset/Kconfig        | 2 +-
 kernel/reboot.c                    | 2 ++
 25 files changed, 26 insertions(+), 1 deletion(-)

Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: David S. Miller <davem@davemloft.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: John Crispin <john@phrozen.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-um@lists.infradead.org
Cc: linux-xtensa@linux-xtensa.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Simek <monstr@monstr.eu>
Cc: openrisc@lists.librecores.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Rich Felker <dalias@libc.org>
Cc: sparclinux@vger.kernel.org
Cc: Stafford Horne <shorne@gmail.com>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
-- 
2.32.0.605.g8dce9f2422-goog

