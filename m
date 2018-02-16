From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] KVM: s390: Add storage key facility interpretation
 control
Date: Fri, 16 Feb 2018 15:35:18 +0100
Message-ID: <6d124087-d507-c253-e4a2-8f35dc006cd6@linux.vnet.ibm.com>
References: <1518779775-256056-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518779775-256056-3-git-send-email-frankja@linux.vnet.ibm.com>
 <970c03cd-ee21-e1a1-c390-aff4f5fce3f0@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="stMMAisgZBX38nEs861ik9SX3iuj2A5gr"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <970c03cd-ee21-e1a1-c390-aff4f5fce3f0@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, alifm@linux.vnet.ibm.com, imbrenda@linux.vnet.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--stMMAisgZBX38nEs861ik9SX3iuj2A5gr
Content-Type: multipart/mixed; boundary="9VHSh4WvOf7ZyQEWDxhsh6L5kvfd0ozYP";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, alifm@linux.vnet.ibm.com,
 imbrenda@linux.vnet.ibm.com, linux-s390@vger.kernel.org
Message-ID: <6d124087-d507-c253-e4a2-8f35dc006cd6@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] KVM: s390: Add storage key facility interpretation
 control
References: <1518779775-256056-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518779775-256056-3-git-send-email-frankja@linux.vnet.ibm.com>
 <970c03cd-ee21-e1a1-c390-aff4f5fce3f0@redhat.com>
In-Reply-To: <970c03cd-ee21-e1a1-c390-aff4f5fce3f0@redhat.com>

