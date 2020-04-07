Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200403090224.24045-1-masahiroy@kernel.org> <20200406180558.GA22412@dev.jcline.org>
In-Reply-To: <20200406180558.GA22412@dev.jcline.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 8 Apr 2020 00:39:34 +0900
Message-ID: <CAK7LNASn8z4SF9YeyidjYDmA+1MMV9VArem=Scui51LaB3Q1wg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add dummy toolchains to enable all cc-option etc.
 in Kconfig
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jeremy Cline <jcline@redhat.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michal Kubecek <mkubecek@suse.cz>, Philipp Rudo <prudo@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Apr 7, 2020 at 3:06 AM Jeremy Cline <jcline@redhat.com> wrote:

> > diff --git a/scripts/dummy-tools/ld b/scripts/dummy-tools/ld
> > new file mode 100755
> > index 000000000000..3bc56ae4cc15
> > --- /dev/null
> > +++ b/scripts/dummy-tools/ld
> > @@ -0,0 +1,4 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +# Dummy script that always succeeds
>
> It looks like scripts/Kbuild.include expects "$(LD) --version" to return
> something. If it doesn't "ld-ifversion" stops working.


Actually, scripts/Kbuild.include is not used in the Kconfig stage.
So, scripts/dummy-tools/ld does not need to handle --version or -v,
but we may do that in the future.

I will support it in v2.


> Other than that it seems to work as advertised. Thanks!
>
> - Jeremy
>


-- 
Best Regards
Masahiro Yamada
