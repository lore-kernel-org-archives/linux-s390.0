From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 03/22] s390: introduce little endian bitops
Date: Mon, 18 Oct 2010 13:51:52 +0900
Message-ID: <AANLkTi=H+c0drWP20JhSs74+V3q2aChgTA1L86pT=FzH@mail.gmail.com>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
	<1287135981-17604-4-git-send-email-akinobu.mita@gmail.com>
	<201010151312.30843.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <201010151312.30843.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

2010/10/15 Arnd Bergmann <arnd@arndb.de>:
> On Friday 15 October 2010, Akinobu Mita wrote:
>> +#define __set_le_bit(nr, addr) \
>> + =A0 =A0 =A0 __set_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
>> +#define __clear_le_bit(nr, addr) =A0 =A0 =A0 \
>> + =A0 =A0 =A0 __clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
>> +#define __test_and_set_le_bit(nr, addr) =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 __test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr=
))
>> +#define test_and_set_le_bit(lock, nr, addr) =A0 =A0\
>> + =A0 =A0 =A0 test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
>> +#define __test_and_clear_le_bit(nr, addr) =A0 =A0 =A0\
>> + =A0 =A0 =A0 __test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (ad=
dr))
>> +#define test_and_clear_le_bit(lock, nr, addr) =A0\
>> + =A0 =A0 =A0 test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr=
))
>> +#define test_le_bit(nr, addr) =A0\
>> + =A0 =A0 =A0 test_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
>
> The test_and_clear_le_bit and test_and_set_le_bit calling conventions
> are a little surprising here. I would not pass the lock argument
> here but leave that to the ext2 wrapper:
>
> #define test_and_set_le_bit(nr, addr) =A0 =A0\
> =A0 =A0 =A0 test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
> #define test_and_clear_le_bit(nr, addr) =A0\
> =A0 =A0 =A0 test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
>
> #define ext2_set_bit_atomic(lock, nr, addr) =A0 =A0 =A0 \
> =A0 =A0 =A0 test_and_set_le_bit((nr), (unsigned long *)(addr))
> #define ext2_clear_bit_atomic(lock, nr, addr) =A0 =A0 \
> =A0 =A0 =A0 test_and_clear_le_bit((nr), (unsigned long *)(addr))
>
> Same thing on arm and m68k.

Oops,
test_and_{set,clear}_le_bit() is only used by ext2_{set,clear}_bit_atom=
ic
and I had one additional patch that cleans up these definisions across
the architectures. So I didn't realize that mistake when I did cross
compile.
