Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C5DC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 24 Sep 2021 22:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08A961251
	for <linux-s390@archiver.kernel.org>; Fri, 24 Sep 2021 22:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345647AbhIXWOA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 24 Sep 2021 18:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345888AbhIXWNw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Sep 2021 18:13:52 -0400
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Sep 2021 15:12:18 PDT
Received: from lug-owl.de (lug-owl.de [IPv6:2a03:4000:10:469::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA0F0C0614ED
        for <linux-s390@vger.kernel.org>; Fri, 24 Sep 2021 15:12:18 -0700 (PDT)
Received: by lug-owl.de (Postfix, from userid 1001)
        id 8456C41EF6; Sat, 25 Sep 2021 00:02:35 +0200 (CEST)
Date:   Sat, 25 Sep 2021 00:02:35 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-s390@vger.kernel.org
Subject: debug_defconfig: error: call to '__write_overflow' declared with
 attribute error: detected write beyond size of object passed as 1st
 parameter
Message-ID: <20210924220235.nw5yicp5z27svvn5@lug-owl.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hyen4ykwsobycek7"
Content-Disposition: inline
X-Operating-System: Linux chamaeleon 5.8.0-0.bpo.2-amd64 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear
 warfare test the bombastical terror of flooding the spy listeners explosion
 sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare
 test the bombastical terror of flooding the spy listeners explosion sex
 drugs and rock'n'roll
X-message-flag: Please send plain text messages only. Do not send HTML
 emails. Thank you. 
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


--hyen4ykwsobycek7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm building a lot of Binutils/GCC targets and with those the Linux
kernel defconfigs.

For s390, I started to see a build error when building the
debug_defconfig:

[mk all 2021-09-20 04:27:45]   s390x-linux-gnu-gcc -Wp,-MMD,arch/s390/crypt=
o/.paes_s390.o.d -nostdinc -isystem /var/lib/laminar/run/linux-s390-debug_d=
efconfig/8/toolchain/bin/../lib/gcc/s390x-linux-gnu/12.0.0/include -I./arch=
/s390/include -I./arch/s390/include/generated  -I./include -I./arch/s390/in=
clude/uapi -I./arch/s390/include/generated/uapi -I./include/uapi -I./includ=
e/generated/uapi -include ./include/linux/compiler-version.h -include ./inc=
lude/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__=
 -fmacro-prefix-map=3D./=3D -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-=
trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=
=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-ty=
pe -Wno-format-security -std=3Dgnu89 -m64 -fPIE -mbackchain -msoft-float -m=
arch=3DzEC12 -mtune=3DzEC12 -Wa,-I./arch/s390/include -mpacked-stack -D__PA=
CK_STACK -mindirect-branch=3Dthunk -mfunction-return=3Dthunk -mindirect-bra=
nch-table -DCC_USING_EXPOLINE -pipe -Wno-sign-compare -fno-asynchronous-unw=
ind-tables -DCONFIG_AS_CFI_VAL_OFFSET=3D1 -fno-delete-null-pointer-checks -=
Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-address-=
of-packed-member -O2 -fno-allow-store-data-races -Wframe-larger-than=3D2048=
 -fno-stack-protector -Wimplicit-fallthrough=3D5 -Wno-main -Wno-unused-but-=
set-variable -Wno-unused-const-variable -ftrivial-auto-var-init=3Dzero -ena=
ble-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang -fno-s=
tack-clash-protection -g -gdwarf-4 -pg -mrecord-mcount -mnop-mcount -mfentr=
y -DCC_USING_NOP_MCOUNT -DCC_USING_FENTRY -fno-inline-functions-called-once=
 -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-stringop-trunca=
tion -Wno-zero-length-bounds -Wno-array-bounds -Wno-stringop-overflow -Wno-=
restrict -Wno-maybe-uninitialized -fno-strict-overflow -fno-stack-check -fc=
onserve-stack -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Wer=
ror=3Ddesignated-init -Wno-packed-not-aligned  -DMODULE -fPIC  -DKBUILD_BAS=
ENAME=3D'"paes_s390"' -DKBUILD_MODNAME=3D'"paes_s390"' -D__KBUILD_MODNAME=
=3Dkmod_paes_s390 -c -o arch/s390/crypto/paes_s390.o arch/s390/crypto/paes_=
s390.c
[mk all 2021-09-20 04:27:47] In file included from ./include/linux/string.h=
:262,
[mk all 2021-09-20 04:27:47]                  from ./include/linux/bitmap.h=
:10,
[mk all 2021-09-20 04:27:47]                  from ./include/linux/cpumask.=
h:12,
[mk all 2021-09-20 04:27:47]                  from ./include/linux/smp.h:13,
[mk all 2021-09-20 04:27:47]                  from ./include/linux/lockdep.=
h:14,
[mk all 2021-09-20 04:27:47]                  from ./include/linux/spinlock=
=2Eh:63,
[mk all 2021-09-20 04:27:47]                  from ./include/linux/mmzone.h=
:8,
[mk all 2021-09-20 04:27:47]                  from ./include/linux/gfp.h:6,
[mk all 2021-09-20 04:27:47]                  from ./include/linux/slab.h:1=
5,
[mk all 2021-09-20 04:27:47]                  from ./include/linux/crypto.h=
:20,
[mk all 2021-09-20 04:27:47]                  from ./include/crypto/aes.h:1=
0,
[mk all 2021-09-20 04:27:47]                  from arch/s390/crypto/paes_s3=
90.c:16:
[mk all 2021-09-20 04:27:47] In function 'memcpy',
[mk all 2021-09-20 04:27:47]     inlined from '__paes_convert_key.part.0' a=
t arch/s390/crypto/paes_s390.c:153:2:
[mk all 2021-09-20 04:27:47] ./include/linux/fortify-string.h:185:25: error=
: call to '__write_overflow' declared with attribute error: detected write =
beyond size of object passed as 1st parameter
[mk all 2021-09-20 04:27:47]   185 |                         __write_overfl=
ow();
[mk all 2021-09-20 04:27:47]       |                         ^~~~~~~~~~~~~~=
~~~~
[mk all 2021-09-20 04:27:47] make[2]: *** [scripts/Makefile.build:277: arch=
/s390/crypto/paes_s390.o] Error 1
[mk all 2021-09-20 04:27:47] make[1]: *** [scripts/Makefile.build:540: arch=
/s390/crypto] Error 2
[mk all 2021-09-20 04:27:47] make: *** [Makefile:1868: arch/s390] Error 2


On a first glimpse, I don't see how this overflows. Is it a compiler
bug? Used GCC is "s390x-linux-gnu-gcc (GCC) 12.0.0 20210917
(experimental)", while an older build for debug_defconfig (using an
older GCC, probably ce3316e9c02c81c509173572c71a101f4eb62a24 as of Thu
Jun 24 13:49:51 2021 -0400) succeeded.

  OTOH, I might have failed to pinpoint the actual bug and the newer GCC
correctly caught it?

Thanks,
  Jan-Benedict

--=20

--hyen4ykwsobycek7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQlDTvPcScNjKREqWEdvV51g5nhuwUCYU5K+AAKCRAdvV51g5nh
u5UVAJ0aI5zuff7wZGyaytVpTQvfhBCo5ACcDtz57eGyHtdxMLGO8dgA0tBPkI0=
=o6az
-----END PGP SIGNATURE-----

--hyen4ykwsobycek7--
