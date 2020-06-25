Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46961 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390013AbgFYHKO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 03:10:14 -0400
Date: Thu, 25 Jun 2020 09:09:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/2] docs: kvm: fix rst formatting
Message-ID: <20200625090942.21dbc0cf.cohuck@redhat.com>
In-Reply-To: <22b7d435-480e-ac7f-de4f-b992df6c9ebb@linux.ibm.com>
References: <20200624202200.28209-1-walling@linux.ibm.com>
        <20200624202200.28209-3-walling@linux.ibm.com>
        <20200625083423.2ee75bb1.cohuck@redhat.com>
        <22b7d435-480e-ac7f-de4f-b992df6c9ebb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ld9iV.4s/wmw0ZpsEKDJZAx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, borntraeger@de.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

--Sig_/Ld9iV.4s/wmw0ZpsEKDJZAx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jun 2020 09:07:43 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 6/25/20 8:34 AM, Cornelia Huck wrote:
> > On Wed, 24 Jun 2020 16:22:00 -0400
> > Collin Walling <walling@linux.ibm.com> wrote:
> >  =20
> >> KVM_CAP_S390_VCPU_RESETS and KVM_CAP_S390_PROTECTED needed
> >> just a little bit of rst touch-up
> >> =20
> >=20
> > Fixes: 7de3f1423ff9 ("KVM: s390: Add new reset vcpu API")
> > Fixes: 04ed89dc4aeb ("KVM: s390: protvirt: Add KVM api documentation") =
=20
>=20
> Do we really do that for documentation changes?

Feel free to keep it or leave it :)

--Sig_/Ld9iV.4s/wmw0ZpsEKDJZAx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl70TbYACgkQ3s9rk8bw
L68P0hAAkwdGWyLFiR44i6hMte0U54WSkKflyDCBDtR8/jyjfY7k8t+D88D9RLoC
Of+FCpqVo2WeMGdoU88twIUOuT3Zvj3DegHGIisDUNOdpSHLWoqI3CTddx/tqgpE
Jg7DSuC4LBfAWnyDGbrHJFFuxuUDcZrgxCHckeJoWRJw9WoyYEJkddSQ6xygJJUO
QnkyRIdEm0zZu9ryLWAMK4QFWitb9lzZ9RtsaY0x8Wk7Lnf/nOPrgDth3+RLW/xo
/ookWunL9/5amxnjUDvvJsqfvl5ndXieBtNYEl6peDSmZMgyItW0rqNBPuaalYgU
okl1ItZ4boP8UwBUlxubmnFMKnDVrOZPDAPWFtkvJ8EQVV20DRjMjK+XjE97wmww
Rb2qmEZk/OyPbDaggkNVeyBSMS122jbnDT0XcEKUMmV2yd7nn+FaqIoFog9TgTdi
1t3X7JdOlwrPr7xfFwik2wiJq0IltoAgeLusdm3xOES31CIo9p2SzOYMtiJaDBZX
i6jYIIHl4uzTmAqaOsNgCRtnRiakKuZ9Pd2EAydLxtZeI7GUbawyk3xYMsDlOF4G
4LTNwi1YVpGgd5Tth3oIb4LN7JjdRRHF7P0Dp7y3gJynFqEmGyQ66Fs1kScBcKx3
tWWOXQots26tu3h+eKEGtF5NbmHU6dE5/8nJ/AWpOsFekiNSMF0=
=KNVK
-----END PGP SIGNATURE-----

--Sig_/Ld9iV.4s/wmw0ZpsEKDJZAx--
