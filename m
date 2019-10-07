Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 5.4 regression fix] x86/boot: Provide memzero_explicit
References: <20191007134724.4019-1-hdegoede@redhat.com>
 <20191007140022.GA29008@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <1dc3c53d-785e-f9a4-1b4c-3374c94ae0a7@redhat.com>
Date: Mon, 7 Oct 2019 16:11:51 +0200
MIME-Version: 1.0
In-Reply-To: <20191007140022.GA29008@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>, Stephan Mueller <smueller@chronox.de>

Hi,

On 07-10-2019 16:00, Ingo Molnar wrote:
> 
> * Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> The purgatory code now uses the shared lib/crypto/sha256.c sha256
>> implementation. This needs memzero_explicit, implement this.
>>
>> Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
>> Fixes: 906a4bb97f5d ("crypto: sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> - Add barrier_data() call after the memset, making the function really
>>    explicit. Using barrier_data() works fine in the purgatory (build)
>>    environment.
>> ---
>>   arch/x86/boot/compressed/string.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
>> index 81fc1eaa3229..654a7164a702 100644
>> --- a/arch/x86/boot/compressed/string.c
>> +++ b/arch/x86/boot/compressed/string.c
>> @@ -50,6 +50,12 @@ void *memset(void *s, int c, size_t n)
>>   	return s;
>>   }
>>   
>> +void memzero_explicit(void *s, size_t count)
>> +{
>> +	memset(s, 0, count);
>> +	barrier_data(s);
>> +}
> 
> So the barrier_data() is only there to keep LTO from optimizing out the
> seemingly unused function?

I believe that Stephan Mueller (who suggested adding the barrier)
was also worried about people using this as an example for other
"explicit" functions which actually might get inlined.

This is not so much about protecting against LTO as it is against
protecting against inlining, which in this case boils down to the
same thing. Also this change makes the arch/x86/boot/compressed/string.c
and lib/string.c versions identical which seems like a good thing to me
(except for the code duplication part of it).

But I agree a comment would be good, how about:

void memzero_explicit(void *s, size_t count)
{
	memset(s, 0, count);
	/* Avoid the memset getting optimized away if we ever get inlined */
	barrier_data(s);
}

?

Regards,

Hans
