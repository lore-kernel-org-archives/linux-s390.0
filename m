Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730189AbgIDLdj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Sep 2020 07:33:39 -0400
Subject: Re: [PATCH 2/2] s390x: Add 3f program exception handler
References: <20200903131435.2535-1-frankja@linux.ibm.com>
 <20200903131435.2535-3-frankja@linux.ibm.com> <20200904103543.GD6075@osiris>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <36e1c11c-c4a2-6ae2-b341-7d582203d031@linux.ibm.com>
Date: Fri, 4 Sep 2020 13:33:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200904103543.GD6075@osiris>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R0pLoHIvQxnoeDOKoMKKZHuT4PSxwBQtC"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R0pLoHIvQxnoeDOKoMKKZHuT4PSxwBQtC
Content-Type: multipart/mixed; boundary="gTcbVriBs7lyOx8yYKq2peyJQlKqyu5Tr"

--gTcbVriBs7lyOx8yYKq2peyJQlKqyu5Tr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/4/20 12:35 PM, Heiko Carstens wrote:
> On Thu, Sep 03, 2020 at 09:14:35AM -0400, Janosch Frank wrote:
>> Program exception 3f (secure storage violation) can only be detected
>> when the CPU is running in SIE with a format 4 state description,
>> e.g. running a protected guest. Because of this and because user
>> space partly controls the guest memory mapping and can trigger this
>> exception, we want to send a SIGSEGV to the process running the guest
>> and not panic the kernel.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> CC: <stable@vger.kernel.org> # 5.7+
>> Fixes: 084ea4d611a3 ("s390/mm: add (non)secure page access exceptions =
handlers")
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> ---
>>  arch/s390/kernel/pgm_check.S |  2 +-
>>  arch/s390/mm/fault.c         | 23 +++++++++++++++++++++++
>>  2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kernel/pgm_check.S b/arch/s390/kernel/pgm_check=
=2ES
>> index 2c27907a5ffc..9a92638360ee 100644
>> --- a/arch/s390/kernel/pgm_check.S
>> +++ b/arch/s390/kernel/pgm_check.S
>> @@ -80,7 +80,7 @@ PGM_CHECK(do_dat_exception)		/* 3b */
>>  PGM_CHECK_DEFAULT			/* 3c */
>>  PGM_CHECK(do_secure_storage_access)	/* 3d */
>>  PGM_CHECK(do_non_secure_storage_access)	/* 3e */
>> -PGM_CHECK_DEFAULT			/* 3f */
>> +PGM_CHECK(do_secure_storage_violation)	/* 3f */
>>  PGM_CHECK(monitor_event_exception)	/* 40 */
>>  PGM_CHECK_DEFAULT			/* 41 */
>>  PGM_CHECK_DEFAULT			/* 42 */
>> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
>> index 4c8c063bce5b..20abb7c5c540 100644
>> --- a/arch/s390/mm/fault.c
>> +++ b/arch/s390/mm/fault.c
>> @@ -859,6 +859,24 @@ void do_non_secure_storage_access(struct pt_regs =
*regs)
>>  }
>>  NOKPROBE_SYMBOL(do_non_secure_storage_access);
>> =20
>> +void do_secure_storage_violation(struct pt_regs *regs)
>> +{
>> +	char buf[TASK_COMM_LEN];
>> +
>> +	/*
>> +	 * Either KVM messed up the secure guest mapping or the same
>> +	 * page is mapped into multiple secure guests.
>> +	 *
>> +	 * This exception is only triggered when a guest 2 is running
>> +	 * and can therefore never occur in kernel context.
>> +	 */
>> +	printk_ratelimited(KERN_WARNING
>> +			   "Secure storage violation in task: %s, pid %d\n",
>> +			   get_task_comm(buf, current), task_pid_nr(current));
>=20
> Why get_task_comm() and task_pid_nr() instead of simply current->comm
> and current->pid?

Normally if there are functions to get data I assume those should be used=
=2E

> Also: is the dmesg message of any value?

Yes, it's import for administrators to know that an exception caused
this segfault and not some memory shenanigans.

As the exception only occurs if a guest runs in unsupported modes like
sharing the memory between two secure guests it's a good first
indication what went wrong.

>=20
>> +	send_sig(SIGSEGV, current, 0);
>> +}
>> +NOKPROBE_SYMBOL(do_secure_storage_violation);>
> Why is this NOKPROBE? Can this deadlock?
Right, we don't need to export this at all, this was copied over from
the export function above.




--gTcbVriBs7lyOx8yYKq2peyJQlKqyu5Tr--

--R0pLoHIvQxnoeDOKoMKKZHuT4PSxwBQtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl9SJggACgkQ41TmuOI4
ufijEA//ci8Z+hrIydllOPAvpGImC3hQj3IEKWQSA7AEXvSVKbNV5SoBiAFcmCKy
UaK79mI3VbgydHpDx6THvgZ3qNGjHGomCJ2WxKFmi+Y03a8tMP0XWFeSEn7dC1a+
1R7CWVvA9b/ZpwzZ3BxdkHxw06vs5pUZryiUQCMtJLdwhxAnYJe1Mggr13CsC4QD
djjUQ2dKWBfwBLFIivFXQWIKlG6RA545vtMQNvs7YFY/+0PXNNMnc/zpAkOU5muJ
WHI4G38iXVhvlIcmpcB7fEDu4fXWHyHZnEWVWh/e5tsabWPwpd0jHZuYjRWyg9bu
ySBOJeEkirBXkrddHVdcp7553hnezs9VtwSSzZ/FT1lJ17tF4+St6KJcdhsE8UKL
HY0brhmPfNaS0bmSby5X8lp0KvGZLclSLypXO/8XD3UMXVR5UI00J39apo70BKsm
WuwzxFjPOz4Ia2qofKPWbzzih5uQQKDAxlP7QOR3Z45+wyO79zAMrPEK3fSa1aVb
CnXScEtaBe1I9iY5tr6RLcrubKpI763ST9TA1YoOa8S/4JddJANljJ91BmC40Ij7
CksJMQNkGApCTmWzSGVhANVKLM8KH5zc3vCdPoNGKlr02bhVz/BOKg+vmljg+xUS
x7C73Qgy2sSfK20KZZ8heDUMLSmYCWGuqFxneIq8XnR/DShTfZw=
=CCcz
-----END PGP SIGNATURE-----

--R0pLoHIvQxnoeDOKoMKKZHuT4PSxwBQtC--
