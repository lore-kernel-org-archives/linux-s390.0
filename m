From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] mm: s390: Only notify on 4k pages
Date: Fri, 26 Jan 2018 11:31:41 +0100
Message-ID: <84a83cd2-28dd-98a1-2b50-09044c2d3798@linux.vnet.ibm.com>
References: <86c5bd00-a552-1737-8db8-3f7b3c21057e@redhat.com>
 <1516894398-12694-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1516894398-12694-2-git-send-email-frankja@linux.vnet.ibm.com>
 <26ef13f7-dfd4-de7d-b448-0084df956d27@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Hzz44c4DQ9AeN2J7D0WWB4XGs0E87o3nS"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <26ef13f7-dfd4-de7d-b448-0084df956d27@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hzz44c4DQ9AeN2J7D0WWB4XGs0E87o3nS
Content-Type: multipart/mixed; boundary="KkZcZNYOVlc2OoFH9ggTlmg5jy2nimgeV";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <84a83cd2-28dd-98a1-2b50-09044c2d3798@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] mm: s390: Only notify on 4k pages
References: <86c5bd00-a552-1737-8db8-3f7b3c21057e@redhat.com>
 <1516894398-12694-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1516894398-12694-2-git-send-email-frankja@linux.vnet.ibm.com>
 <26ef13f7-dfd4-de7d-b448-0084df956d27@redhat.com>
In-Reply-To: <26ef13f7-dfd4-de7d-b448-0084df956d27@redhat.com>

--KkZcZNYOVlc2OoFH9ggTlmg5jy2nimgeV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.01.2018 17:04, David Hildenbrand wrote:
> On 25.01.2018 16:33, Janosch Frank wrote:
>> Let's try this
>=20
> Actually we can reduce this code here quite a lot by simply checking fo=
r
>=20
> if (pmd_large(*pmdp)) {
> 	// splitup
> 	rc =3D EAGAIN;
> }

Yes, we can. (and I did)
It actually looks a lot better now, thanks!

I'm still dreading the rebase to put the changes into the original
patch, though. :)

>> -	/* Remove the page table tree from on specific entry */
>>  	head =3D radix_tree_delete(&sg->host_to_rmap, (vmaddr & HPAGE_MASK) =
>> PAGE_SHIFT);
>>  	gmap_for_each_rmap_safe(rmap, rnext, head) {
>>  		bits =3D rmap->raddr & _SHADOW_RMAP_MASK;
>>  		raddr =3D rmap->raddr ^ bits;
>> -		switch (bits) {
>> -		case _SHADOW_RMAP_REGION1:
>> -			gmap_unshadow_r2t(sg, raddr);
>> -			break;
>> -		case _SHADOW_RMAP_REGION2:
>> -			gmap_unshadow_r3t(sg, raddr);
>> -			break;
>> -		case _SHADOW_RMAP_REGION3:
>> -			gmap_unshadow_sgt(sg, raddr);
>> -			break;
>> -		case _SHADOW_RMAP_SEGMENT_LP:
>> +		if (bits =3D=3D  _SHADOW_RMAP_SEGMENT_LP)
>>  			gmap_unshadow_segment(sg, raddr);
>> -			break;
>> -		case _SHADOW_RMAP_SEGMENT:
>> -			gmap_unshadow_pgt(sg, raddr);
>> -			break;
>> -		case _SHADOW_RMAP_PGTABLE:
>> -			gmap_unshadow_page(sg, raddr);
>> -			break;
>> -		}
>=20
> Now this looks much better. Do we still need the _SHADOW_RMAP_SEGMENT_L=
P
> check in gmap_shadow_notify() ? don't think so

Well the l2 big -> l3 little case also needs _SHADOW_RMAP_PGTABLE, so we
need at least an if/else. I forgot about that case yesterday but just
fixed it up...

Also I'm seeing increased migration time, the 10g l2 takes 1m20s on
postcopy (1m30 precopy) to migrate, which took 30 - 45s before. However,
I did not run into any problems yet, so we got that goin' for us, which
is nice.


--KkZcZNYOVlc2OoFH9ggTlmg5jy2nimgeV--

--Hzz44c4DQ9AeN2J7D0WWB4XGs0E87o3nS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaawOOAAoJEBcO/8Q8ZEV5ozoQAJbmGa5Pf1XZQEZcyVTTvhqv
BgsDaN/aY3mLTrxJa+7ERXPbCTnjCEF9ASnIajOzB4OgVcb4bb3AE3RVvXV5qb46
O14Ss58gbrhr1aM5ZdYKs+zHceW8khrEdhuhTSGgc0+Bpr5xK2rU5BnSAT21d0iP
LgypUtamyjZVHB6Gc4f2SYe+O4mKzZQ9ZZF1Clh8R+YszMBvTPyDWyJqZ9LOtPGb
6rwVFe0yFcl1/MHBk8/R8z263jKPE1QEoLdbODvILL2ABY4f53HuykiMCCh3/gtk
oXT9NC0EGgDhyVhiIwZdj9nQFEK1oXm+e722wN1AiXfSG2ScW3F5kIkCeeO/dMm2
QxW7GjAxeJhvKNTmmrS0c9tzbc90gcSEUmI1jJJGrauxCmLSUFDWVOjoSqY5u7jA
YrvJq8A+HIhjQDmS+ACM+eLFPAhh7vhO9nfvhe/XShwGH8s4JsKAQNthQfK5HFsV
RK9L163N6obEcgFg3V7XM+83IeLcLPi5P20gjs8rc3zKGgtDrB31p0LQ1Iu8OnjT
DTY5U2RJG/YeZQxZhPiCyKt0pJznVMc0Vz7fYOjCGpfs64oDgKhX+TuCBTB/sLQG
25nXtmU7r4wBOihlHw2F8NZ2oAVGqSZKSA+wSYI9Zq/18gM5846lzndfEDQ1ItKu
dnNg8ojczLB0xrb4LN9O
=gVSZ
-----END PGP SIGNATURE-----

--Hzz44c4DQ9AeN2J7D0WWB4XGs0E87o3nS--
