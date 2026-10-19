Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792449077;
	b=IVgxx8aGunUGvT5wyfDjFtsBh89uumh+n9fwcBmQtM+B4PqkNe86IDEDzZ/AR/Un7+wo
	 DPoknffWL7krmIVepXQbRnZdxAI5jjGv5AONR2Ki3vQDcBvccpWBHg+AH9X0RiZAyMBBm
	 SYpsibJJmU02lv40dB4ItVDvKdgbOYE0dsWPwlkNa8bp/5foc5CkPVBsk2yHllBfDQ8FS
	 IjDFLSJ3p0GWw4W3KqWuHOkpoCZFKyDCrdDGn19Nx0H39StPq+1D4K0s5ygDGDPVlp0lt
	 EoZLvUZ9ZqumBaFbjrpfDzBjWKi+VSA9T+AQxLkn4/UlQJq+PLetlkJh7N9aL2WlfSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792449077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=7Y7YiwpHnHRTlx4OY6pg4GKzGSuy4/quEwIOKfF9VTA=;
	b=Wyaty97obFwb2y+aHQiQIVzL/NcywO+OaB1jGxDEmOfYjPNqSYWb8CuqgDmgyUqDUhWq
	 gKdH/QuB0yXIAYZFP3Piz17JLEF8C+SxIJl6Xr6bHN3iqVjhKhE3RVE2D9AaD93/q+ArF
	 KEACXSxx84+tp3NUq1gpjUKOmyoQ8GWIpd4vW110/fpB/xPqF9dr6PAfvmG6BGw4wdHE7
	 +Z+Scsw0vZoTWtyTDWiXTP8V9H477Sd+ieBOQxSJ+YdrQ6+gTQ2RGyVTgXPWGl2fe0Hiy
	 a1hQ3fzm3xQk3Mru8k+dvNCN/giWn8ERH5fr+9PAbRXFstohNY5wbdV5GtMWuUkJHOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RRrtCUSO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD916606A31C
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 22:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD916606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RRrtCUSO
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-188406bb948so226825c88.1
        for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 15:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792449076; cv=none;
        d=google.com; s=arc-20260327;
        b=qWZ8GAOFFzkvGv32oD4M1hzvvooZ/JEm0ibx4iQKGMfKvIhBNmQgwtRUEAKW4OYosF
         JLnIEnob1fOoiGlyr/x4Azust8/JCflxdkV5R6P4AXAmJ3zApYxQ3Yx+Fw72JT9Ib/Su
         zTRW5qL9saYCE88uZBUCMFLB3PWw2uYOyrx3LKc8o020J5ofLwuclyFBxhDVUq4dwx4H
         JDot0eca7QOGSecA1EGNGo/lisCt7IYoeU8s+1mfjGS045HzMDi8KASVSGAK/NErGMbA
         SzVmZS1XGAKRvUWRbYse/mn//HI5WfNDLWd3WSmeqvXWtOdbVrLV5j68PoPVGGnoxlyx
         8PRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7Y7YiwpHnHRTlx4OY6pg4GKzGSuy4/quEwIOKfF9VTA=;
        fh=RuD3WgVSzPPlQ93yBXhqZad+r0RgsG2QVP0Tf3m3mTQ=;
        b=MrBBAU17QPgna5PUfiNCjz4nSYA2g6COsGuHjqo35/iyJptOSHrQb3l+NV1HVifdAm
         1aU4RzqseVV5VmIa/fCQsIAFyKM7pFME3B0njh7fQUX6rgRTDvJeyhekOhUxfW6lU4qa
         9wngE/TxzRlZGnbvjqEh8hwUtyfXukHnLvMWvOD8Pz48wjDDocBYPHaH2rEu/LoAh1D7
         VsWQnzDJtqbiAaW2JJ6Qhp/8JxAlpLNstTQhwmZQ9+Xqx80bopTQlxvAeqXlBlHNx1IS
         4SitCfe5rOiakw6qeEQHsZ6NqSPfZBLwnDuKvmlUElJmHngbXVijZSQPwtr7qNZKWlxA
         E42A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792449076; x=1793053876; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Y7YiwpHnHRTlx4OY6pg4GKzGSuy4/quEwIOKfF9VTA=;
        b=RRrtCUSOeiSWzPRRuOZ0DhvH8GX/P9S9t7QK6Q7kZ6lDpGqUM+mKeh1xmTjTdeO5pE
         lvm8uc1V/pVV21IR6OdurhClovblGshTMXDN/+3P4KpNxTGas6fDVPjP8px74TP1kRE6
         xCJqOUXrEK3icNuxkKplIbfGOx7nWOQLEU0mOPhACFkfc4Vcx1X5AJ9iDsyApc6qbqKs
         A8NtIo8/4VEv8x/YyXlZvlzlELK5p9S6uKqb0fuVbS3kFb5VefDP5uZe0cGxFn+z9DUw
         xI0oXslo7OltJIt+4BX7wcxs5AtJVW9NfsXMAVoR1tr0zSkHekFdqpMg3lGPrhc4Kq+0
         N8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792449076; x=1793053876;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Y7YiwpHnHRTlx4OY6pg4GKzGSuy4/quEwIOKfF9VTA=;
        b=1U1mMzSuZkRGIXcMyrVPu/mk+JxZn/I2C86wFDE74hdkQNyGgfESXyyyXSfWKuKLoH
         Vh7ZO/Tml7/cGSn9LqaN4ZenLytj+WRxUQfALva/iuL90p6QDM04aZd4Y7TN5agek9y2
         zQruRqrQ1J7ijBi5LpBr36tH9QdkmsiUtg2SUhiueZPTwuJdWo9gGUvAxhYi/AODO5ND
         B/Rz7hkEPSL3lX8PLh2MtxPDRK7dmW0eiXdvjP2EvXkYwBWOQ1Y6k+M2jxMAEKyjtOBy
         iPJR4I3y+AU4TGyNZIIemCD7yIkR7wlgglIySmwUL8cYHzfLOXT9PbyYpAmMQN3w6T1+
         vUYw==
