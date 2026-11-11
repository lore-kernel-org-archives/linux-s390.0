Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794391231;
	b=hKQTkOecjDAHtWDM97Fwo2xYhgsUNz44UGLiJePwCkHuW3ylmQzcEf+u7IozwTUewWdz
	 5Qk8UAnvoHu4RKsrz3PiVqVFKnMCs5BMWllcAGjG/l/cejMdqSr7n7o7Mfv0oRYIf0OOg
	 +HWw6kgPl9WWtYkMLHbMzq3J7yxwnxFeSyVk4hsZVeg/1NeSVVfWW7txwrJB4kBdiX2p5
	 jgmny7harlbvJNG50lOHkYyAhEW5FE5nyAVvBf+am8hofrNlwnWhbA/DEzxUxZOwooZW1
	 VE5L+bUTlPOoVNK/Xd8p9ilR+/X2bTq0f5Z+wYmFbhxFVhpbvmU046Vnk4Aii8k+E0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=0snpShHvjoBSXjJ0hmmIC0sdwMSEV+1aJlZlq/yq2c4=;
	b=qJp9ex+H9XPqpKuRo6Nj7JZaDUlefjAVq/TWEcfyIql0EJuTzDvSSaI43umYuYFdikHQ
	 qiTP+rhGY4W+su98JDA94VMFe4lyHPandbR+wWjzxQaS6tLzt7NTDiqfjyM/RKgykRDNp
	 9dVb9nHSDMOjeaMOdUsqff4eYKUENQj7pQax1aTiVyKFGzmf3EldPlqZf2cHFItEq+FO0
	 okjwwGx1b9SsjIzMx2uwbtdZYfQ2CNYyu/E/b7I29tdLHn2Qwn5OSH1ZLh/hrJ0uaAmhh
	 9LYBpdROXMwW9kcwOLjv9MiyBGA5mCBOx1pPggds+VywzTCV6wc84/8mxsM7a2ziDOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EZxd9Jl0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFA4606A332
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 10:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CFA4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EZxd9Jl0
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67be7b9abc8so2628542d50.0
        for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 02:00:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794391230; cv=none;
        d=google.com; s=arc-20260327;
        b=lzzHD32rdbhBTeUHecEx/iq9VU4cwmR8YTgWCZnUqI4OWEkLiKu07Qe+bJyuw7xZFK
         XZnmAQlDTWfWjaI4ctmnyeV5zuyWdAaZF9pLqARo3rROda1SPnFjq0CULolZqD1IPgju
         LEm1ViFgWfvw/AbQ1xNBScANwkX4DeJHMZnnHJ5/NQf3H++y0Oj1paRxGzDalrtGN2Qk
         Mz+f7mqbA0KBIZ+xzPNcgWJGMe6tfQHTh+Rh8axrpmCNOfFYH2egbxOUYVcVsQjdKTrD
         spc92zUA2+HARWk2e8M/Qq/F2Ee0oklVHs0xRImrhky3XOKx2ioi5n40/JEtpSU82fQV
         5MmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0snpShHvjoBSXjJ0hmmIC0sdwMSEV+1aJlZlq/yq2c4=;
        fh=IoDmT7zh1AUTlLwlmeTy3/v0SRI1QhFZdTpiFr3ojSA=;
        b=PSl9KA7ORh/DegCLR6prsnAC6MhHFrues6KrO7gcoqE02g8dyypYG7xuB6BfKhDSa1
         +Cg68y4XiEDUYCPsXHD/qf+ElY5nu/rtV2fLHkbKG5v5a3hnCnuXXtDMpwpKDZlljyoa
         AtKhk8MwAm5PY7LxiSua+7/cKBZdCqxZw60b+PhLE7H4mwBWS4+R3fisRPGPjZ6tXZum
         15HZrszhgg9Axdzci3Cn3au4WUMJ0MK+U0MQv5bW39QOpdQDAcZLOg0ixaiAs4KiFWyD
         tZHEDMbQLHumJIZMM8+IDJI7FOkbI2SRtrM/nSaxMQ+kWUEgIglXz3o1H5SkOmA+qQXW
         ODEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794391230; x=1794996030; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0snpShHvjoBSXjJ0hmmIC0sdwMSEV+1aJlZlq/yq2c4=;
        b=EZxd9Jl091oE3DJRikNmKAw2F6sX+5bNmT9eX6X8j6BAbM4wmEoWjXqkmsr2jl9lnL
         Zeh0w1WKLVCC5eov/G0u3dzMI/RoFoOwV49j21zQkTGLoxg0wO/bsi62+699Yg7pWa1T
         5sg6vFUkYWAggIRdZfuNuM7iNP98H4gaigwtNSR3U512FacQENKhMJD8HUP2lM2WeAQ7
         dl18CL+hkIqvgCyRp1jt53TpY9ihb7HmTPECA9SlySjQOh0FNNqDvIDnzjTeWmub9C5A
         rehHTCdZv3bkhFLTLs1vbOnXcpvUbAh+WfWwphblEPrZXmHBBXpYC87NbcJMNxpdxlbO
         +bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794391230; x=1794996030;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0snpShHvjoBSXjJ0hmmIC0sdwMSEV+1aJlZlq/yq2c4=;
        b=VJIYRVmH71NIBgLIrpaJkFbjqPOxZF1UoUoIxVYSY9VwGysNtYRCXmMIf/H1oRc4tW
         nWfYNPUP3OpbkKh7Dzi5uLPcNBMLAEBRJYDpsvPB2jiDS4F3q+N+UGhGPXKRoFYnWT8r
         M9o7uoA0P1PI49hzH7ga8gOc9McvKUIVGn+fbtuAX1YS24u8p7EZt8j2xVWQK6YU2iTc
         1JCUxNwXD0ZNHssinPgjFcjDU4YW21lTSDmpGHDfrCoAZ0ie4jTpqS4ojRXqpuejqMl3
         acnZtKmcUPacStqNAkOBZECIjz3bR0L+yae/n07aKAUeb2CABFvxMLvmknKUWo2zlhCE
         156A==
