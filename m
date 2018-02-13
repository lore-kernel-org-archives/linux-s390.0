From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
Date: Tue, 13 Feb 2018 15:54:43 +0100
Message-ID: <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sF527g9BHrdrWkdlITkUKHN9LICKBJMbH"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sF527g9BHrdrWkdlITkUKHN9LICKBJMbH
Content-Type: multipart/mixed; boundary="ynYaE1duruzqWiuhiKzt9epcA2v5kf9f8";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
In-Reply-To: <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>

--ynYaE1duruzqWiuhiKzt9epcA2v5kf9f8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.02.2018 15:36, David Hildenbrand wrote:
> On 09.02.2018 10:34, Janosch Frank wrote:
>> For later migration of huge pages we want to write-protect guest
>> PMDs. While doing this, we have to make absolutely sure, that the
>> guest's lowcore is always accessible when the VCPU is running. With
>> PTEs, this is solved by marking the PGSTEs of the lowcore pages with
>> the invalidation notification bit and kicking the guest out of the SIE=

>> via a notifier function if we need to invalidate such a page.
>>
>> With PMDs we do not have PGSTEs or some other bits we could use in the=

>> host PMD. Instead we pick one of the free bits in the gmap PMD. Every
>> time a host pmd will be invalidated, we will check if the respective
>> gmap PMD has the bit set and in that case fire up the notifier.
>>
>> In the first step we only support setting the invalidation bit, but we=

