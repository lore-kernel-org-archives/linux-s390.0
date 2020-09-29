Return-Path: <linux-kselftest-owner@vger.kernel.org>
Date: Tue, 29 Sep 2020 14:55:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 2/8] selftests/vm: use a common gup_test.h
Message-ID: <20200929175524.GX9916@ziepe.ca>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-3-jhubbard@nvidia.com>
 <20200928125739.GP9916@ziepe.ca>
 <6481e78f-c70d-133a-ff4a-325b5cd8fd5d@nvidia.com>
 <20200929163507.GV9916@ziepe.ca>
 <aab477bf-4353-5e6b-4cc9-9872c9376ed2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab477bf-4353-5e6b-4cc9-9872c9376ed2@nvidia.com>
List-ID: <linux-s390.vger.kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-s390@vger.kernel.org

On Tue, Sep 29, 2020 at 10:44:31AM -0700, John Hubbard wrote:
> On 9/29/20 9:35 AM, Jason Gunthorpe wrote:
> > On Mon, Sep 28, 2020 at 01:10:24PM -0700, John Hubbard wrote:
> > > On 9/28/20 5:57 AM, Jason Gunthorpe wrote:
> > > > On Sun, Sep 27, 2020 at 11:21:53PM -0700, John Hubbard wrote:
> > > > > diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> > > > > index d1ae706d9927..9cc6bc087461 100644
> > > > > +++ b/tools/testing/selftests/vm/Makefile
> > > > > @@ -130,3 +130,5 @@ endif
> > > > >    $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
> > > > >    $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
> > > > > +
> > > > > +$(OUTPUT)/gup_test: ../../../../mm/gup_test.h
> > > > 
> > > > There is no reason to do this, the auto depends will pick up header
> > > > files, and gup_test.h isn't a generated file
> > > > 
> 
> Oh, I misread your comment! You were talking about this Makefile
> dependency that I'm adding, rather than the ../'s in the path.
> 
> Well, for that though, it also has to stay as shown in this patch,
> because of this:
> 
> I don't see any "gcc -m" type of dependency generation pass happening
> in this relatively simple Make system. 

It happens with -MD, all the deps are stored in files like mm/.init-mm.o.cmd
and sucked into the build.

> And so, without including an explicit header file dependency (at
> least, that's the simplest way), changes to gup_test.h are not
> detected.

Shouldn't be

> Both the Makefile code and the observed behavior back this up. (I
> expect that this is because there is less use of header files in
> this area, because most unit tests are self-contained within a
> single .c file.)

Something else is very wrong then.

Jason
