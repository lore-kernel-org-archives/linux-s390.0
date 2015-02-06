From: Joseph Myers <joseph@codesourcery.com>
Date: Fri, 06 Feb 2015 18:03:13 +0000
Subject: Re: [PATCH RFC] Update kernel math-emu code from current glibc soft-fp
Message-Id: <alpine.DEB.2.10.1502061748060.27832@digraph.polyomino.org.uk>
References: <alpine.DEB.2.10.1502061719210.27832@digraph.polyomino.org.uk>
 <54D4FCC9.80704@infradead.org>
In-Reply-To: <54D4FCC9.80704@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 6 Feb 2015, Randy Dunlap wrote:

> On 02/06/15 09:25, Joseph Myers wrote:
> > At this point this patch is an RFC rather than yet being ready for
> > inclusion, because I've only tested it for powerpc (both e500 and
> > emulation of classic hard float); it's quite likely there are bugs in
> > the changes for other architectures, quite possibly breaking the
> > build.  I've also posted it to libc-alpha
> > <https://sourceware.org/ml/libc-alpha/2015-02/msg00107.html> with a
> > call for testing and notes on what testing might be appropriate.
> 
> Is there a test suite?

In practice, the current glibc testsuite ("make math/tests" then look in 
math/subdir-tests.sum for FAILs and examine those in more detail - some 
may well be pre-existing and appear without my patch) provides pretty 
thorough coverage of basic floating-point operations.  There are at least 
two pre-existing bugs in the powerpc emulation that show up that way 
(running the testsuite, built for classic hard-float, on a processor where 
classic hard-float isn't supported in hardware), but as they are 
independent of this update I put them on my list of issues to look at 
later.  Various of the issues I fixed in Nov/Dec 2013 with the powerpc 
e500 SPE float emulation were also found through the glibc testsuite.

People have also used other testsuites such as TestFloat and ucbtest in 
the past to validate floating-point emulation (ucbtest was used to 
validate some of the past soft-fp changes, for example).  All of these end 
up testing some combination of compiler, library, hardware and kernel so 
it's not always immediately obvious where a failure is coming from.  If 
there are architectural tests of instruction semantics available, those 
could be used and might validate choices of results where they aren't 
fully specified by IEEE 754 (of course, the existing code may not always 
make such choices in a way that matches the hardware, either).  There 
isn't a testsuite specific to soft-fp.

-- 
Joseph S. Myers
joseph@codesourcery.com
