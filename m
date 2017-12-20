From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 22/22] RFC: s390/mm: Add gmap lock classes
Date: Wed, 20 Dec 2017 13:36:12 +0100
Message-ID: <a052e498-a033-3274-dda8-89ef66ee07eb@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-23-git-send-email-frankja@linux.vnet.ibm.com>
 <875a7110-e255-2690-c8bc-8d7665a9f63a@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DzeMbfkgUsIiA8IwAJjknWJBTIDB1CG6N"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <875a7110-e255-2690-c8bc-8d7665a9f63a@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DzeMbfkgUsIiA8IwAJjknWJBTIDB1CG6N
Content-Type: multipart/mixed; boundary="9X4qkPuql5weSSy3vOeGlHXtrf7BlxDBc";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <a052e498-a033-3274-dda8-89ef66ee07eb@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 22/22] RFC: s390/mm: Add gmap lock classes
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-23-git-send-email-frankja@linux.vnet.ibm.com>
 <875a7110-e255-2690-c8bc-8d7665a9f63a@de.ibm.com>
In-Reply-To: <875a7110-e255-2690-c8bc-8d7665a9f63a@de.ibm.com>

--9X4qkPuql5weSSy3vOeGlHXtrf7BlxDBc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.12.2017 13:24, Christian Borntraeger wrote:
> On 12/13/2017 01:53 PM, Janosch Frank wrote:
>> A shadow gmap and its parent are locked right after each other when
>> doing VSIE management. Lockdep can't differentiate between the two
>> classes without some help.
>>  /**
>>   * struct gmap_struct - guest address space
>>   * @list: list head for the mm->context gmap list
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index cb03646..86a12f3 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -199,10 +199,8 @@ static void gmap_free(struct gmap *gmap)
>>  	gmap_radix_tree_free(&gmap->host_to_guest);
>>
>>  	/* Free split pmd page tables */
>> -	spin_lock(&gmap->guest_table_lock);
>>  	list_for_each_entry_safe(page, next, &gmap->split_list, lru)
>>  		page_table_free_pgste(page);
>> -	spin_unlock(&gmap->guest_table_lock);
>=20
> Any reason why you only remove these?

They were inserted when I had some locking problems on split pages.
After I spoke to Martin and checked that we absolutely have no reference
to the gmap anymore and hence can not end up in gmap_split_free at the
same time I decided to remove them.

However, they should rather have never been introduced in the split
patch than being removed here... My current internal branch has this
fixed, as well as some other rebasing mistakes.


--9X4qkPuql5weSSy3vOeGlHXtrf7BlxDBc--

--DzeMbfkgUsIiA8IwAJjknWJBTIDB1CG6N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaOllDAAoJEBcO/8Q8ZEV5Sk8P/ih+nNnrKot6JGHdGKS1qMiV
038gFN96KJebkwM05L6Iaf2Jg3zZBg+PkIp4UC1keZ1KovtJvt+kasHH+UJgDtK0
/kkbxUn+Y4Tw7Je2ek3EevDDPI/pEcKRn9f+QBTElSUdeETWscZMuC7ygCFs0ArD
VMiOg3F16vRSgmaMrMJSOoEtfBUHmo8Z+vcm04HznuB5SX++ar2BnliaAUn+oT5w
da/BUgtihRMQ/b1/LWLN76K6XYKTnWGwzcuxI4eiRnk1sWqu2idTSd0+GMTcXDEe
Muv7egU6JZ7EGQv3yTgCuaMoqz7DLsxWyTVlvUlF8OxEpe3GdqAllYOjKyrZFDEC
wbDHOwsHDAi+/sZdzxyqn/WxkV44nxmsdyFBisXBLNDZ5syk8lU2vRk5BdzjoemL
ofFDWUWF5vzjJe8uqi+vaFTMj5SUCGN4v84U9JdFodM2sQ4UfL3RC3wnlq+3XR8h
U2IOfSNF5nBzc1B92/aqR0pU02i/4a8aGpMR7JtAFj2RQyvlPUJVTZQdkwSCHbHf
Gutd9LYohzYUfXWqsjhmfkCRaCqikx9fhIee+ieB8QpubJ3KoY65KjPFj6KcAeu2
zVEobFigLpbaNELXxR2K/qG7tDgj5IMbCmJ2+g+DyD3U4s5ERE0XvCK60bVIyiOx
kHvtXCqZlHYQVwkh/sxx
=SOCR
-----END PGP SIGNATURE-----

--DzeMbfkgUsIiA8IwAJjknWJBTIDB1CG6N--
