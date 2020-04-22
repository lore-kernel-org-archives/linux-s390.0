Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39456 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725786AbgDVHoq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Apr 2020 03:44:46 -0400
Subject: Re: [kvm-unit-tests PATCH v5 02/10] s390x: Use PSW bits definitions
 in cstart
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-3-git-send-email-pmorel@linux.ibm.com>
 <aae40a5a-63a6-e802-53bb-9683d03ad57d@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d4e66e9b-ed68-e7ef-4b9d-8af879e44813@redhat.com>
Date: Wed, 22 Apr 2020 09:44:37 +0200
MIME-Version: 1.0
In-Reply-To: <aae40a5a-63a6-e802-53bb-9683d03ad57d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, cohuck@redhat.com


>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>> index 45da523..2885a36 100644
>> --- a/s390x/cstart64.S
>> +++ b/s390x/cstart64.S
>> @@ -12,6 +12,7 @@
>>   */
>>  #include <asm/asm-offsets.h>
>>  #include <asm/sigp.h>
>> +#include <asm/arch_def.h>
>> =20
>>  .section .init
>> =20
>> @@ -214,19 +215,19 @@ svc_int:
>> =20
>>  	.align	8
>>  reset_psw:
>> -	.quad	0x0008000180000000
>> +	.quad	PSW_EXCEPTION_MASK
>=20
> That won't work, this is a short PSW and you're removing the short
> indication here. Notice the 0008 at the front.

Good catch! Guess it would have bailed out when testing.


--=20
Thanks,

David / dhildenb
