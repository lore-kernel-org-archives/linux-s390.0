Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfHRQIJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 18 Aug 2019 12:08:09 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD9F0C057E29
        for <linux-s390@vger.kernel.org>; Sun, 18 Aug 2019 16:08:08 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id a2so3881827wrs.8
        for <linux-s390@vger.kernel.org>; Sun, 18 Aug 2019 09:08:08 -0700 (PDT)
Subject: Re: [PATCH 3/6] crypto: sha256 - Move lib/sha256.c to lib/crypto
References: <20190816211611.2568-1-hdegoede@redhat.com>
 <20190816211611.2568-4-hdegoede@redhat.com>
 <20190817051942.GB8209@sol.localdomain>
 <909d255d-a648-13b5-100f-fe67be547961@redhat.com>
 <20190818155453.GC1118@sol.localdomain>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <52363837-5f5f-53ed-d97c-0de47145987b@redhat.com>
Date: Sun, 18 Aug 2019 18:08:05 +0200
MIME-Version: 1.0
In-Reply-To: <20190818155453.GC1118@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 18-08-19 17:54, Eric Biggers wrote:
> On Sat, Aug 17, 2019 at 10:28:04AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 17-08-19 07:19, Eric Biggers wrote:
>>> On Fri, Aug 16, 2019 at 11:16:08PM +0200, Hans de Goede wrote:
>>>> diff --git a/include/linux/sha256.h b/include/crypto/sha256.h
>>>> similarity index 100%
>>>> rename from include/linux/sha256.h
>>>> rename to include/crypto/sha256.h
>>>
>>> <crypto/sha.h> already has the declarations for both SHA-1 and SHA-2, including
>>> SHA-256.  So I'm not sure a separate sha256.h is appropriate.  How about putting
>>> these declarations in <crypto/sha.h>?
>>
>> The problems with that is that the sha256_init, etc. names are quite generic
>> and they have not been reserved before, so a lot of the crypto hw-accel
>> drivers use them, for private file-local (static) code, e.g.:
>>
>> [hans@shalem linux]$ ack -l sha256_init
>> include/crypto/sha256.h
>> drivers/crypto/marvell/hash.c
>> drivers/crypto/ccp/ccp-ops.c
>> drivers/crypto/nx/nx-sha256.c
>> drivers/crypto/ux500/hash/hash_core.c
>> drivers/crypto/inside-secure/safexcel_hash.c
>> drivers/crypto/chelsio/chcr_algo.h
>> drivers/crypto/stm32/stm32-hash.c
>> drivers/crypto/omap-sham.c
>> drivers/crypto/padlock-sha.c
>> drivers/crypto/n2_core.c
>> drivers/crypto/atmel-aes.c
>> drivers/crypto/axis/artpec6_crypto.c
>> drivers/crypto/mediatek/mtk-sha.c
>> drivers/crypto/qat/qat_common/qat_algs.c
>> drivers/crypto/img-hash.c
>> drivers/crypto/ccree/cc_hash.c
>> lib/crypto/sha256.c
>> arch/powerpc/crypto/sha256-spe-glue.c
>> arch/mips/cavium-octeon/crypto/octeon-sha256.c
>> arch/x86/purgatory/purgatory.c
>> arch/s390/crypto/sha256_s390.c
>> arch/s390/purgatory/purgatory.c
>>
>> (in case you do not know ack is a smarter grep, which skips .o files, etc.)
> 
> You need to match at word boundaries to avoid matching on ${foo}_sha256_init().
> So it's actually a somewhat shorter list:
> 
> $ git grep -l -E '\<sha(224|256)_(init|update|final)\>'
> arch/arm/crypto/sha256_glue.c
> arch/arm/crypto/sha256_neon_glue.c
> arch/arm64/crypto/sha256-glue.c
> arch/s390/crypto/sha256_s390.c
> arch/s390/purgatory/purgatory.c
> arch/x86/crypto/sha256_ssse3_glue.c
> arch/x86/purgatory/purgatory.c
> crypto/sha256_generic.c
> drivers/crypto/ccree/cc_hash.c
> drivers/crypto/chelsio/chcr_algo.h
> drivers/crypto/n2_core.c
> include/linux/sha256.h
> lib/sha256.c
> 
> 5 of these are already edited by this patchset, so that leaves only 8 files.

Good point.

>> All these do include crypto/sha.h and putting the stuff which is in what
>> was linux/sha256.h into crypto/sha.h leads to name collisions which causes
>> more churn then I would like this series to cause.
>>
>> I guess we could do a cleanup afterwards, with one patch per file above
>> to fix the name collision issue, and then merge the 2 headers. I do not
>> want to do that for this series, as I want to keep this series as KISS
>> as possible since it is messing with somewhat sensitive stuff.
>>
>> And TBH I even wonder if a follow-up series is worth the churn...
>>
> 
> I think it should be done; the same was done when introducing the AES library.
> But I'm okay with it being done later, if you want to keep this patchset
> shorter.

I would prefer to do this later, so that we can focus on the basis
of merging the 2 implementations now.

I'm willing to commit to doing the cleanup once the base series has been merged.

Regards,

Hans