X-Forwarded-Encrypted: i=1; AKwUvBxLhYOCVyh9XvcvGJJKM551soMrrhjxtMC2M8biePhl7BadyAPY9kCM6Kg6LgncBo0BX1CfNuvvz9Kq@vger.kernel.org
X-Gm-Message-State: AFq9FYKQ+8d6G/uf4oWcIv6CVzIS3/Vgeskcz+dgH4vaSv9qr5D4axaW
	L3tLqI1Lt+zKuQ9MZIbHDfe4zxaPOR9A14xJuzSrOkD6a0J+fpobggvvV3rI3hL3mtubJucV9zo
	PVtrxqR8CV/abmW14+46t2PhF9R/Z+rLSDRnVKr35
X-Gm-Gg: AYBFou0RLOfTQYSSzonKvd15/QlQzvpyB3GWkt9g3LXgZHYUw9k0i1ousiqufeBXl50
	pHum7rdDS9FBzu2hcPWpyl4sRMU0uc4bPpZhy5L+DWAtxOksBKSBoARxaAPKfOJwcw5w7f+n8HR
	DgsrUoedbqTX4CpSiNfY+NWIozPe7VlIsegnsJz6bshzDYRkiz8GTStHMcFWeIq4XJumyu5B+3O
	4WMHFvSaDUuv+K3UzZ4JYPISi4lomEishS81gPZqqnzIPwnQpPsry+cbeYRsSrp8v8sn5qPluwB
	V0pbLIPNctCRkmIthsZ/GHN3os1jsM/QUC+ETHJNV6hp/rZj6hAJ/LuiP7MajE1DoIydgiJg2r4
	D5b4E8QMcBs7/wbdxkGvr2VmFwUg+18u/eWoUbKm4Z3Jxe+4JCp4riHeQtJnYkQHW5UA+
