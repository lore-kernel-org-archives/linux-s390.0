Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4185C3F2D4
	for <linux-s390@archiver.kernel.org>; Fri, 24 Jun 2022 12:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiFXMYn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 24 Jun 2022 08:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiFXMYm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Jun 2022 08:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0206B46B3A;
        Fri, 24 Jun 2022 05:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DCEC60F50;
        Fri, 24 Jun 2022 12:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996C0C34114;
        Fri, 24 Jun 2022 12:24:36 +0000 (UTC)
Date:   Fri, 24 Jun 2022 13:24:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, hch@infradead.org, christophe.leroy@csgroup.eu,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org, openrisc@lists.librecores.org,
        linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH V4 05/26] arm64/mm: Move protection_map[] inside the
 platform
Message-ID: <YrWtALCwqrL6mU3T@arm.com>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-6-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624044339.1533882-6-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 24, 2022 at 10:13:18AM +0530, Anshuman Khandual wrote:
> This moves protection_map[] inside the platform and makes it a static.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
