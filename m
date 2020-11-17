Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728910AbgKQPWk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 10:22:40 -0500
Subject: Re: [PATCH 2/2] s390/gmap: make gmap memcg aware
References: <20201117151023.424575-1-borntraeger@de.ibm.com>
 <20201117151023.424575-3-borntraeger@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <fd9f77d2-fdd1-d2ab-d9ca-ee914ac9deaf@linux.ibm.com>
Date: Tue, 17 Nov 2020 16:22:31 +0100
MIME-Version: 1.0
In-Reply-To: <20201117151023.424575-3-borntraeger@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yn1L4LO3leP2IUxhIomLOzXc4goaloWlm"
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yn1L4LO3leP2IUxhIomLOzXc4goaloWlm
Content-Type: multipart/mixed; boundary="r28RLISvB67qD59H8b7zxUWS9egGfrkWi";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>, linux-s390
 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>
Message-ID: <fd9f77d2-fdd1-d2ab-d9ca-ee914ac9deaf@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390/gmap: make gmap memcg aware
References: <20201117151023.424575-1-borntraeger@de.ibm.com>
 <20201117151023.424575-3-borntraeger@de.ibm.com>
In-Reply-To: <20201117151023.424575-3-borntraeger@de.ibm.com>

--r28RLISvB67qD59H8b7zxUWS9egGfrkWi
Content-Type: multipart/mixed;
 boundary="------------32D3451EA9CF3737893459CE"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------32D3451EA9CF3737893459CE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/20 4:10 PM, Christian Borntraeger wrote:
> gmap allocations can be attributed to a process.
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 64795d034926..9bb2c7512cd5 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2,7 +2,7 @@
>  /*
>   *  KVM guest address space mapping code
>   *
> - *    Copyright IBM Corp. 2007, 2016, 2018
> + *    Copyright IBM Corp. 2007, 2020

Do you mean 2007 - 2020 or did you drop the 2016 and 2018?
How does this even work?

Acked-by: Janosch Frank <frankja@linux.ibm.com>


>   *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
>   *		 David Hildenbrand <david@redhat.com>
>   *		 Janosch Frank <frankja@linux.vnet.ibm.com>
> @@ -56,19 +56,19 @@ static struct gmap *gmap_alloc(unsigned long limit)=

>  		atype =3D _ASCE_TYPE_REGION1;
>  		etype =3D _REGION1_ENTRY_EMPTY;
>  	}
> -	gmap =3D kzalloc(sizeof(struct gmap), GFP_KERNEL);
> +	gmap =3D kzalloc(sizeof(struct gmap), GFP_KERNEL_ACCOUNT);
>  	if (!gmap)
>  		goto out;
>  	INIT_LIST_HEAD(&gmap->crst_list);
>  	INIT_LIST_HEAD(&gmap->children);
>  	INIT_LIST_HEAD(&gmap->pt_list);
> -	INIT_RADIX_TREE(&gmap->guest_to_host, GFP_KERNEL);
> -	INIT_RADIX_TREE(&gmap->host_to_guest, GFP_ATOMIC);
> -	INIT_RADIX_TREE(&gmap->host_to_rmap, GFP_ATOMIC);
> +	INIT_RADIX_TREE(&gmap->guest_to_host, GFP_KERNEL_ACCOUNT);
> +	INIT_RADIX_TREE(&gmap->host_to_guest, GFP_ATOMIC | __GFP_ACCOUNT);
> +	INIT_RADIX_TREE(&gmap->host_to_rmap, GFP_ATOMIC | __GFP_ACCOUNT);
>  	spin_lock_init(&gmap->guest_table_lock);
>  	spin_lock_init(&gmap->shadow_lock);
>  	refcount_set(&gmap->ref_count, 1);
> -	page =3D alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
> +	page =3D alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
>  	if (!page)
>  		goto out_free;
>  	page->index =3D 0;
> @@ -309,7 +309,7 @@ static int gmap_alloc_table(struct gmap *gmap, unsi=
gned long *table,
>  	unsigned long *new;
>=20
>  	/* since we dont free the gmap table until gmap_free we can unlock */=

