Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 5/9] crypto: ccree - Rename arrays to avoid conflict with
 crypto/sha256.h
References: <20190901203532.2615-1-hdegoede@redhat.com>
 <20190901203532.2615-6-hdegoede@redhat.com>
 <CAOtvUMdd+V5pesw+O-kk9_JB5YpxUM+hU+Uu=kiMvOL9d0AziQ@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <0d55a6a7-9cca-38cb-97a2-558280fdc122@redhat.com>
Date: Tue, 3 Sep 2019 09:51:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAOtvUMdd+V5pesw+O-kk9_JB5YpxUM+hU+Uu=kiMvOL9d0AziQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Atul Gupta <atul.gupta@chelsio.com>, Marc Zyngier <marc.zyngier@arm.com>, Eric Biggers <ebiggers@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, x86@kernel.org, linux-s390@vger.kernel.org, linux-efi@vger.kernel.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi,

On 03-09-19 09:45, Gilad Ben-Yossef wrote:
> On Sun, Sep 1, 2019 at 11:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Rename the algo_init arrays to cc_algo_init so that they do not conflict
>> with the functions declared in crypto/sha256.h.
>>
>> This is a preparation patch for folding crypto/sha256.h into crypto/sha.h.
> 
> I'm fine with the renaming.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Your Signed-off-by is only used when the patches passes through your hands,
since Herbert will likely apply this directly that is not the case.

You want either Acked-by or Reviewed-by to signal that you are ok with this patch.

Regards,

Hans
