Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567CD3E833E
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004710; cv=pass; b=rS40aywztwnA3UF0bq/AP5DdU7MdNwi6Cr+5Ki1ha8vl8WW7S8rcyirZ4INCeFXDkdyBktA35p6diJ9pVI7HH59m/i2WwXkg00KA5Ny40vG5qrPNRaBRiRbM6Y/veUtviiexSD74fI2CFmfUGtZdq7+4SUUHfSgGoLBets8VcW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004710; c=relaxed/simple;
	bh=JuqRk2XlPGw6lxDyvK2jCFY+Vi0UuVT6u0VrH8mtBjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjSOEinQ9xDQzzvQ1NkYcwhbpW+Bd2zITD/KocjCGkKg/bSt3DsHIH/7K+d3eTDb7jT2vNdJW4xW9+9Dtt9ZfZmIeFQ4v54n1PJNAIq1Yz85Z/8LVOnGdl9Mg6pZMqi/H7Yrqrao20HgtxVQknDksT0KrNh6ra+b47wQm9dRZec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acp5qJdP; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acp5qJdP"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so3982008f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 15:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787004706; cv=none;
        d=google.com; s=arc-20260327;
        b=Xq1BFNaFVwA4c2fPkSoKppIjw2kAoQVq1YLRGxvIHmDO7GJ2jEWgrsNjisejbDwz8I
         Ceo38z09FbcaoE3VbPUR88vHsltyeKUWNS97zzMfKWIiNt/NsiVOMUIUD7gqt6hvjyQ5
         14IdvU16vcYIC8nkZlv28Hh4O1tWayT5yuiolDHnPvpXXOSIdPJn3fswMlN8aTR9rKU4
         oqfIGLQlLsizrL/w4ymAkjVpDbk0PuvJIhTDc/r5PygBohuoHBQ5/WR5bL+yqAqukac4
         +b8CGPdYqv7kbwaAC3G2KUDbCZYI1o/6FBfxkANY/pBLwSKqw0DinJa221nuSQ89J1n5
         HBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MuUlcuNt+uC+rzkXIVye+jGcsTwTkO/x89Y77r9f6y4=;
        fh=a8qsJ4/+N1Zs1f3FKXhGYoPmgQp5CtmsWN2c0LOSMx0=;
        b=Wx5YIZzd8n5S+CQctUSMuCOFicXb7YeJFvjFb/2gKxqoRR8PFhlpI7QRploN9/Sk4Q
         S9RBOsBNn4pBM4h/t97ZlXySIS+iFNLT2RxSgrwsKH1qViynr9ZNQAtucUyk4885pvb8
         Yke3KRHvREx2QWnDVw8NprIZMVPxcZRFJyIgVf81mykPWzDug2N/IMO92AZzNgsQcWsc
         q3MIstvFz/7HUTGw0OA8+ynXwOhC9bj5a0zHX+ID7QGEOim+WnCtGzWWXLUKbbAuL2pY
         GbR46U0m75VKIAGG+TDcUQyJRlWUi8bDNimmIAZ5n1nKoJYb5wR2OokRX2BFwTGQhcrS
         1Vtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787004706; x=1787609506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MuUlcuNt+uC+rzkXIVye+jGcsTwTkO/x89Y77r9f6y4=;
        b=acp5qJdPLxfQw0fGR6vrJB5qTe1crZ/PhOMuUKOfbQILgFp3b02RC8NY7eKExWhwlW
         b8Q8ZrHP/O/qBtOTxCg3OxjzljUN5peTdkS2VdpFaYKTPc+3m62og/9M+XBCDdSYfkJ5
         DOanS5cMwfGaoriVSMH1V2ur9DiBPKdnkWhURMDV6NtRWjTD+zZQAGiKWX8BAPY0wCyc
         w+P6ytHzpy/+Vq+/gvcXpU8+BrFlriNxuFMCWwmT3dpXcHC6TeLexcdmN8W1+y/I4eLR
         cdfYFWE6Vr6en8Yq60rK84Ju8mRTu3VNS+qF22aZD+VyhfwcEYp4qW1RQYruCTu8bR9h
         jpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787004706; x=1787609506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MuUlcuNt+uC+rzkXIVye+jGcsTwTkO/x89Y77r9f6y4=;
        b=Wd97KZKdSO5v2ghiv1sAuGUm8IDMqgajwXr911pTtcMfYTkpTPXG0oFNAZM2s7aYnx
         I2mBKhQ0eEmao+7ZeFkLeE9FPNF0MaVo/lA0lBdWux87kmZAP+4zNdWAdhjcEKlvyi72
         C5dmWH+Cybg9Dc63oWIHER6gP4//p8sVHP9fxZLf7RD6SjFBoJmYZ58n9rHveBGwSwDu
         3uTR4xAUf84m/Xorcnxy5dTD4JaTtryezxqxY9tA6Lf8wZrbU8c1Wbw/zdNRQF/NlWPl
         OjuQn46ZGPcCrqkQznNiJ9TEtKjMrRCYC1g4H48/TKueuecgGvegJNHM0BYfkOA9BLmp
         aafg==
