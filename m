Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v1] s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
References: <20190531093628.14766-1-david@redhat.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Mon, 3 Jun 2019 09:48:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190531093628.14766-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <3dfea8fd-dbe7-f9d0-f7a7-2c65349c0a81@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 31.05.19 11:36, David Hildenbrand wrote:
> systemd-modules-load.service automatically tries to load the pkey module
> on systems that have MSA.
>
> Pkey also requires the MSA3 facility and a bunch of subfunctions.
> Failing with -EOPNOTSUPP makes "systemd-modules-load.service" fail on
> any system that does not have all needed subfunctions. For example,
> when running under QEMU TCG (but also on systems where protected keys
> are disabled via the HMC).
>
> Let's use -ENODEV, so systemd-modules-load.service properly ignores
> failing to load the pkey module because of missing HW functionality.
>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index 45eb0c14b880..ddfcefb47284 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -1695,15 +1695,15 @@ static int __init pkey_init(void)
>  	 * are able to work with protected keys.
>  	 */
>  	if (!cpacf_query(CPACF_PCKMO, &pckmo_functions))
> -		return -EOPNOTSUPP;
> +		return -ENODEV;
>  
>  	/* check for kmc instructions available */
>  	if (!cpacf_query(CPACF_KMC, &kmc_functions))
> -		return -EOPNOTSUPP;
> +		return -ENODEV;
>  	if (!cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_128) ||
>  	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_192) ||
>  	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_256))
> -		return -EOPNOTSUPP;
> +		return -ENODEV;
>  
>  	pkey_debug_init();
>  
I can't really agree to this: there are a lot more modules returning
EOPNOTSUPP, for example have a look into the arch/s390/crypto
subdirectory. The ghash_s390 module also registers for MSA feature
and also returns EOPNOTSUPPORTED when the required hardware extension
is not available. Same with the prng kernel module, sha1_s390, sha256_s390
and I assume there is a bunch of other kernel modules with same behavior.
I would prefer having this fixed on the systemd-modules-load.service side.

regards
Harald Freudenberger
