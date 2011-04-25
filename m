From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/6] s390: use asm-generic/bitops/le.h
Date: Mon, 25 Apr 2011 14:33:19 -0700
Message-ID: <20110425143319.f4c6e036.akpm@linux-foundation.org>
References: <1303638677-11211-1-git-send-email-akinobu.mita@gmail.com>
	<1303638677-11211-6-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1303638677-11211-6-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 24 Apr 2011 18:51:16 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> The previous style change enables to use asm-generic/bitops/le.h
> on s390.

What kernel version is this patchset against?

>  }
>  #define find_next_bit_le find_next_bit_le
>  
> +#include <asm-generic/bitops/le.h>
> +
>  #include <asm-generic/bitops/ext2-atomic-test.h>
>  

Mainline arch/s390/include/asm/bitops.h doesn't have this inclusion.

Please recheck, redo and resend.