>> do not support restricting access of guest pmds. It will follow
>> shortly.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>=20
> [...]
>=20
>> +
>> +/**
>> + * gmap_pmd_split - Split a huge gmap pmd and use a page table instea=
d
>> + * @gmap: pointer to guest mapping meta data structure
>> + * @gaddr: virtual address in the guest address space
>> + * @pmdp: pointer to the pmd that will be split
>> + *
>> + * When splitting gmap pmds, we have to make the resulting page table=

>> + * look like it's a normal one to be able to use the common pte
>> + * handling functions. Also we need to track these new tables as they=

>> + * aren't tracked anywhere else.
>> + */
>> +static int gmap_pmd_split(struct gmap *gmap, unsigned long gaddr, pmd=
_t *pmdp)
>> +{
>> +	unsigned long *table;
>> +	struct page *page;
>> +	pmd_t new;
>> +	int i;
>> +
>=20
> That's interesting, because the SIE can now suddenly work on these
> PGSTEs, e.g. not leading to intercepts on certain events (like setting
> storage keys).
>=20
> How is that intended to be handled? I assume we would somehow have to
> forbid the SIE from making use of the PGSTE. But that involves clearing=

> certain interception controls, which might be problematic.

Well, cmma is disabled and storage keys should only be a problem, when
the pte is invalid without the pgste lock, which should never be the
case for split pmds.

>=20
>> +	page =3D page_table_alloc_pgste(gmap->mm);
>> +	if (!page)
>> +		return -ENOMEM;
>> +	table =3D (unsigned long *) page_to_phys(page);
>> +	for (i =3D 0; i < 256; i++) {
>> +		table[i] =3D (pmd_val(*pmdp) & HPAGE_MASK) + i * PAGE_SIZE;
>> +		/* pmd_large() implies pmd/pte_present() */
>> +		table[i] |=3D  _PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE;
>> +		/* ptes are directly marked as dirty */
>> +		table[i + PTRS_PER_PTE] |=3D PGSTE_UC_BIT;
>> +	}
>> +
>> +	pmd_val(new) =3D ((unsigned long)table | _SEGMENT_ENTRY |
>> +			(_SEGMENT_ENTRY_GMAP_SPLIT));
>> +	list_add(&page->lru, &gmap->split_list);
>> +	gmap_pmdp_xchg(gmap, pmdp, new, gaddr);
>> +	return 0;
>> +}
>> +
>>  /*
>>   * gmap_protect_pte - remove access rights to memory and set pgste bi=
ts
>>   * @gmap: pointer to guest mapping meta data structure
>> @@ -941,7 +1021,7 @@ static int gmap_protect_pte(struct gmap *gmap, un=
signed long gaddr,
>>  	spinlock_t *ptl =3D NULL;
>>  	unsigned long pbits =3D 0;
>> =20
>> -	ptep =3D pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
>> +	ptep =3D gmap_pte_from_pmd(gmap, pmdp, gaddr, &ptl);
>>  	if (!ptep)
>>  		return -ENOMEM;
>> =20
>> @@ -979,15 +1059,21 @@ static int gmap_protect_range(struct gmap *gmap=
, unsigned long gaddr,
>>  		rc =3D -EAGAIN;
>>  		pmdp =3D gmap_pmd_op_walk(gmap, gaddr);
>>  		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
>> -			rc =3D gmap_protect_pte(gmap, gaddr, pmdp, prot,
>> -					      bits);
>> -			if (!rc) {
>> -				len -=3D PAGE_SIZE;
>> -				gaddr +=3D PAGE_SIZE;
>> +			if (!pmd_large(*pmdp)) {
>> +				rc =3D gmap_protect_pte(gmap, gaddr, pmdp, prot,
>> +						      bits);
>> +				if (!rc) {
>> +					len -=3D PAGE_SIZE;
>> +					gaddr +=3D PAGE_SIZE;
>> +				}
>> +			} else {
>> +				rc =3D gmap_pmd_split(gmap, gaddr, pmdp);
>> +				if (!rc)
>> +					rc =3D -EFAULT;
>=20
> Not sure if -EFAULT is the right thing to do here. Actually this would
> be a much better use case for -EAGAIN.
>=20
> (or simply avoid this by doing an gmap_pmd_op_end() + continue;)

That is a leftover from the dark days of pmd protecting/notifying.
Will fix.

>=20
>>  			}
>>  			gmap_pmd_op_end(gmap, pmdp);
>>  		}
>> -		if (rc) {
>> +		if (rc && rc !=3D -EFAULT) {
>>  			vmaddr =3D __gmap_translate(gmap, gaddr);
>>  			if (IS_ERR_VALUE(vmaddr))
>>  				return vmaddr;
>> @@ -2133,6 +2219,39 @@ static void gmap_shadow_notify(struct gmap *sg,=
 unsigned long vmaddr,
>>  	spin_unlock(&sg->guest_table_lock);
>>  }

>>  /**
>>   * ptep_notify - call all invalidation callbacks for a specific pte.
>>   * @mm: pointer to the process mm_struct
>> @@ -2177,6 +2296,23 @@ void ptep_notify(struct mm_struct *mm, unsigned=
 long vmaddr,
>>  }
>>  EXPORT_SYMBOL_GPL(ptep_notify);
>> =20
>> +static void pmdp_notify_split(struct mm_struct *mm, unsigned long vma=
ddr,
>> +			      unsigned long *table)
>> +{
>> +	int i =3D 0;
>> +	unsigned long bits;
>> +	unsigned long *ptep =3D (unsigned long *)(*table & PAGE_MASK);
>> +	unsigned long *pgste =3D ptep + PTRS_PER_PTE;
>> +
>> +	for (; i < 256; i++, vmaddr +=3D PAGE_SIZE, ptep++, pgste++) {
>> +		bits =3D *pgste & (PGSTE_IN_BIT | PGSTE_VSIE_BIT);
>> +		if (bits) {
>> +			*pgste ^=3D bits;
>> +			ptep_notify_gmap(mm, vmaddr, (pte_t *)ptep, bits);
>=20
> All existing callers of ptep_notify_gmap() are called with the pgste
> lock being held. I guess we don't need that here as we always take the
> guest_table_lock when working with split PMDs.

That's my understanding

>=20
> Complicated stuff :)

Yes, also this is rather horrible performance wise, as we do another run
through the gmap list in ptep_notify_gmap, which we need to do, because
we don't get the gmap in ptep_remove_dirty_protection_split and
test_and_clear_guest_dirty_split.

The reason for that being, that we need the pgste lock for our dirty
changes which we only can do in pgtable.c for more or less proper
separation of mm and gmap functions. I've yet to find a nice and clean
solution to that.

>=20
>> +		}
>> +	}
>> +}
>=20
>=20



--ynYaE1duruzqWiuhiKzt9epcA2v5kf9f8--

--sF527g9BHrdrWkdlITkUKHN9LICKBJMbH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJagvwzAAoJEBcO/8Q8ZEV51aoP/R5RFVueRahx5NLXsavCNEm6
KHJjWSR08O/bYH5YmUA7kF0tuE6iNPmvmzgjvMpvJUJ7N8cREmlpB11Zt47VLEUv
VK9nyrRP/HZruT/KP6m79LULJw/y+NIUn1liMWgbH75jxeRuAKW0lZIu4MToQU6s
oNB8Z6dmiJ+Yr//vzo8wr+o4yzzt10cm67+No4mYD9WdxG6aqxjxBaspAi+xhNAM
ghqVdLTLNeNgD25XElXdATwt9C083yHC8LvEAUBYN5IqR0WBQJzhof9FWDJv5VjN
pnfE+nqvWwUdTWOtXH2EhyZ99snSZx2cPkqkWoHvALLGSVUlNVm3vd7LN/CbRAgn
io411eX5dzztbZDRo8YwLNhyV0w5q78LS0N+gtOkpoRcGy1yKAwOOiiIT5QbSW41
LxEMvGTF1JPcNrzj4gxP+V+tXdGWb+8lwimBefKovAqXXp1R9dl4VpMTbtAXAmgH
WIxOLIfnRIORSFpRYjLAzI+Zlo5va/UFqsTDncquxHvoP24ra62XTHo6MuokcW3c
4kdxH72tUKnwUdJ0sdt2pH5IyE0RjhZ1YWcP3vjgfWrQWQCZZi7XD6lpBulUCSR9
vuEe1uE6mUkQR0/ePLuqYmu5QSVsc4WYM4kf5XLPafl94MjKb3cSi3YTCqWWcJJZ
PHFtVzfok6/2ogVFMbuJ
=ZlnE
-----END PGP SIGNATURE-----

--sF527g9BHrdrWkdlITkUKHN9LICKBJMbH--
