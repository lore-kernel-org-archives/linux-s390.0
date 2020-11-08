Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from smtprelay0088.hostedemail.com ([216.40.44.88]:39838 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727570AbgKHU67 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 8 Nov 2020 15:58:59 -0500
Message-ID: <2b8fb8823fe73f28ef77bbdd78c9c8b2105e3077.camel@perches.com>
Subject: Re: [PATCH] s390/qeth: remove useless if/else
From: Joe Perches <joe@perches.com>
Date: Sun, 08 Nov 2020 12:58:55 -0800
In-Reply-To: <1604817287-11258-1-git-send-email-kaixuxia@tencent.com>
References: <1604817287-11258-1-git-send-email-kaixuxia@tencent.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: xiakaixu1987@gmail.com, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>

On Sun, 2020-11-08 at 14:34 +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
>=20
> Fix the following coccinelle report:
>=20
> ./drivers/s390/net/qeth_l3_main.c:107:2-4: WARNING: possible condition wi=
th no effect (if =3D=3D else)
>=20
> Both branches are the same, so remove them.
[]
> diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_m=
ain.c
[]
> @@ -104,10 +104,7 @@ static bool qeth_l3_is_addr_covered_by_ipato(struct =
qeth_card *card,
> =EF=BF=BD		qeth_l3_convert_addr_to_bits(ipatoe->addr, ipatoe_bits,
> =EF=BF=BD					  (ipatoe->proto =3D=3D QETH_PROT_IPV4) ?
> =EF=BF=BD					  4 : 16);
> -		if (addr->proto =3D=3D QETH_PROT_IPV4)
> -			rc =3D !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
> -		else
> -			rc =3D !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
> +		rc =3D !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);

It's not always best to remove one branch.

Is this a copy/paste defect or is it useless?
Do you know which?
If you do, you should state this in the commit message.
