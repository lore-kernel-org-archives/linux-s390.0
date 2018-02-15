From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] KVM: s390: Refactor host cmma and pfmfi
 interpretation controls
Date: Thu, 15 Feb 2018 17:42:40 +0100
Message-ID: <208a30df-f8af-9f73-bffd-71c6f94cf0a0@linux.vnet.ibm.com>
References: <28551222-18a6-4566-0b7a-acc366c860c3@redhat.com>
 <1518709402-91101-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518709402-91101-2-git-send-email-frankja@linux.vnet.ibm.com>
 <4b1638fd-c5d9-b265-861b-5065a83c0342@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CA4gLwFi2PHl3KeVymrJNRR75MCWvqxhW"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4b1638fd-c5d9-b265-861b-5065a83c0342@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CA4gLwFi2PHl3KeVymrJNRR75MCWvqxhW
Content-Type: multipart/mixed; boundary="vGdu8yliXlK0jsGE5SZxm0QFtPKEgRIZg";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <208a30df-f8af-9f73-bffd-71c6f94cf0a0@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] KVM: s390: Refactor host cmma and pfmfi
 interpretation controls
References: <28551222-18a6-4566-0b7a-acc366c860c3@redhat.com>
 <1518709402-91101-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518709402-91101-2-git-send-email-frankja@linux.vnet.ibm.com>
 <4b1638fd-c5d9-b265-861b-5065a83c0342@redhat.com>
In-Reply-To: <4b1638fd-c5d9-b265-861b-5065a83c0342@redhat.com>

--vGdu8yliXlK0jsGE5SZxm0QFtPKEgRIZg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.02.2018 17:08, David Hildenbrand wrote:
> On 15.02.2018 16:43, Janosch Frank wrote:
>> use_cmma in kvm_arch means that the vm is allowed to use cmma, whereas=

>> use_cmma in the mm context means it has been used before. Let's rename=

>> the kvm_arch one to has_cmma
>=20
> Unfortunately all naming related to CMM(A) is already screwed up.
>=20
> If the guest can issue the ESSA instruction, it has the CMM facility. W=
e
> used to provide it to him by enabling the CMMA control - the
> "interpretation facility". We could right now fully emulate it (which i=
s
> what we do when we dirty track changes).
>=20
> At least in the CPU model we did it right. (the feature is called "cmm"=
)
>=20
> But anyhow, we only provide the CMM facility to the guest right now if
> we have CMMA, so keeping the name "cmma" here is not completely wrong.
>=20
>>
>> Also let's introduce has_pfmfi, so we can remove the pfmfi disablement=

>=20
> Mixed feelings. has_pfmfi sounds more like "this guest has the PFMFI
> feature", which is something related to vSIE. It is really more
> "use_pfmfi". Because we provide the PFMF instruction either way (by
> emulating it - it belongs to edat1).
>=20
> Can we name this "use_cmma" and "use_pfmfi" and "use_skf", because that=

> is actually what we do?

As long as we have a difference between the arch and the context one and
the implementation of the patches are not a problem, sure.

We could also invert them and use emulate_pfmf or intercept_* which is
more specific about what we actually (don't) do.

>=20
> The thing in the mm context should rather be renamed to "uses_cmm(a)" o=
r
> "used_cmm(a)".

Yes, I like uses more, the rest of the gang likes used, now feel free to
propose something entirely different :)

If there's not much that speaks against the first two patches, I'd spin
them off to merge them earlier, the use_cmma cleanup has been on my list
for a long time. Thoughts?

