Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E41C61DA4
	for <linux-s390@archiver.kernel.org>; Tue, 14 Feb 2023 09:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjBNJI1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Feb 2023 04:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjBNJIC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Feb 2023 04:08:02 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761DF2385E
        for <linux-s390@vger.kernel.org>; Tue, 14 Feb 2023 01:07:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so11030586wms.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Feb 2023 01:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbfAOEl06OR99NGfEFoVS3aDlJXydx8Xm+1KWeTVt3w=;
        b=zRquXGkMWQxsjnDEBjUSG+i3tQ4HS9mWc+qp3B0uER9rI+yxxkGNzBJJJiV3Uc7zDn
         Q/SIl930elCR4FLEZaUlUTER5P0EKYuYi7wU57oROLtYDV50OfmdspRi97sBkypI70dP
         po58UWXAjDuTr6rOOCXox5kdhQcDL9/ogCL3j9KU3d4ifIWTwe8unvDy8lerc6+lmod4
         qwNxvQ7OmxQjhgo8tWmfXCNS63ob4Zt+EmuTDM6lqufmEYJtL7S+0oYcsFKtDBysZ/kW
         iVaSdCu8rkK9JOa4zJmqTtkn2DyLcn71i/iBL0fmcxvBqvih825/Usphrecq1kQudKlb
         ntrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbfAOEl06OR99NGfEFoVS3aDlJXydx8Xm+1KWeTVt3w=;
        b=vsCpxZVyVJAYODKDssmckMfQraMMMPDo+AOIINuqNNuSPFBJs+gOJZpBVkpaWYH/PP
         NbnNlN1cSq5CAt8kSyGAf7E/CbfcmGoJve3W2OkBl6R8onhWOv4IS/hVYEnPEAwkyZoy
         fTNmlLSRpq/NXnYFJWgxhGw93RU57HQXuJE3qu2tiVPGpSf16MxoSDY3o0J+Zu0m+jac
         hdmicQNphHYFyUDb7UW6r+cpIdkKK4ScQKpu55BS9TUidxbdLe9r/ROmPuxsluVXPrla
         NxsJHD9DrfRqF6EgkxRxFTewu724dh3/4RCdbFrT6uf7qQOFM66YBHvhuBXnj0zb8/PU
         9JVw==
X-Gm-Message-State: AO0yUKVatpAaiQWbbhU05nDrwCzsGXNh/VbL7l+sHG2/NbF4xuKe3C5M
        26UkqS9+NkEGJ9v4ZRTDl0YlwQ==
X-Google-Smtp-Source: AK7set8Wqv9ha6dIxkwRao9Qw+uzxpAx6YT4sYvT8HUQnEonxroJL/jacmiqSmbe1Ht/5qToQDlogw==
X-Received: by 2002:a05:600c:13c3:b0:3dc:1ad6:55fd with SMTP id e3-20020a05600c13c300b003dc1ad655fdmr1420116wmg.32.1676365630595;
        Tue, 14 Feb 2023 01:07:10 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id c129-20020a1c3587000000b003dc1a525f22sm17268744wma.25.2023.02.14.01.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:07:10 -0800 (PST)
Message-ID: <03a97cc1-1f8c-d412-272b-340e76858b7a@linaro.org>
Date:   Tue, 14 Feb 2023 10:07:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3 01/24] alpha: Remove COMMAND_LINE_SIZE from uapi
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
 <20230214074925.228106-2-alexghiti@rivosinc.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230214074925.228106-2-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14/2/23 08:49, Alexandre Ghiti wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> As far as I can tell this is not used by userspace and thus should not
> be part of the user-visible API.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>   arch/alpha/include/asm/setup.h      | 4 ++--
>   arch/alpha/include/uapi/asm/setup.h | 2 --
>   2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

