Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB1CC742A7
	for <linux-s390@archiver.kernel.org>; Tue,  7 Mar 2023 21:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCGVmC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Mar 2023 16:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCGVmB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Mar 2023 16:42:01 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C8A6178
        for <linux-s390@vger.kernel.org>; Tue,  7 Mar 2023 13:41:59 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id x11so11090801pln.12
        for <linux-s390@vger.kernel.org>; Tue, 07 Mar 2023 13:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678225318;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0UBWEzua7mI1E3a/+R1pzklpJ+RGJpYFy9mijom/UM=;
        b=3d0i9L9fgsM6wfDV6SgEVPe2doCmA84h8dgaHpMbejZeZuQRklJuURRf6PhkCN7ukc
         w/n+8nbuC+OW0mQWtjtERbzb9wBvkWnsuB3UcR0sH2Ba3g7FDMT+jDol43sV0ZSapUuU
         afFVzDtGs7qaCnWpNgGUvXPCI9VeRCtjLQt1T3AcBXMLT19wGawFny88dkq7b+SM519J
         izcWM0iUW0/Sac/AVhLneLvdpP7x0olNKc4YqRIWvevDICe0+qs1ypmIQEYjXt6H2n6Q
         PGyqmNUpfeGmcTALJ+qCkHjqjpTn7tbuCsOrFtOo3YqXRw3n/PRxx6fcIN5oBf8fOwBc
         hPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678225318;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0UBWEzua7mI1E3a/+R1pzklpJ+RGJpYFy9mijom/UM=;
        b=eBxv2X+aTlZEyQdOK/KFulLe6epN06qI2Md1AC+Iv7tIz1SbvdJ44M80vKQ7iXaHW8
         uZPJVxB5wYL5n+4sOxUvxGXUA5dIm+mCAvaZDPY4GnQ5+2hLg4nNzrifyHRi5yxaM3X7
         p/oTPZjV297nWzVidSoOnKI7Yz04vO/9MoTPtv7vubLtHQ3o1TrDsmvT5Xaowxe0ZY2V
         yPCEV++/iB9cC2RbTsQoOhUh8OfkzRVVcnsRomehT0TA+vCyy7BkKZknk/dOSmSBhVoo
         f6TbYGok5GzdNjetzpuPPqWgqlGLdLF60q+0LrDuDoo2NmgKzE6ZBrzqrEBHCCu/UsPQ
         ueOA==
X-Gm-Message-State: AO0yUKVLm6A24fbzzF2c7lFjryz/VjZyGd9fLCAayyiunTfpXBfFkIbR
        QoOULFJ5WQBSqc+7GXXLQkU/oQ==
X-Google-Smtp-Source: AK7set/K6eJAQf/eSbaq269PoSBswE0gsDc5h7lzSW9lr2zauw1plinMmCGHpVyR/4qKnDR1/eXDIg==
X-Received: by 2002:a17:902:ce90:b0:19a:9434:af30 with SMTP id f16-20020a170902ce9000b0019a9434af30mr18505363plg.18.1678225318377;
        Tue, 07 Mar 2023 13:41:58 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id km12-20020a17090327cc00b0019e30e3068bsm8866509plb.168.2023.03.07.13.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 13:41:57 -0800 (PST)
Date:   Tue, 07 Mar 2023 13:41:57 -0800 (PST)
X-Google-Original-Date: Tue, 07 Mar 2023 13:40:59 PST (-0800)
Subject:     Re: [PATCH v5 12/26] riscv: Remove COMMAND_LINE_SIZE from uapi
In-Reply-To: <20230306100508.1171812-13-alexghiti@rivosinc.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, corbet@lwn.net,
        Richard Henderson <richard.henderson@linaro.org>,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org,
        linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, chenhuacai@kernel.org,
        kernel@xen0n.name, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, alexghiti@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexghiti@rivosinc.com
Message-ID: <mhng-d4be5bb5-f0ad-4e76-9b11-83732d233a45@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 06 Mar 2023 02:04:54 PST (-0800), alexghiti@rivosinc.com wrote:
> As far as I can tell this is not used by userspace and thus should not
> be part of the user-visible API.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/setup.h      | 7 +++++++
>  arch/riscv/include/uapi/asm/setup.h | 2 --
>  2 files changed, 7 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/setup.h
>
> diff --git a/arch/riscv/include/asm/setup.h b/arch/riscv/include/asm/setup.h
> new file mode 100644
> index 000000000000..f165a14344e2
> --- /dev/null
> +++ b/arch/riscv/include/asm/setup.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_RISCV_SETUP_H
> +#define _ASM_RISCV_SETUP_H
> +
> +#define COMMAND_LINE_SIZE       1024
> +
> +#endif /* _ASM_RISCV_SETUP_H */
> diff --git a/arch/riscv/include/uapi/asm/setup.h b/arch/riscv/include/uapi/asm/setup.h
> index 66b13a522880..17fcecd4a2f8 100644
> --- a/arch/riscv/include/uapi/asm/setup.h
> +++ b/arch/riscv/include/uapi/asm/setup.h
> @@ -3,6 +3,4 @@
>  #ifndef _UAPI_ASM_RISCV_SETUP_H
>  #define _UAPI_ASM_RISCV_SETUP_H
>
> -#define COMMAND_LINE_SIZE	1024
> -
>  #endif /* _UAPI_ASM_RISCV_SETUP_H */

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!
