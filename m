Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201104201631.40017.arnd@arndb.de>
References: <1303309252-9946-1-git-send-email-akinobu.mita@gmail.com>
	<201104201631.40017.arnd@arndb.de>
Date: Thu, 21 Apr 2011 07:59:30 +0900
Message-ID: <BANLkTimBF312svk0mRkt5_Y=t+B12cLW+Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] bitops: add ifdef CONFIG_GENERIC_FIND_BIT_LE guard
From: Akinobu Mita <akinobu.mita@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

2011/4/20 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 20 April 2011, Akinobu Mita wrote:
>> index 946a21b..bd2253e 100644
>> --- a/include/asm-generic/bitops/le.h
>> +++ b/include/asm-generic/bitops/le.h
>> @@ -30,6 +30,8 @@ static inline unsigned long find_first_zero_bit_le(con=
st void *addr,
>>
>> =A0#define BITOP_LE_SWIZZLE =A0 =A0 =A0 ((BITS_PER_LONG-1) & ~0x7)
>>
>> +#ifdef CONFIG_GENERIC_FIND_BIT_LE
>> +
>> =A0extern unsigned long find_next_zero_bit_le(const void *addr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long size, unsigned long offset=
);
>> =A0extern unsigned long find_next_bit_le(const void *addr,
>> @@ -38,6 +40,8 @@ extern unsigned long find_next_bit_le(const void *addr,
>> =A0#define find_first_zero_bit_le(addr, size) \
>> =A0 =A0 =A0 =A0 find_next_zero_bit_le((addr), (size), 0)
>>
>> +#endif /* CONFIG_GENERIC_FIND_BIT_LE */
>> +
>> =A0#else
>> =A0#error "Please fix <asm/byteorder.h>"
>> =A0#endif
>
> The style that we normally use in asm-generic is to test the macro itself
> for existence, so in asm-generic, do:
>
> #ifndef find_next_zero_bit_le
> extern unsigned long find_next_zero_bit_le(const void *addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long size, unsigned long offset);
> #endif
>
> and in the architectures, write
>
> static inline unsigned long find_next_zero_bit_le(const void *addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long size, unsigned long offset)
> #define find_next_zero_bit_le find_next_zero_bit_le
>
> I guess we can do the #ifdef separately for each of the three macros,
> or choose one of them to use as a key.

I see.

Should we also kill CONFIG_GENERIC_FIND_BIT_LE option comletely,
then add the #ifdef for each find_*() in lib/find_next_bit.c and always bui=
ld
it unconditionally ?
