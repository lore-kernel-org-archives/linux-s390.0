Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8998EC43217
	for <linux-s390@archiver.kernel.org>; Wed,  2 Nov 2022 19:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKBTKR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Nov 2022 15:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiKBTJ7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Nov 2022 15:09:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515F1103A
        for <linux-s390@vger.kernel.org>; Wed,  2 Nov 2022 12:09:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so3023967pjk.2
        for <linux-s390@vger.kernel.org>; Wed, 02 Nov 2022 12:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNhnJbXAJF4UzyH8g8T6ZxMpszM79ChXkqdNt8W8NYI=;
        b=VwmffTXNNVk9OBe+Hnb1vM8Qkem8njG1t/7NVdWtvzLrL7Silwy1LUoeD738n3tOxs
         iK3jGMKaUFT7YdCmh+Gc9iJ/YxnaQ2rljYHzLP0L65O3V7/zav62TcWDBN+p4X1FC2G3
         eyyWgcMxBcpZxnBLphn5OoB8FI5JAsGow22/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNhnJbXAJF4UzyH8g8T6ZxMpszM79ChXkqdNt8W8NYI=;
        b=CvHB+dzuJYstIMa+7beePXRUR/v5uJmwqRCskpcBm8O1C2iXkcmkpNJjP7Fd0nMar9
         diktLkCLRb+SAokl8+ko1HvRtoPOZP+VLCjKPy0PdYhR4xNnoRJ/dYbahwit5XbVFgaz
         QpiG2KJxKcZEJBYvduIxX6Mn0MrOW8rEfjYPLrwsPE6ryinodUNaVKBconkL0PenzaLo
         G8L8AU9hUhYlLHIJ11hIFNcuyqfHgoOy30diBkVILsQp/XPPfxcvpVklZlx/KS387V0f
         NWcgWVY0AEEIeAXnMbSdIztQwaY2tLXZiK4esVcQF02GIGKZtq53HivvcR6cGBGRXxZi
         s31A==
X-Gm-Message-State: ACrzQf2QmCauoXuEx2nDV15IBcYt0d4ezwplH3utlo3/JliJ2egXfD4g
        H99/8MJoQqBxOoJowMPZi8SeOw==
X-Google-Smtp-Source: AMsMyM4DStPKStM8pFzW0+6/3LvqImBH8Zv6MGJVHGEF5VEN77SWeQxRJeBNzvxONcQowosistNujg==
X-Received: by 2002:a17:902:e883:b0:187:27a7:c8a3 with SMTP id w3-20020a170902e88300b0018727a7c8a3mr14846919plg.32.1667416195682;
        Wed, 02 Nov 2022 12:09:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a16-20020aa794b0000000b005627d995a36sm8805579pfl.44.2022.11.02.12.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:09:55 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:09:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 2/3] s390/netiucv: Fix return type of netiucv_tx()
Message-ID: <202211021209.8BAB0ABFCE@keescook>
References: <20221102163252.49175-1-nathan@kernel.org>
 <20221102163252.49175-2-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102163252.49175-2-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 02, 2022 at 09:32:51AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/s390/net/netiucv.c:1854:21: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .ndo_start_xmit         = netiucv_tx,
>                                     ^~~~~~~~~~
> 
> ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> 'netdev_tx_t', not 'int'. Adjust the return type of netiucv_tx() to
> match the prototype's to resolve the warning and potential CFI failure,
> should s390 select ARCH_SUPPORTS_CFI_CLANG in the future.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