X-Forwarded-Encrypted: i=1; AL+hErF+Cm1xij/bzA0CdwQULMj2xgdFNLl2IwojuVWbnpN8DKT2+O9YX334/JyaGWvdUN2NaT0E0lMHBhXB@vger.kernel.org
X-Gm-Message-State: APuU4Z+h/uZFqmyzrIBLDwP4PwXWfR9U7RgcuOI8mqaH0kGHPgBJG5wr
	u6tMnRB1xeWMlEP/Cw64J6FHXcEv4CkOss8j0Mn46JHi3NN6A88CKB+uBdSHc9Kfpk2QGQHcL4H
	T2FC2F0D3imR5IovRdHA0dzk5zykRvLiHitNgMoCe
X-Gm-Gg: AYBFou0V0kFZ25894cjAiW8ARDXHTBmyRmnKFt/azugrPLtpw9PaLce7fiCDzg/QvK4
	/JBDsaRq9Wa+SR8G3LFOVI/3Ant6nv6skiFE1AonBHWPtFETMiOSHF8M+JtFMS1383vqziPQZG7
	M+J0pJVqSO6uoDlcfMRA8jyc8EUND7K9pmNHlMhLExvBAWv+YHbFR3e51Jw/Zj4IuzzSjFYNo3J
	cQkfL6lQE9JnU14Sxsh7ZmUWekzam6d5mtWrSLCw2zYiaXES5Wo9bOLvC+Gik/McjY4e5SMr6h8
	KZrDn+2UZt4CbV5VHrN/J+lUODlPY+o1tijsumxOMKBiOHjj/hqoduWLAT111Qf9QYYAlUbyJLd
	PhnHO9cDxMrvoH4jZtPUZoh/fB/mbJsSa+e0LdKhBfVpyzxM2bOsSiE/EuwKgi2wnb4ms2l5tc8
	3IOwuksofIyjIpYg==
