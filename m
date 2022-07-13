Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADA0C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 13 Jul 2022 15:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiGMPqZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 13 Jul 2022 11:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiGMPqY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 13 Jul 2022 11:46:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732234D4D1;
        Wed, 13 Jul 2022 08:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A81F6193B;
        Wed, 13 Jul 2022 15:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FD3C3411E;
        Wed, 13 Jul 2022 15:46:19 +0000 (UTC)
Date:   Wed, 13 Jul 2022 16:46:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5] random: remove CONFIG_ARCH_RANDOM
Message-ID: <Ys7ox2TNyq36APxD@arm.com>
References: <20220706143521.459565-1-Jason@zx2c4.com>
 <20220708004032.733426-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708004032.733426-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jul 08, 2022 at 02:40:32AM +0200, Jason A. Donenfeld wrote:
> When RDRAND was introduced, there was much discussion on whether it
> should be trusted and how the kernel should handle that. Initially, two
> mechanisms cropped up, CONFIG_ARCH_RANDOM, a compile time switch, and
> "nordrand", a boot-time switch.
> 
> Later the thinking evolved. With a properly designed RNG, using RDRAND
> values alone won't harm anything, even if the outputs are malicious.
> Rather, the issue is whether those values are being *trusted* to be good
> or not. And so a new set of options were introduced as the real
> ones that people use -- CONFIG_RANDOM_TRUST_CPU and "random.trust_cpu".
> With these options, RDRAND is used, but it's not always credited. So in
> the worst case, it does nothing, and in the best case, maybe it helps.
> 
> Along the way, CONFIG_ARCH_RANDOM's meaning got sort of pulled into the
> center and became something certain platforms force-select.
> 
> The old options don't really help with much, and it's a bit odd to have
> special handling for these instructions when the kernel can deal fine
> with the existence or untrusted existence or broken existence or
> non-existence of that CPU capability.
> 
> Simplify the situation by removing CONFIG_ARCH_RANDOM and using the
> ordinary asm-generic fallback pattern instead, keeping the two options
> that are actually used. For now it leaves "nordrand" for now, as the
> removal of that will take a different route.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Acked-by: Borislav Petkov <bp@suse.de>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