>=20
>> when we activate cmma and rather not activate it in the first place.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  3 ++-
>>  arch/s390/kvm/kvm-s390.c         | 25 +++++++++++++------------
>>  arch/s390/kvm/priv.c             |  2 +-
>>  3 files changed, 16 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/=
kvm_host.h
>> index afb0f08..b768754 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -791,7 +791,8 @@ struct kvm_arch{
>>  	unsigned long mem_limit;
>>  	int css_support;
>>  	int use_irqchip;
>> -	int use_cmma;
>> +	int has_cmma;
>> +	int has_pfmfi;
>>  	int user_cpu_state_ctrl;
>>  	int user_sigp;
>>  	int user_stsi;
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 4a2d68c..781aaf0 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -655,7 +655,9 @@ static int kvm_s390_set_mem_control(struct kvm *kv=
m, struct kvm_device_attr *att
>>  		VM_EVENT(kvm, 3, "%s", "ENABLE: CMMA support");
>>  		mutex_lock(&kvm->lock);
>>  		if (!kvm->created_vcpus) {
>> -			kvm->arch.use_cmma =3D 1;
>> +			kvm->arch.has_cmma =3D 1;
>> +			/* Not compatible with cmma. */
>> +			kvm->arch.has_pfmfi =3D 0;
>>  			ret =3D 0;
>>  		}
>>  		mutex_unlock(&kvm->lock);
>> @@ -665,7 +667,7 @@ static int kvm_s390_set_mem_control(struct kvm *kv=
m, struct kvm_device_attr *att
>>  		if (!sclp.has_cmma)
>>  			break;
>>  		ret =3D -EINVAL;
>> -		if (!kvm->arch.use_cmma)
>> +		if (!kvm->arch.has_cmma)
>>  			break;
>> =20
>>  		VM_EVENT(kvm, 3, "%s", "RESET: CMMA states");
>> @@ -810,7 +812,7 @@ static int kvm_s390_vm_start_migration(struct kvm =
*kvm)
>>  		return -ENOMEM;
>>  	kvm->arch.migration_state =3D mgs;
>> =20
>> -	if (kvm->arch.use_cmma) {
>> +	if (kvm->arch.has_cmma) {
>>  		/*
>>  		 * Get the first slot. They are reverse sorted by base_gfn, so
>>  		 * the first slot is also the one at the end of the address
>> @@ -855,7 +857,7 @@ static int kvm_s390_vm_stop_migration(struct kvm *=
kvm)
>>  	mgs =3D kvm->arch.migration_state;
>>  	kvm->arch.migration_state =3D NULL;
>> =20
>> -	if (kvm->arch.use_cmma) {
>> +	if (kvm->arch.has_cmma) {
>>  		kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
>>  		/* We have to wait for the essa emulation to finish */
>>  		synchronize_srcu(&kvm->srcu);
>> @@ -1551,7 +1553,7 @@ static int kvm_s390_get_cmma_bits(struct kvm *kv=
m,
>>  	cur =3D args->start_gfn;
>>  	i =3D next =3D pgstev =3D 0;
>> =20
>> -	if (unlikely(!kvm->arch.use_cmma))
>> +	if (unlikely(!kvm->arch.has_cmma))
>>  		return -ENXIO;
>>  	/* Invalid/unsupported flags were specified */
>>  	if (args->flags & ~KVM_S390_CMMA_PEEK)
>> @@ -1650,7 +1652,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kv=
m,
>> =20
>>  	mask =3D args->mask;
>> =20
>> -	if (!kvm->arch.use_cmma)
>> +	if (!kvm->arch.has_cmma)
>>  		return -ENXIO;
>>  	/* invalid/unsupported flags */
>>  	if (args->flags !=3D 0)
>> @@ -2007,6 +2009,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned l=
ong type)
>> =20
>>  	kvm->arch.css_support =3D 0;
>>  	kvm->arch.use_irqchip =3D 0;
>> +	kvm->arch.has_pfmfi =3D sclp.has_pfmfi;
>>  	kvm->arch.epoch =3D 0;
>> =20
>>  	spin_lock_init(&kvm->arch.start_stop_lock);
>> @@ -2045,7 +2048,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu=
)
>>  	if (kvm_is_ucontrol(vcpu->kvm))
>>  		gmap_remove(vcpu->arch.gmap);
>> =20
>> -	if (vcpu->kvm->arch.use_cmma)
>> +	if (vcpu->kvm->arch.has_cmma)
>>  		kvm_s390_vcpu_unsetup_cmma(vcpu);
>>  	free_page((unsigned long)(vcpu->arch.sie_block));
>> =20
>> @@ -2431,8 +2434,6 @@ int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vc=
pu)
>>  	vcpu->arch.sie_block->cbrlo =3D get_zeroed_page(GFP_KERNEL);
>>  	if (!vcpu->arch.sie_block->cbrlo)
>>  		return -ENOMEM;
>> -
>> -	vcpu->arch.sie_block->ecb2 &=3D ~ECB2_PFMFI;
>>  	return 0;
>>  }
>> =20
>> @@ -2468,7 +2469,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
>>  	if (test_kvm_facility(vcpu->kvm, 73))
>>  		vcpu->arch.sie_block->ecb |=3D ECB_TE;
>> =20
>> -	if (test_kvm_facility(vcpu->kvm, 8) && sclp.has_pfmfi)
>> +	if (test_kvm_facility(vcpu->kvm, 8) && vcpu->kvm->arch.has_pfmfi)
>>  		vcpu->arch.sie_block->ecb2 |=3D ECB2_PFMFI;
>>  	if (test_kvm_facility(vcpu->kvm, 130))
>>  		vcpu->arch.sie_block->ecb2 |=3D ECB2_IEP;
>> @@ -2502,7 +2503,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
>>  	else
>>  		vcpu->arch.sie_block->ictl |=3D ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
>> =20
>> -	if (vcpu->kvm->arch.use_cmma) {
>> +	if (vcpu->kvm->arch.has_cmma) {
>>  		rc =3D kvm_s390_vcpu_setup_cmma(vcpu);
>>  		if (rc)
>>  			return rc;
>> @@ -3013,7 +3014,7 @@ static int kvm_s390_handle_requests(struct kvm_v=
cpu *vcpu)
>>  		 * Re-enable CMMA virtualization if CMMA is available and
>>  		 * was used.
>>  		 */
>> -		if ((vcpu->kvm->arch.use_cmma) &&
>> +		if ((vcpu->kvm->arch.has_cmma) &&
>>  		    (vcpu->kvm->mm->context.use_cmma))
>>  			vcpu->arch.sie_block->ecb2 |=3D ECB2_CMMA;
>>  		goto retry;
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index c4c4e15..908b579 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -1050,7 +1050,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
>>  	VCPU_EVENT(vcpu, 4, "ESSA: release %d pages", entries);
>>  	gmap =3D vcpu->arch.gmap;
>>  	vcpu->stat.instruction_essa++;
>> -	if (!vcpu->kvm->arch.use_cmma)
>> +	if (!vcpu->kvm->arch.has_cmma)
>>  		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
>> =20
>>  	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>>
>=20
>=20



--vGdu8yliXlK0jsGE5SZxm0QFtPKEgRIZg--

--CA4gLwFi2PHl3KeVymrJNRR75MCWvqxhW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJahbiHAAoJEBcO/8Q8ZEV5Y/QP/RBRsW3dgivHEgqOwryVGjYQ
ty9AGAlv7/FrwOn4V9mCg5P+KEl8K18lBfngaaFo/jEzRu3rWk0Sd3u4ot4kj+lH
xoa7MP+jQWoCxNkEGZrrxduEy2U6URpNJqjSrPFf15X29/phTDzt7sa5Ocqt07i3
hxhcJJOHwfH9iAgIfQoJoiwuRCZSIAwN/rpNthuWXNz7A1qrU9F0boxtCeD4DOYV
R52vzTRdzFlVEQYZ87931/vNZ87b54ocJmDMDk53kYuiOWGaY5rCcD4GNhapvpBh
imyMt1b35obc4QimEl765MsWR2oLjP7q7mU0+adI/jlK13GUyQJ8qly2PqmFoWom
uPsVtaRFK1UwkEe3F0I3fapGKUtP5nAKlVvhrVP3wlh1yENhVZKVgQU6iCTArtgn
CC39VYMEUvfsKyFncofngcs1SbKkiXehHb9QvYwbCsJFbNJqb7IrbYHgBo9ZODjH
5Fw1TlNMR0wMTtWl670WCWjuEaMJGXNqC3zM5ZLSdP1dj/k8AO9ckEp0yD/q9V3/
MI69zrhRq99hKqSiiIEY+yhct/ZcQX6gVHPT6b0soWxVVrh58c8wTTpzaZBNtUwx
H/VjV5V+B3zFBfKL7xP01X2gJAsDQFysKtBk2qnZ4OQtjprA4O2+xAGNCbc0MZ28
I12s+lNHPlveD79WVIjE
=4Ti8
-----END PGP SIGNATURE-----

--CA4gLwFi2PHl3KeVymrJNRR75MCWvqxhW--
