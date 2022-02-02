Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D7AC43219
	for <linux-s390@archiver.kernel.org>; Wed,  2 Feb 2022 07:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbiBBHsw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:48:52 -0500
Received: from verein.lst.de ([213.95.11.211]:33198 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240572AbiBBHsv (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 2 Feb 2022 02:48:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D24367373; Wed,  2 Feb 2022 08:48:47 +0100 (CET)
Date:   Wed, 2 Feb 2022 08:48:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     palmer@dabbelt.com, arnd@arndb.de, anup@brainfault.org,
        gregkh@linuxfoundation.org, liush@allwinnertech.com,
        wefu@redhat.com, drew@beagleboard.org, wangjunqiang@iscas.ac.cn,
        hch@lst.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V5 06/21] asm-generic: compat: Cleanup duplicate
 definitions
Message-ID: <20220202074846.GA18398@lst.de>
References: <20220201150545.1512822-1-guoren@kernel.org> <20220201150545.1512822-7-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201150545.1512822-7-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
