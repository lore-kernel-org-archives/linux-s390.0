Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731919AbgAIRv1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 12:51:27 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009HlrXJ144288
        for <linux-s390@vger.kernel.org>; Thu, 9 Jan 2020 12:51:25 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xe7quju3h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 09 Jan 2020 12:51:25 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 9 Jan 2020 17:51:23 -0000
Subject: Re: [PATCH v4] KVM: s390: Add new reset vcpu API
References: <20200109155602.18985-1-frankja@linux.ibm.com>
 <20200109180841.6843cb92.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 9 Jan 2020 18:51:18 +0100
MIME-Version: 1.0
In-Reply-To: <20200109180841.6843cb92.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8jBGlaw2qxmqwKHASssfIF6BKVulnU4Mk"
Message-Id: <f79b523e-f3e8-95b8-c242-1e7ca0083012@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8jBGlaw2qxmqwKHASssfIF6BKVulnU4Mk
Content-Type: multipart/mixed; boundary="XWVmLUsfnl9x0LO90BCakHrQ85T3IBgwg"

--XWVmLUsfnl9x0LO90BCakHrQ85T3IBgwg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/9/20 6:08 PM, Cornelia Huck wrote:
> On Thu,  9 Jan 2020 10:56:01 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
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
>> ---
>>
>> I dropped the reviews, as I changed quite a lot. =20
>>
>> Keep in mind, that now we'll need a new parameter in normal and
>> initial reset for protected virtualization to indicate that we need to=

>> do the reset via the UV call. The Ultravisor does only accept the
>> needed reset, not any subset resets.
>=20
> In the interface, or externally?

?

>=20
> [Apologies, but the details of the protected virt stuff are no longer
> in my cache.
Reworded explanation:
I can't use a fallthrough, because the UV will reject the normal reset
if we do an initial reset (same goes for the clear reset). To address
this issue, I added a boolean to the normal and initial reset functions
which tells the function if it was called directly or was called because
of the fallthrough.

Only if called directly a UV call for the reset is done, that way we can
keep the fallthrough.

>>  static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>>  {
>> -	kvm_s390_vcpu_initial_reset(vcpu);
>> +	/* this equals initial cpu reset in pop, but we don't switch to ESA =
*/
>=20
> Maybe also mention that in the documentation?

Sure

>=20
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
>> +
>=20
> Add a comment that the remaining work will be done in normal_reset?

Will do

>=20
>> +	return 0;
>> +}
>> +
>> +static int kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_sync_regs *regs =3D &vcpu->run->s.regs;
>> +
>> +	memset(&regs->gprs, 0, sizeof(regs->gprs));
>> +	/*
>> +	 * Will be picked up via save_fpu_regs() in the initial reset
>> +	 * fallthrough.
>> +	 */
>=20
> This comment is a bit confusing... what does 'picked up' mean?
>=20
> (Maybe I'm just too tired, sorry...)

fpus are loaded lazily, maybe I should just remove the comment.

>=20
>> +	memset(&regs->vrs, 0, sizeof(regs->vrs));
>> +	memset(&regs->acrs, 0, sizeof(regs->acrs));
>> +
>> +	regs->etoken =3D 0;
>> +	regs->etoken_extension =3D 0;
>> +
>> +	memset(&regs->gscb, 0, sizeof(regs->gscb));
>> +	if (MACHINE_HAS_GS) {
>> +		preempt_disable();
>> +		__ctl_set_bit(2, 4);
>> +		if (current->thread.gs_cb) {
>> +			vcpu->arch.host_gscb =3D current->thread.gs_cb;
>> +			save_gs_cb(vcpu->arch.host_gscb);
>> +		}
>> +		if (vcpu->arch.gs_enabled) {
>> +			current->thread.gs_cb =3D (struct gs_cb *)
>> +				&vcpu->run->s.regs.gscb;
>> +			restore_gs_cb(current->thread.gs_cb);
>> +		}
>> +		preempt_enable();
>> +	}
>=20
> And here that the remaining work will be done in initial_reset and
> normal_reset?
>=20
>>  	return 0;
>>  }
>> =20
>> @@ -4363,8 +4402,15 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>  		r =3D kvm_arch_vcpu_ioctl_set_initial_psw(vcpu, psw);
>>  		break;
>>  	}
>> +
>> +	case KVM_S390_CLEAR_RESET:
>> +		r =3D kvm_arch_vcpu_ioctl_clear_reset(vcpu);
>> +		/* fallthrough */
>>  	case KVM_S390_INITIAL_RESET:
>>  		r =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>> +		/* fallthrough */
>> +	case KVM_S390_NORMAL_RESET:
>> +		r =3D kvm_arch_vcpu_ioctl_normal_reset(vcpu);
>=20
> Can any of these functions return !0 when the protected virt stuff is
> done on top? If not, can we make them void and just set r=3D0; here?

