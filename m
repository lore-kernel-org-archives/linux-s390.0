Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403978AbfFLKlX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 06:41:23 -0400
Subject: Re: [PATCH v2 1/4] s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
References: <20190612102248.18903-1-david@redhat.com>
 <20190612102248.18903-2-david@redhat.com>
 <7f313d87-f9ea-e291-49e2-8da29cf41680@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <53936c66-ca09-98a7-4c3c-eae8c6024887@redhat.com>
Date: Wed, 12 Jun 2019 12:41:19 +0200
MIME-Version: 1.0
In-Reply-To: <7f313d87-f9ea-e291-49e2-8da29cf41680@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>

On 12.06.19 12:39, Harald Freudenberger wrote:
> On 12.06.19 12:22, David Hildenbrand wrote:
>> systemd-modules-load.service automatically tries to load the pkey module
>> on systems that have MSA.
>>
>> Pkey also requires the MSA3 facility and a bunch of subfunctions.
>> Failing with -EOPNOTSUPP makes "systemd-modules-load.service" fail on
>> any system that does not have all needed subfunctions. For example,
>> when running under QEMU TCG (but also on systems where protected keys
>> are disabled via the HMC).
>>
>> Let's use -ENODEV, so systemd-modules-load.service properly ignores
>> failing to load the pkey module because of missing HW functionality.
>>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/s390/crypto/pkey_api.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
>> index 45eb0c14b880..ddfcefb47284 100644
>> --- a/drivers/s390/crypto/pkey_api.c
>> +++ b/drivers/s390/crypto/pkey_api.c
>> @@ -1695,15 +1695,15 @@ static int __init pkey_init(void)
>>  	 * are able to work with protected keys.
>>  	 */
>>  	if (!cpacf_query(CPACF_PCKMO, &pckmo_functions))
>> -		return -EOPNOTSUPP;
>> +		return -ENODEV;
>>  
>>  	/* check for kmc instructions available */
>>  	if (!cpacf_query(CPACF_KMC, &kmc_functions))
>> -		return -EOPNOTSUPP;
>> +		return -ENODEV;
>>  	if (!cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_128) ||
>>  	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_192) ||
>>  	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_256))
>> -		return -EOPNOTSUPP;
>> +		return -ENODEV;
>>  
>>  	pkey_debug_init();
>>  
> You missed one match in this file. Function pkey_clr2protkey()
> also does a cpacf_test_func() and may return -EOPNOTSUPP.
> I checked the call chain, it's save to change the returncode there also.

That's unrelated to module loading (if I am not wrong), shall we still
include this change here?

Thanks!

> If done, Thanks and add my
> reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> 


-- 

Thanks,

David / dhildenb
