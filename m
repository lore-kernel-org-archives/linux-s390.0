Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:55199 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfLCNEf (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 3 Dec 2019 08:04:35 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with generic bitops
In-Reply-To: <CANpmjNN-=F6GK_jHPUx8OdpboK7nMV=i=sKKfSsKwKEHnMTG0g@mail.gmail.com>
References: <20190820024941.12640-1-dja@axtens.net> <877e6vutiu.fsf@dja-thinkpad.axtens.net> <878sp57z44.fsf@dja-thinkpad.axtens.net> <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com> <87a78xgu8o.fsf@dja-thinkpad.axtens.net> <87y2wbf0xx.fsf@dja-thinkpad.axtens.net> <CANpmjNN-=F6GK_jHPUx8OdpboK7nMV=i=sKKfSsKwKEHnMTG0g@mail.gmail.com>
Date: Wed, 04 Dec 2019 00:04:23 +1100
Message-ID: <87r21lef1k.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marco Elver <elver@google.com>, Daniel Axtens <dja@axtens.net>
Cc: linux-s390@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org

Marco Elver <elver@google.com> writes:
> On Wed, 20 Nov 2019 at 08:42, Daniel Axtens <dja@axtens.net> wrote:
>>
>> > But the docs do seem to indicate that it's atomic (for whatever that
>> > means for a single read operation?), so you are right, it should live in
>> > instrumented-atomic.h.
>>
>> Actually, on further inspection, test_bit has lived in
>> bitops/non-atomic.h since it was added in 4117b02132d1 ("[PATCH] bitops:
>> generic __{,test_and_}{set,clear,change}_bit() and test_bit()")
>>
>> So to match that, the wrapper should live in instrumented-non-atomic.h
>> too.
>>
>> If test_bit should move, that would need to be a different patch. But I
>> don't really know if it makes too much sense to stress about a read
>> operation, as opposed to a read/modify/write...
>
> That's fair enough. I suppose this can stay where it is because it's
> not hurting anyone per-se, but the only bad thing about it is that
> kernel-api documentation will present test_bit() in non-atomic
> operations.

I only just noticed this thread as I was about to send a pull request
for these two commits.

I think I agree that test_bit() shouldn't move (yet), but I dislike that
the documentation ends up being confusing due to this patch.

So I'm inclined to append or squash in the patch below, which removes
the new headers from the documentation. The end result is the docs look
more or less the same, just the ordering of some of the functions
changes. But we don't end up with test_bit() under the "Non-atomic"
header, and then also documented in Documentation/atomic_bitops.txt.

Thoughts?

cheers


diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 2caaeb55e8dd..4ac53a1363f6 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -57,21 +57,12 @@ The Linux kernel provides more basic utility functions.
 Bit Operations
 --------------
 
-Atomic Operations
-~~~~~~~~~~~~~~~~~
-
 .. kernel-doc:: include/asm-generic/bitops/instrumented-atomic.h
    :internal:
 
-Non-atomic Operations
-~~~~~~~~~~~~~~~~~~~~~
-
 .. kernel-doc:: include/asm-generic/bitops/instrumented-non-atomic.h
    :internal:
 
-Locking Operations
-~~~~~~~~~~~~~~~~~~
-
 .. kernel-doc:: include/asm-generic/bitops/instrumented-lock.h
    :internal:
 
