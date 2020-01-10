Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728002AbgAJMY0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 07:24:26 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ACMVPu024311
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2020 07:24:24 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xeeywh1n9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2020 07:24:23 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 10 Jan 2020 12:24:21 -0000
Subject: Re: [PATCH v7] KVM: s390: Add new reset vcpu API
References: <20200110114540.90713-1-frankja@linux.ibm.com>
 <f6c54d4e-6b31-d93f-e919-45781aadfd55@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 10 Jan 2020 13:24:16 +0100
MIME-Version: 1.0
In-Reply-To: <f6c54d4e-6b31-d93f-e919-45781aadfd55@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fbInxgi8zL8sS9XwYBpfcgOLDUzy8i4dp"
Message-Id: <2d7610ee-e507-37f1-50c3-fe651499196d@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, borntraeger@de.ibm.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fbInxgi8zL8sS9XwYBpfcgOLDUzy8i4dp
Content-Type: multipart/mixed; boundary="hm2Rcg3P5CRUjpgJA8b5kBP2f2Kge4Gj5"

--hm2Rcg3P5CRUjpgJA8b5kBP2f2Kge4Gj5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/10/20 1:11 PM, Thomas Huth wrote:
> On 10/01/2020 12.45, Janosch Frank wrote:
>> The architecture states that we need to reset local IRQs for all CPU
>> resets. Because the old reset interface did not support the normal CPU=

>> reset we never did that on a normal reset.
>>
>> Let's implement an interface for the missing normal and clear resets
>> and reset all local IRQs, registers and control structures as stated
>> in the architecture.
>>
>> Userspace might already reset the registers via the vcpu run struct,
>> but as we need the interface for the interrupt clearing part anyway,
>> we implement the resets fully and don't rely on userspace to reset the=

>> rest.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  Documentation/virt/kvm/api.txt |  43 +++++++++++++
>>  arch/s390/kvm/kvm-s390.c       | 112 +++++++++++++++++++++++---------=
-
>>  include/uapi/linux/kvm.h       |   5 ++
>>  3 files changed, 127 insertions(+), 33 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/a=
pi.txt
>> index ebb37b34dcfc..73448764f544 100644
>> --- a/Documentation/virt/kvm/api.txt
>> +++ b/Documentation/virt/kvm/api.txt
>> @@ -4168,6 +4168,42 @@ This ioctl issues an ultravisor call to termina=
te the secure guest,
>>  unpins the VPA pages and releases all the device pages that are used =
to
>>  track the secure pages by hypervisor.
>> =20
>> +4.122 KVM_S390_NORMAL_RESET
>> +
>> +Capability: KVM_CAP_S390_VCPU_RESETS
>> +Architectures: s390
>> +Type: vcpu ioctl
>> +Parameters: none
>> +Returns: 0
>> +
>> +This ioctl resets VCPU registers and control structures according to
>> +the cpu reset definition in the POP (Principles Of Operation).
>> +
>> +4.123 KVM_S390_INITIAL_RESET
>> +
>> +Capability: none
>> +Architectures: s390
>> +Type: vcpu ioctl
>> +Parameters: none
>> +Returns: 0
>> +
>> +This ioctl resets VCPU registers and control structures according to
>> +the initial cpu reset definition in the POP. However, the cpu is not
>> +put into ESA mode. This reset is a superset of the normal reset.
>> +
>> +4.124 KVM_S390_CLEAR_RESET
>> +
>> +Capability: KVM_CAP_S390_VCPU_RESETS
>> +Architectures: s390
>> +Type: vcpu ioctl
>> +Parameters: none
>> +Returns: 0
>> +
>> +This ioctl resets VCPU registers and control structures according to
>> +the clear cpu reset definition in the POP. However, the cpu is not pu=
t
>> +into ESA mode. This reset is a superset of the initial reset.
>> +
>> +
>>  5. The kvm_run structure
>>  ------------------------
>> =20
>> @@ -5396,3 +5432,10 @@ handling by KVM (as some KVM hypercall may be m=
istakenly treated as TLB
>>  flush hypercalls by Hyper-V) so userspace should disable KVM identifi=
cation
>>  in CPUID and only exposes Hyper-V identification. In this case, guest=

