Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FBBC53210
	for <linux-s390@archiver.kernel.org>; Thu, 29 Dec 2022 16:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiL2QWv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Dec 2022 11:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiL2QW1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Dec 2022 11:22:27 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DB113D1E
        for <linux-s390@vger.kernel.org>; Thu, 29 Dec 2022 08:22:25 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 78so12657339pgb.8
        for <linux-s390@vger.kernel.org>; Thu, 29 Dec 2022 08:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGyrD0+PhkAL5dbAeObFs9RwoqBo5ONG0NwovuaDsrM=;
        b=dahVygbdXamhJiKEgN7Jyg1lXYgvfTSo1DMUkYl6yXrdIMvfnyRS0HpjAJGhYD3IFg
         E+JY0GnUUwwkM2h9ox2Zgy/UxJJ4gx7kMRbUi8BoQs1MkH7ANMKs27AnO7PEO784TqXp
         ruuAqGepnkn93qVt3OFjdbG1AsqdvffnpusA3lSTC6zFKd8HiqB0qYg9fELjUJN4UbO/
         3lnm7IU3UfXKaT3AUgnmQMHaYpOZ2VZND7TcbraC5FIjkTHVAEIVzHPRo5TQwNIMJbMP
         q3kZJpTtujX11O+tGSd8oHpehkbK7CbScXp9TvIT0cj2FcWn3tOzaHwI3gNMSd/9wBDx
         rNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGyrD0+PhkAL5dbAeObFs9RwoqBo5ONG0NwovuaDsrM=;
        b=5Tg0niwCcaaG+TrMnqE70st5uIDs4VhJJUmPFMk+mNzzGVa/+R0L5oZhG0BL2CJu2b
         cdeFDb8h7lOY+SlOPOBsjdR/x8b0Qi6yHSDLERsSpgkRsV6EDlIfETFzdjFmoilJIV4C
         XPww/7RgztSp5cWNwCX3DfdgWSq8jAmtt3it9jcdKO8S/G76seFc7xp9xJrK/lwCAyA9
         XJIEwFiFGmjEGJpJ8BW1HRc8Gm05DEbos7QQ16I/S/rU+tQvRg2Kx5uQZijaQ4oXb/PD
         zR2vQd5mpxr8SPZUDB23zPHA8fFwJ4HKtbSW7LPelydEgtSCWrZX0J3YnPDzxs3x0f9v
         3GGQ==
X-Gm-Message-State: AFqh2koeXxUPbEOVKBhUBuMl70URJCo/EOzh5QBQoYc9r9Gm3jAqfxrs
        RzJtLOcfj9IaxnspyM/BSw7yPg==
X-Google-Smtp-Source: AMrXdXvpdMbR8CMYmi4dUk/9PgGNumQG+p4T2pa56FD3JYpViB2+8Ov5fWBEh9VYECa0d3vj+bwoEw==
X-Received: by 2002:aa7:99cb:0:b0:580:d188:f516 with SMTP id v11-20020aa799cb000000b00580d188f516mr22924872pfi.19.1672330945228;
        Thu, 29 Dec 2022 08:22:25 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id x185-20020a6286c2000000b0056bfebfa6e4sm12277463pfd.190.2022.12.29.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:22:24 -0800 (PST)
Date:   Thu, 29 Dec 2022 08:22:24 -0800 (PST)
X-Google-Original-Date: Thu, 29 Dec 2022 07:53:04 PST (-0800)
Subject:     Re: [PATCH v2] vdso: Improve cmd_vdso_check to check all dynamic relocations
In-Reply-To: <20221221235147.45lkqmosndritfpe@google.com>
CC:     christophe.leroy@csgroup.eu, luto@kernel.org, tglx@linutronix.de,
        vincenzo.frascino@arm.com, Arnd Bergmann <arnd@arndb.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     maskray@google.com
Message-ID: <mhng-17d41c33-7f33-4a1c-8af2-ae7d07134e8c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 21 Dec 2022 15:51:47 PST (-0800), maskray@google.com wrote:
> The actual intention is that no dynamic relocation exists. However, some
> GNU ld ports produce unneeded R_*_NONE. (If a port fails to determine
> the exact .rel[a].dyn size, the trailing zeros become R_*_NONE
> relocations. E.g. ld's powerpc port recently fixed
> https://sourceware.org/bugzilla/show_bug.cgi?id=29540) R_*_NONE are
> generally no-op in the dynamic loaders. So just ignore them.
>
> With the change, we can remove ARCH_REL_TYPE_ABS. ARCH_REL_TYPE_ABS is a
> bit misnomer as ports may check RELAVETIVE/GLOB_DAT/JUMP_SLOT which are
> not called "absolute relocations". (The patch is motivated by the arm64
> port missing R_AARCH64_RELATIVE.)
>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Change from v1:
> * rebase after 8ac3b5cd3e0521d92f9755e90d140382fc292510 (lib/vdso: use "grep -E" instead of "egrep")
> * change the commit message to mention an example GNU ld bug; no longer say the patch fixes a deprecated egrep use
> ---
>   arch/arm/vdso/Makefile            |  3 ---
>   arch/arm64/kernel/vdso/Makefile   |  3 ---
>   arch/arm64/kernel/vdso32/Makefile |  3 ---
>   arch/csky/kernel/vdso/Makefile    |  3 ---
>   arch/loongarch/vdso/Makefile      |  3 ---
>   arch/mips/vdso/Makefile           |  3 ---
>   arch/powerpc/kernel/vdso/Makefile |  1 -
>   arch/riscv/kernel/vdso/Makefile   |  3 ---
>   arch/s390/kernel/vdso32/Makefile  |  2 --
>   arch/s390/kernel/vdso64/Makefile  |  2 --
>   arch/x86/entry/vdso/Makefile      |  4 ----
>   lib/vdso/Makefile                 | 13 ++++---------
>   12 files changed, 4 insertions(+), 39 deletions(-)

[snip]

> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 06e6b27f3bcc..d85c37e11b21 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -1,9 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   # Copied from arch/tile/kernel/vdso/Makefile
>
> -# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
> -# the inclusion of generic Makefile.
> -ARCH_REL_TYPE_ABS := R_RISCV_32|R_RISCV_64|R_RISCV_JUMP_SLOT
>   include $(srctree)/lib/vdso/Makefile
>   # Symbols present in the vdso
>   vdso-syms  = rt_sigreturn

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V

Thanks!
