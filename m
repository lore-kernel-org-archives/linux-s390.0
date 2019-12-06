Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:34691 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfLFMqT (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 6 Dec 2019 07:46:19 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops)
Date: Fri, 06 Dec 2019 23:46:11 +1100
Message-ID: <87blslei5o.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dja@axtens.net, elver@google.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, kasan-dev@googlegroups.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull another powerpc update for 5.5.

As you'll see from the diffstat this is mostly not powerpc code. In order to do
KASAN instrumentation of bitops we needed to juggle some of the generic bitops
headers.

Because those changes potentially affect several architectures I wasn't
confident putting them directly into my tree, so I've had them sitting in a
topic branch. That branch (topic/kasan-bitops) has been in linux-next for a
month, and I've not had any feedback that it's caused any problems.

So I think this is good to merge, but it's a standalone pull so if anyone does
object it's not a problem.

cheers


The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.5-2

for you to fetch changes up to 4f4afc2c9599520300b3f2b3666d2034fca03df3:

  docs/core-api: Remove possibly confusing sub-headings from Bit Operations (2019-12-04 21:20:28 +1100)

- ------------------------------------------------------------------
powerpc updates for 5.5 #2

A few commits splitting the KASAN instrumented bitops header in
three, to match the split of the asm-generic bitops headers.

This is needed on powerpc because we use asm-generic/bitops/non-atomic.h,
for the non-atomic bitops, whereas the existing KASAN instrumented
bitops assume all the underlying operations are provided by the arch
as arch_foo() versions.

Thanks to:
  Daniel Axtens & Christophe Leroy.

- ------------------------------------------------------------------
Daniel Axtens (2):
      kasan: support instrumented bitops combined with generic bitops
      powerpc: support KASAN instrumentation of bitops

Michael Ellerman (1):
      docs/core-api: Remove possibly confusing sub-headings from Bit Operations


 Documentation/core-api/kernel-api.rst                |   8 +-
 arch/powerpc/include/asm/bitops.h                    |  51 ++--
 arch/s390/include/asm/bitops.h                       |   4 +-
 arch/x86/include/asm/bitops.h                        |   4 +-
 include/asm-generic/bitops-instrumented.h            | 263 --------------------
 include/asm-generic/bitops/instrumented-atomic.h     | 100 ++++++++
 include/asm-generic/bitops/instrumented-lock.h       |  81 ++++++
 include/asm-generic/bitops/instrumented-non-atomic.h | 114 +++++++++
 8 files changed, 337 insertions(+), 288 deletions(-)
 delete mode 100644 include/asm-generic/bitops-instrumented.h
 create mode 100644 include/asm-generic/bitops/instrumented-atomic.h
 create mode 100644 include/asm-generic/bitops/instrumented-lock.h
 create mode 100644 include/asm-generic/bitops/instrumented-non-atomic.h
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl3qSS4ACgkQUevqPMjh
pYCp1Q//TrG2tPMDPHpWqCzNdWoh96zpIo2UsauDcc8l+XT7shkwHcGnpoECgCfK
NjhP77qqXI61E+5qUCfO16/j5g6PbvvG/E/xlQEdgX7lIxBeGs4IkoRU8QjkJ9w5
wAjG/XwaMJ21CQY2F51dn9NPQUvFxKV0o6QJ+/pIFBnv0eeYCtRWno7+tZGIiMhk
ExfJhR0rnBdBc6oonNOTAfWn5u51FRRqUeICeo4iFoICu5v4cTbPiU3/8bZYzhSb
wM9WdG+/IUs02PffIQF4GDyMmzi/Qm3Ujl3tUIEaFHlfN9pF6X7Yog7Co26CShJj
No4wJK5rS3ECXmwo7Yd69sV9FZrMZZvGY9x7p7bEE7mqk1fHMaM3DMXvR8Gx6UGM
NCXX2QIIigz3RUTbj3CW2iZa9R/FTSFXs3Ih4YDDJdPNanYpcX3/wE6mpwsco8do
lxWcN1AMGXLiaNdQ8IkRZ6hOLH/Po34RvDo1P1mS06NzfyyTZW7JNiUtU2HSqPRs
vjIkHDM7585ika6jeDHU4cJaLy7bsCNV2fLsHWDE3Xno43g7qcKGOx+PtO25XubZ
iP1vojR4Qml+e3ySf6dDiOIDltSWZwjCGtbi2gmdErHiLdLeJX2XGjC36Qnep6u6
15HIWzX41tg8y4QRJDmPyeDm3Ccbabz+m4LaccbdObgGWVwxwgA=
=06Wr
-----END PGP SIGNATURE-----
