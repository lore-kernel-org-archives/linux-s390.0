Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727135AbgAJInm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 03:43:42 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00A8gFAe079973
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2020 03:43:40 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xe0sm6uh7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2020 03:43:40 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 10 Jan 2020 08:43:38 -0000
Subject: Re: [PATCH v4] KVM: s390: Add new reset vcpu API
From: Janosch Frank <frankja@linux.ibm.com>
References: <20200109155602.18985-1-frankja@linux.ibm.com>
 <20200109180841.6843cb92.cohuck@redhat.com>
 <f79b523e-f3e8-95b8-c242-1e7ca0083012@linux.ibm.com>
 <f18955c0-4002-c494-b14e-1b9733aad20e@redhat.com>
 <c0049bfb-9516-a382-c69c-0693cb0fbfda@linux.ibm.com>
Date: Fri, 10 Jan 2020 09:43:33 +0100
MIME-Version: 1.0
In-Reply-To: <c0049bfb-9516-a382-c69c-0693cb0fbfda@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D97QCypl9jX0GQ2sIsVURVgaFC620wFjf"
Message-Id: <90f65536-c2bb-9234-aef4-7941d477369e@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D97QCypl9jX0GQ2sIsVURVgaFC620wFjf
Content-Type: multipart/mixed; boundary="EHOb0zA2ovju0swjOBPjhydfEIu9lPBJ5"

--EHOb0zA2ovju0swjOBPjhydfEIu9lPBJ5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/10/20 8:14 AM, Janosch Frank wrote:
> On 1/10/20 8:03 AM, Thomas Huth wrote:
>> On 09/01/2020 18.51, Janosch Frank wrote:
>>> On 1/9/20 6:08 PM, Cornelia Huck wrote:
>>>> On Thu,  9 Jan 2020 10:56:01 -0500
>>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>>
>>>>> The architecture states that we need to reset local IRQs for all CP=
U
>>>>> resets. Because the old reset interface did not support the normal =
CPU
>>>>> reset we never did that on a normal reset.
>>>>>
>>>>> Let's implement an interface for the missing normal and clear reset=
s
>>>>> and reset all local IRQs, registers and control structures as state=
d
>>>>> in the architecture.
>>>>>
>>>>> Userspace might already reset the registers via the vcpu run struct=
,
>>>>> but as we need the interface for the interrupt clearing part anyway=
,
>>>>> we implement the resets fully and don't rely on userspace to reset =
the
>>>>> rest.
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> ---
>>>>>
>>>>> I dropped the reviews, as I changed quite a lot. =20
>>>>>
>>>>> Keep in mind, that now we'll need a new parameter in normal and
>>>>> initial reset for protected virtualization to indicate that we need=
 to
>>>>> do the reset via the UV call. The Ultravisor does only accept the
>>>>> needed reset, not any subset resets.
>>>>
>>>> In the interface, or externally?
>>>
>>> ?
>>>
>>>>
>>>> [Apologies, but the details of the protected virt stuff are no longe=
r
>>>> in my cache.
>>> Reworded explanation:
>>> I can't use a fallthrough, because the UV will reject the normal rese=
t
>>> if we do an initial reset (same goes for the clear reset). To address=

>>> this issue, I added a boolean to the normal and initial reset functio=
ns
>>> which tells the function if it was called directly or was called beca=
use
>>> of the fallthrough.
>>>
>>> Only if called directly a UV call for the reset is done, that way we =
can
>>> keep the fallthrough.
>>
>> Sounds complicated. And do we need the fallthrough stuff here at all?
>> What about doing something like:
>=20
> That would work and I thought about it, it just comes down to taste :-)=

> I don't have any strong feelings for a specific implementation.

To be more specific:


Commit c72db49c098bceb8b73c2e9d305caf37a41fb3bf
Author: Janosch Frank <frankja@linux.ibm.com>
Date:   Thu Jan 9 04:37:50 2020 -0500

    KVM: s390: protvirt: Add UV cpu reset calls

    For protected VMs, the VCPU resets are done by the Ultravisor, as KVM=

    has no access to the VCPU registers.

    As the Ultravisor will only accept a call for the reset that is
    needed, we need to fence the UV calls when chaining resets.

    Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 63dc2bd97582..d5876527e464 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3476,8 +3476,11 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(struct
kvm_vcpu *vcpu,
 	return r;
 }

-static int kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu)
+static int kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu, bool
chain)
 {
+	int rc =3D 0;
+	u32 ret;
+
 	vcpu->arch.sie_block->gpsw.mask =3D ~PSW_MASK_RI;
 	vcpu->arch.pfault_token =3D KVM_S390_PFAULT_TOKEN_INVALID;
 	memset(vcpu->run->s.regs.riccb, 0, sizeof(vcpu->run->s.regs.riccb));
@@ -3487,11 +3490,21 @@ static int
kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu)
 		kvm_s390_vcpu_stop(vcpu);
 	kvm_s390_clear_local_irqs(vcpu);

