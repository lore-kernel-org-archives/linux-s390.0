Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294A4C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  1 Mar 2022 20:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbiCAUol (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237672AbiCAUok (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Mar 2022 15:44:40 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6ACEC522D7;
        Tue,  1 Mar 2022 12:43:59 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8EF2392009D; Tue,  1 Mar 2022 21:43:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 88C9F92009B;
        Tue,  1 Mar 2022 20:43:58 +0000 (GMT)
Date:   Tue, 1 Mar 2022 20:43:58 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PING][PATCH v2] parport_pc: Also enable driver for PCI systems
In-Reply-To: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203011751030.11354@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 14 Feb 2022, Maciej W. Rozycki wrote:

> Nowadays PC-style parallel ports come in the form of PCI and PCIe option 
> cards and there are some combined parallel/serial option cards as well 
> that we handle in the parport subsystem.  There is nothing in particular 
> that would prevent them from being used in any system equipped with PCI 
> or PCIe connectivity, except that we do not permit the PARPORT_PC config 
> option to be selected for platforms for which ARCH_MIGHT_HAVE_PC_PARPORT 
> has not been set for.

 Ping for:

<https://lore.kernel.org/lkml/alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk/>

  Maciej