X-Received: by 2002:a05:690e:439b:b0:67c:2fdb:9419 with SMTP id
 956f58d0204a3-67c67f97140mr1094112d50.57.1794391229421; Wed, 11 Nov 2026
 02:00:29 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111092231.2027735-1-arnd@kernel.org>
In-Reply-To: <20261111092231.2027735-1-arnd@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 11 Nov 2026 10:59:51 +0100
X-Gm-Features: AclHuK_qP5L8F_RmiE0XH87_imZfKgz52BAPUVzydYBM3OwPM4hCNb5eu8txhc4
Message-ID: <CANpmjNP5p-N6v=GiETYQMxgRMsOgKOdUjDCxSHj-6=pa4NkA8w@mail.gmail.com>
Subject: Re: [PATCH] [RFC] instrumented.h: mark instrument_write non-const
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>, Andreas Grapentin <gra@linux.ibm.com>, 
	Finn Thain <fthain@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 10:22, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> I got another instance of a -Wmaybe-uninitialized in ntfs, as this is
> the only place that enables the warning:
>
> In file included from include/asm-generic/rwonce.h:26,
>                  from fs/ntfs3/file.c:10:
> In function 'instrument_copy_from_user_before',
>     inlined from '_inline_copy_from_user' at include/linux/uaccess.h:184:2,
>     inlined from 'copy_from_user' at include/linux/uaccess.h:222:9,
>     inlined from 'ntfs_ioctl_fitrim' at fs/ntfs3/file.c:78:6,
>     inlined from 'ntfs_ioctl' at fs/ntfs3/file.c:246:10:
> include/linux/kasan-checks.h:38:27: error: 'range' may be used uninitialized [-Werror=maybe-uninitialized]
>    38 | #define kasan_check_write __kasan_check_write
> include/linux/instrumented.h:146:9: note: in expansion of macro 'kasan_check_write'
>   146 |         kasan_check_write(to, n);
>       |         ^~~~~~~~~~~~~~~~~
> include/linux/kasan-checks.h: In function 'ntfs_ioctl':
> include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
>    20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
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

Agree, but the code where a real 'write' happens ought to never pass
in a const-qualified variable or pointer anyway, so I think it's fine.

> This also found incorrect 'const' annotations in
> arch/s390/include/asm/fpu-insn.h, which writes to those pointers.

That looks like a bug. Maybe split it into a separate patch.

