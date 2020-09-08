Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51506 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729533AbgIHHw5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 03:52:57 -0400
Subject: Re: [PATCH v2] KVM: s390: Introduce storage key removal facility
References: <b34e559a-8292-873f-8d33-1e7ce819f4d5@de.ibm.com>
 <20200907143352.96618-1-frankja@linux.ibm.com>
 <20200907183030.07333af7.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <cd3ce2d9-99a5-5bb5-9b13-62d378274265@linux.ibm.com>
Date: Tue, 8 Sep 2020 09:52:48 +0200
MIME-Version: 1.0
In-Reply-To: <20200907183030.07333af7.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bDdIQxSXyo1Qhe3iT1xeRipwEAmCIgqf5"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, david@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bDdIQxSXyo1Qhe3iT1xeRipwEAmCIgqf5
Content-Type: multipart/mixed; boundary="q72FnDexAOUcsKP33pSlLf16jxBzFhTiz"

--q72FnDexAOUcsKP33pSlLf16jxBzFhTiz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/7/20 6:30 PM, Cornelia Huck wrote:
> On Mon,  7 Sep 2020 10:33:52 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> The storage key removal facility makes skey related instructions
>> result in special operation program exceptions. It is based on the
>> Keyless Subset Facility.
>>
>> The usual suspects are iske, sske, rrbe and their respective
>> variants. lpsw(e), pfmf and tprot can also specify a key and essa with=

>> an ORC of 4 will consult the change bit, hence they all result in
>> exceptions.
>>
>> Unfortunately storage keys were so essential to the architecture, that=

>> there is no facility bit that we could deactivate. That's why the
>> removal facility (bit 169) was introduced which makes it necessary,
>> that, if active, the skey related facilities 10, 14, 66, 145 and 149
>> are zero. Managing this requirement and migratability has to be done
>> in userspace, as KVM does not check the facilities it receives to be
>> able to easily implement userspace emulation.
>>
>> Removing storage key support allows us to circumvent complicated
>> emulation code and makes huge page support tremendously easier.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>
>> v2:
>> 	* Removed the likely
>> 	* Updated and re-shuffeled the comments which had the wrong informati=
on
>>
>> ---
>>  arch/s390/kvm/intercept.c | 40 ++++++++++++++++++++++++++++++++++++++=
-
>>  arch/s390/kvm/kvm-s390.c  |  5 +++++
>>  arch/s390/kvm/priv.c      | 26 ++++++++++++++++++++++---
>>  3 files changed, 67 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
>> index e7a7c499a73f..983647ea2abe 100644
>> --- a/arch/s390/kvm/intercept.c
>> +++ b/arch/s390/kvm/intercept.c
>> @@ -33,6 +33,7 @@ u8 kvm_s390_get_ilen(struct kvm_vcpu *vcpu)
>>  	case ICPT_OPEREXC:
>>  	case ICPT_PARTEXEC:
>>  	case ICPT_IOINST:
>> +	case ICPT_KSS:
>>  		/* instruction only stored for these icptcodes */
>>  		ilen =3D insn_length(vcpu->arch.sie_block->ipa >> 8);
>>  		/* Use the length of the EXECUTE instruction if necessary */
>> @@ -565,7 +566,44 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcp=
u)
>>  		rc =3D handle_partial_execution(vcpu);
>>  		break;
>>  	case ICPT_KSS:
>> -		rc =3D kvm_s390_skey_check_enable(vcpu);
>> +		if (!test_kvm_facility(vcpu->kvm, 169)) {
>> +			rc =3D kvm_s390_skey_check_enable(vcpu);
>> +		} else {
>=20
> <bikeshed>Introduce a helper function? This is getting a bit hard to
> read.</bikeshed>
>=20
>> +			/*
>> +			 * Storage key removal facility emulation.
>> +			 *
>> +			 * KSS is the same priority as an instruction
>> +			 * interception. Hence we need handling here
>> +			 * and in the instruction emulation code.
>> +			 *
>> +			 * KSS is nullifying (no psw forward), SKRF
>> +			 * issues suppressing SPECIAL OPS, so we need
>> +			 * to forward by hand.
>> +			 */
>> +			switch (vcpu->arch.sie_block->ipa) {
>> +			case 0xb2b2:
>> +				kvm_s390_forward_psw(vcpu, kvm_s390_get_ilen(vcpu));
>> +				rc =3D kvm_s390_handle_b2(vcpu);
>> +				break;
>> +			case 0x8200:
>=20
> Can we have speaking names? I can only guess that this is an lpsw...

You can only guess from the kvm_s390_handle_lpsw() call below? ;-)

I'd be happy to put this into an own function and add some comments to
the cases where we lack them. However, I don't really want to define
constants for speaking names.

>=20
>> +				kvm_s390_forward_psw(vcpu, kvm_s390_get_ilen(vcpu));
>> +				rc =3D kvm_s390_handle_lpsw(vcpu);
>> +				break;
>> +			case 0:
>> +				/*
>> +				 * Interception caused by a key in a
>> +				 * exception new PSW mask. The guest
>> +				 * PSW has already been updated to the
>> +				 * non-valid PSW so we only need to
>> +				 * inject a PGM.
>> +				 */
>> +				rc =3D kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>> +				break;
>> +			default:
>> +				kvm_s390_forward_psw(vcpu, kvm_s390_get_ilen(vcpu));
>> +				rc =3D kvm_s390_inject_program_int(vcpu, PGM_SPECIAL_OPERATION);
>> +			}
>> +		}
>>  		break;
>>  	case ICPT_MCHKREQ:
>>  	case ICPT_INT_ENABLE:
>=20



--q72FnDexAOUcsKP33pSlLf16jxBzFhTiz--

--bDdIQxSXyo1Qhe3iT1xeRipwEAmCIgqf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl9XOFAACgkQ41TmuOI4
ufhxRw/8DNiKgSVDvxYcB9zbinpQ9MQ1574ylhF9gPQss5iInm8r/YP80YLJm87K
SkS1pdAUanSy9C0vPMHEEH1eqbPKgxuAmJvsFqoY1Krts7ydU/T+pHKhyZ8jpo03
1gUM5ZZUtwNNZpESrrma4QoRh0Qjy4HWcyOhaFyFedyySHSzGkl2SS/rPt5VmaKD
29Xt0tzbdV3RgONl8KFoiOZ+hgXq+Hqo+mD4t0mgm0ahD5eVOOT3R5cLwoKDRmIU
DZ9qZulJlzr0TtI4r06s1LWHpByxqbdcygl4ZGE9YtVzIROMz4FeIrk/fBSHBDIX
2BWLEDpjG5y9NFA5gJ+l23C6eVU+HoC/U299+4wnvtKyYDTUbL333Hwovzc1we+v
AffAtKXfdzwWC2JOEwMaP31aruluTF4d7zbTZOEYenT7dLzNYzJMisQM9XeyEylD
Go+4wy7ObX51ayfaLwGlA9a7bItdrZbE/kIGbd8GQYzyvq1Ig9fjHFkoBjNWqwwt
VMgN8DqBy2QFvSLlCl4YgBlmgMeUPqexSBAhS/viHS/bjWOQfxLOm/6aPrzvITC+
TQ4BXcSNEaBIlkevHuq4S3AnghI5JkGvcQtH79fc/pnxQU1pd18yvmYC3Er8CdRB
2S7P20HN12eUepl+ELuznsfzIKYrZ6tZo0/iFcKHJYmeLNUl6oc=
=0Nrr
-----END PGP SIGNATURE-----

--bDdIQxSXyo1Qhe3iT1xeRipwEAmCIgqf5--