> -	page =3D alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
> +	page =3D alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
>  	if (!page)
>  		return -ENOMEM;
>  	new =3D (unsigned long *) page_to_phys(page);
> @@ -594,7 +594,7 @@ int __gmap_link(struct gmap *gmap, unsigned long ga=
ddr, unsigned long vmaddr)
>  	if (pmd_large(*pmd) && !gmap->mm->context.allow_gmap_hpage_1m)
>  		return -EFAULT;
>  	/* Link gmap segment table entry location to page table. */
> -	rc =3D radix_tree_preload(GFP_KERNEL);
> +	rc =3D radix_tree_preload(GFP_KERNEL_ACCOUNT);
>  	if (rc)
>  		return rc;
>  	ptl =3D pmd_lock(mm, pmd);
> @@ -1218,11 +1218,11 @@ static int gmap_protect_rmap(struct gmap *sg, u=
nsigned long raddr,
>  		vmaddr =3D __gmap_translate(parent, paddr);
>  		if (IS_ERR_VALUE(vmaddr))
>  			return vmaddr;
> -		rmap =3D kzalloc(sizeof(*rmap), GFP_KERNEL);
> +		rmap =3D kzalloc(sizeof(*rmap), GFP_KERNEL_ACCOUNT);
>  		if (!rmap)
>  			return -ENOMEM;
>  		rmap->raddr =3D raddr;
> -		rc =3D radix_tree_preload(GFP_KERNEL);
> +		rc =3D radix_tree_preload(GFP_KERNEL_ACCOUNT);
>  		if (rc) {
>  			kfree(rmap);
>  			return rc;
> @@ -1741,7 +1741,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned lon=
g saddr, unsigned long r2t,
>=20
>  	BUG_ON(!gmap_is_shadow(sg));
>  	/* Allocate a shadow region second table */
> -	page =3D alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
> +	page =3D alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
>  	if (!page)
>  		return -ENOMEM;
>  	page->index =3D r2t & _REGION_ENTRY_ORIGIN;
> @@ -1825,7 +1825,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned lon=
g saddr, unsigned long r3t,
>=20
>  	BUG_ON(!gmap_is_shadow(sg));
>  	/* Allocate a shadow region second table */
> -	page =3D alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
> +	page =3D alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
>  	if (!page)
>  		return -ENOMEM;
>  	page->index =3D r3t & _REGION_ENTRY_ORIGIN;
> @@ -1909,7 +1909,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned lon=
g saddr, unsigned long sgt,
>=20
>  	BUG_ON(!gmap_is_shadow(sg) || (sgt & _REGION3_ENTRY_LARGE));
>  	/* Allocate a shadow segment table */
> -	page =3D alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
> +	page =3D alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
>  	if (!page)
>  		return -ENOMEM;
>  	page->index =3D sgt & _REGION_ENTRY_ORIGIN;
> @@ -2116,7 +2116,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned lo=
ng saddr, pte_t pte)
>  	parent =3D sg->parent;
>  	prot =3D (pte_val(pte) & _PAGE_PROTECT) ? PROT_READ : PROT_WRITE;
>=20
> -	rmap =3D kzalloc(sizeof(*rmap), GFP_KERNEL);
> +	rmap =3D kzalloc(sizeof(*rmap), GFP_KERNEL_ACCOUNT);
>  	if (!rmap)
>  		return -ENOMEM;
>  	rmap->raddr =3D (saddr & PAGE_MASK) | _SHADOW_RMAP_PGTABLE;
> @@ -2128,7 +2128,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned lo=
ng saddr, pte_t pte)
>  			rc =3D vmaddr;
>  			break;
>  		}
> -		rc =3D radix_tree_preload(GFP_KERNEL);
> +		rc =3D radix_tree_preload(GFP_KERNEL_ACCOUNT);
>  		if (rc)
>  			break;
>  		rc =3D -EAGAIN;
>=20


--------------32D3451EA9CF3737893459CE
Content-Type: application/pgp-keys;
 name="OpenPGP_0xE354E6B8E238B9F8.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0xE354E6B8E238B9F8.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFubpD4BEADX0uhkRhkj2AVn7kI4IuPY3A8xKat0ihuPDXbynUC77mNox7yvK3X5QBO6q=