-	return 0;
+	if (kvm_s390_pv_handle_cpu(vcpu) && !chain) {
+		rc =3D uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
+				   UVC_CMD_CPU_RESET, &ret);
+		VCPU_EVENT(vcpu, 3, "PROTVIRT RESET NORMAL VCPU: cpu %d rc %x rrc %x",=

+			   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
+	}
+
+	return rc;
 }

-static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
+static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu,
bool chain)
 {
+	int rc =3D 0;
+	u32 ret;
+
 	/* this equals initial cpu reset in pop, but we don't switch to ESA */
 	vcpu->arch.sie_block->gpsw.mask =3D 0UL;
 	vcpu->arch.sie_block->gpsw.addr =3D 0UL;
@@ -3509,16 +3522,26 @@ static int
kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
 	/* make sure the new fpc will be lazily loaded */
 	save_fpu_regs();
 	current->thread.fpu.fpc =3D 0;
-	if (!kvm_s390_pv_is_protected(vcpu->kvm))
+	if (!kvm_s390_pv_handle_cpu(vcpu))
 		vcpu->arch.sie_block->gbea =3D 1;
 	vcpu->arch.sie_block->pp =3D 0;
 	vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;

-	return 0;
+	if (kvm_s390_pv_handle_cpu(vcpu) && !chain) {
+		rc =3D uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
+				   UVC_CMD_CPU_RESET_INITIAL,
+				   &ret);
+		VCPU_EVENT(vcpu, 3, "PROTVIRT RESET INITIAL VCPU: cpu %d rc %x rrc %x"=
,
+			   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
+	}
+
+	return rc;
 }

 static int kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
 {
+	int rc =3D 0;
+	u32 ret;
 	struct kvm_sync_regs *regs =3D &vcpu->run->s.regs;

 	memset(&regs->gprs, 0, sizeof(regs->gprs));
@@ -3547,7 +3570,13 @@ static int kvm_arch_vcpu_ioctl_clear_reset(struct
kvm_vcpu *vcpu)
 		}
 		preempt_enable();
 	}
-	return 0;
+	if (kvm_s390_pv_handle_cpu(vcpu)) {
+		rc =3D uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
+				   UVC_CMD_CPU_RESET_CLEAR, &ret);
+		VCPU_EVENT(vcpu, 3, "PROTVIRT RESET CLEAR VCPU: cpu %d rc %x rrc %x",
+			   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
+	}
+	return rc;
 }

 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs
*regs)
@@ -4738,12 +4767,16 @@ long kvm_arch_vcpu_ioctl(struct file *filp,

 	case KVM_S390_CLEAR_RESET:
 		r =3D kvm_arch_vcpu_ioctl_clear_reset(vcpu);
+		if (r)
+			break;
 		/* fallthrough */
 	case KVM_S390_INITIAL_RESET:
-		r =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
+		r =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu, ioctl !=3D
KVM_S390_INITIAL_RESET);
+		if (r)
+			break;
 		/* fallthrough */
 	case KVM_S390_NORMAL_RESET:
-		r =3D kvm_arch_vcpu_ioctl_normal_reset(vcpu);
+		r =3D kvm_arch_vcpu_ioctl_normal_reset(vcpu, ioctl !=3D
KVM_S390_NORMAL_RESET);
 		break;
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {


--EHOb0zA2ovju0swjOBPjhydfEIu9lPBJ5--

--D97QCypl9jX0GQ2sIsVURVgaFC620wFjf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4YOTUACgkQ41TmuOI4
ufheQw/9FCAVgY0bCvJDnCl8gAYxC57+x2KPylEv9ad9yQMosSD+Lcg462rifabO
5MrJQmIHJG5/tq/OksI8RC7LKiMI61FljzPNJ04nQ/H2EMUnsPnnKhmg4bS7Rhn9
xOeXsvR6TDa7LFCWRa9BgFJWPPbNLadhgrssRTUSEIG/ld1030dAcRSWpx5hq1to
gpb0FfJDVKcaebT6ODDGbmF9QeN5T8yrT7viheMq3GmKtg17SLH8erZM2Se5bh/R
BQuuVFwyDXhIsNiXGxhbWJYIcvTpQkjM/WxW+0Xaz5yq0dGp7RuSUAZ8kzyfaYZQ
ix6fEgXcRkIWSjFvwLHY9bZVv/QBXLGc1W8i8rqukMhS4KqvuO4EljIMYA7M+UFd
ZGVQTscDySBBpBc2UBSKOO8sgdp20jYR1Uw24ZRprOFecsJV29E0Hc+LdTbDzaZg
7sPF9WwvnyNdDOMCSjx2BOsSgNPbOvTA6N9ZFELL8CRHNBldcCTq9EQGXDmmRr8G
fLEDWiAWMJBBXAESnSZxkdfuKaOdUY0tBvqhOtiHr7qJ5cIaimpq7NQtUIp4fDAE
/QZgfFVzHMhO8KQ55dSepFZ78dzc4XuCo03lZ7mpsDhoGzAPa0fsnopXZrtO12Sk
rAwf8NCZIpQLPbetp6v3yhQSVTh5O5Z8T8nPK2y6QxKIwx0n8NM=
=4tjx
-----END PGP SIGNATURE-----

--D97QCypl9jX0GQ2sIsVURVgaFC620wFjf--
