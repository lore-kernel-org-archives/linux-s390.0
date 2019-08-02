Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:40771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbfHBEss (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 2 Aug 2019 00:48:48 -0400
Date: Fri, 2 Aug 2019 14:48:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
Message-ID: <20190802144844.43508be1@canb.auug.org.au>
In-Reply-To: <20190802031414.GB14879@gondor.apana.org.au>
References: <20190731163915.3fdfcb14@canb.auug.org.au>
        <20190731085819.GA3488@osiris>
        <20190731110816.GA20753@gondor.apana.org.au>
        <20190731111520.GC3488@osiris>
        <20190731113216.GA21068@gondor.apana.org.au>
        <20190731114453.GD3488@osiris>
        <20190801122849.GB4163@osiris>
        <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
        <20190802102019.6a789c51@canb.auug.org.au>
        <20190802031414.GB14879@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WV=Ll5clhjs7L92CiGDoOM6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, Patrick Steuer <steuer@linux.ibm.com>, Ondrej Mosnacek <omosnace@redhat.com>

--Sig_/WV=Ll5clhjs7L92CiGDoOM6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On Fri, 2 Aug 2019 13:14:14 +1000 Herbert Xu <herbert@gondor.apana.org.au> =
wrote:
>
> For now I'm going to back out those two specific patches as the
> rest seem to be valid by themselves.

I have applied the top commit from your tree to linux-next today just
to help with building and testing over the weekend (I had already
merged your tree before you added the revert).

Thanks
--=20
Cheers,
Stephen Rothwell

--Sig_/WV=Ll5clhjs7L92CiGDoOM6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1DwKwACgkQAVBC80lX
0Gx4KAgAiV9cuFhIGVwQAfbUj4A9D69fl2gB+ggN5Tg6pyo4CrosPziIsPG1bEkj
d0RCgB60EJb3You7yESMfn6LMAx15gLTq4UyIImnZiGbgKlpeQNbOGpJ4J5T3UEK
yuXf73EGoh608Mx5guggDqPzk3Ww4BeqUgwZYvLSK9JC/GG73aGkziXPeZSoE9Ta
oz5GRxCXLlHxBsLWry97jZ1d43CIhlio2Z4QLvyOK8cwLRNrb1Hd+qDNog9BvAK3
J+b5Zgj01vCKpuwn8AW3VecydnbQa3UBqiWnjXXrDNRPrPEtRUOXUdmIN0WCppYy
7flo7JAwQqsIx5shJLoh+nsE7xKANw==
=GAVZ
-----END PGP SIGNATURE-----

--Sig_/WV=Ll5clhjs7L92CiGDoOM6--