X-Received: by 2002:a05:701b:42cb:10b0:169:b1b1:1445 with SMTP id
 a92af1059eb24-18512e2515fmr12984330c88.31.1792449074316; Mon, 19 Oct 2026
 15:31:14 -0700 (PDT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 20 Oct 2026 00:30:37 +0200
X-Gm-Features: AclHuK-9KfyXQ0m8f9CHsU2jTa1lgiXB2sNpwhyCmDMarQWZL2s0qBm4al6Ih6c
Message-ID: <CANpmjNPPncfo41Hu=TKB8cd1aFm0Lm-9+AT6pXVsYyUgFVx8TQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Peter Collingbourne <peter@pcc.me.uk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 03:58, Qiliang Yuan <odys.yuan@gmail.com> wrote:
>
> load_unaligned_zeropad() reads a word that may run into an unmapped
> page and recovers through an exception fixup. It does the word loads of
> sized_strscpy() and of the name compare in dentry_string_cmp(), path
> components in hash_name() and hashlen_string(), and the trailing bytes
> in x86's csum_partial().
>
> It is inline assembly on every architecture that implements it, so
> KASAN and KCSAN never see these loads, while read_word_at_a_time() at
> least checks the first byte of each word. A use-after-free or
> out-of-bounds read of a name handed to path lookup goes unreported, and
> so does strscpy() reading from a bad source, which the kasan_strings
> KUnit case expects to be reported. On x86_64 with generic KASAN:
>
>   KASAN and string KUnit suites      failures
>                                   before    after
>   CONFIG_FORTIFY_SOURCE=n              1        0
>   CONFIG_FORTIFY_SOURCE=y              1        0
>
> Check the first byte at the start of load_unaligned_zeropad() on every
> architecture, as read_word_at_a_time() does. All callers only load a
> word whose first byte belongs to the string or buffer they read, so
> the check does not flag their intended reads past the end. Add no-op
> stubs for the powerpc selftest that builds the header in user space.
>
> Suggested-by: Peter Collingbourne <peter@pcc.me.uk>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>

Thanks!

> ---
>  arch/arm/include/asm/word-at-a-time.h                           | 7 +++++++
>  arch/arm64/include/asm/word-at-a-time.h                         | 7 +++++++
>  arch/powerpc/include/asm/word-at-a-time.h                       | 6 ++++++
>  arch/riscv/include/asm/word-at-a-time.h                         | 6 ++++++
>  arch/s390/include/asm/word-at-a-time.h                          | 6 ++++++
>  arch/x86/include/asm/word-at-a-time.h                           | 6 ++++++
>  tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h | 3 +++
>  tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h | 3 +++
>  8 files changed, 44 insertions(+)
>
> diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
> index 5023f98d8293d..f672aad2e30e6 100644
> --- a/arch/arm/include/asm/word-at-a-time.h
> +++ b/arch/arm/include/asm/word-at-a-time.h
> @@ -56,6 +56,9 @@ static inline unsigned long find_zero(unsigned long mask)
>  #include <asm-generic/word-at-a-time.h>
>  #endif
>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +
>  #ifdef CONFIG_DCACHE_WORD_ACCESS
>
>  /*
> @@ -69,6 +72,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret, tmp;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         /* Load word from unaligned pointer addr */
>         asm(
>         "1:     ldr     %0, [%2]\n"
> diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
> index 824ca6987a516..11ecca99057aa 100644
> --- a/arch/arm64/include/asm/word-at-a-time.h
> +++ b/arch/arm64/include/asm/word-at-a-time.h
> @@ -40,6 +40,9 @@ static inline unsigned long zero_bytemask(unsigned long bits)
>  #include <asm-generic/word-at-a-time.h>
>  #endif
>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +
>  /*
>   * Load an unaligned word from kernel space.
>   *
> @@ -51,6 +54,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         __mte_enable_tco_async();
>
>         /* Load word from unaligned pointer addr */
> diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
> index 54653a8634149..49c6a1f65c493 100644
> --- a/arch/powerpc/include/asm/word-at-a-time.h
> +++ b/arch/powerpc/include/asm/word-at-a-time.h
> @@ -5,6 +5,8 @@
>   * Word-at-a-time interfaces for PowerPC.
>   */
>  #include <linux/bitops.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  #include <linux/wordpart.h>
>  #include <asm/asm-compat.h>
>  #include <asm/extable.h>
> @@ -168,6 +170,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret, offset, tmp;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         asm(
>         "1:     " PPC_LL "%[ret], 0(%[addr])\n"
>         "2:\n"
> diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
> index 3802cda71ab7e..fb7e2904dd7fd 100644
> --- a/arch/riscv/include/asm/word-at-a-time.h
> +++ b/arch/riscv/include/asm/word-at-a-time.h
> @@ -11,6 +11,8 @@
>
>  #include <asm/asm-extable.h>
>  #include <linux/bitops.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  #include <linux/wordpart.h>
>
>  struct word_at_a_time {
> @@ -60,6 +62,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         /* Load word from unaligned pointer addr */
>         asm(
>         "1:     " REG_L " %0, %2\n"
> diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
> index eaa19dee76994..59393cf065964 100644
> --- a/arch/s390/include/asm/word-at-a-time.h
> +++ b/arch/s390/include/asm/word-at-a-time.h
> @@ -3,6 +3,8 @@
>  #define _ASM_WORD_AT_A_TIME_H
>
>  #include <linux/bitops.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  #include <linux/wordpart.h>
>  #include <asm/asm-extable.h>
>  #include <asm/bitsperlong.h>
> @@ -52,6 +54,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long data;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         asm_inline volatile(
>                 "0:     lg      %[data],0(%[addr])\n"
>                 "1:     nopr    %%r7\n"
> diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
> index 422a47746657a..1319e1d87a9c4 100644
> --- a/arch/x86/include/asm/word-at-a-time.h
> +++ b/arch/x86/include/asm/word-at-a-time.h
> @@ -3,6 +3,8 @@
>  #define _ASM_WORD_AT_A_TIME_H
>
>  #include <linux/bitops.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  #include <linux/wordpart.h>
>
>  struct word_at_a_time {
> @@ -71,6 +73,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         asm volatile(
>                 "1:     mov %[mem], %[ret]\n"
>                 "2:\n"
> diff --git a/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h b/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h
> new file mode 100644
> index 0000000000000..000c92de6baf2
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* There is nothing for KASAN to check in user space. */
> +#define kasan_check_read(p, size)      ((void)(p), (void)(size))
> diff --git a/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h b/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h
> new file mode 100644
> index 0000000000000..39c97bc15531e
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* There is nothing for KCSAN to check in user space. */
> +#define kcsan_check_read(p, size)      ((void)(p), (void)(size))
>
> --
> 2.43.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477%40gmail.com.
