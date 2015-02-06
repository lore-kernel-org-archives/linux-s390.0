From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 06 Feb 2015 17:41:29 +0000
Subject: Re: [PATCH RFC] Update kernel math-emu code from current glibc soft-fp
Message-Id: <54D4FCC9.80704@infradead.org>
References: <alpine.DEB.2.10.1502061719210.27832@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.10.1502061719210.27832@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: Joseph Myers <joseph@codesourcery.com>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 02/06/15 09:25, Joseph Myers wrote:
> At this point this patch is an RFC rather than yet being ready for
> inclusion, because I've only tested it for powerpc (both e500 and
> emulation of classic hard float); it's quite likely there are bugs in
> the changes for other architectures, quite possibly breaking the
> build.  I've also posted it to libc-alpha
> <https://sourceware.org/ml/libc-alpha/2015-02/msg00107.html> with a
> call for testing and notes on what testing might be appropriate.

Is there a test suite?


and a diffstat is good to see:

 arch/alpha/include/asm/sfp-machine.h    |    3 
 arch/alpha/math-emu/math.c              |  131 -
 arch/powerpc/include/asm/sfp-machine.h  |   39 
 arch/powerpc/math-emu/fadd.c            |    6 
 arch/powerpc/math-emu/fadds.c           |    6 
 arch/powerpc/math-emu/fcmpo.c           |    2 
 arch/powerpc/math-emu/fcmpu.c           |    2 
 arch/powerpc/math-emu/fctiw.c           |    2 
 arch/powerpc/math-emu/fctiwz.c          |    2 
 arch/powerpc/math-emu/fmadd.c           |    8 
 arch/powerpc/math-emu/fmadds.c          |    8 
 arch/powerpc/math-emu/fmsub.c           |    8 
 arch/powerpc/math-emu/fmsubs.c          |    8 
 arch/powerpc/math-emu/fnmadd.c          |    8 
 arch/powerpc/math-emu/fnmadds.c         |    8 
 arch/powerpc/math-emu/fnmsub.c          |    8 
 arch/powerpc/math-emu/fnmsubs.c         |    8 
 arch/powerpc/math-emu/fsub.c            |    6 
 arch/powerpc/math-emu/fsubs.c           |    6 
 arch/powerpc/math-emu/lfs.c             |   11 
 arch/powerpc/math-emu/math_efp.c        |  254 +-
 arch/powerpc/math-emu/stfs.c            |    6 
 arch/s390/include/asm/sfp-machine.h     |   10 
 arch/s390/math-emu/math.c               |  278 +--
 arch/sh/include/asm/sfp-machine.h       |   10 
 arch/sh/math-emu/math.c                 |   51 
 arch/sparc/include/asm/sfp-machine_32.h |    3 
 arch/sparc/include/asm/sfp-machine_64.h |    3 
 arch/sparc/math-emu/math_32.c           |  144 -
 arch/sparc/math-emu/math_64.c           |  140 -
 include/math-emu/double.h               |  391 ++--
 include/math-emu/op-1.h                 |  546 +++---
 include/math-emu/op-2.h                 | 1127 ++++++------
 include/math-emu/op-4.h                 | 1449 ++++++++-------
 include/math-emu/op-8.h                 |  205 +-
 include/math-emu/op-common.h            | 2902 ++++++++++++++++++++++----------
 include/math-emu/quad.h                 |  428 +++-
 include/math-emu/single.h               |  225 +-
 include/math-emu/soft-fp.h              |  342 ++-
 39 files changed, 5495 insertions(+), 3299 deletions(-)




-- 
~Randy
