From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 00/22] KVM/s390: Hugetlbfs enablement
Date: Wed, 24 Jan 2018 10:01:39 +0100
Message-ID: <ad16efe7-3b7a-04b1-7a2a-1225ea460498@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <8f1ca87d-eb66-1b88-5ef1-0123e04bc565@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mMRdqID4720zmMsOoBv1NXu5y2WlGzNHv"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <8f1ca87d-eb66-1b88-5ef1-0123e04bc565@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mMRdqID4720zmMsOoBv1NXu5y2WlGzNHv
Content-Type: multipart/mixed; boundary="Ee837jSUn4LfNDoHQn1cgzQZIowPidOWh";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <ad16efe7-3b7a-04b1-7a2a-1225ea460498@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 00/22] KVM/s390: Hugetlbfs enablement
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <8f1ca87d-eb66-1b88-5ef1-0123e04bc565@redhat.com>
In-Reply-To: <8f1ca87d-eb66-1b88-5ef1-0123e04bc565@redhat.com>

--Ee837jSUn4LfNDoHQn1cgzQZIowPidOWh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.01.2018 22:15, David Hildenbrand wrote:
> On 13.12.2017 13:53, Janosch Frank wrote:
> Please correct me if I'm wrong (this stuff is complicated):
>=20
>=20
> Right now we have to split huge pages under the following condition:
>=20
> a) We are write protecting (prot !=3D PROT_WRITE) ...
> b) ... and we are doing it during shadow page table creation
> (GMAP_NOTIFY_SHADOW)
>=20
> -> gmap_protect_pmd()

Yes

>=20
>=20
> This is to work around issues (RW vs. RO) when
> a) G2 puts G2->G3 DAT tables on same huge page as a G2 prefix
> b) Guest G2->G3 DAT tables on same huge page as G2->G3 pages referenced=

> in such a table
>=20
> "we cannot have RO and RW at the same time if things depend on each oth=
er".

Yes

>=20
>=20
> Now, the interesting thing is, for shadow page tables
> (GMAP_NOTIFY_SHADOW), we only protect RO: via gmap_protect_rmap() and
> gmap_protect_range().
>=20
> So basically for all shadow page table housekeeping, we never protect o=
n
> pmds but only on ptes. -> We always split huge pages
>=20
> This implies and important insight: _SEGMENT_ENTRY_GMAP_VSIE is never
> used. (and I will prepare a cleanup patch to make PROT_READ implicit on=

> e.g. gmap_protect_rmap(), because this clarifies this a lot)

Yes, I guess _SEGMENT_ENTRY_GMAP_VSIE is a leftover from before the
splitting.

>=20
>=20
> We only ever protect right now on huge pages without splitting it up fo=
r
> the prefix, as I already mentioned. And as discussed, I doubt this is
> really worth it. And we can get rid of a lot of code this way.

See next answer

>=20
>=20
> Long story short:
>=20
> If we simply split up huge pages when protecting the prefix, we don't
> need gmap_protect_pmd() anymore, and therefore also (at least) not

We need it for the dirty tracking, no?

>=20
> - s390/mm: Abstract gmap notify bit setting

Yes, that's not needed then.

> - s390/mm: add gmap PMD invalidation notification

We need that one (in parts) because of the protection transfer to user
space. We will be notified on mm pmds. Even if we split a pmd, we will
be notified on a pmd, not on a pte. So we need at least a skeleton that
calls pmdp_notify_split.

I'm currently preparing a patch that rips out pmd protection with
software bits. I'll attach it when finished, so we can have a look what
can go.

>=20
>=20
> So I think doing proper sub-hugepage protection right from the beginnin=
g
> makes perfect sense.
>=20
> @Martin, Christian, am I missing something? What's your take on this?
>=20



--Ee837jSUn4LfNDoHQn1cgzQZIowPidOWh--

--mMRdqID4720zmMsOoBv1NXu5y2WlGzNHv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaaEt6AAoJEBcO/8Q8ZEV5dGoP/RKw+aE+tMxLGE44NyIrKux7
l+2cCxCmwer5T6yY4I8ZZWSAGjoVZIHw6JU8vnSrrG+WRJ/F8Fs2yf+H579jhZes
LAR7+2axspe/Cm8n4UyBQAAobJltoNdtpDOBOLn+DH4VT1vjfmtCXrjjad+2Kbod
1MRGiXp5jfNsdE40h6sUsQ6E9HHq13kgyf57DgQ2cA/CAa04SEcZ4L53ntrlLLe2
zfeQ85YD3frXYVhHHODPs7TxoVcG6GitzGWaIFKghU1hULMbsjQHJtMkBvcR+cKM
pKXBZw3PedynQHeTv6fiSUMq9EAUuTRhXYJEgP5+taBfaLXxh0Lf/xI2w0ZTOE3S
zM6GPSPUpxhC2LEfuOUPiwijz4omxrCNe4/szkkueOq39ON3APh1ZuaUqoMVmvwe
0fJkUTv3PRYtTQDZ+GQPy50Y+dirrhBP4YlmIdEtdbkLDgmG6Q+u0w+g5OoZD8GW
6rGMAtO8lqxvi6XAUVFSsIOo1zPXUqSIfXl9znnbo33MGgg+UxS2JGRn0spgIzYn
br5H2Ky+QFPS1+cPiXHGRdJJL8dh3orOX7J0Ut1Buhgyi22/NpAjnT8NBtGWvhYs
zwCL+PlSnAgNVOJBenL8hf7r6ZhhWX2VFp5gSotXXZCI4yCpRNu4ux/sFqkv6E6Y
PRcNMR5RIeGMcuRzDO4i
=p/K8
-----END PGP SIGNATURE-----

--mMRdqID4720zmMsOoBv1NXu5y2WlGzNHv--
