From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 5/6] s390: use asm-generic/bitops/le.h
Date: Tue, 26 Apr 2011 11:00:58 +0900
Message-ID: <BANLkTi=S0JjzFq_Sf1tSgdk6h2V-m5n_pQ@mail.gmail.com>
References: <1303638677-11211-1-git-send-email-akinobu.mita@gmail.com>
	<1303638677-11211-6-git-send-email-akinobu.mita@gmail.com>
	<20110425143319.f4c6e036.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20110425143319.f4c6e036.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

2011/4/26 Andrew Morton <akpm@linux-foundation.org>:
> On Sun, 24 Apr 2011 18:51:16 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
>> The previous style change enables to use asm-generic/bitops/le.h
>> on s390.
>
> What kernel version is this patchset against?
>
>> =A0}
>> =A0#define find_next_bit_le find_next_bit_le
>>
>> +#include <asm-generic/bitops/le.h>
>> +
>> =A0#include <asm-generic/bitops/ext2-atomic-test.h>
>>
>
> Mainline arch/s390/include/asm/bitops.h doesn't have this inclusion.

Oops, the change is only in my local tree.

> Please recheck, redo and resend.

OK, I will.