LqY
r+qrG3buymJJRD9xkp4mqgasHdB5WR9MhXWKH08EvtvAMkEJLnqxgbqf8td3pCQ2cEpv15mH4=
9iK
SmlTcJ+PvJpGZcq/jE42u9/0YFHhozm8GfQdb9SOI/wBSsOqcXcLTUeAvbdqSBZezuMRBivJQ=
QI1
esD9HuADmxdE7c4AeMlap9MvxvUtWk4ZJ/1Z3swMVCGzZb2Xg/9jZpLsyQzblDbbTlEeyBACe=
ED7
DYLZI3d0SFKeJZ1SUyMmSOcr9zeSh4S4h4w8xgDDGmeDVygBQZa1HaoLEsb8Y4avOYIgYDhgk=
Ch0
nol7XQ5i/yKLtnNThubAcxNyryw1xSstnKlxPRoxtqTsxMAiSekk0m3WJwvwd1s878HrQNK0o=
rWd
8BzzlSswzjNfQYLF466JOjHPWFOok9pzRs+ucrs6MUwDJj0ScITWU9Rxb04XyigY4XmZ8dywa=
xwi
2ZVTEg+MD+sPmRrTw+5F+sU83cUstuymF3w1GmyofgsUZ+/ldjToHnq21MNa1wx0lCEipCCyE=
/8K
9B9bg9pUwy5lfx7yORP3JuAUfCYb8DVSHWBPHKNjHTOLb2g2UT65AjZEQE95U2AY9iYm5usMq=
aWD
39pAHfhC09/7NQARAQABzSVKYW5vc2NoIEZyYW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+w=
sF3
BBMBCAAhBQJbm6Q+AhsjBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEONU5rjiOLn4p9gQA=
Ljk
dj5euJVI2nNT3/IAxAhQSmRhPEt0AmnCYnuTcHRWPujNr5kqgtyER9+EMQ0ZkX44JU2q7OWxT=
dSN
SAN/5Z7qmOR9JySvDOf4d3mSbMB5zxL9d8SbnSs1uW96H9ZBTlTQnmLfsiM9TetAjSrR8nUmj=
Ghe
2YUhJLR1v1LguME+YseTeXnLzIzqqpu311/eYiiIGcmaOjPCE+vFjcXL5oLnGUE73qSYiujwh=
fPC
CUK0850o1fUAYq5pCNBCoKT4OddZR+0itKc/cT6NwEDwdokeg0+rAhxb4Rv5oFO70lziBplEj=
Oxu
3dqgIKbHbjzaEXTb+mr7VI9O4tTdqrwJo2q9zLqqOfDBi7NDvZFLzaCewhbdEpDYVu6/WxprA=
Y94
hY3F4trTrQMHJKQENtF6ZTQc9fcT5I3gAmP+OEvDE5hcTALpWm6Z6SzxO7gEYCnF+qGXqp8sJ=
Vrw
eMubUscyLqHoqdZC2UG4LQ1OJ97nzDpIRe0g6oJ9ZIYHKmfw5jjwH6rASTld5MFWajWdNsqK1=
5k/
RZnHAGICKVIBOBsq26m4EsBlfCdt3b/6emuBjUXR1pyjHMz2awWzCq6/6OWs5eANZ0sdosNqd=
q2v
0ULYTazJz2rlCXV89qRa7ukkNwdBSZNEwsD4eEMicj1LSrqWDZMAALw50L4jxaMD7lPLjJbaw=
sFc
BBABCAAGBQJbm7i8AAoJELvpdr8mrl3SNBQQANp57g9R15FxBxvKpu2TvP9eZJl/CeVCb6ED8=
NZL
TUweQmm3mMfzmtkbuBU9BWJwR/dfqWnjvNA/8awXDA1dxLUEUC76y1P2ya5F1DGeB9PzmK3hq=
iez
jeN0irBJwMx2ZHT190NML8InRHry1pOvkFXQBrtgwzlyvgXsuU5Und/YesGPzYwVvb0rFIbjM=
ncm
FjuIIlrVnIH3iOcr9yG+4hLHcmKcPcOBStJi5KJT/5d13i4HRKj8j3Q2wyK/XPvqBl7CBTpUv=
grr
gZA856rkOVRCwy9v9q3+F7soRwGoaKoUxhWLJt/cCXoQbRCIc9UmNxq5a2pQLrCU3MOqZEPJB=
GT/
sYfsRlNsK4Shop/pubhvRKgYVFLH/Bc8gSvBKalIOkwQxUHyH6t0YXTOFcaIymRlt+XlyH8+r=
3rq
TLIVDzjxUur0OKU/1yjG7IIBzwoFAGxXzdkeSIJ3V2oXqH4WdM+BdawllDaq3t3qMu5ykjCBR=
yxU
M4S3SoSiYyz5u5mSlSFApJXGqz0HudIUCwoO3gLruHNnj8kT0ScwyPTqS4U3zA8qYYr9+2n5n=
gN4
ZuYxWCX7/GDhYAIysdj5N+MuXElIOZeO5EUp3nIjcuoTivWTj8i4lcS56tWcEdJyporJRbHRt=
VyV
5HNGWjZIlRi8z5YBkKD11bDYdFZAPskHFFN7wsFcBBMBAgAGBQJbm7WQAAoJEIZFfh8x4fgdb=
4YP
/3v5dXvrJTUFs+8WFrY6zCmbCPDgMOu+Yw96XMqJOfdUSFgJsr9KzREGjmV43Z5p90c9dR7hP=
9j9
gv6R2N/Gn6GHljrW9F381iF1vZ7zmPTRMhXOmc6rbpisp3EicImmV+aWO5pn9C9RT2hrC4E2a=
cbv
at8LlHGbxEsRQhRtlUnfAKNxGbxkaBx8nIyjmkiFCvYUdIfdQZ5Pz6ePmUWeXVzDZKK7UO+Ca=
M+U
IMhnm44m7ud6aSS7xQFLDJr+8i5BnST1GBaAR9gr0+wQfeO077heB62Wtxgg0jr9wWIOPiD2X=
XHD
v3g3K1362+PR+nxTmcBelVjFqQpRXnw4Kcs6fmhCslHV+ixXN59q9GjOZ/OueU0JZHqZ6AFZQ=
zYl
TQD9X2cUwVbtfyOd4U1VAOVJ1F4YjD0iOkzfT8iGiEHNwtqPyWPcBvEK4/ZTDNVMUKnJPkqMa=
RKY
Q2JCv3aROtFYOCfyVoVAB/hXXGfpPWhhy1wo6gYdYe6ywt28zxXDdA9j5CBaUiQX4u24xOHbF=
aE3
+9kWLfv1MgPH5Kq7DZM6WJ3SvcqclQdaUlgPQlFTg03b2akkOXwmyQQfjA5u9G7Rz0q+8WJ+d=
zRj
2z0xgd1kAU4zckGs61M6GGGCQYcLlo1JLqUPcfBGUyRDVA8T+Tv3SmwvEuO5H+FpSVqAIykAn=
YI1
wsFcBBABAgAGBQJbm8vmAAoJEBF7vIC1phx84ccQAJCm6ibzB4lubSlWZ1fCK0vmJdBu1nxjV=
LEj
lMXw+L0xmqB2aEi5QuzoYlctnvmsL6PG7em9XO89NgPKBMVeJPSIHJ2ASOJgPk0gUknz+luOG=
MmF
1JKjfC8nwaB2GDEbj0vd3bfgLb6vOavg7XzvFavuGO4U4mzlvs8Ts+uSPBXEHDJH97AMhm+Lw=
TsR
92/a9lM95zX3jUJQvm/d8kwx1zbwXy21noOH8XmS4a8y9OKOjK6d2cxbWQJ3uio9sMyIfvp9T=
jE8
mw4U5W8bOcGDGQJhLXOiosJNl/QWCLjWdBfyXNdVIY6NXBQfvax2j9IZmugnd3u4/mFZsM16I=
CnO
fl3ULbs+PFJq9WHvmlUvbMTuGFL88TIlnKWfogRWtlaSvGBNFMAg+QxI1MHWq8PH4BNe8TqQd=
Zps
kWiRc8mvbziH59zX5EsIN90eRSmcbP6n4kBFutwtNDV9j19ee52c0GljELlJ1Q2F55LqTr0sy=
4j2
sEfObfLjIjkGs4DvLjeWbSllVKXPJ4JTUJCFO680EHE0jZ9p/VLkYNp3GDmrOSe3b7NjAUag/=
uom
x5X324p1vNzpP6Thd25q87ZljkuWayXcPp5r/9nLd33ZlGWSx5/eaUBpDSqOfXNAJTuYoFMfD=
a3U
kkC5H38e8TvJbnikKEstdT/50GZq5u2hLKiWNGVEwsFcBBIBAgAGBQJbm7/VAAoJEA0vhuyXG=
x0A
Y3sP/2Be0rwSRICIji9aNduvMknMBUfSG4IVF5+3icvWDJUJbuu0diNYmIRCpn7uJuwBrnDeV=
aYB
CTU45q95swUiSBaWliK9G1NQtLVZjSQ6kFBN/c3/Gn1/eVasJz3/5dIn+wAHFbdWWHc2m2Cr1=
r+Z
r3z3D5g6CDiFlFTvDPo6ZHbaqu7o+2QEcwg3fA5/HRcw5KG8B+boVAFqhNHxTHYFe+WEj5f6m=
qu8
LovDjhotTPq+inybSj8FbDhIwA4xpj4TrSoO+K1z0Kuc0+p9xLmlRB3QEB1FZt4iFxTSeh6oD=
TwW
X8STUaH0FlZSQQvDi1EWWkVhMu6wH9fzDDKwyaE8nn95tLv4WtceCyiRBv76RGx/Q+ejmvrvy=
6R7
0hwjWfM0Sdly2KaErnSgtEbB01qx9NCs6OBm/GNhn2WwskXnQD2oS6hAMJNI38y/XkRw8Y9SQ=
4K1
uFVBqoB+KGm2YoLfTKbGCf5U3wStWBn8a2k1j2h1hjlmlx2mA8uPkqfZQqti+HByT65rQUzFK=
OwZ
hLGhKoV8xYl8n8uVdC/NVNQI6wNoi8tEBJt0ctYnb8YdVHfRDOV5gQUsd+lCIA2dZCHWqjnLA=
D6m
kt+Q8iaVsp5eFKBlGsBSGYBpD20QLw9lixwaDzag3AhV71438ia7rjuK+bfcT8hvdFcOhcmjk=
Ors
jSvqwsFcBBIBAgAGBQJbm8iIAAoJECIOw3kbKW7CFN8P/RQk+RC0NnpL/yFAP3sF07D8ttzZN=
V3F
08ofvstZjZ4Cvc5HBUwVGehrVQO/hIjzEw8VmMFh0jnquuyvD3/OekcEAQ7aSSeJtU5+4WCPK=
0Aw
sV6S08J2EFKaNArBFUOwRCRENUgSdkDYidwtxZ6nsf8kGh80Bjr23yWcDz7lgGSzbj8JmwmVp=
kRn
OE+gpwx/QK/LZPbuJzhrDtwK5TKRTg57ZTcoD5NZ6OmKg3lSCn9eh4q8m6V0l48Y79lrZ2+ZC=
384
PsQwByoKacl1CS50UzHsd4i+wsWIjs4cl0vyRkn0Qk69yEWgG0WZHoP7WfVjCrWfgw5gBxHoW=
/QA
2aZOdSGcCLsJ1ubHh+KP43CSTNLm/+8oA49guZmBI+YsTyt4vr6/vYDvrSIz73n22edbgUr8Q=
OXN
h+sHJ7LH1sWG3kdZ8GptPqZOr7lAoGsz3QlvlEPJwqwYodShQb7sZmfT2d63YL0whBkeHOj7y=
FQp
PQYa5YDrBGQv+FLrCquysFS0cw3NzeJzhzAnDy/uSn/v6tpzvw/Qc16gMrJU0OdzfgKjzjF0N=
4Yq
IFiTPdq+bTXrvV5009ElR0uCTFjK/JF4ZVB2tn+QUwy5Jq972X3TsCQfUJKNS/O6sVM+XvcR5=
zw7
ZyqWBOMI9OEzUhqolfH+Vq36shpPjNR821NhMxh4yvWhwsBcBBABCAAGBQJc7pIqAAoJEL4Y/=
M44
5LLlLoEH/19s1qwYjKU5FushYDRtQGMXBHHqbuWHXuFgQqw9Ro9aIQTg1J3JiP04hfTIipKkU=
k8W
T7bp8oPxhoGTGhunkLGeel4VGzqew6KNgUjR4aOHly1rqWARgY6Vn1Zs2pOQwhvMHFZKzNyTX=
X0l
R67kGYDRiOY4DOYoEiSpWa0LpaIjAXzvpXgzsp9cQ73yS9wBs1CaFlgi2IleI/HM64j4gQHYm=
Hva
JngficYZBislT+6TasOJYcbjMgXtIBi8dfvox6qA7weXaTLwIixJijpUofb1IiQVAJDNCYzdA=
7aI
IZ2wCoNpIeqw7a+567ecdbcTe+8XQOMzCpqYVYO6HEV0XtnCwXMEEgEIAB0WIQTzlzFsIQqcA=
xIF
ZpFGfI7ScWqT1wUCXO7vlwAKCRBGfI7ScWqT13aVD/9s3dQVKgqwEvTyZztMtwiWtTqb2AMjf=
5/g
1MW8XbN+pim6tP+63suWYitIUG8jL8gPXvLMhE28Tndk2RkalG7RjhDrT+aiJDKFL1KegwZTh=
QBQ
9xQvLP2wk+5i0p+F5ABMn2NivCD7XVw1pk1MUM1xDyVXLvqPT8sc35RORbuny7OeM50ZgaTS+=
5wv
8cQ4Nl8SmdyOX7teGVPUTNpJz3/QXL56dcF3p/CLtF9kcJw0biPSh+7WpDWFLe45yobY7N6Hs=
2ur
ptA9K0B+1f5WNdYdbvH0r4coPJ9FSVlSt9K4hUFR31eA/NLlWaq2NJfixTyC5QP8uykLh+ZgR=
U9K
NaGbXoSZ4EoYc3EQ56i4YAA0jJGhIdfbIY++GNs42xJuyqhYuJEKl/y7sCRxHqYGx4l+E+1gs=
V8E
43XKDIizjkgUOu1+Zcrqeo64gSqllCaT99/3v8uJFrZmWDDH1sYLnoxMgPfb+ZdVwu8t8YDlU=
zmc
F0vcbAIKFDLI9/sSFuaYW8zrfSZturGAX6geZAH5S/SLn4OnMC8oZrqZmJHu7Ty3zpey5Vajs=
l9K
gEcQ06D+YH/qF5IZA4E8SwQ1j7fD7LQu7ud4VuAaF1lKU5UeE+ZBv3TYdJ+5HevRbM26LbKox=
LpL
GR+y5qwPaMwgvYLb3wQsgBy88HFgF8J9cpicJBokrs7BTQRbm6Q+ARAAwHFE0alxf2mOdzkh+=
yMC
CvZRSsSJtCKBZDhIeyzH6exRs2j+wDa2XXCM4WYt/McjpHGhWPp6RhFr5KO65SAJ9CaQTuMd4=
X4Z
oQQ/1kmPC0CBUDTYxJt786zKO2/SWyQKkMX21EWNw6pdxlM3lkxvbmidNLvhBD5WPM3FUoQ5b=
SJe
Ty4odtHvMYE5zc8eXNddJUErtImb9pQBOgzPtmyUE7DEmIsCpcE7r/SyPQoZ6KOvrbDeeTasj=
MWK
iYBJZN1c5U10q9/q7UgsH7atnIpxE288XNV7oSF+qbv2ghpzX7hJDN+G+xtQ+gj8wzKqJDRW8=
qDu
g0Nfn1unOYHLV4P5WetNohJeAuK4HK9/hKX6D1FsynjPCV7+SqauGA8Yb24ra/A5vIK9/PlCh=
WSp
Vi5cIUOeq/8wFL+iyLJtdRphbNv3JoA9W6gUzRx3E1sFrUUy4Jp6iW1YrDCbmCbeCjT6qYU1r=
D2P
EhLW7nyJWB1zidpalMzkXk64ntrtKnErxgG0n3nPWqUxZdl5KP3Xaj3GTKSoQYl5mPLSc0j5N=
/hu
Larq+Ok2AJuaLorSbIAEetQru7Pjzbqv6Uyw4SvuvzY5nPeDRgXEQOKk7srBBhO/b2Fj9qCAF=
OBb
+oKmlh2eDBCNl06h/MIsMz3QkD2LEhNH11omLuzm3hK0+oi0k2RseK0AEQEAAcLBXwQYAQgAC=
QUC
W5ukPgIbDAAKCRDjVOa44ji5+AwxD/0bsnJFuuUmXDxuHDHzYFsWRfK1Y3lZf/TwX8tNSvEdI=
Wo1
ONG1rV0jIm8u49P3TI8/fYzei/gCRyb6y8+KmEc59mLPON1vkX14+tmXXuGDQROUi4ycHkQmz=
Fim
iS4+uPfX3LcU8nm/fgDC0EuMkUsB7gGS5gG+QMgltYAXE1mW/DjeQZlp0anhpiIAtRLwpx8vv=
mgZ
x059Jvs1fPQYUy01Gpd+bXI1BcJbgWN/UdrsfxzZQTtRmN2flmF4Qb6u6pGrU4S42kEppzqzI=
c6m
JnUoT9ZXhU1W811FCGL/xm8pzv2Ky9oGkKWj9WxFBIvJVAH1yWxFhnZxxZHIq8otPdhPP/Y/P=
QyY
OJpmajmru07VMY0TJQXCJYl5M0i1JPkLw+CytZFonrybHuJrXhQXZFh3z+AR//vA8WqUXBtVA=
IXk
p0kUOS4judGp5zge6Fxfr4CiGontkwX2cUDRgLN0UPm4Gg3IQqhZuWnYkj+fjk+DY5ClHhqQX=
v2k
ckEpXv0a6KU4AovOaY3v47mBJ9j/VAIJHwSazh70PWftkr2vBUXetTSS5AieCxbpkZ/cEJV9o=
nBW
4vFA1d3aNIVyUUWE1gsax7HDIZKxVi4WIjxeIqYV+1DXTlgUPdKqR8gMR5g2s3aNu4BI377IG=
DHb
3ipJxDkxG+aYcMVoIOwXCA6CX/VDAg=3D=3D
=3DR9cN
-----END PGP PUBLIC KEY BLOCK-----

