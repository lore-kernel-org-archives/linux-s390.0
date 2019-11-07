Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:37289 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfKGELT (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 6 Nov 2019 23:11:19 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Please add powerpc topic/kasan-bitops branch to linux-next
Date: Thu, 07 Nov 2019 15:11:12 +1100
Message-ID: <87r22k5nrz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, christophe.leroy@c-s.fr, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com, Daniel Axtens <dja@axtens.net>

Hi Stephen,

Can you please add the topic/kasan-bitops tree of the powerpc repository
to linux-next.

powerpc         git     git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git#topic/kasan-bitops

See:
  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=topic/kasan-bitops

This will be a (hopefully) short lived branch to carry some cross
architecture KASAN related patches for v5.5.

cheers
