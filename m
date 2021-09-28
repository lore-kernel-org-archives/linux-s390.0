Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEB2C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 10:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD466101E
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 10:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhI1KpP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Sep 2021 06:45:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240161AbhI1KpP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Sep 2021 06:45:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S9GInP006401;
        Tue, 28 Sep 2021 06:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=UXUqrhxvWfslFXoU9dYXa6K+2pOU1h+umMczfxjGqeE=;
 b=hIqy0lQwNbv6lnZWrfYODTGltD7k1jhTSYgkI+AZ1FpLNbGvnr6E4uY2An+BxfZWoa8N
 1zMoBuVp8xnYycsVnx1i0v0OAND7X2OUDnfMej9FXt406QC2IbmDAidIcBi933T8bLeb
 i3bd3XTkKQaYCcgZ6Tv84YecRLr+uVETH2Kwso6lUtuFbEFDVEvg1M7ulVcFlsfj/LHP
 R7kNeKXV86Lua2/juHU+3VWZtyVki9wY7SiSb6ma1YsqTs7t7euvcK/Dl+0n82WiTa4z
 SbWazK4IauMDmS9jlfwIV0dHRxfEIMSm9azWF2wgQ+XzU5A6HFtrnnujLOGZs8CE1y2X ag== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bc0929mb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 06:43:33 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18SAXG2W031693;
        Tue, 28 Sep 2021 10:43:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3b9u1jcvhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 10:43:30 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18SAhROr1245722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 10:43:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74E1B52067;
        Tue, 28 Sep 2021 10:43:27 +0000 (GMT)
Received: from osiris (unknown [9.145.163.77])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 3FF6452075;
        Tue, 28 Sep 2021 10:43:27 +0000 (GMT)
Date:   Tue, 28 Sep 2021 12:43:25 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc:     linux-s390@vger.kernel.org,
        Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: debug_defconfig: error: call to '__write_overflow' declared with
 attribute error: detected write beyond size of object passed as 1st
 parameter
Message-ID: <YVLxzffW9a/FAVTt@osiris>
References: <20210924220235.nw5yicp5z27svvn5@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210924220235.nw5yicp5z27svvn5@lug-owl.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u2hNPOXX5acvcus6Z-H55MB_ckFJwuwX
X-Proofpoint-GUID: u2hNPOXX5acvcus6Z-H55MB_ckFJwuwX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280061
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Sep 25, 2021 at 12:02:35AM +0200, Jan-Benedict Glaw wrote:
> Hi!
>=20
> I'm building a lot of Binutils/GCC targets and with those the Linux
> kernel defconfigs.
>=20
> For s390, I started to see a build error when building the
> debug_defconfig:
>=20
> [mk all 2021-09-20 04:27:45]   s390x-linux-gnu-gcc -Wp,-MMD,arch/s390/cry=
pto/.paes_s390.o.d -nostdinc -isystem /var/lib/laminar/run/linux-s390-debug=
_defconfig/8/toolchain/bin/../lib/gcc/s390x-linux-gnu/12.0.0/include -I./ar=
ch/s390/include -I./arch/s390/include/generated  -I./include -I./arch/s390/=
include/uapi -I./arch/s390/include/generated/uapi -I./include/uapi -I./incl=
ude/generated/uapi -include ./include/linux/compiler-version.h -include ./i=
nclude/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL=
__ -fmacro-prefix-map=3D./=3D -Wall -Wundef -Werror=3Dstrict-prototypes -Wn=
o-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=
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
> [mk all 2021-09-20 04:27:47] In file included from ./include/linux/string=
=2Eh:262,
> [mk all 2021-09-20 04:27:47]                  from ./include/linux/bitmap=
=2Eh:10,
> [mk all 2021-09-20 04:27:47]                  from ./include/linux/cpumas=
k.h:12,
> [mk all 2021-09-20 04:27:47]                  from ./include/linux/smp.h:=
13,
> [mk all 2021-09-20 04:27:47]                  from ./include/linux/lockde=
p.h:14,
> [mk all 2021-09-20 04:27:47]                  from ./include/linux/spinlo=
ck.h:63,
> [mk all 2021-09-20 04:27:47]                  from ./include/linux/mmzone=
=2Eh:8,
> [mk all 2021-09-20 04:27:47]                  from ./include/linux/gfp.h:=
6,
> [mk all 2021-09-20 04:27:47]                  from ./include/linux/slab.h=
:15,
> [mk all 2021-09-20 04:27:47]                  from ./include/linux/crypto=
=2Eh:20,
> [mk all 2021-09-20 04:27:47]                  from ./include/crypto/aes.h=
:10,
> [mk all 2021-09-20 04:27:47]                  from arch/s390/crypto/paes_=
s390.c:16:
> [mk all 2021-09-20 04:27:47] In function 'memcpy',
> [mk all 2021-09-20 04:27:47]     inlined from '__paes_convert_key.part.0'=
 at arch/s390/crypto/paes_s390.c:153:2:
> [mk all 2021-09-20 04:27:47] ./include/linux/fortify-string.h:185:25: err=
or: call to '__write_overflow' declared with attribute error: detected writ=
e beyond size of object passed as 1st parameter
> [mk all 2021-09-20 04:27:47]   185 |                         __write_over=
flow();
> [mk all 2021-09-20 04:27:47]       |                         ^~~~~~~~~~~~=
~~~~~~
> [mk all 2021-09-20 04:27:47] make[2]: *** [scripts/Makefile.build:277: ar=
ch/s390/crypto/paes_s390.o] Error 1
> [mk all 2021-09-20 04:27:47] make[1]: *** [scripts/Makefile.build:540: ar=
ch/s390/crypto] Error 2
> [mk all 2021-09-20 04:27:47] make: *** [Makefile:1868: arch/s390] Error 2
>=20
>=20
> On a first glimpse, I don't see how this overflows. Is it a compiler
> bug? Used GCC is "s390x-linux-gnu-gcc (GCC) 12.0.0 20210917
> (experimental)", while an older build for debug_defconfig (using an
> older GCC, probably ce3316e9c02c81c509173572c71a101f4eb62a24 as of Thu
> Jun 24 13:49:51 2021 -0400) succeeded.
>=20
>   OTOH, I might have failed to pinpoint the actual bug and the newer GCC
> correctly caught it?

This _looks_ like a compiler bug. Disassembling the function plus
using pahole told me that everything should be ok. However I used
gcc-11 instead of experimental gcc-12.

Adding Harald, just in case I missed something.
