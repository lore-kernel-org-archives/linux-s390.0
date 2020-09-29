Return-Path: <linux-kselftest-owner@vger.kernel.org>
Date: Tue, 29 Sep 2020 13:35:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 2/8] selftests/vm: use a common gup_test.h
Message-ID: <20200929163507.GV9916@ziepe.ca>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-3-jhubbard@nvidia.com>
 <20200928125739.GP9916@ziepe.ca>
 <6481e78f-c70d-133a-ff4a-325b5cd8fd5d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6481e78f-c70d-133a-ff4a-325b5cd8fd5d@nvidia.com>
List-ID: <linux-s390.vger.kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-s390@vger.kernel.org

On Mon, Sep 28, 2020 at 01:10:24PM -0700, John Hubbard wrote:
> On 9/28/20 5:57 AM, Jason Gunthorpe wrote:
> > On Sun, Sep 27, 2020 at 11:21:53PM -0700, John Hubbard wrote:
> > > diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> > > index d1ae706d9927..9cc6bc087461 100644
> > > +++ b/tools/testing/selftests/vm/Makefile
> > > @@ -130,3 +130,5 @@ endif
> > >   $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
> > >   $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
> > > +
> > > +$(OUTPUT)/gup_test: ../../../../mm/gup_test.h
> > 
> > There is no reason to do this, the auto depends will pick up header
> > files, and gup_test.h isn't a generated file
> > 
> 
> It is less capable than you might think. Without the admittedly ugly technique
> above, it fails to build, and as you can see, the include paths that are fed to
> gcc are just a single one: usr/include:
> 
> $ make
> make --no-builtin-rules ARCH=x86 -C ../../../.. headers_install
> gcc -Wall -I ../../../../usr/include     gup_test.c
> /kernel_work/linux-next-github/tools/testing/selftests/kselftest_harness.h
> /kernel_work/linux-next-github/tools/testing/selftests/kselftest.h
> ../../../../mm/gup_test.h -lrt -o
> /kernel_work/linux-next-github/tools/testing/selftests/vm/gup_test
> make[1]: Entering directory '/kernel_work/linux-next-github'
> gup_test.c:10:10: fatal error: gup_test.h: No such file or directory
>    10 | #include "gup_test.h"
>       |          ^~~~~~~~~~~~

You are supposed to use

  #include "../../../../mm/gup_test.h"

I have no idea what weird behavior the makefile is triggering that the
above include works

Jason