--9VHSh4WvOf7ZyQEWDxhsh6L5kvfd0ozYP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.02.2018 15:30, David Hildenbrand wrote:
> On 16.02.2018 12:16, Janosch Frank wrote:
>> Up to now we always expected to have the storage key facility
>> available for our (non-VSIE) KVM guests. For huge page support, we
>> need to be able to disable it, so let's introduce that now.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> Reviewed-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h    |  1 +
>>  arch/s390/include/asm/mmu.h         |  2 +-
>>  arch/s390/include/asm/mmu_context.h |  2 +-
>>  arch/s390/include/asm/pgtable.h     |  4 ++--
>>  arch/s390/kvm/kvm-s390.c            |  3 ++-
>>  arch/s390/kvm/priv.c                | 22 +++++++++++++---------
>>  arch/s390/mm/gmap.c                 |  6 +++---
>>  arch/s390/mm/pgtable.c              |  4 ++--
>>  8 files changed, 25 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/=
kvm_host.h
>> index 27918b1..f161ad0 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -793,6 +793,7 @@ struct kvm_arch{
>>  	int use_irqchip;
>>  	int use_cmma;
>>  	int use_pfmfi;
>> +	int use_skf;
>>  	int user_cpu_state_ctrl;
>>  	int user_sigp;
>>  	int user_stsi;
>> diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h=

>> index c639c95..f5ff9db 100644
>> --- a/arch/s390/include/asm/mmu.h
>> +++ b/arch/s390/include/asm/mmu.h
>> @@ -21,7 +21,7 @@ typedef struct {
>>  	/* The mmu context uses extended page tables. */
>>  	unsigned int has_pgste:1;
>>  	/* The mmu context uses storage keys. */
>> -	unsigned int use_skey:1;
>> +	unsigned int uses_skeys:1;
>>  	/* The mmu context uses CMM. */
>>  	unsigned int uses_cmm:1;
>>  } mm_context_t;
>> diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/a=
sm/mmu_context.h
>> index d3ebfa8..bc9a2a9 100644
>> --- a/arch/s390/include/asm/mmu_context.h
>> +++ b/arch/s390/include/asm/mmu_context.h
>> @@ -30,7 +30,7 @@ static inline int init_new_context(struct task_struc=
t *tsk,
>>  		test_thread_flag(TIF_PGSTE) ||
>>  		(current->mm && current->mm->context.alloc_pgste);
>>  	mm->context.has_pgste =3D 0;
>> -	mm->context.use_skey =3D 0;
>> +	mm->context.uses_skeys =3D 0;
>>  	mm->context.uses_cmm =3D 0;
>>  #endif
>>  	switch (mm->context.asce_limit) {
>> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/p=
gtable.h
>> index 9223b4d..4f26425 100644
>> --- a/arch/s390/include/asm/pgtable.h
>> +++ b/arch/s390/include/asm/pgtable.h
>> @@ -509,10 +509,10 @@ static inline int mm_alloc_pgste(struct mm_struc=
t *mm)
>>   * faults should no longer be backed by zero pages
>>   */
>>  #define mm_forbids_zeropage mm_has_pgste
>> -static inline int mm_use_skey(struct mm_struct *mm)
>> +static inline int mm_uses_skeys(struct mm_struct *mm)
>>  {
>>  #ifdef CONFIG_PGSTE
>> -	if (mm->context.use_skey)
>> +	if (mm->context.uses_skeys)
>>  		return 1;
>>  #endif
>>  	return 0;
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 8fb6549..90deb7b 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -1432,7 +1432,7 @@ static long kvm_s390_get_skeys(struct kvm *kvm, =
struct kvm_s390_skeys *args)
>>  		return -EINVAL;
>> =20
>>  	/* Is this guest using storage keys? */
>> -	if (!mm_use_skey(current->mm))
>> +	if (!mm_uses_skeys(current->mm))
>>  		return KVM_S390_GET_SKEYS_NONE;
>> =20
>>  	/* Enforce sane limit on memory allocation */
>> @@ -2010,6 +2010,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned l=
ong type)
>>  	kvm->arch.css_support =3D 0;
>>  	kvm->arch.use_irqchip =3D 0;
>>  	kvm->arch.use_pfmfi =3D sclp.has_pfmfi;
>> +	kvm->arch.use_skf =3D sclp.has_skey;
>>  	kvm->arch.epoch =3D 0;
>> =20
>>  	spin_lock_init(&kvm->arch.start_stop_lock);
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index 76a2380..d9bd147 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -208,19 +208,23 @@ int kvm_s390_skey_check_enable(struct kvm_vcpu *=
vcpu)
>>  	struct kvm_s390_sie_block *sie_block =3D vcpu->arch.sie_block;
>> =20
>>  	trace_kvm_s390_skey_related_inst(vcpu);
>> -	if (!(sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)) &&
>> +	/* Already enabled? */
>> +	if (vcpu->kvm->arch.use_skf &&
>> +	    !(sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)) &&
>>  	    !kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
>>  		return rc;
>=20
> While at it, can you directly "return 0;" here and remove the
> initialization of rc to 0? Makes the code easier to read

Sure

>=20
>> =20
>>  	rc =3D s390_enable_skey();
>>  	VCPU_EVENT(vcpu, 3, "enabling storage keys for guest: %d", rc);
>> -	if (!rc) {
>> -		if (kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
>> -			kvm_s390_clear_cpuflags(vcpu, CPUSTAT_KSS);
>> -		else
>> -			sie_block->ictl &=3D ~(ICTL_ISKE | ICTL_SSKE |
>> -					     ICTL_RRBE);
>> -	}
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
>> +		kvm_s390_clear_cpuflags(vcpu, CPUSTAT_KSS);
>> +	if (!vcpu->kvm->arch.use_skf)
>> +		sie_block->ictl |=3D ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
>> +	else
>> +		sie_block->ictl &=3D ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
>=20
>=20
> I wonder why
>=20
> vcpu->arch.sie_block->ictl |=3D ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
>=20
> Is set conditionally (sclp.has_kss) in kvm_arch_vcpu_setup().
>=20
> Can't we simply always set these bits there and only clear them here
> conditionally?

Intercept priority... skey intercepts are more important than kss.

>=20
>=20
>>  	return rc;
>>  }
>> =20
>> @@ -231,7 +235,7 @@ static int try_handle_skey(struct kvm_vcpu *vcpu)
>>  	rc =3D kvm_s390_skey_check_enable(vcpu);
>>  	if (rc)
>>  		return rc;
>> -	if (sclp.has_skey) {
>> +	if (vcpu->kvm->arch.use_skf) {
>>  		/* with storage-key facility, SIE interprets it for us */
>>  		kvm_s390_retry_instr(vcpu);
>>  		VCPU_EVENT(vcpu, 4, "%s", "retrying storage key operation");
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index 2cafcba..dbdcd25 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -3094,14 +3094,14 @@ int s390_enable_skey(void)
>>  	int rc =3D 0;
>> =20
>>  	down_write(&mm->mmap_sem);
>> -	if (mm_use_skey(mm))
>> +	if (mm_uses_skeys(mm))
>>  		goto out_up;
>> =20
>> -	mm->context.use_skey =3D 1;
>> +	mm->context.uses_skeys =3D 1;
>>  	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
>>  		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
>>  				MADV_UNMERGEABLE, &vma->vm_flags)) {
>> -			mm->context.use_skey =3D 0;
>> +			mm->context.uses_skeys =3D 0;
>>  			rc =3D -ENOMEM;
>>  			goto out_up;
>>  		}
>> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
>> index 871fc65..158c880 100644
>> --- a/arch/s390/mm/pgtable.c
>> +++ b/arch/s390/mm/pgtable.c
>> @@ -158,7 +158,7 @@ static inline pgste_t pgste_update_all(pte_t pte, =
pgste_t pgste,
>>  #ifdef CONFIG_PGSTE
>>  	unsigned long address, bits, skey;
>> =20
>> -	if (!mm_use_skey(mm) || pte_val(pte) & _PAGE_INVALID)
>> +	if (!mm_uses_skeys(mm) || pte_val(pte) & _PAGE_INVALID)
>>  		return pgste;
>>  	address =3D pte_val(pte) & PAGE_MASK;
>>  	skey =3D (unsigned long) page_get_storage_key(address);
>> @@ -180,7 +180,7 @@ static inline void pgste_set_key(pte_t *ptep, pgst=
e_t pgste, pte_t entry,
>>  	unsigned long address;
>>  	unsigned long nkey;
>> =20
>> -	if (!mm_use_skey(mm) || pte_val(entry) & _PAGE_INVALID)
>> +	if (!mm_uses_skeys(mm) || pte_val(entry) & _PAGE_INVALID)
>>  		return;
>>  	VM_BUG_ON(!(pte_val(*ptep) & _PAGE_INVALID));
>>  	address =3D pte_val(entry) & PAGE_MASK;
>>
>=20
>=20



--9VHSh4WvOf7ZyQEWDxhsh6L5kvfd0ozYP--

--stMMAisgZBX38nEs861ik9SX3iuj2A5gr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJahuw1AAoJEBcO/8Q8ZEV5ecUQAKvF/mIC6jnE2uVfDYzkT5Fl
LamFZpUbyFMZ+ncwkugnst4aaix31dd23V0EB1ID5ucQ/KPcWQr40KyaDT/LnZSc
knKkoXkylKQKtP1orSwWYxk0m/CCA4r6bbFYxlZdeNHoN23AvhlP+HTt9b9KUTT/
uZdBg13vRdpMBK2E746bRFvrF4hfwYcAMuFh//9UU4N3LZfqgNBbumNOSSObyRJf
quPjRUWmGOb2ooBYfpjs5i0Bi5GQvkNorq8aJTpF/VxvJuKm/yz2tkz+dEh8mxUb
73ZfY255k2klZcuv1uN0G4qfCxadXCIggKOsFg53nwATjBEV+VPtAMffAyMf0hNx
K2dkzBI6OcsADLo9bTc0LZlsI8z311iOOmWc945XmBFeTXhL4vkRYHGOTnbrNEYh
zq+vh88o6SfsMK0QN8UI3cXtFpyuTaBXvHvtZPLsx2//iWYu2tVg8H7Xm9BHt4cv
shHsw96K2KFE8/JyYiGtVspsDykt98A+ppO046dT57WbtTQUdsckY3XWU+ZtX7xu
It+3yB2u/SGTSyPIjEzPq0sTbdDRSoePvL7rQ/SfJZX6dvHW/UuaxChmIN82+HkK
rH7zbMJGWIuWVtSeHnfbfCufVM45rRhfzb/MsegXMZ8x66xF62Ysj6l8rgLNE4Qb
UhItZGXuzUr0xB05JRTw
=qMOK
-----END PGP SIGNATURE-----

--stMMAisgZBX38nEs861ik9SX3iuj2A5gr--
