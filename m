From: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH 01/10] Add support for GCC-4.5's __builtin_unreachable()
 to compiler.h
Date: Thu, 10 Sep 2009 17:14:30 -0700
Message-ID: <4AA99666.4090207@twiddle.net>
References: <4AA991C1.1050800@caviumnetworks.com> <1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
Errors-to: linux-mips-bounce@linux-mips.org
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>, Mike Frysinger <vapier@gentoo.org>, uclinux-d
List-ID: <linux-s390.vger.kernel.org>

On 09/10/2009 04:56 PM, David Daney wrote:
> +#ifndef unreachable
> +# define unreachable() do { for (;;) ; } while (0)
> +#endif

#define unreachable() do { } while (1)


r~
