Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <64480084bc652d5fa91bf5cd4be979e2f1e4cf11.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
	<64480084bc652d5fa91bf5cd4be979e2f1e4cf11.1453759363.git.luto@kernel.org>
Date: Wed, 27 Jan 2016 11:17:05 -0800
Message-ID: <CAKdAkRQm6ADz5aCYAFxXcoGZ2zNFwTUXjMzZdNj-D2-YrYQtrg@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] input: Redefine INPUT_COMPAT_TEST as in_compat_syscall()
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160127191705.VZ2fR3khHnUujtKCiF4vEF5Gh-_CkimL3Gars_LeXwI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Andy,

On Mon, Jan 25, 2016 at 2:24 PM, Andy Lutomirski <luto@kernel.org> wrote:
> The input compat code should work like all other compat code: for
> 32-bit syscalls, use the 32-bit ABI and for 64-bit syscalls, use the
> 64-bit ABI.  We have a helper for that (in_compat_syscall()): just
> use it.
>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  drivers/input/input-compat.h | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/input/input-compat.h b/drivers/input/input-compat.h
> index 148f66fe3205..0f25878d5fa2 100644
> --- a/drivers/input/input-compat.h
> +++ b/drivers/input/input-compat.h
> @@ -17,17 +17,7 @@
>
>  #ifdef CONFIG_COMPAT
>
> -/* Note to the author of this code: did it ever occur to
> -   you why the ifdefs are needed? Think about it again. -AK */
> -#if defined(CONFIG_X86_64) || defined(CONFIG_TILE)
> -#  define INPUT_COMPAT_TEST is_compat_task()
> -#elif defined(CONFIG_S390)
> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_31BIT)
> -#elif defined(CONFIG_MIPS)
> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT_ADDR)
> -#else
> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT)
> -#endif
> +#define INPUT_COMPAT_TEST in_compat_syscall()
>


If we now have function that works on all arches I'd prefer if we used
it directly instead of continuing using INPUT_COMPAT_TEST.

Thanks.

-- 
Dmitry
