Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgDTHOW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 03:14:22 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K72812054136
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 03:14:21 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmu6mb6e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 03:14:21 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 20 Apr 2020 08:13:57 +0100
Subject: Re: linux-next: Tree for Apr 20
References: <20200420142610.390e5922@canb.auug.org.au>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Apr 2020 09:14:15 +0200
MIME-Version: 1.0
In-Reply-To: <20200420142610.390e5922@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Message-Id: <2d87a4f9-9d87-e929-9b03-31f92dad5ca6@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, linux-s390 <linux-s390@vger.kernel.org>, Hadar Gat <hadar.gat@arm.com>


On 20.04.20 06:26, Stephen Rothwell wrote:
> Hi all,
>=20
> Changes since 20200417:
>=20
> My fixes tree is empty again.
>=20
> The qcom tree still had its build failure for which I reverted a commit.
>=20
> The crypto tree still has its build failure for which I reverted 5 commit=
s.
>=20
> The drm-misc tree gained a build failure for which I disabled a
> COMPILE_TEST setting.
>=20
> The sound-asoc tree still has its build failures so I used the version fr=
om
> next-20200414.
>=20
> The ipmi tree gained a build failure for which I applied a patch.
>=20
> Non-merge commits (relative to Linus' tree): 2732
>  3544 files changed, 76515 insertions(+), 37271 deletions(-)

s390 defconfig still does not compile. While the media kconfig problem is g=
one I now have

  CC [M]  drivers/char/hw_random/cctrng.o
drivers/char/hw_random/cctrng.c: In function =EF=BF=BDcc_trng_compwork_hand=
ler=EF=BF=BD:
drivers/char/hw_random/cctrng.c:334:49: error: =EF=BF=BDfips_enabled=EF=BF=
=BD undeclared (first use in this function); did you mean =EF=BF=BDvdso_ena=
bled=EF=BF=BD?
  334 |  if (CC_REG_FLD_GET(RNG_ISR, CRNGT_ERR, isr) && fips_enabled) {
      |                                                 ^~~~~~~~~~~~
      |                                                 vdso_enabled
drivers/char/hw_random/cctrng.c:334:49: note: each undeclared identifier is=
 reported only once for each function it appears in
drivers/char/hw_random/cctrng.c:335:3: error: implicit declaration of funct=
ion =EF=BF=BDfips_fail_notify=EF=BF=BD [-Werror=3Dimplicit-function-declara=
tion]
  335 |   fips_fail_notify();
      |   ^~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Can we maybe make this driver depend on ARM?
