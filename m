Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417ECC433F5
	for <linux-s390@archiver.kernel.org>; Sat, 21 May 2022 10:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbiEUKfP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 21 May 2022 06:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbiEUKfO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 21 May 2022 06:35:14 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EC762A15
        for <linux-s390@vger.kernel.org>; Sat, 21 May 2022 03:35:13 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A3F4A3F1A1
        for <linux-s390@vger.kernel.org>; Sat, 21 May 2022 10:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653129310;
        bh=6xjjxCPsshHoGVKLB5r3oHbwMZn1xq0/B2U9BnnWFDI=;
        h=From:Date:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=s3fbhfnGyhYjsueo29DEcExBNRYmjAmOs4MQWwtqyuIBnV4rdsQ8Vjgf7KjZ/Scde
         gP2irDr/CQsLCuPq7phQYUjmheFoYo7zyfEJmMrg8Jd+5z4eUzwiDXL1vQXE26SryJ
         1i1I+1QR9wzr0GrdH1pbdAS4CGFfp/euItEmJvB+XRJSIbWDcPcUhCSqvaLyBHOD01
         Df+T0Rnu7GrogAcxXZobHtsJ+TH6zWr1iccn0pNbqP1WpHBpp4bkLCA1M9DewlIt6p
         bx+C421W7eoQotg2lIcZ/TuR7kjNHzq3KRud8dpDbe428OH2xiAyPbNSKLWYkzCfqH
         rS+7r7q7seBsQ==
Received: by mail-wm1-f72.google.com with SMTP id k124-20020a1ca182000000b003973db7d1a0so893179wme.1
        for <linux-s390@vger.kernel.org>; Sat, 21 May 2022 03:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version;
        bh=6xjjxCPsshHoGVKLB5r3oHbwMZn1xq0/B2U9BnnWFDI=;
        b=teoYHX+W3jLPfTYXrOznIQayj+DnX5kVEoeWuPLwTof7sVYdRN8o543ZiSEs/l/Mcz
         m3su1gpB7CR/LDhUnX1LRLhlLvLpCHm6bmAL40x+FsHn7Q3ltIsFkgDqWOtGXCr3pMUT
         4RI21W0JeRnI9gobjyIUGxzjPLeCdPNCd4ZzeQppM0RFMeGxPcqujaUAG8xHkOvVhlt1
         hkiTzr92pQyhj5BI3OrBDK7eHw8xf1xIXhgCt4crodKlTSw/JhPUAb5zV+bUPqVUEUIq
         Hu52eBuGbmGLid2i91zkphqsabER2BBs9z14DwcKCKQZdApSdzsRPUbQ5s2GR+Co+9eD
         Fu9Q==
X-Gm-Message-State: AOAM530NUZwXbLPFvGMLgeHOQmuGM4FmO6A3xAN9JzLfFkvtTEgyMxRP
        W+JhB4CVvrlTPUR38UuGHYWKz3F9rFM3dQ/eEWPyY3XM65O4ypR3YWyLgk/ElJvoUgPuHCBgtcC
        DB3ZQKjXjULd8qAv9/OUzA7S00vXTl8xWYIK6I4M=
X-Received: by 2002:a5d:4d84:0:b0:20d:1172:a240 with SMTP id b4-20020a5d4d84000000b0020d1172a240mr11726775wru.120.1653129310282;
        Sat, 21 May 2022 03:35:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBgBLS2cEjr1e6IYas7V8FfDppzGWitFscKU8UGBaE/z0v10um6PXd5yGUyEWxoglvxr63ww==
X-Received: by 2002:a5d:4d84:0:b0:20d:1172:a240 with SMTP id b4-20020a5d4d84000000b0020d1172a240mr11726766wru.120.1653129310102;
        Sat, 21 May 2022 03:35:10 -0700 (PDT)