X-Forwarded-Encrypted: i=1; AHgh+Rpg3ZPLfReajXXTDBBXv1SIoHQmxpQiHuPwx6Zbz7YTFAIcfqjWveh2zLfB7bZk+19ewd6Ic0/xSSRU@vger.kernel.org
X-Gm-Message-State: AOJu0YydmyDiT2FLTsanD5DM3FCo61R7yndcGJBb9I6J8/J7aWnx+koz
	B5o94evgT8qMusb2TtBdDsE0QbYOJVhXn015mUXGMx8zFbp+yHMsSyr7Gj0jX0MyIUfDou+kGGg
	8huOfH/lPdWArVxXU+T+d9EgZrgshSF0=
X-Gm-Gg: AR+sD10XeIUHERrSq/bzV8s3YTe78ZN1OsjCwIf+ZS/1ixIKSWax4Xj8VeLZmCFHZHL
	OSrqd3jqB1UcM4TkzN/+AhcbeMnk/LVMRrO8IurwWdHnTyO7aYFqn143nMR55R4jbsH7fAYUVu7
	UpZHU2xzF6HUDGmEB+jwq0q4ZVDwWG3F/iCeSLtZDGbt00emraiBBpqCswXJOPUU+v19KRFJSFb
	awTa8lSWH9GBMQw34TgX2jAfO+7qcVg76JlJezo/pyNEFXJx9Jzz+WRp1xc4Q/NnkjreKOGfKLL
	dBxiRyRK+Uog1pc3zHS2AowzxU4kWALDlfhKHnP8KSTdMa4VkNcggSPvhIi54r1JENfkL7bNbT9
	NTgU=
X-Received: by 2002:a05:6000:230f:b0:47f:f1ab:9075 with SMTP id
 ffacd0b85a97d-4816074ccd8mr39569778f8f.20.1787004706313; Mon, 17 Aug 2026
 15:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786956464.git.agordeev@linux.ibm.com> <52c9be0cf71a8896a5d76c148c38fb24a2005dd9.1786956464.git.agordeev@linux.ibm.com>
In-Reply-To: <52c9be0cf71a8896a5d76c148c38fb24a2005dd9.1786956464.git.agordeev@linux.ibm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 18 Aug 2026 00:11:34 +0200
X-Gm-Features: AcwNN1UPAiqWXSnHKbEWgYvXv-PgfhXyzAJo9d_a04N2AaWGsS3uQiqqfo9-6Eo
Message-ID: <CA+fCnZfMkPDVyy0t9W-3d55M2ba9wXoRyzj2EWWYLEW=QO3zWg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] mm/kasan: Introduce helpers for lazy MMU mode sanitizer
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 1:33=E2=80=AFPM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> Provide helpers that allow architectures implement
> illegitimate PTE direct accesses while the lazy MMU
> mode is enabled, such as:
>
>         pte_t pte =3D *ptep;
>         *ptep =3D pte;
>
> By contrast, these would have to be:
>
>         pte_t pte =3D ptep_get(ptep);
>         set_pte(ptep, pte);
>
> The direct PTE accesses pose a real issue on s390.
>
> Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  include/linux/kasan.h     | 19 +++++++++++++++++--
>  mm/kasan/common.c         | 14 ++++++++++++++
>  mm/kasan/kasan.h          |  2 ++
>  mm/kasan/report_generic.c |  3 +++
>  4 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index bf233bde68c7..1aa4d9dd2485 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -6,6 +6,7 @@
>  #include <linux/kasan-enabled.h>
>  #include <linux/kasan-tags.h>
>  #include <linux/kernel.h>
> +#include <linux/pgtable.h>
>  #include <linux/static_key.h>
>  #include <linux/types.h>
>
> @@ -35,8 +36,6 @@ typedef unsigned int __bitwise kasan_vmalloc_flags_t;
>
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>
> -#include <linux/pgtable.h>
> -
>  /* Software KASAN implementations use shadow memory. */
>
>  #ifdef CONFIG_KASAN_SW_TAGS
> @@ -134,6 +133,20 @@ static __always_inline void kasan_poison_slab(struct=
 slab *slab)
