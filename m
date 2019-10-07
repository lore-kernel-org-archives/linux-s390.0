Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfJGSHG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 7 Oct 2019 14:07:06 -0400
From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 0/1] s390/purgatory: Make sure we fail the build if purgatory has missing symbols
Date: Mon,  7 Oct 2019 20:07:02 +0200
Message-Id: <20191007180703.3678-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi s390 maintainers,

This patch mirrors a similar patch for x86, but it has been untested
because I do not have a mainframe to compile on :)

In 5.4-rc1 the 2 different sha256 implementations for the purgatory resp.
for crypto/sha256_generic.c have been consolidated into 1 single shared
implementation under lib/crypto/sha256.c .

At least on x86 this was causing silent corruption of the purgatory due
to a missing memzero_explicit symbol in the purgatory string.c/.o file.

With the x86 equivalent of this patch applied a x86 build of 5.4-rc1 now
correctly fails:

  CHK     arch/x86/purgatory/purgatory.ro
ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
make[2]: *** [arch/x86/purgatory/Makefile:72:
    arch/x86/purgatory/kexec-purgatory.c] Error 1
make[1]: *** [scripts/Makefile.build:509: arch/x86/purgatory] Error 2
make: *** [Makefile:1650: arch/x86] Error 2

It would be great if the s390 maintainers can test this equivalent patch
on s390.

As for fixing the missing memzero_explicit symbol, we are currently
discussing making memzero_explicit a static inline wrapper of memset
in string.h, so that we do not need to implement it in multiple places.

This discussion is Cc-ed to the generic linux-kernel@vger.kernel.org list,
it is happening in the
"[PATCH v2 5.4 regression fix] x86/boot: Provide memzero_explicit" thread.

Regards,

Hans
