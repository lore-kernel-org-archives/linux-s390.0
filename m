From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 03/22] s390: introduce little endian bitops
Date: Fri, 15 Oct 2010 13:12:30 +0200
Message-ID: <201010151312.30843.arnd@arndb.de>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com> <1287135981-17604-4-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1287135981-17604-4-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Friday 15 October 2010, Akinobu Mita wrote:
> +#define __set_le_bit(nr, addr) \
> +       __set_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
> +#define __clear_le_bit(nr, addr)       \
> +       __clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
> +#define __test_and_set_le_bit(nr, addr)        \
> +       __test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
> +#define test_and_set_le_bit(lock, nr, addr)    \
> +       test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
> +#define __test_and_clear_le_bit(nr, addr)      \
> +       __test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
> +#define test_and_clear_le_bit(lock, nr, addr)  \
> +       test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
> +#define test_le_bit(nr, addr)  \
> +       test_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))

The test_and_clear_le_bit and test_and_set_le_bit calling conventions
are a little surprising here. I would not pass the lock argument
here but leave that to the ext2 wrapper:

#define test_and_set_le_bit(nr, addr)    \
       test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))
#define test_and_clear_le_bit(nr, addr)  \
       test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (addr))

#define ext2_set_bit_atomic(lock, nr, addr)       \
       test_and_set_le_bit((nr), (unsigned long *)(addr))
#define ext2_clear_bit_atomic(lock, nr, addr)     \
       test_and_clear_le_bit((nr), (unsigned long *)(addr))

Same thing on arm and m68k.

	Arnd