> Any ideas?
>
> Fixes: 33b75c1d884e ("instrumented.h: allow instrumenting both sides of copy_from_user()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

If there are no warnings that appear because of this elsewhere, then:

Acked-by: Marco Elver <elver@google.com>

> ---
>  arch/s390/include/asm/fpu-insn.h |  8 ++++----
>  include/linux/instrumented.h     | 10 +++++-----
>  include/linux/kasan-checks.h     |  6 +++---
>  mm/kasan/shadow.c                |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
> index aaf1faeb3dc5..7cd6e9f30485 100644
> --- a/arch/s390/include/asm/fpu-insn.h
> +++ b/arch/s390/include/asm/fpu-insn.h
> @@ -359,7 +359,7 @@ static __always_inline void fpu_vsrlb(u8 v1, u8 v2, u8 v3)
>
>  #ifdef CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS
>
> -static __always_inline void fpu_vst(u8 v1, const void *vxr)
> +static __always_inline void fpu_vst(u8 v1, void *vxr)
>  {
>         instrument_write(vxr, sizeof(__vector128));
>         asm volatile("VST       %[v1],%O[vxr],,%R[vxr]"
> @@ -370,7 +370,7 @@ static __always_inline void fpu_vst(u8 v1, const void *vxr)
>
>  #else /* CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
>
> -static __always_inline void fpu_vst(u8 v1, const void *vxr)
> +static __always_inline void fpu_vst(u8 v1, void *vxr)
>  {
>         instrument_write(vxr, sizeof(__vector128));
>         asm volatile(
> @@ -385,7 +385,7 @@ static __always_inline void fpu_vst(u8 v1, const void *vxr)
>
>  #ifdef CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS
>
> -static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
> +static __always_inline void fpu_vstl(u8 v1, u32 index, void *vxr)
>  {
>         unsigned int size;
>
> @@ -400,7 +400,7 @@ static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
>
>  #else /* CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
>
> -static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
> +static __always_inline void fpu_vstl(u8 v1, u32 index, void *vxr)
>  {
>         unsigned int size;
>
> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> index a1b4cf81adc2..d28aa6b0aeb8 100644
> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -36,7 +36,7 @@ static __always_inline void instrument_read(const volatile void *v, size_t size)
>   * Instrument a regular write access. The instrumentation should be inserted
>   * before the actual write happens.
>   */
> -static __always_inline void instrument_write(const volatile void *v, size_t size)
> +static __always_inline void instrument_write(volatile void *v, size_t size)
>  {
>         kasan_check_write(v, size);
>         kcsan_check_write(v, size);
> @@ -50,7 +50,7 @@ static __always_inline void instrument_write(const volatile void *v, size_t size
>   * Instrument a regular write access. The instrumentation should be inserted
>   * before the actual write happens.
>   */
> -static __always_inline void instrument_read_write(const volatile void *v, size_t size)
> +static __always_inline void instrument_read_write(volatile void *v, size_t size)
>  {
>         kasan_check_write(v, size);
>         kcsan_check_read_write(v, size);
> @@ -92,7 +92,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
>   * Instrument an atomic write access. The instrumentation should be inserted
>   * before the actual write happens.
>   */
> -static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
> +static __always_inline void instrument_atomic_write(volatile void *v, size_t size)
>  {
>         kasan_check_write(v, size);
>         kcsan_check_atomic_write(v, size);
> @@ -107,7 +107,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
>   * Instrument an atomic read-write access. The instrumentation should be
>   * inserted before the actual write happens.
>   */
> -static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
> +static __always_inline void instrument_atomic_read_write(volatile void *v, size_t size)
>  {
>         kasan_check_write(v, size);
>         kcsan_check_atomic_read_write(v, size);
> @@ -141,7 +141,7 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
>   * variants). The instrumentation should be inserted before the accesses.
>   */
>  static __always_inline void
> -instrument_copy_from_user_before(const void *to, const void __user *from, unsigned long n)
> +instrument_copy_from_user_before(void *to, const void __user *from, unsigned long n)
>  {
>         kasan_check_write(to, n);
>         kcsan_check_write(to, n);
> diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
> index 3d6d22a25bdc..90b878b876f5 100644
> --- a/include/linux/kasan-checks.h
> +++ b/include/linux/kasan-checks.h
> @@ -17,13 +17,13 @@
>   */
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  bool __kasan_check_read(const volatile void *p, unsigned int size);
> -bool __kasan_check_write(const volatile void *p, unsigned int size);
> +bool __kasan_check_write(volatile void *p, unsigned int size);
>  #else
>  static inline bool __kasan_check_read(const volatile void *p, unsigned int size)
>  {
>         return true;
>  }
> -static inline bool __kasan_check_write(const volatile void *p, unsigned int size)
> +static inline bool __kasan_check_write(volatile void *p, unsigned int size)
>  {
>         return true;
>  }
> @@ -41,7 +41,7 @@ static inline bool kasan_check_read(const volatile void *p, unsigned int size)
>  {
>         return true;
>  }
> -static inline bool kasan_check_write(const volatile void *p, unsigned int size)
> +static inline bool kasan_check_write(volatile void *p, unsigned int size)
>  {
>         return true;
>  }
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index d286e0a04543..591c179164af 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -32,7 +32,7 @@ bool __kasan_check_read(const volatile void *p, unsigned int size)
>  }
>  EXPORT_SYMBOL(__kasan_check_read);
>
> -bool __kasan_check_write(const volatile void *p, unsigned int size)
> +bool __kasan_check_write(volatile void *p, unsigned int size)
>  {
>         return kasan_check_range((void *)p, size, true, _RET_IP_);
>  }
> --
> 2.53.0
>