--------------32D3451EA9CF3737893459CE--

--r28RLISvB67qD59H8b7zxUWS9egGfrkWi--

--yn1L4LO3leP2IUxhIomLOzXc4goaloWlm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl+z6rcFAwAAAAAACgkQ41TmuOI4ufjR
zxAAoQt8tXngi+kHZsETdMvdd+CWpxQQ8yWZjTu5IxeK7knb84532bzvxs3qTEfKaNoNzoiDtB+U
WJT/zuRG+aZtLZu29PgqtzJA1Iuck++2fOgXJQjht2PU4Dm0/IlVmgvAQQweDPS6AeJrrieO6QqR
geJIIoNnyy+mqQ+kLDYGv34lSmTkD89pzi2+ufgem1J6BT3AZk5DX4/3V4+KdjLYUIV/ICt9SVmK
PID+Gbw2FX7fO1SIsrkweeXAtm2UhjLNuagVt3Sp8Wx5Xw+Pwz+0Koar2ZODBm9rbDJuy2ljqLUL
Hg+lSymK+UsHOuUSLbuOrgLZgbXCfDu4a5f3rvc+KP+epzhj16o/APyscbt05qRaRjRjYIBAT+Sq
SSRq+ImpVUW35jBRTUQSsotTDyS9Zcm/VQU67owqyRG7y2TVqXUe9tnar64yo3qIUN+j8zFH+1BX
QOGv4WUrvt3tRL7rP3yDGSGqcYoo/spB+wZbeeFbi+ZyYG7JPG8mogRbCxS0/7gLmsXLazMrrz3l
h+vs/xI9FF4MgjuuPFVurY093mAMpVJw0YkTwhbbWZnUkVXmQP33mjKAkUGinQB8UO7P2AnVvkyI
d7xRYgzbz/+8YXlL1o2o3JjYDZmvl8BzKlvnrQsGHAOnRGfHMtJxO+uUBrQemTs3Jn2dg1Of1mpr
j1I=
=9DPo
-----END PGP SIGNATURE-----

--yn1L4LO3leP2IUxhIomLOzXc4goaloWlm--
