Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgIAJTy (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 1 Sep 2020 05:19:54 -0400
Date: Tue, 1 Sep 2020 10:19:49 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arch: vdso: add vdso linker script to 'targets' instead
 of extra-y
Message-ID: <20200901091948.GF5561@gaia>
References: <20200831182239.480317-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831182239.480317-1-masahiroy@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Greentime Hu <green.hu@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nick Hu <nickhu@andestech.com>, Paul Mackerras <paulus@samba.org>, Vasily Gorbik <gor@linux.ibm.com>, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Tue, Sep 01, 2020 at 03:22:39AM +0900, Masahiro Yamada wrote:
> The vdso linker script is preprocessed on demand.
> Adding it to 'targets' is enough to include the .cmd file.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
