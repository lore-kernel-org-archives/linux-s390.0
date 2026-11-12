Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475393;
	b=XMb83QU3rpTJmlWFMTO3UQSlCthXYVsmQpqD/EcrKi8RgVj9DlGaRXdC6N3SkSgMKDSh
	 HPXyzs6QLYDEGZ2wxpH4OtnwEVbuOhWWYDe6l1a9nO1vJT7uDn9dxtYquFfylHEJRD/49
	 v3fQGoLSXEU19VH1jNKzYk34wm4nI0m7sJyZFA7xhHuX9mhwUP+rWPe0N4wBqmJdoQ/fw
	 LCNgH2icniXxy6iMpblQjAqfsPaeGAeJSrYB+25y8RjspawiRUqiKnthXILIH0NYnuw/B
	 73dQJ71wP70ubFQW1oowxAL+6Uo0X6RDlIYRauPjDF5nQuOvn6tc7Yg6zFjvlxfYKHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475393;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=COtLWNA/6jmhBo0z5yMAfo9QrtLgCVfE5IORaIf3+y0=;
	b=y7xtHyxdZ8Qdyh1c1eMXQ2K0/VhXORKdl16AJ/QUNdVO3YH6PYINcRiXXHiSTcMJefRQ
	 DTWJJLMgi5uczfIilWjvNwvKANBKpSPn1HrIEHmjtmpcfh3DUgPcS69JiwwCW9Am1GhPO
	 ORIAzHoZe0rIlfxB2j4jdE2Ywc0t7q9y80DXTsZf3l0EQVlcDQp8i1b6bnC3ArU0sq7xm
	 8ZEaEtAd4upBHvDAJI2e7wNY4co0KioWhE6FaPd8bHA9/7yAPtzR0P07WCPoLPcx5KSth
	 A61pbzxVxJTFYHauEwlQuZDRPsDRrGyswXV2ukW0/lhhQhWmFBKn/g2NOrl7ktjz9Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lk4fh6uh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713B3606A31C
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lk4fh6uh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ABF1F00A06;
	Thu, 12 Nov 2026 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794475393;
	bh=COtLWNA/6jmhBo0z5yMAfo9QrtLgCVfE5IORaIf3+y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lk4fh6uhvdQFKXLCzlATpBN3Z7PdfBoxwcNAdDbfcX1qP/wElnNrdjWUZD48uAeyb
	 PjVMHIs4sK62MoAvAI2wCoqHqu2Vu+GT95E6j8c+oMVVF6H7DLtby7fWvEcyeBOBTA
	 6f7sTCixJv60UN2HYBXcao3yokBrl6yPVJgAZ9JV0559s+ShUeWqOxHln3Hik44V/I
	 Vmes/612GaBJ9dMFCSU5okPkUc+9pcbWWSK8ZnLw4/rlSwcMyjGojguStEAkr73aUA
	 dFmyUa0tdm3HKAyF0LGo22Jy22nLTGiEsoEvlsXyC2PbiRvG1jQfJneKiY6SwS+zf6
	 ZKmQkzFwk+lEA==
Message-ID: <sashiko-outbox-210869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] [RFC] instrumented.h: mark instrument_write non-const
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Marco Elver" <elver@google.com>, "Alexander
 Potapenko" <glider@google.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Andrey
 Konovalov" <andreyknvl@gmail.com>, "Dmitry Vyukov" <dvyukov@google.com>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Steffen Eiden" <seiden@linux.ibm.com>, "Aleksei
 Nikiforov" <aleksei.nikiforov@linux.ibm.com>, "Andreas Grapentin" <gra@linux.ibm.com>, "Finn
 Thain" <fthain@linux-m68k.org>, "Peter Zijlstra" <peterz@infradead.org>, "Anshuman
 Khandual" <anshuman.khandual@arm.com>, "David Hildenbrand" <david@kernel.org>, linux-s390@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
In-Reply-To: <20261111092231.2027735-1-arnd@kernel.org>
References: <20261111092231.2027735-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 09:23:11 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] kasan: instrument_read_write() hides uninitialized variables
  under KASAN
- [Low] instrumented.h: inaccurate Fixes tag and RFC question in commit
  message
--

commit e49ee4fd80c81d953b77b9f3cd5a327db833a726
Author: Arnd Bergmann <arnd@arndb.de>

