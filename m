Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 7 Oct 2019 17:40:07 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 5.4 regression fix] x86/boot: Provide memzero_explicit
Message-ID: <20191007154007.GA96929@gmail.com>
References: <20191007134724.4019-1-hdegoede@redhat.com>
 <20191007140022.GA29008@gmail.com>
 <1dc3c53d-785e-f9a4-1b4c-3374c94ae0a7@redhat.com>
 <20191007142230.GA117630@gmail.com>
 <2982b666-e310-afb7-40eb-e536ce95e23d@redhat.com>
 <20191007144600.GB59713@gmail.com>
 <20191007152049.GA384920@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007152049.GA384920@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Stephan Mueller <smueller@chronox.de>


* Arvind Sankar <nivedita@alum.mit.edu> wrote:

> With the barrier in there, is there any reason to *not* inline the
> function? barrier_data() is an asm statement that tells the compiler
> that the asm uses the memory that was set to zero, thus preventing it
> from removing the memset even if nothing else uses that memory later. A
> more detailed comment is there in compiler-gcc.h. I can't see why it
> wouldn't work even if it were inlined.
> 
> If the function can indeed be inlined, we could just make the common
> implementation a macro and avoid duplicating it? As mentioned in another
> mail, we otherwise will likely need another duplicate implementation for
> arch/s390/purgatory as well.

I suspect macro would be justified in this case. Mind sending a v3 patch 
to demonstrate how it would all look like?

I'll zap v2 if the macro solution looks better.

Thanks,

	Ingo
