From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 11/22] s390/mm: Remove superfluous parameter
Date: Tue, 16 Jan 2018 13:39:03 +0100
Message-ID: <99ca63eb-d566-a0b8-cccb-8eee038a1279@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-12-git-send-email-frankja@linux.vnet.ibm.com>
 <cd57a116-dd73-033c-2298-3b78ea6c4f92@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IHzcpRNRLMnFeZnsegmHkJB2ZX2BNGCde"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <cd57a116-dd73-033c-2298-3b78ea6c4f92@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IHzcpRNRLMnFeZnsegmHkJB2ZX2BNGCde
Content-Type: multipart/mixed; boundary="7KqPwpWggE95lCBao12Jtgg0kPO5hJ8po";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com,
 dominik.dingel@gmail.com, linux-s390@vger.kernel.org
Message-ID: <99ca63eb-d566-a0b8-cccb-8eee038a1279@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 11/22] s390/mm: Remove superfluous parameter
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-12-git-send-email-frankja@linux.vnet.ibm.com>
 <cd57a116-dd73-033c-2298-3b78ea6c4f92@linux.vnet.ibm.com>
In-Reply-To: <cd57a116-dd73-033c-2298-3b78ea6c4f92@linux.vnet.ibm.com>

--7KqPwpWggE95lCBao12Jtgg0kPO5hJ8po
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.12.2017 10:22, Janosch Frank wrote:
> On 13.12.2017 13:53, Janosch Frank wrote:
>> It seems it hasn't even been used before the last cleanup and was
>> overlooked.
>=20
> This one is an independent cleanup.
>=20
> Can we move this out of this series and schedule it for earlier
> inclusion into mainline?

Polite ping
pte has never been used, not even when it was introduced by Martin.

>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>  arch/s390/mm/gmap.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index ffc11d8..d396da8 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -2237,7 +2237,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_page);
>>   * Called with sg->parent->shadow_lock.
>>   */
>>  static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,=

>> -			       unsigned long gaddr, pte_t *pte)
>> +			       unsigned long gaddr)
>>  {
>>  	struct gmap_rmap *rmap, *rnext, *head;
>>  	unsigned long start, end, bits, raddr;
>> @@ -2322,7 +2322,7 @@ void ptep_notify(struct mm_struct *mm, unsigned =
long vmaddr,
>>  			spin_lock(&gmap->shadow_lock);
>>  			list_for_each_entry_safe(sg, next,
>>  						 &gmap->children, list)
>> -				gmap_shadow_notify(sg, vmaddr, gaddr, pte);
>> +				gmap_shadow_notify(sg, vmaddr, gaddr);
>>  			spin_unlock(&gmap->shadow_lock);
>>  		}
>>  		if (bits & PGSTE_IN_BIT)
>>
>=20
>=20



--7KqPwpWggE95lCBao12Jtgg0kPO5hJ8po--

--IHzcpRNRLMnFeZnsegmHkJB2ZX2BNGCde
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaXfJuAAoJEBcO/8Q8ZEV5BtUQAJeFanbrSx/6B0lctzypt0ST
01qngynm1IwAsqpMFKB5O+SyNbAheib25F82uIQItuzAzQ9UInZFOWiKji3E6MPC
yGLl2YLvrl757ibQxFWFaFugYLG3XrGkHjjYwGJX6v9DjCR26SrnPcqAETF/cka1
ELUO5k5MgQFOX1/7WDk2N/aFiVgaOWs5cGSfiReacmsHyJZHFQIZUkAt2eUopwdM
+xa6Hi8tOlfb+OHlBVrjc2aezwuWSaGF5or/m+8Eys4ENOuOH8z5aeMllqEt7PCj
HgXSDQJustZIrpRrl9gUDzPJZfmtyh20djSBDNbVKlWTErhIUO29daaAghEkkKyb
u+gGvmNEVrZLTd3Ywru6Q6cJJV35oixLcJxa2ekQ3OWRGVYdyhKIA/q1keBt5uMM
1Y2CX/XIQx0bv8qYocL5Mdh9lNGpDiDkRbBd3uKBUN4A1VRw+2Z1uIsBw2VaXjz6
K4nu7nbzQPH58yKqSPQMCFdOzpwQs+XqQ2/zFxEk8ysxIvOqjmgKjm2Ty9V/SvUf
f+Lpxu8gWOh4gFMjwFFogDmy2vebqUB4s7dsUbPbEdiatB5icuYlYWUCLd70A8S6
eU7jT35tiMIn30rj8IADw/WGccp6iwxrcjEuMOW+dAEJ6oyvzNMcx5cVLyEYx7iG
ONZtlJDSMzhHicBuoCvG
=pPLt
-----END PGP SIGNATURE-----

--IHzcpRNRLMnFeZnsegmHkJB2ZX2BNGCde--
