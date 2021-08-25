Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CA7C432BE
	for <linux-s390@archiver.kernel.org>; Wed, 25 Aug 2021 03:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3062D6128A
	for <linux-s390@archiver.kernel.org>; Wed, 25 Aug 2021 03:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbhHYDuk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 Aug 2021 23:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbhHYDuY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Aug 2021 23:50:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D975AC0613CF
        for <linux-s390@vger.kernel.org>; Tue, 24 Aug 2021 20:49:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m4so2485553pll.0
        for <linux-s390@vger.kernel.org>; Tue, 24 Aug 2021 20:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CbvF3gcMl15CsJvEJlvAwV4jg0kS7/1c0/243X9NmVQ=;
        b=nS8Xfv5Np514ewOr71qM5OVYQ4om375+9iia5AAYDaK3OM+hzJenuJr7dAU5cYremk
         lMJSdk/H6gRuWyoAZ38Dxo4xTOwzwlYBTQ7mHvrJGvY2eRlpd9btrTwCc/T4R+lnp2Oz
         tfjjB9XYA84IA+sxs7E0+0bjR3ImZY/NCblTCqWV1vz8ngiUx+QRlaWbVMisVRWW3rOO
         yK85Pgi7JMY0nVAg9WrPZrM52PG/5lW+DmvVcQIgBTfNfdcKCdUHJCl4J+hHtwrGzLzq
         JQXK/nMftIjnNhxqPt/IHdPMmbV0SixoX/iiQ7rUV+IDNkS5Y0uflbsJwBJg2KghrkLe
         Gahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CbvF3gcMl15CsJvEJlvAwV4jg0kS7/1c0/243X9NmVQ=;
        b=t+QccLShp+YX1bhfbziwFGki+FhhIjCsl/pSfAtId0LRpMhEdW/fjbkzVkO/TKPkpr
         NdSw0U8b4wxODRi1r1gScid11hvNP+N8cmKNz+o3NPzgQMUCw3TbgwP/WPtb8jTM9BI7
         pvztcdpK3ADRHBmG4ro8HRe4RVKjW2zAfbcLbSN2C8wblr2PH0tCSw2Fftzp+ljZV3aY
         Fk5fJjgQpFW65O3+jGKO56pfKrOUR37iMZeov/8B7ws9nCjFduNAd2fvYpazgaIXp1Yh
         /GeCYXEaqGMYjwdiRVPIWHJQCyy1xA+iiIJ6XUyj4kFAq0WL3QyKis7dVHJHx0c3jKoE
         92+A==
X-Gm-Message-State: AOAM532G14HzSMaGXWRcPV85R7U5+8AtMM3epHwpkh3KjQh+QTbMohtM
        fKtP2Ni9xEpWpwieFXJDHJR0JA==
X-Google-Smtp-Source: ABdhPJyuW0xG5fzwlVnm+V74njUWhK4iHoDYuJqptloS8iraqWcj5+LzzcKnLTPVDHS2p7IwfcePKA==
X-Received: by 2002:a17:90a:428f:: with SMTP id p15mr8241589pjg.75.1629863378109;
        Tue, 24 Aug 2021 20:49:38 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q21sm23393107pgk.71.2021.08.24.20.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 20:49:37 -0700 (PDT)
Date:   Tue, 24 Aug 2021 20:49:37 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Aug 2021 20:42:18 PDT (-0700)
Subject:     Re: [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT in Kconfig
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
CC:     rostedt@goodmis.org, mingo@redhat.com, masahiroy@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, ardb@kernel.org, bp@alien8.de,
        linus.walleij@linaro.org, ley.foon.tan@intel.com, x86@kernel.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        anshuman.khandual@arm.com, nickhu@andestech.com,
        tglx@linutronix.de, rppt@kernel.org, geert@linux-m68k.org,
        peterz@infradead.org, catalin.marinas@arm.com,
        linux-riscv@lists.infradead.org, yifeifz2@illinois.edu,
        green.hu@gmail.com, monstr@monstr.eu, deller@gmx.de,
        linux-sh@vger.kernel.org, vgupta@synopsys.com,
        u.kleine-koenig@pengutronix.de, guoren@kernel.org,
        samitolvanen@google.com, richard@nod.at, borntraeger@de.ibm.com,
        dalias@libc.org, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        jdike@addtoit.com, jcmvbkbc@gmail.com,
        linux-hexagon@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        hpa@zytor.com, will@kernel.org, tsbogend@alpha.franken.de,
        stefan.kristiansson@saunalahti.fi, linux-s390@vger.kernel.org,
        ysato@users.sourceforge.jp, James.Bottomley@HansenPartnership.com,
        linux-um@lists.infradead.org, andreyknvl@gmail.com,
        frederic@kernel.org, npiggin@gmail.com, benh@kernel.crashing.org,
        bcain@codeaurora.org, linux-csky@vger.kernel.org, shorne@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, chris@zankel.net,
        gor@linux.ibm.com, linux-snps-arc@lists.infradead.org,
        jonas@southpole.se, linux-parisc@vger.kernel.org,
        keescook@chromium.org, krzysztof.kozlowski@canonical.com,
        colin.king@canonical.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, deanbo422@gmail.com,
        anton.ivanov@cambridgegreys.com, akpm@linux-foundation.org,
        mpe@ellerman.id.au, paulus@samba.org, mark.rutland@arm.com,
        viresh.kumar@linaro.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     masahiroy@kernel.org
Message-ID: <mhng-fae2ea79-c261-4e5d-8eae-21e60810a957@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 30 Jul 2021 22:22:32 PDT (-0700), masahiroy@kernel.org wrote:
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/riscv/Kconfig            | 4 +---

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
