Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbfKHHgp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Nov 2019 02:36:45 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA87YFcd040201
        for <linux-s390@vger.kernel.org>; Fri, 8 Nov 2019 02:36:44 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w517en7nf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 08 Nov 2019 02:36:43 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 8 Nov 2019 07:36:40 -0000
Subject: Re: [RFC 04/37] KVM: s390: protvirt: Add initial lifecycle handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-5-frankja@linux.ibm.com>
 <20191107172956.4f4d8a90.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 8 Nov 2019 08:36:35 +0100
MIME-Version: 1.0
In-Reply-To: <20191107172956.4f4d8a90.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UGkhotNZgKUySzlg3WmGIsATWGy5vEiVB"
Message-Id: <8989f705-ce14-7b85-e5b6-6d87803db491@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UGkhotNZgKUySzlg3WmGIsATWGy5vEiVB
Content-Type: multipart/mixed; boundary="92l716vdYBFs2aAbM0kOtdRaT7f81yQfS"

--92l716vdYBFs2aAbM0kOtdRaT7f81yQfS
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/7/19 5:29 PM, Cornelia Huck wrote:
> On Thu, 24 Oct 2019 07:40:26 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Let's add a KVM interface to create and destroy protected VMs.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  24 +++-
>>  arch/s390/include/asm/uv.h       | 110 ++++++++++++++
>>  arch/s390/kvm/Makefile           |   2 +-
>>  arch/s390/kvm/kvm-s390.c         | 173 +++++++++++++++++++++-
>>  arch/s390/kvm/kvm-s390.h         |  47 ++++++
>>  arch/s390/kvm/pv.c               | 237 ++++++++++++++++++++++++++++++=
+
>>  include/uapi/linux/kvm.h         |  33 +++++
>=20
> Any new ioctls and caps probably want a mention in
> Documentation/virt/kvm/api.txt :)

Noted