> instrumented.h: mark instrument_write non-const
>
> I got another instance of a -Wmaybe-uninitialized in ntfs, as this is
> the only place that enables the warning:
>
> In file included from include/asm-generic/rwonce.h:26,
>                  from fs/ntfs3/file.c:10:
> In function 'instrument_copy_from_user_before',
>     inlined from '_inline_copy_from_user' at include/linux/uaccess.h:184:=
2,
>     inlined from 'copy_from_user' at include/linux/uaccess.h:222:9,
>     inlined from 'ntfs_ioctl_fitrim' at fs/ntfs3/file.c:78:6,
>     inlined from 'ntfs_ioctl' at fs/ntfs3/file.c:246:10:
> include/linux/kasan-checks.h:38:27: error: 'range' may be used uninitiali=
zed [-Werror=3Dmaybe-uninitialized]
>    38 | #define kasan_check_write __kasan_check_write
> include/linux/instrumented.h:146:9: note: in expansion of macro 'kasan_ch=
eck_write'
>   146 |         kasan_check_write(to, n);
>       |         ^~~~~~~~~~~~~~~~~
> include/linux/kasan-checks.h: In function 'ntfs_ioctl':
> include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const vol=
atile void *' to '__kasan_check_write' declared here
>    20 | bool __kasan_check_write(const volatile void *p, unsigned int siz=
e);
>       |      ^~~~~~~~~~~~~~~~~~~
> fs/ntfs3/file.c:66:29: note: 'range' declared here
>    66 |         struct fstrim_range range;
>       |                             ^~~~~
>
> The problem here is that copy_from_user() is called on an uninitialized
> object, but the instrumentation passes the pointer into a function that
> takes a const object. gcc deduces that any access to that object is
> undefined behavior and warns about it.
>
> The only workaround I could come up with is to remove the 'const' keyword
> from these annotations, which of course is not great either, as the
> functions do not actually access the data at all.
>
> This also found incorrect 'const' annotations in
> arch/s390/include/asm/fpu-insn.h, which writes to those pointers.
>
> Any ideas?
>
> Fixes: 33b75c1d884e ("instrumented.h: allow instrumenting both sides of c=
opy_from_user()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[Severity: Low]
33b75c1d884e ("instrumented.h: allow instrumenting both sides of
copy_from_user()") only renamed instrument_copy_from_user() to
instrument_copy_from_user_before().  The const void *to parameter calling
kasan_check_write(to, n) was introduced in 36e4d4dd4fc4 ("include/linux: Add
instrumented.h infrastructure"), and __kasan_check_write(const volatile void
*p, ...) was introduced in 7d8ad890dad0 ("mm/kasan: introduce
__kasan_check_{read,write}").  Also, the "Any ideas?" question from the RFC=
 is
still in the commit message.

> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> index a1b4cf81adc2a..d28aa6b0aeb8c 100644
> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -36,7 +36,7 @@ static __always_inline void instrument_read(const volat=
ile void *v, size_t size)
>   * Instrument a regular write access. The instrumentation should be inse=
rted
>   * before the actual write happens.
>   */
> -static __always_inline void instrument_write(const volatile void *v, siz=
e_t size)
> +static __always_inline void instrument_write(volatile void *v, size_t si=
ze)
>  {
>  	kasan_check_write(v, size);
>  	kcsan_check_write(v, size);
> @@ -50,7 +50,7 @@ static __always_inline void instrument_write(const vola=
tile void *v, size_t size
>   * Instrument a regular write access. The instrumentation should be inse=
rted
>   * before the actual write happens.
>   */
> -static __always_inline void instrument_read_write(const volatile void *v=
, size_t size)
> +static __always_inline void instrument_read_write(volatile void *v, size=
_t size)
>  {
>  	kasan_check_write(v, size);
>  	kcsan_check_read_write(v, size);
> @@ -92,7 +92,7 @@ static __always_inline void instrument_atomic_read(cons=
t volatile void *v, size_
>   * Instrument an atomic write access. The instrumentation should be inse=
rted
>   * before the actual write happens.
>   */
> -static __always_inline void instrument_atomic_write(const volatile void =
*v, size_t size)
> +static __always_inline void instrument_atomic_write(volatile void *v, si=
ze_t size)
>  {
>  	kasan_check_write(v, size);
>  	kcsan_check_atomic_write(v, size);
> @@ -107,7 +107,7 @@ static __always_inline void instrument_atomic_write(c=
onst volatile void *v, size
>   * Instrument an atomic read-write access. The instrumentation should be
>   * inserted before the actual write happens.
>   */
> -static __always_inline void instrument_atomic_read_write(const volatile =
void *v, size_t size)
> +static __always_inline void instrument_atomic_read_write(volatile void *=
v, size_t size)
>  {
>  	kasan_check_write(v, size);
>  	kcsan_check_atomic_read_write(v, size);

[ ... ]

> diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
> index 3d6d22a25bdc3..90b878b876f5c 100644
> --- a/include/linux/kasan-checks.h
> +++ b/include/linux/kasan-checks.h
> @@ -17,13 +17,13 @@
>   */
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  bool __kasan_check_read(const volatile void *p, unsigned int size);
> -bool __kasan_check_write(const volatile void *p, unsigned int size);
> +bool __kasan_check_write(volatile void *p, unsigned int size);

[Severity: Low]
Does removing const from __kasan_check_write() suppress legitimate
-Wuninitialized and -Wmaybe-uninitialized warnings for callers of
instrument_read_write() and instrument_atomic_read_write() when KASAN is
enabled?

When a local variable's address is passed to an external function taking a
non-const pointer, GCC assumes the call may initialize the object.  Because
instrument_read_write() and instrument_atomic_read_write() call
kasan_check_write(v, size) before kcsan_check_read_write(v, size) and before
the caller's read-modify-write operation (such as oldp in try_cmpxchg()),
uninitialized read-modify-write operands will be treated as initialized by
__kasan_check_write().

07a1a6562ce2 ("kcsan: Silence -Wmaybe-uninitialized when calling
__kcsan_check_access()") avoided the same fs/ntfs3/file.c warning for KCSAN=
 by
keeping const volatile void * on the external function and wrapping the
pointer in absolute_pointer() only in the write-only macros while leaving
read-write checks unwrapped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111092231.2027=
735-1-arnd@kernel.org?part=3D1
