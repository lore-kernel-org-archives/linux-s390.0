Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06579C433EF
	for <linux-s390@archiver.kernel.org>; Wed,  6 Jul 2022 12:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiGFMfZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Jul 2022 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiGFMfY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Jul 2022 08:35:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CFF1B7B4;
        Wed,  6 Jul 2022 05:35:22 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff625329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f625:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6447F1EC0554;
        Wed,  6 Jul 2022 14:35:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657110917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aOfghTrex1dSH5ya2NTo53o75SOki07wRbpatW6WuBk=;
        b=KCUu0L2dkP2XI8FBDBFzdO0NWi8TMtHxuIX9sQgc8hqhPWfiDc3DIkWjRmLn/A5w4jes+W
        Kdp/Bzg5kTu+nf6MBnNBJTADx5tph7Hm3ovWxLGauzcr2XCZznaaWbyvFkNYCST3UF4uBO
        rmMjNumRUWoX4RY3dD2SpM+CD9QRTo4=
Date:   Wed, 6 Jul 2022 14:35:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] random: remove CONFIG_ARCH_RANDOM
Message-ID: <YsWBhaZT5dCQHfwp@zn.tnic>
References: <20220706003225.335768-1-Jason@zx2c4.com>
 <20220706105411.406259-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220706105411.406259-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 06, 2022 at 12:54:11PM +0200, Jason A. Donenfeld wrote:
> So this commit simplifies things by removing CONFIG_ARCH_RANDOM, keeping

No need to say "this commit" or "this patch" - just write "as if you are
giving orders to the codebase to change its behaviour."

In this case, "So simplify things by ... "

>  arch/x86/Kconfig                                  |  9 ---------
>  arch/x86/include/asm/archrandom.h                 | 14 +++++---------
>  arch/x86/kernel/cpu/rdrand.c                      |  2 --

For those:

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
