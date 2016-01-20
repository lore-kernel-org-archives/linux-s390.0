Return-Path: <mingo.kernel.org@gmail.com>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 20 Jan 2016 11:33:25 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/4] support for text-relative kallsyms table
Message-ID: <20160120103325.GA20197@gmail.com>
References: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, akpm@linux-foundation.org, hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz, rusty@rustcorp.com.au
List-ID: <linux-s390.vger.kernel.org>


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> This implements text-relative kallsyms address tables. This was developed as 
> part of my series to implement KASLR/CONFIG_RELOCATABLE for arm64, but I think 
> it may be beneficial to other architectures as well, so I am presenting it as a 
> separate series.
> 
> The idea is that on 64-bit builds, it is rather wasteful to use absolute 
> addressing for kernel symbols since they are all within a couple of MBs of each 
> other. On top of that, the absolute addressing implies that, when the kernel is 
> relocated at runtime, each address in the table needs to be fixed up 
> individually.
> 
> Since all section-relative addresses are already emitted relative to _text, it 
> is quite straight-forward to record only the offset, and add the absolute 
> address of _text at runtime when referring to the address table.
> 
> The reduction ranges from around 250 KB uncompressed vmlinux size and 10 KB 
> compressed size (s390) to 3 MB/500 KB for ppc64 (although, in the latter case, 
> the reduction in uncompressed size is primarily __init data)

So since kallsyms is in unswappable kernel RAM, the uncompressed size reduction is 
what we care about mostly. How much bootloader load times are impacted is a third 
order concern.

IOW a nice change!

Thanks,

	Ingo