>                 __kasan_poison_slab(slab);
>  }
>
> +void __kasan_poison_pte(pte_t *pte, int nr);
> +static __always_inline void kasan_poison_pte(pte_t *pte, int nr)
> +{
> +       if (kasan_enabled())
> +               __kasan_poison_pte(pte, nr);
> +}
> +
> +void __kasan_unpoison_pte(pte_t *pte, int nr);
> +static __always_inline void kasan_unpoison_pte(pte_t *pte, int nr)
> +{
> +       if (kasan_enabled())
> +               __kasan_unpoison_pte(pte, nr);
> +}
> +
>  void __kasan_unpoison_new_object(struct kmem_cache *cache, void *object)=
;
>  /**
>   * kasan_unpoison_new_object - Temporarily unpoison a new slab object.
> @@ -414,6 +427,8 @@ static inline bool kasan_unpoison_pages(struct page *=
page, unsigned int order,
>         return false;
>  }
>  static inline void kasan_poison_slab(struct slab *slab) {}
> +static inline void kasan_poison_pte(pte_t *pte, int nr) {}
> +static inline void kasan_unpoison_pte(pte_t *pte, int nr) {}
>  static inline void kasan_unpoison_new_object(struct kmem_cache *cache,
>                                         void *object) {}
>  static inline void kasan_poison_new_object(struct kmem_cache *cache,
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index b7d05c2a6d93..94d106094989 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -163,6 +163,20 @@ void __kasan_poison_slab(struct slab *slab)
>                      KASAN_SLAB_REDZONE, false);
>  }
>
> +void __kasan_poison_pte(pte_t *pte, int nr)
> +{
> +       if (IS_ALIGNED(sizeof(*pte), KASAN_GRANULE_SIZE))
> +               kasan_poison(pte, sizeof(*pte) * nr, KASAN_LAZY_MMU_PTE, =
false);
> +}
> +EXPORT_SYMBOL_GPL(__kasan_poison_pte);
> +
> +void __kasan_unpoison_pte(pte_t *pte, int nr)
> +{
> +       if (IS_ALIGNED(sizeof(*pte), KASAN_GRANULE_SIZE))
> +               kasan_unpoison(pte, sizeof(*pte) * nr, false);
> +}
> +EXPORT_SYMBOL_GPL(__kasan_unpoison_pte);
> +
>  void __kasan_unpoison_new_object(struct kmem_cache *cache, void *object)
>  {
>         kasan_unpoison(object, cache->object_size, false);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index fc9169a54766..1a2d18cdb21d 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -144,12 +144,14 @@ static inline bool kasan_requires_meta(void)
>  #define KASAN_PAGE_REDZONE     0xFE  /* redzone for kmalloc_large alloca=
tion */
>  #define KASAN_SLAB_REDZONE     0xFC  /* redzone for slab object */
>  #define KASAN_SLAB_FREE                0xFB  /* freed slab object */
> +#define KASAN_LAZY_MMU_PTE     0xFD  /* direct pte access in lazy mmu mo=
de */
>  #define KASAN_VMALLOC_INVALID  0xF8  /* inaccessible space in vmap area =
*/
>  #else
>  #define KASAN_PAGE_FREE                KASAN_TAG_INVALID
>  #define KASAN_PAGE_REDZONE     KASAN_TAG_INVALID
>  #define KASAN_SLAB_REDZONE     KASAN_TAG_INVALID
>  #define KASAN_SLAB_FREE                KASAN_TAG_INVALID
> +#define KASAN_LAZY_MMU_PTE     KASAN_TAG_INVALID
>  #define KASAN_VMALLOC_INVALID  KASAN_TAG_INVALID /* only used for SW_TAG=
S */
>  #endif
>
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index f5b8e37b3805..489d4a8d6902 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -113,6 +113,9 @@ static const char *get_shadow_bug_type(struct kasan_r=
eport_info *info)
>         case KASAN_SLAB_FREE_META:
>                 bug_type =3D "slab-use-after-free";
>                 break;
> +       case KASAN_LAZY_MMU_PTE:
> +               bug_type =3D "lazy-mmu-pte-access";
> +               break;
>         case KASAN_ALLOCA_LEFT:
>         case KASAN_ALLOCA_RIGHT:
>                 bug_type =3D "alloca-out-of-bounds";
> --
> 2.53.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev=
/52c9be0cf71a8896a5d76c148c38fb24a2005dd9.1786956464.git.agordeev%40linux.i=
bm.com.

Hi Alexander,

Should all this be limited to only s390?

Thanks!