>>  thinks it's running on Hyper-V and only use Hyper-V hypercalls.
>> +
>> +8.22 KVM_CAP_S390_VCPU_RESETS
>> +
>> +Architectures: s390
>> +
>> +This capability indicates that the KVM_S390_NORMAL_RESET and
>> +KVM_S390_CLEAR_RESET ioctls are available.
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index d9e6bf3d54f0..5640f3d6f98d 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -529,6 +529,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, =
long ext)
>>  	case KVM_CAP_S390_CMMA_MIGRATION:
>>  	case KVM_CAP_S390_AIS:
>>  	case KVM_CAP_S390_AIS_MIGRATION:
>> +	case KVM_CAP_S390_VCPU_RESETS:
>>  		r =3D 1;
>>  		break;
>>  	case KVM_CAP_S390_HPAGE_1M:
>> @@ -2844,35 +2845,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>> =20
>>  }
>> =20
>> -static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
>> -{
>> -	/* this equals initial cpu reset in pop, but we don't switch to ESA =
*/
>> -	vcpu->arch.sie_block->gpsw.mask =3D 0UL;
>> -	vcpu->arch.sie_block->gpsw.addr =3D 0UL;
>> -	kvm_s390_set_prefix(vcpu, 0);
>> -	kvm_s390_set_cpu_timer(vcpu, 0);
>> -	vcpu->arch.sie_block->ckc       =3D 0UL;
>> -	vcpu->arch.sie_block->todpr     =3D 0;
>> -	memset(vcpu->arch.sie_block->gcr, 0, 16 * sizeof(__u64));
>> -	vcpu->arch.sie_block->gcr[0]  =3D CR0_UNUSED_56 |
>> -					CR0_INTERRUPT_KEY_SUBMASK |
>> -					CR0_MEASUREMENT_ALERT_SUBMASK;
>> -	vcpu->arch.sie_block->gcr[14] =3D CR14_UNUSED_32 |
>> -					CR14_UNUSED_33 |
>> -					CR14_EXTERNAL_DAMAGE_SUBMASK;
>> -	/* make sure the new fpc will be lazily loaded */
>> -	save_fpu_regs();
>> -	current->thread.fpu.fpc =3D 0;
>> -	vcpu->arch.sie_block->gbea =3D 1;
>> -	vcpu->arch.sie_block->pp =3D 0;
>> -	vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
>> -	vcpu->arch.pfault_token =3D KVM_S390_PFAULT_TOKEN_INVALID;
>> -	kvm_clear_async_pf_completion_queue(vcpu);
>> -	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
>> -		kvm_s390_vcpu_stop(vcpu);
>> -	kvm_s390_clear_local_irqs(vcpu);
>> -}
>> -
>>  void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>>  {
>>  	mutex_lock(&vcpu->kvm->lock);
>> @@ -3287,10 +3259,75 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(str=
uct kvm_vcpu *vcpu,
>>  	return r;
>>  }
>> =20
>> -static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>> +static void kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu)
>>  {
>> -	kvm_s390_vcpu_initial_reset(vcpu);
>> -	return 0;
>> +	vcpu->arch.sie_block->gpsw.mask =3D ~PSW_MASK_RI;
>> +	vcpu->arch.pfault_token =3D KVM_S390_PFAULT_TOKEN_INVALID;
>> +	memset(vcpu->run->s.regs.riccb, 0, sizeof(vcpu->run->s.regs.riccb));=

>> +
>> +	kvm_clear_async_pf_completion_queue(vcpu);
>> +	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
>> +		kvm_s390_vcpu_stop(vcpu);
>> +	kvm_s390_clear_local_irqs(vcpu);
>> +}
>> +
>> +static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>> +{
>> +	/* Initial reset is a superset of the normal reset */
>> +	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
>> +
>> +	/* this equals initial cpu reset in pop, but we don't switch to ESA =
*/
>> +	vcpu->arch.sie_block->gpsw.mask =3D 0UL;
>> +	vcpu->arch.sie_block->gpsw.addr =3D 0UL;
>> +	kvm_s390_set_prefix(vcpu, 0);
>> +	kvm_s390_set_cpu_timer(vcpu, 0);
>> +	vcpu->arch.sie_block->ckc       =3D 0UL;
>> +	vcpu->arch.sie_block->todpr     =3D 0;
>> +	memset(vcpu->arch.sie_block->gcr, 0, 16 * sizeof(__u64));
>> +	vcpu->arch.sie_block->gcr[0]  =3D CR0_UNUSED_56 |
>> +					CR0_INTERRUPT_KEY_SUBMASK |
>> +					CR0_MEASUREMENT_ALERT_SUBMASK;
>> +	vcpu->arch.sie_block->gcr[14] =3D CR14_UNUSED_32 |
>> +					CR14_UNUSED_33 |
>> +					CR14_EXTERNAL_DAMAGE_SUBMASK;
>> +	/* make sure the new fpc will be lazily loaded */
>> +	save_fpu_regs();
>> +	current->thread.fpu.fpc =3D 0;
>> +	vcpu->arch.sie_block->gbea =3D 1;
>> +	vcpu->arch.sie_block->pp =3D 0;
>> +	vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
>> +}
>> +
>> +static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_sync_regs *regs =3D &vcpu->run->s.regs;
>> +
>> +	/* Clear reset is a superset of the initial reset */
>> +	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
>=20
> s/kvm_arch_vcpu_ioctl_normal_reset/kvm_arch_vcpu_ioctl_initial_reset/

