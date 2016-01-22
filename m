Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 22 Jan 2016 15:43:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] kallsyms: add support for relative offsets in
 kallsyms address table
Message-ID: <20160122154358.e6491d6a963747b449731eb9@linux-foundation.org>
In-Reply-To: <20160122153428.8422f42877c7707dbcba0259@linux-foundation.org>
References: <1453373299-28181-1-git-send-email-ard.biesheuvel@linaro.org>
	<1453396783-21591-1-git-send-email-ard.biesheuvel@linaro.org>
	<20160122153428.8422f42877c7707dbcba0259@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160122234358.MuWDuQ_RiHZQGCzSu1m9MZLqG_8-IHP91v0smJf3gAI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, mingo@kernel.org, hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz, rusty@rustcorp.com.au, arnd@arndb.de, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 22 Jan 2016 15:34:28 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> > Support for the above is enabled by default for all architectures except
> > IA-64, whose symbols are too far apart to capture in this manner.
> 
> scripts/kallsyms.c: In function 'record_relative_base':
> scripts/kallsyms.c:744: error: 'ULLONG_MAX' undeclared (first use in this function)
> scripts/kallsyms.c:744: error: (Each undeclared identifier is reported only once
> scripts/kallsyms.c:744: error: for each function it appears in.)
> 
> That's with (ancient) glibc-headers-2.5-3.  It appears that limits.h's
> ULLONG_MAX requires "#ifdef __USE_ISOC99".  I'm not sure what's the
> correct way of turning this on.

Actually, how about we replace it with -1ULL and get on with life.