They do return > 0 if the UV call fails, so I need those r values.

>=20
>>  		break;
>>  	case KVM_SET_ONE_REG:
>>  	case KVM_GET_ONE_REG: {
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index f0a16b4adbbd..4b95f9a31a2f 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1009,6 +1009,7 @@ struct kvm_ppc_resize_hpt {
>>  #define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 176
>>  #define KVM_CAP_ARM_NISV_TO_USER 177
>>  #define KVM_CAP_ARM_INJECT_EXT_DABT 178
>> +#define KVM_CAP_S390_VCPU_RESETS 179
>> =20
>>  #ifdef KVM_CAP_IRQ_ROUTING
>> =20
>> @@ -1473,6 +1474,10 @@ struct kvm_enc_region {
>>  /* Available with KVM_CAP_ARM_SVE */
>>  #define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
>> =20
>> +/* Available with  KVM_CAP_S390_VCPU_RESETS */
>> +#define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
>> +#define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
>> +
>>  /* Secure Encrypted Virtualization command */
>>  enum sev_cmd_id {
>>  	/* Guest initialization commands */
>=20



--XWVmLUsfnl9x0LO90BCakHrQ85T3IBgwg--

--8jBGlaw2qxmqwKHASssfIF6BKVulnU4Mk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4XaBYACgkQ41TmuOI4
ufhyRhAAwwVRSPsmNKeccMjeZ+1nivugQ9toHea9XHpURuscVFokCxdDaWgqQrjE
UPPQsaly7xd7u3jLLW60zK2jKx415JkfDgWpMNS4uTRyUCV6f7tkmqgslSw1tOlF
eX3leOJ1VaXGuhjvrFim0mcLTZ3cAlZ/jFMHFMS6iEAYx/OI6Yb6hPqBVsxiXmvO
BHd6QEfgo4dCBoTzl/+DVglEX/nSifHBHE4FjM/IOXQnRgKhER07A3oM5EidKb79
b49M23d7/6bRoCnqwIXjJo1XSBC7eMr3AJkfUKehyiSE0pTovYoiJ/8slihfnnd2
dlw3x2vOQQE5BGIjXIGoXfjz9AwUouap7J21YAh5P19Xp4nlL3nfIhPJJ+naA59D
T3jqWCELUKcjo6hfGOjrxmu/7mmbQrHNncfPqwe+s26pEy2AgetrclBsFSJXS1c3
bG7VRYWBHLiueI1RPQgraxw5iF8Y35DnLyAK4jLEhRwAZRCxGtaKiKrqKjHOA/bR
5xcCXuRTbR0liRTbLpFZEyd0ZA95/bYxNRJ8obIAKFIbmqDr41IFrQRBgXsbl8u3
tXuNnFLoSpA3SlydWnvFnZy5ONR+D+yK7nBQ6By4pc0f/brC7EZGPGMsrEhPreFZ
NI3hsOflfcVjS766wYaj8pMyNBc2BNknIDm7rEWjz2gBtbM/tZo=
=/JuM
-----END PGP SIGNATURE-----

--8jBGlaw2qxmqwKHASssfIF6BKVulnU4Mk--