-_-
It seems like my vacation was not enough...

>=20
>> +	memset(&regs->gprs, 0, sizeof(regs->gprs));
>> +	/* Will be picked up because of save_fpu_regs() in the initial reset=
 */
>> +	memset(&current->thread.fpu.vxrs, 0, sizeof(current->thread.fpu.vxrs=
));
>=20
> I'm still not 100% sure about whether current->thread.fpu.vxrs is alway=
s
> fine here? But I hope Christian can give an ACK for that...
>=20
>  Thomas
>=20



--hm2Rcg3P5CRUjpgJA8b5kBP2f2Kge4Gj5--

--fbInxgi8zL8sS9XwYBpfcgOLDUzy8i4dp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4YbPAACgkQ41TmuOI4
ufip1RAAqwg/QLYCGS8+X9Bf6Mp3caZgm6mwjWglW/6I/7dYpne+4FrzutIzFK92
q/XoX4Y3GRYx2QncEdIcYvGd1UOw7z+5wpJtWrwEO8lrhh82A/M2tBpDyfwKZfAI
3EH4sngf9+7vN+LJbll8KN5bWeNpxtXZjWokdb05GCYT8jFWo034qo2I5yQQr6wS
B71FGbAw07rgkAoLDMDkc8YOLCZwi7Pu8wDtZxgDYbFNyBbbZK9CEFI5UMCUiRmO
hTTUmkPn9njbAmBUJlnlc2MqwbQsrOlSdZBoXVJX+hFT8FFM4Hwen7tiVEQ5kmyJ
YheWbs1FSAW0C3vUX/hoTJq48c/q+1nO3iZ8bqzUQw0wBjdaWiyz8lfUSsmP8bpt
IHdexHWfhQUMSBVAUwiMsiCgGGIjWNV5ma6/RsaL9HWYL2nN5dza94o7+dBvFo2T
Hhj1mIREh8Ki2OnjTlXu8b0VnVwmUn8upQVxbLqtnlcv9uxYaopr4YdwRwjY8790
ckUYa/Rk8/bpnNcfsljr6r3WHk1Zp6P57wKONCYHfyGXftcBFbAo8mc8NuyD/1r9
rPV436kPamDJFGa9Le6mWRLL6djhzKRozoF+ISJsvqVp5kV07p2AQ6bFvjchFM+V
w5JR3oQukd0QjGrHC5++Np6fidoPTbQ7W4exw8e9wT96QY/B20s=
=Q5tx
-----END PGP SIGNATURE-----

--fbInxgi8zL8sS9XwYBpfcgOLDUzy8i4dp--
