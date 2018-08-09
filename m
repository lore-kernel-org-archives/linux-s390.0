From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v8 20/22] KVM: s390: Handling of Cypto control block in
 VSIE
Date: Thu, 9 Aug 2018 08:20:28 +0200
Message-ID: <dc8b3e66-9ba4-2b78-1e49-12a35d5d234b@linux.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-21-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7yP7ABIUzi2Flvscp0MxtQKgqiq9qW3nw"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533739472-7172-21-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7yP7ABIUzi2Flvscp0MxtQKgqiq9qW3nw
Content-Type: multipart/mixed; boundary="zoIkknPCBIS9fHSmo77lJf57uLCc1UdSj";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
 bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
 alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
 jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
 berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
 Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <dc8b3e66-9ba4-2b78-1e49-12a35d5d234b@linux.ibm.com>
Subject: Re: [PATCH v8 20/22] KVM: s390: Handling of Cypto control block in
 VSIE
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-21-git-send-email-akrowiak@linux.vnet.ibm.com>
In-Reply-To: <1533739472-7172-21-git-send-email-akrowiak@linux.vnet.ibm.com>

--zoIkknPCBIS9fHSmo77lJf57uLCc1UdSj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.08.2018 16:44, Tony Krowiak wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> +#define ECA_APIE 0x00000008

That shouldn't be necessary, it's defined in kvm_host.h which vsie.c
includes. Or is it not?

> +static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_=
page)
> +{
> +	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
> +	struct kvm_s390_sie_block *scb_o =3D vsie_page->scb_o;
> +	const uint32_t crycbd_o =3D READ_ONCE(scb_o->crycbd);
> +	const u32 crycb_addr =3D crycbd_o & 0x7ffffff8U;
> +	int g2_fmt =3D vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
> +	int g3_fmt =3D crycbd_o & CRYCB_FORMAT_MASK;
> +	int g2_apie, g2_msa3, g3_apie, g3_msa3;
> +	int size, ret;
> +
> +	/* crycb should not cross a page boundary */
> +	size =3D (g3_fmt =3D=3D CRYCB_FORMAT2) ? 0x100 : 0x80;
> +	if ((crycb_addr & PAGE_MASK) !=3D ((crycb_addr + size) & PAGE_MASK))
> +		return set_validity_icpt(scb_s, 0x003CU);
> +
> +	g2_apie =3D vcpu->arch.sie_block->eca & ECA_APIE;
> +	g3_apie =3D scb_o->eca & g2_apie;
> +
> +	g2_msa3 =3D test_kvm_facility(vcpu->kvm, 76);
> +	g3_msa3 =3D (g3_fmt !=3D CRYCB_FORMAT0) & g2_msa3;
> +
> +	scb_s->crycbd =3D 0;
> +	/* If no AP instructions and no keys we just set crycbd to 0 */
> +	if (!(g3_apie || g3_msa3))
> +		return 0;
> +
> +	if (!crycb_addr)
> +		return set_validity_icpt(scb_s, 0x0039U);
> +
> +	if (g3_apie) {
> +		ret =3D copy_apcb(vcpu, vsie_page, g2_fmt, g3_fmt);
> +		if (ret)
> +			goto out;

s/goto out;/return ret;/

> +		scb_s->eca |=3D g3_apie;
> +	}
> +
> +	if (g3_msa3)
> +		ret =3D copy_key_masks(vcpu, vsie_page);
> +
> +	if (!ret)
> +		scb_s->crycbd =3D ((__u32)(__u64) &vsie_page->crycb) | g2_fmt;
> +
> +out:
> +	return ret;
> +}
> +
>  /* shadow (round up/down) the ibc to avoid validity icpt */
>  static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_=
page)
>  {
>=20



--zoIkknPCBIS9fHSmo77lJf57uLCc1UdSj--

--7yP7ABIUzi2Flvscp0MxtQKgqiq9qW3nw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJba90sAAoJEBcO/8Q8ZEV5flIP/0PqKs8xJo6i8IQM8Ig1oFyn
I8KXYstwekyKeZ5ebKxCxu57/lQ/tlrtz2cHl8FtskaNbd5eRRDfIbm/gXyx10l5
+8O8rC3AYFOJJ2ofJRGXUb6mh0efyOpa897V8Qs8TwJ6ZkBOXj/xL2++Im+iq/GT
lqmuWuBsQiIzmPe5r9ueF63x1EQzf8exJwXBvBarhgFGOqlguJk85uMHrYITUU0M
n3WdAmzeFlhWis6eTx9IqyyViMmlKCz15W57LTntcWboHWZV/+1HsBlPhkslxbWJ
lu4X3mnKfog062Ob12PIjZzvRske7yfVqJDfi3KezeHmRfjggdak+h/CYEpymo67
8GxIbLAoy+qlRGPBiRoV+dremAfcsCsmVBGm8CNqPFFBDBadqB+bc+WlNjB5CMAk
aIDgNGK0MAlwsRsJCDWe9Bcm/BuWNeypdnyOefRVUaT4m1O+Wn1JZHbDts2zaJ4O
OApsIWikbkExJQNeXu9BcWmcmjh8+gILHHMUQai5j0UswcaHkCUZC5M8wcWdsNug
I23b1gVPKukGifAGTL7j+7iaBI4BfpIu1RfOeauWRezWMS60xJAdFKphhzyrCgVa
i2VG4Xu7R/0uppwc+Xl666xlfR60lskYV6Zev3NR49sW06cFEx/DKcU4NUaFrZIP
h148Whx21lFUVb2kRbEM
=5ukE
-----END PGP SIGNATURE-----

--7yP7ABIUzi2Flvscp0MxtQKgqiq9qW3nw--
