Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732260AbgK0SXW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 Nov 2020 13:23:22 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF9FC0613D2
        for <linux-s390@vger.kernel.org>; Fri, 27 Nov 2020 10:23:22 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id j10so6882016lja.5
        for <linux-s390@vger.kernel.org>; Fri, 27 Nov 2020 10:23:21 -0800 (PST)
MIME-Version: 1.0
References: <3E05451B-A9CD-4719-99D0-72750A304044@amazon.com> <CAG48ez2VAu6oARGVZ+muDK9_6_38KVUTJf7utz5Nn=AsmN17nA@mail.gmail.com>
In-Reply-To: <CAG48ez2VAu6oARGVZ+muDK9_6_38KVUTJf7utz5Nn=AsmN17nA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 27 Nov 2020 19:22:53 +0100
Message-ID: <CAG48ez13ZAAOVmA89PRKRqr9UezV2_bj8Q6_6sSPzcqfzbsuQQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/virt: vmgenid: add vm generation id driver
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: "Catangiu, Adrian Costin" <acatan@amazon.com>
Cc: "Graf (AWS), Alexander" <graf@amazon.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Willy Tarreau <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>, Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, linux-s390 <linux-s390@vger.kernel.org>, "areber@redhat.com" <areber@redhat.com>, Pavel Emelyanov <ovzxemul@gmail.com>, Andrey Vagin <avagin@gmail.com>, Mike Rapoport <rppt@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, "gil@azul.com" <gil@azul.com>, "asmehra@redhat.com" <asmehra@redhat.com>, "dgunigun@redhat.com" <dgunigun@redhat.com>, "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>

[resend in the hope that amazon will accept my mail this time instead
of replying "550 Too many invalid recipients" again]

On Fri, Nov 20, 2020 at 11:29 PM Jann Horn <jannh@google.com> wrote:
> On Mon, Nov 16, 2020 at 4:35 PM Catangiu, Adrian Costin
> <acatan@amazon.com> wrote:
> > This patch is a driver that exposes a monotonic incremental Virtual
> > Machine Generation u32 counter via a char-dev FS interface that
> > provides sync and async VmGen counter updates notifications. It also
> > provides VmGen counter retrieval and confirmation mechanisms.
> >
> > The hw provided UUID is not exposed to userspace, it is internally
> > used by the driver to keep accounting for the exposed VmGen counter.
> > The counter starts from zero when the driver is initialized and
> > monotonically increments every time the hw UUID changes (the VM
> > generation changes).
> >
> > On each hw UUID change, the new hypervisor-provided UUID is also fed
> > to the kernel RNG.
>
> As for v1:
>
> Is there a reasonable usecase for the "confirmation" mechanism? It
> doesn't seem very useful to me.
>
> How do you envision integrating this with libraries that have to work
> in restrictive seccomp sandboxes? If this was in the vDSO, that would
> be much easier.