>=20
>>  7 files changed, 622 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/s390/kvm/pv.c
>=20
> (...)
>=20
>> @@ -2157,6 +2164,96 @@ static int kvm_s390_set_cmma_bits(struct kvm *k=
vm,
>>  	return r;
>>  }
>> =20
>> +#ifdef CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST
>> +static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd=
)
>> +{
>> +	int r =3D 0;
>> +	void __user *argp =3D (void __user *)cmd->data;
>> +
>> +	switch (cmd->cmd) {
>> +	case KVM_PV_VM_CREATE: {
>> +		r =3D kvm_s390_pv_alloc_vm(kvm);
>> +		if (r)
>> +			break;
>> +
>> +		mutex_lock(&kvm->lock);
>> +		kvm_s390_vcpu_block_all(kvm);
>> +		/* FMT 4 SIE needs esca */
>> +		r =3D sca_switch_to_extended(kvm);
>> +		if (!r)
>> +			r =3D kvm_s390_pv_create_vm(kvm);
>> +		kvm_s390_vcpu_unblock_all(kvm);
>> +		mutex_unlock(&kvm->lock);
>> +		break;
>> +	}
>> +	case KVM_PV_VM_DESTROY: {
>> +		/* All VCPUs have to be destroyed before this call. */
>> +		mutex_lock(&kvm->lock);
>> +		kvm_s390_vcpu_block_all(kvm);
>> +		r =3D kvm_s390_pv_destroy_vm(kvm);
>> +		if (!r)
>> +			kvm_s390_pv_dealloc_vm(kvm);
>> +		kvm_s390_vcpu_unblock_all(kvm);
>> +		mutex_unlock(&kvm->lock);
>> +		break;
>> +	}
>=20
> Would be helpful to have some code that shows when/how these are called=

> - do you have any plans to post something soon?

Qemu patches will be in internal review soonish and afterwards I'll post
them upstream

>=20
> (...)
>=20
>> @@ -2529,6 +2642,9 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu=
)
>> =20
>>  	if (vcpu->kvm->arch.use_cmma)
>>  		kvm_s390_vcpu_unsetup_cmma(vcpu);
>> +	if (IS_ENABLED(CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST) &&
>> +	    kvm_s390_pv_handle_cpu(vcpu))
>=20
> I was a bit confused by that function name... maybe
> kvm_s390_pv_cpu_get_handle()?

Sure

>=20
> Also, if this always returns 0 if the config option is off, you
> probably don't need to check for that option?

Hmm, if we decide to remove the config option altogether then it's not
needed anyway and I think that's what Christian wants.

>=20
>> +		kvm_s390_pv_destroy_cpu(vcpu);
>>  	free_page((unsigned long)(vcpu->arch.sie_block));
>> =20
>>  	kvm_vcpu_uninit(vcpu);
>> @@ -2555,8 +2671,13 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>>  {
>>  	kvm_free_vcpus(kvm);
>>  	sca_dispose(kvm);
>> -	debug_unregister(kvm->arch.dbf);
>>  	kvm_s390_gisa_destroy(kvm);
>> +	if (IS_ENABLED(CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST) &&
>> +	    kvm_s390_pv_is_protected(kvm)) {
>> +		kvm_s390_pv_destroy_vm(kvm);
>> +		kvm_s390_pv_dealloc_vm(kvm);
>=20
> It seems the pv vm can be either destroyed via the ioctl above or in
> the course of normal vm destruction. When is which way supposed to be
> used? Also, it seems kvm_s390_pv_destroy_vm() can fail -- can that be a=

> problem in this code path?

On a reboot we need to tear down the protected VM and boot from
unprotected mode again. If the VM shuts down we go through this cleanup
path. If it fails the kernel will loose the memory that was allocated to
start the VM.

>=20
>> +	}
>> +	debug_unregister(kvm->arch.dbf);
>>  	free_page((unsigned long)kvm->arch.sie_page2);
>>  	if (!kvm_is_ucontrol(kvm))
>>  		gmap_remove(kvm->arch.gmap);
>=20
> (...)
>=20
>> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
>> index 6d9448dbd052..0d61dcc51f0e 100644
>> --- a/arch/s390/kvm/kvm-s390.h
>> +++ b/arch/s390/kvm/kvm-s390.h
>> @@ -196,6 +196,53 @@ static inline int kvm_s390_user_cpu_state_ctrl(st=
ruct kvm *kvm)
>>  	return kvm->arch.user_cpu_state_ctrl !=3D 0;
>>  }
>> =20
>> +#ifdef CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST
>> +/* implemented in pv.c */
>> +void kvm_s390_pv_unpin(struct kvm *kvm);
>> +void kvm_s390_pv_dealloc_vm(struct kvm *kvm);
>> +int kvm_s390_pv_alloc_vm(struct kvm *kvm);
>> +int kvm_s390_pv_create_vm(struct kvm *kvm);
>> +int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu);
>> +int kvm_s390_pv_destroy_vm(struct kvm *kvm);
>> +int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu);
>> +int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length)=
;
>> +int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned =
long size,
>> +		       unsigned long tweak);
>> +int kvm_s390_pv_verify(struct kvm *kvm);
>> +
>> +static inline bool kvm_s390_pv_is_protected(struct kvm *kvm)
>> +{
>> +	return !!kvm->arch.pv.handle;
>> +}
>> +
>> +static inline u64 kvm_s390_pv_handle(struct kvm *kvm)
>=20
> This function name is less confusing than the one below, but maybe also=

> rename this to kvm_s390_pv_get_handle() for consistency?

kvm_s390_pv_kvm_handle?

>=20
>> +{
>> +	return kvm->arch.pv.handle;
>> +}
>> +
>> +static inline u64 kvm_s390_pv_handle_cpu(struct kvm_vcpu *vcpu)
>> +{
>> +	return vcpu->arch.pv.handle;
>> +}
>> +#else
>> +static inline void kvm_s390_pv_unpin(struct kvm *kvm) {}
>> +static inline void kvm_s390_pv_dealloc_vm(struct kvm *kvm) {}
>> +static inline int kvm_s390_pv_alloc_vm(struct kvm *kvm) { return 0; }=

>> +static inline int kvm_s390_pv_create_vm(struct kvm *kvm) { return 0; =
}
>> +static inline int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu) { ret=
urn 0; }
>> +static inline int kvm_s390_pv_destroy_vm(struct kvm *kvm) { return 0;=
 }
>> +static inline int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu) { re=
turn 0; }
>> +static inline int kvm_s390_pv_set_sec_parms(struct kvm *kvm,
>> +					    u64 origin, u64 length) { return 0; }
>> +static inline int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long a=
ddr,
>> +				     unsigned long size,  unsigned long tweak)
>> +{ return 0; }
>> +static inline int kvm_s390_pv_verify(struct kvm *kvm) { return 0; }
>> +static inline bool kvm_s390_pv_is_protected(struct kvm *kvm) { return=
 0; }
