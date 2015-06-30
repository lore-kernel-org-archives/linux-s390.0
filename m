From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 30 Jun 2015 03:28:33 +0000
Subject: Re: [PATCH RESEND] Update kernel math-emu code from current glibc soft-fp
Message-Id: <1435634913.24866.1.camel@ellerman.id.au>
References: <alpine.DEB.2.10.1505192206580.28384@digraph.polyomino.org.uk>
 <alpine.DEB.2.10.1506221321340.27145@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.10.1506221321340.27145@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: Joseph Myers <joseph@codesourcery.com>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2015-06-22 at 13:26 +0000, Joseph Myers wrote:
> From: Joseph Myers <joseph@codesourcery.com>
> 
> The include/math-emu code (used for alpha powerpc sh sparc, and to a
> very limited extent for s390) was taken from an old version of glibc's
> soft-fp code around 15 years ago (in the pre-git era, anyway, and some

...

> This patch is unchanged from that posted at 
> <https://lkml.org/lkml/2015/5/19/1047>, still applies to current sources 
> and is proposed for 4.2.


Hi Joseph,

This is an awesome effort, and greatly appreciated.

However in it's current form it's not easily mergeable, because it touches five
architectures and has the potential to cause breakage on all of them.

It's also too late for 4.2. The merge window for 4.2 is open now, which means
arch maintainers have stopped taking intrusive patches 1-2 weeks ago.

Is there some way you can imagine of splitting this up into smaller chunks, so
that different arches can merge the pieces separately?

cheers


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
 arch/s390/kernel/sysinfo.c              |   11 
 arch/sh/include/asm/sfp-machine.h       |   10 
 arch/sh/math-emu/math.c                 |   51 
 arch/sparc/include/asm/sfp-machine_32.h |    3 
 arch/sparc/include/asm/sfp-machine_64.h |    3 
 arch/sparc/math-emu/math_32.c           |  144 -
 arch/sparc/math-emu/math_64.c           |  140 -
 include/math-emu/double.h               |  398 ++--
 include/math-emu/op-1.h                 |  554 +++---
 include/math-emu/op-2.h                 | 1136 ++++++------
 include/math-emu/op-4.h                 | 1457 ++++++++-------
 include/math-emu/op-8.h                 |  211 +-
 include/math-emu/op-common.h            | 2927 ++++++++++++++++++++++----------
 include/math-emu/quad.h                 |  434 +++-
 include/math-emu/single.h               |  233 +-
 include/math-emu/soft-fp.h              |  367 ++--
 39 files changed, 5433 insertions(+), 3196 deletions(-)
