Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfHPVQU (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 16 Aug 2019 17:16:20 -0400
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/6] crypto: sha256 - Merge 2 separate C implementations into 1, put into separate library
Date: Fri, 16 Aug 2019 23:16:05 +0200
Message-Id: <20190816211611.2568-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi All,

Here is a patch series refactoring the current 2 separate SHA256
C implementations into 1 and put it into a separate library.

There are 2 reasons for this:

1) Remove the code duplication of having 2 separate implementations

2) Offer a separate library SHA256 implementation which can be used
without having to call crypto_alloc_shash first. This is especially
useful for use during early boot when crypto_alloc_shash does not
work yet.

This has been tested on x86, including checking that kecec still works.

This has NOT been tested on s390, if someone with access to s390 can
test that things still build with this series applied and that
kexec still works, that would be great.

Regards,

Hans