>> +static inline u64 kvm_s390_pv_handle(struct kvm *kvm) { return 0; }
>> +static inline u64 kvm_s390_pv_handle_cpu(struct kvm_vcpu *vcpu) { ret=
urn 0; }
>> +#endif
>> +
>>  /* implemented in interrupt.c */
>>  int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
>>  void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu);
>=20
> (...)
>=20
>> +int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu)
>> +{
>> +	int rc;
>> +	struct uv_cb_csc uvcb =3D {
>> +		.header.cmd =3D UVC_CMD_CREATE_SEC_CPU,
>> +		.header.len =3D sizeof(uvcb),
>> +	};
>> +
>> +	/* EEXIST and ENOENT? */
>=20
> ?

I was asking myself if EEXIST or ENOENT would be better error values
than EINVAL.

>=20
>> +	if (kvm_s390_pv_handle_cpu(vcpu))
>> +		return -EINVAL;
>> +
>> +	vcpu->arch.pv.stor_base =3D __get_free_pages(GFP_KERNEL,
>> +						   get_order(uv_info.guest_cpu_stor_len));
>> +	if (!vcpu->arch.pv.stor_base)
>> +		return -ENOMEM;
>> +
>> +	/* Input */
>> +	uvcb.guest_handle =3D kvm_s390_pv_handle(vcpu->kvm);
>> +	uvcb.num =3D vcpu->arch.sie_block->icpua;
>> +	uvcb.state_origin =3D (u64)vcpu->arch.sie_block;
>> +	uvcb.stor_origin =3D (u64)vcpu->arch.pv.stor_base;
>> +
>> +	rc =3D uv_call(0, (u64)&uvcb);
>> +	VCPU_EVENT(vcpu, 3, "PROTVIRT CREATE VCPU: cpu %d handle %llx rc %x =
rrc %x",
>> +		   vcpu->vcpu_id, uvcb.cpu_handle, uvcb.header.rc,
>> +		   uvcb.header.rrc);
>> +
>> +	/* Output */
>> +	vcpu->arch.pv.handle =3D uvcb.cpu_handle;
>> +	vcpu->arch.sie_block->pv_handle_cpu =3D uvcb.cpu_handle;
>> +	vcpu->arch.sie_block->pv_handle_config =3D kvm_s390_pv_handle(vcpu->=
kvm);
>> +	vcpu->arch.sie_block->sdf =3D 2;
>> +	if (!rc)
>> +		return 0;
>> +
>> +	kvm_s390_pv_destroy_cpu(vcpu);
>> +	return -EINVAL;
>> +}
>=20
> (...)
>=20
> Only a quick readthrough, as this patch is longish.
>=20



--92l716vdYBFs2aAbM0kOtdRaT7f81yQfS--

--UGkhotNZgKUySzlg3WmGIsATWGy5vEiVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3FGwMACgkQ41TmuOI4
ufiPXA//YF3ulKyBnYnxIx22CUKdQX9lNPFQXwgrpYudWNW+x8OliajJdFh1RJxt
N/+5QYHM7fS77Zjf/yaLSVXaNuVoA3Ax72arwG4aLEgEvICWaahPrSFYc0uHIEak
oiDl+/H36XJOviXs3ri4Aq7o+/NUqRVTIiHcNCpOmbfOmfmKiY0EDcxX1IHHJ7DE
i6LPBpEqgRXs5fA7cqIT9IzTuPhHCXnltXfGIgQWX7DfwIXkctgVMGOVpPV2ihaA
sD9CZJIPg87bTZREjM4qELe4oMlGX8ONobUYz02FcLVbctJqa53ZPHsxRLtc2fdx
hQADbY3AiY2DdubEpps+hFDxdZGQALq8xenAc+VooFlG6ho+zQQZLHBipobX3IjI
zYSpPODmmZz/kvxII+BoDG6YkFFCKshLriJytWmlEDBMpbduIOyhvRY3Q9bPTDa/
Efn4XH58IRF7hR2s5A1rBLBGv45XzPNBrZYeZsE19kxc6RcxmIvfR6oKcCovNu7g
2v3JPCArT3jm+M3CKPbH0S3sNaF732c5Bp+RZgRt+aQBtY3AzdSKXmmJ7NYJTVzU
TUbzTMmut/B+gibOSJyCB0qiDmUAjPpaD9MpA2Z6YruHrzWVuG/hg0kkTcAGz0/S
2jY41gyhG2fcTI13+w/lIBrdMiJWd0CnTxThWnECaDGohTJKtsA=
=ClVo
-----END PGP SIGNATURE-----

--UGkhotNZgKUySzlg3WmGIsATWGy5vEiVB--
