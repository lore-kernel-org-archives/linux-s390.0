Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A462C4743C
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3A2610A1
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFGJd0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhFGJd0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Jun 2021 05:33:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E386EC061766;
        Mon,  7 Jun 2021 02:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MlvkgxFcyawWgLbaD1anFAhejhA4mPswAd0WEOPLbd0=; b=cetr6/k8ZHIlURSNkBDEkxOd3
        puNo+HwooQUeJn9AaPBl4regJ9NkcXwohGBb5OPUoX7XTTODh5d6IsuhC8Hnw3taLmVn0F8+4hF1o
        ArioCmyKCJRUZ5c5W9Ct8Cw0Zpb4xNWdK87xHBWnc3daFNyrTg9aLL7A/E6TbbFPNgdTXMtoLpPh1
        VNTboFgYQtPgYxGziLgboqSm+C9rc0zETM+h5ZE5kg+2kGPOkoZAIe8MZfd5JZNTDNazJFXr/S6Gm
        YDi+dqX3d1L4b71QKMOqk7jvcXPp8QSgQdX3C28GtCjdiTWKtuBWWAYuFwAi7GnVSCXRZB8Zx7iVW
        ALDutps2w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44784)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lqBbS-0000Eu-Fv; Mon, 07 Jun 2021 10:31:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lqBbN-0005oE-UB; Mon, 07 Jun 2021 10:31:21 +0100
Date:   Mon, 7 Jun 2021 10:31:21 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        uclinux-h8-devel@lists.sourceforge.jp, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mm@kvack.org,
        linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/15] init_mm: cleanup ARCH's text/data/brk setup code
Message-ID: <20210607093121.GC22278@shell.armlinux.org.uk>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
 <YL0+Jargm+y9aqx1@kernel.org>
 <481056ab-686e-9f42-3b8a-b31941f58af6@huawei.com>
 <006eb573-5a20-1ac7-6234-338d11346a08@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006eb573-5a20-1ac7-6234-338d11346a08@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 07, 2021 at 07:48:54AM +0200, Christophe Leroy wrote:
> Hi Kefeng,
> 
> What you could do is to define a __weak function that architectures can
> override and call that function from mm_init() as suggested by Mike,

The problem with weak functions is that they bloat the kernel. Each
time a weak function is overriden, it becomes dead unreachable code
within the kernel image.

At some point we're probabily going to have to enable -ffunction-sections
to (hopefully) allow the dead code to be discarded.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
