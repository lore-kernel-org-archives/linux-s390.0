Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 7 Nov 2016 14:38:07 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] s390: squash facilities_src.h into gen_facilities.c
References: <1478403928-20799-1-git-send-email-yamada.masahiro@socionext.com>
 <1478403928-20799-2-git-send-email-yamada.masahiro@socionext.com>
 <20161107070322.GA4075@osiris>
 <20161107105005.3477a324@mschwide>
 <1478524386.29112.18.camel@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478524386.29112.18.camel@tiscali.nl>
Message-Id: <20161107133807.GB4075@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-s390@vger.kernel.org, Sascha Silbe <silbe@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 07, 2016 at 02:13:06PM +0100, Paul Bolle wrote:
> It took me some time to figure out that gen_facilities is only used to
> generate a small header file (generated/facilities.h). And that header's only
> goal is to define FACILITIES_ALS and FACILITIES_KVM.
> 
> Pasted below is an attempt to use asm/facilities.h instead of
> generated/facilities.h. That allows to drop arch/s390/tools/ entirely. I don't
> actually have an s390 machine at hand to test this, but this does build and
> the preprocessed code this generates looks sane.
> 
> (Yes, asm/facilities.h might need another level of preprocessor defines to
> become actually readable.)

The whole point of the tool is that we can use the bit numbers that are
specified within the architecture document, with the additional odd IBM bit
numbering scheme. Where the most significant bit has bit number 0(!).

> diff --git a/arch/s390/include/asm/facilities.h b/arch/s390/include/asm/facilities.h
> new file mode 100644
> index 000000000000..c87f18d29217
> --- /dev/null
> +++ b/arch/s390/include/asm/facilities.h
> @@ -0,0 +1,43 @@
> +#ifndef __ASM_FACILITIES_H
> +#define __ASM_FACILITIES_H
> +
> +#define FACILITIES_ALS \
> +	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z900_FEATURES), UL) << 0 |	/* N3 instructions */ \

So, this is wrong. It should be " << 63" to match the existing code.

> +#define FACILITIES_KVM \
> +	_BITUL(0)  |	/* N3 instructions */ \
> +	_BITUL(1)  |	/* z/Arch mode installed */ \
> +	_BITUL(2)  |	/* z/Arch mode active */ \
> +	_BITUL(3)  |	/* DAT-enhancement */ \
> +	_BITUL(4)  |	/* idte segment table */ \
> +	_BITUL(5)  |	/* idte region table */ \
> +	_BITUL(6)  |	/* ASN-and-LX reuse */ \
> +	_BITUL(7)  |	/* stfle */ \
> +	_BITUL(8)  |	/* enhanced-DAT 1 */ \
> +	_BITUL(9)  |	/* sense-running-status */ \
> +	_BITUL(10) |	/* conditional sske */ \
> +	_BITUL(13) |	/* ipte-range */ \
> +	_BITUL(14)  	/* nonquiescing key-setting */ \
> +	, \
> +	_BITUL(9)  |	/* transactional execution */ \
> +	_BITUL(11) |	/* access-exception-fetch/store indication */ \

And this is exactly what I want to avoid: start counting from zero again if
we cross a double word. It _must_ read 73, 75, otherwise this becomes the
unmaintainable and error prone mess we had before.

I just want a list with bit numbers and the rest must be created
automatically.
