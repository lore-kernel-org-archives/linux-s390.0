Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44539 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfHTJ4J (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Aug 2019 05:56:09 -0400
Received: by mail-oi1-f194.google.com with SMTP id k22so3615422oiw.11
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 02:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190820024941.12640-1-dja@axtens.net>
In-Reply-To: <20190820024941.12640-1-dja@axtens.net>
From: Marco Elver <elver@google.com>
Date: Tue, 20 Aug 2019 11:55:56 +0200
Message-ID: <CANpmjNMpBAjX4G2GYmM6-z8TfXdbzLCuAMQ-fmGRwEDFMci4Ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with
 generic bitops
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Axtens <dja@axtens.net>
Cc: christophe.leroy@c-s.fr, linux-s390@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org, kasan-dev <kasan-dev@googlegroups.com>

On Tue, 20 Aug 2019 at 04:50, Daniel Axtens <dja@axtens.net> wrote:
>
> Currently bitops-instrumented.h assumes that the architecture provides
> atomic, non-atomic and locking bitops (e.g. both set_bit and __set_bit).
> This is true on x86 and s390, but is not always true: there is a
> generic bitops/non-atomic.h header that provides generic non-atomic
> operations, and also a generic bitops/lock.h for locking operations.
>
> powerpc uses the generic non-atomic version, so it does not have it's
> own e.g. __set_bit that could be renamed arch___set_bit.
>
> Split up bitops-instrumented.h to mirror the atomic/non-atomic/lock
> split. This allows arches to only include the headers where they
> have arch-specific versions to rename. Update x86 and s390.
>
> (The generic operations are automatically instrumented because they're
> written in C, not asm.)
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Acked-by: Marco Elver <elver@google.com>

Thanks!