Received: from smeagol (mob-194-230-144-64.cgn.sunrise.net. [194.230.144.64])
        by smtp.gmail.com with ESMTPSA id u9-20020adfb209000000b0020c5253d925sm4793422wra.113.2022.05.21.03.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 03:35:08 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
Date:   Sat, 21 May 2022 12:35:03 +0200
To:     Joe Perches <joe@perches.com>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] s390: Kconfig: Fix indentation and add comments
Message-ID: <20220521123503.03da61da@smeagol>
In-Reply-To: <8d86b87edc9c9fa33b6a18fac8b160ee56e6a07c.camel@perches.com>
References: <20220520115708.147841-1-juergh@canonical.com>
        <20220520115708.147841-2-juergh@canonical.com>
        <8d86b87edc9c9fa33b6a18fac8b160ee56e6a07c.camel@perches.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7C=1PIYdh2C/CG8EBl=OCo/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

--Sig_/7C=1PIYdh2C/CG8EBl=OCo/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 20 May 2022 10:15:38 -0700
Joe Perches <joe@perches.com> wrote:

> On Fri, 2022-05-20 at 13:57 +0200, Juerg Haefliger wrote:
> > The convention for indentation seems to be a single tab. Help text is
> > further indented by an additional two whitespaces. Fix the lines that
> > violate these rules.
> >=20
> > While add it, add trailing comments to endmenu statements for better
> > readability. =20
> []
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig =20
> []
> > @@ -607,7 +607,7 @@ config RANDOMIZE_BASE
> >  	  as a security feature that deters exploit attempts relying on
> >  	  knowledge of the location of kernel internals.
> > =20
> > -endmenu
> > +endmenu # "Processor type and features" =20
>=20
> An endmenu comment is relatively unusual.
>=20
> $ git grep '^endmenu' -- '*/Kconfig*' | wc -l
> 394
> $ git grep '^endmenu.*#' -- '*/Kconfig*' | wc -l
> 20
>=20
> I believe it doesn't really help readability.

Thanks for the review. Will send a v2 without that.

...Juerg

>=20


--Sig_/7C=1PIYdh2C/CG8EBl=OCo/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmKIwFcACgkQD9OLCQum
QrfWSA/+LdHqfqWlzjHR038R4bbraz22SBsGuI4mCpDwU3gLzOKSbwxCyIr+0kG7
Ox6xDZnClHNHrQG8r+CmPYVY40Pla9Ta6E9oDouRe0m5hcpIoMmj3fD6K7q+b6PZ
3QKw6t2XIAYSfpvSkiStHRewjXc/R2wmaGuIqIFKZda6KTOKiHUBmlNUYKAsnBoR
C4CmUeCB+ky6ij6dZYYXEIxDl8ZBZnMGn938BJ2dHBu9cj7FcJyAik7v3Uc+a7RH
11RQGDqbRcHGGEC1woxv0oaZWwHzdcFumQy+hv1sbLmKGBHStXFRdoUF4NHiAYH3
3WrLE024lwnR8/ZpdClbvH661mWKY6ilNRGVMbDQ/4w9Pf5bXGFYrB2vIdK4aySr
5PIckHP5J0e2DYePlbdZabXXG71gs+yOOZ5kqA0Gv7PXpiaX53Vexop41v2e6b7y
4KpZ7mKiR+BopKxaT9/rKKilzByZc+wzg2oM+V/9gjHRnI9mbGAex1FG/hZGAKpk
0YGkf/X7edMx8fpotNtHB50F4twz3RBol2IFrh3fy1Nux17tCOShedUz9xKzkjes
iig6OdEji4uy3D+q0jwc+6HGtjMPVwze8y0kpZez5oZkqsGku6SjB/GiI+DV4zBf
5YtnG/VF+WA3LA6OKVdEaTyUoYQZ7zGP+bbMwG6pnEaNjo51QWw=
=Kwnk
-----END PGP SIGNATURE-----

--Sig_/7C=1PIYdh2C/CG8EBl=OCo/--
