Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Jun 2019 11:08:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1] s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
Message-ID: <20190603110839.1a44f352.cohuck@redhat.com>
In-Reply-To: <67136b8b-251f-4745-a220-2624aeac289e@redhat.com>
References: <20190531093628.14766-1-david@redhat.com>
        <3dfea8fd-dbe7-f9d0-f7a7-2c65349c0a81@linux.ibm.com>
        <67136b8b-251f-4745-a220-2624aeac289e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Mon, 3 Jun 2019 10:14:53 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 03.06.19 09:48, Harald Freudenberger wrote:
> > On 31.05.19 11:36, David Hildenbrand wrote:  
> >> systemd-modules-load.service automatically tries to load the pkey module
> >> on systems that have MSA.
> >>
> >> Pkey also requires the MSA3 facility and a bunch of subfunctions.
> >> Failing with -EOPNOTSUPP makes "systemd-modules-load.service" fail on
> >> any system that does not have all needed subfunctions. For example,
> >> when running under QEMU TCG (but also on systems where protected keys
> >> are disabled via the HMC).
> >>
> >> Let's use -ENODEV, so systemd-modules-load.service properly ignores
> >> failing to load the pkey module because of missing HW functionality.
> >>
> >> Cc: Harald Freudenberger <freude@linux.ibm.com>
> >> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> >> Cc: Cornelia Huck <cohuck@redhat.com>
> >> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  drivers/s390/crypto/pkey_api.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> >> index 45eb0c14b880..ddfcefb47284 100644
> >> --- a/drivers/s390/crypto/pkey_api.c
> >> +++ b/drivers/s390/crypto/pkey_api.c
> >> @@ -1695,15 +1695,15 @@ static int __init pkey_init(void)
> >>  	 * are able to work with protected keys.
> >>  	 */
> >>  	if (!cpacf_query(CPACF_PCKMO, &pckmo_functions))
> >> -		return -EOPNOTSUPP;
> >> +		return -ENODEV;
> >>  
> >>  	/* check for kmc instructions available */
> >>  	if (!cpacf_query(CPACF_KMC, &kmc_functions))
> >> -		return -EOPNOTSUPP;
> >> +		return -ENODEV;
> >>  	if (!cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_128) ||
> >>  	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_192) ||
> >>  	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_256))
> >> -		return -EOPNOTSUPP;
> >> +		return -ENODEV;
> >>  
> >>  	pkey_debug_init();
> >>    
> > I can't really agree to this: there are a lot more modules returning
> > EOPNOTSUPP, for example have a look into the arch/s390/crypto
> > subdirectory. The ghash_s390 module also registers for MSA feature
> > and also returns EOPNOTSUPPORTED when the required hardware extension  
> 
> For s390x KVM, we return ENODEV in case the SIE (the HW feature) is not
> available. Just because s390x crypto is doing it consistently this way
> doesn't mean it is the right thing to do.
> 
> Maybe we should change all s390x crypto modules then.

I agree.

> 
> > is not available. Same with the prng kernel module, sha1_s390, sha256_s390
> > and I assume there is a bunch of other kernel modules with same behavior.
> > I would prefer having this fixed on the systemd-modules-load.service side.  
> 
> 
> A very, very bad comparison (because it contains a lot of false positives):
> 
> t460s: ~/git/linux memory_block_devices2 $ git grep -A 20 "_init("  --
> 'drivers*.[c]' | grep ENODEV | wc -l
> 1552
> 
> t460s: ~/git/linux memory_block_devices2 $ git grep -A 20 "_init("  --
> 'drivers*.[c]' | grep EOPNOTSUPP | wc -l
> 56
> 
> No, I don't think EOPNOTSUPP is the right thing to do.

If we frame it as
-EOPNOTSUPP -> operation not supported (i.e. we cannot perform this
operation)
-ENODEV -> no such device (i.e. we're lacking hardware support)

I think -ENODEV makes more sense (even though we could argue for both.)
And it is an easy change to make...
