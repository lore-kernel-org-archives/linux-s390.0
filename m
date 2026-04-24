Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15408203710
	for <linux-s390@vger.kernel.org>; Fri, 24 Apr 2026 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777015019; cv=pass; b=qrbauYiwGIerxOrKKwU52mf75JKCfNNH/jYQxXz2ou4IkqJYCJYm6AqW3542wNm5/inzxzzsm4y9eSrr/phwYUnCuYDWvGX1OBOSsgM4jwMXQk3jxZZV1ZP/ElzuQEax6h/lNcGz0sl6YwXXi/bTOiRzrvyx/A+YVIP6n4Rwt/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777015019; c=relaxed/simple;
	bh=W+ssi1VXndSbA3jTir7s/4LRoYtNUVNtJuZsueaDSGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOpCsgeVxlc5YzY2DHlaI3h/fRhwRKkQ6khl9QsisH4zcgtq6b/XhQQBuPyt3UNruyxdDNpLV2RTHazuTg0E10ArYU1Hd+1REctRe59vzt5GEDMb9qZrL9MYl2CP6eFhEJw3VGL1wAeIhay2ImV8wt1oeybTXO0QbuwLW0MDcPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii/v758E; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii/v758E"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67893fba9c3so2357671a12.2
        for <linux-s390@vger.kernel.org>; Fri, 24 Apr 2026 00:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777015016; cv=none;
        d=google.com; s=arc-20240605;
        b=Dc/mylDkZzDQB1jDH2I8w3xpK9J8BRPHiPKT7IqX8YGpTni5925NudipKXAbhwdzso
         XmlRQ84ZeINQtpVyPGlDu8MNzWG3ti6r7yM1DsiCX+0QdOgrnvHugeu21FtThZFACJQm
         GggzzMaZeXykm4zIgJ1PiatWvPbkq5IPB31jsjubR0jlYrnUvJtrnFoJAGo8oLa1uShu
         HtTnNKwGkZ367oy82J2DhaTdcofmWaEKgPUQK5EQll9LOSvq3GMY0h6+09NfOjD0GuvN
         pm6H1SNd4m9w6HhpvlZqwu5ZmwOfVhG9BRbozr/QWQkUJa64fdZznHGUCB0aXWGHeYrd
         gslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8uv1ap7wfpWSK/rjkumTWgHiVOSnLQXCSFDMADgPR1Y=;
        fh=2YY3isReSougrUMRSF+ojyONKGIMMqpo+7QghDGGiEY=;
        b=VnCX8sT+putRMIYKjOu5R2Z0oROHu3sx9Dq6mh+5TnJYhgI42BEZwk6cw5DsfXQ/t7
         2gKBjOzrUFYPLAezGerl9RCh8gvwYka1Y2zFGUlSuT8grC4D1iMEtUcrOB66UCvzhT8S
         yhCYo2cuy0+9wM3pHJWAX+KzdjFgCqr2dm3TCuIruiB1S+iDovTK+MWjFEfHVeRRkAGy
         FAs6rH9jh/5A+KBJALm7OGWQARdA/DVJ+Cj2pq36dJT8XucmV1q2H2AkG/UDIKz7ETGK
         nGze1+OqlzVmsxCZNwYumxWijWK5wFHc3vLviYgkgXjGrabk6q+ULRwFJj+gslUiF0Qm
         48Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777015016; x=1777619816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uv1ap7wfpWSK/rjkumTWgHiVOSnLQXCSFDMADgPR1Y=;
        b=Ii/v758ESAPCph1vuePCXkFXQqx0DIewWiAP07QoulSKxGGgKcF7EQtj2F//bLSVrp
         Talx2NtuhA/ZUOBYlmrO8renTgK6nt+VJyOjno4TJHW4h9ly6b4bRXvr7ARjBID1riEr
         68MUQnetBgUwPdBwa6ZKbyOFeLUUzzSkFXmO6ARbMYRVTQJgup1FFTsxJVEEb9S5Puy/
         6JX3j5/S/ZxI2cunsZYGL0OZuP9uRdXtuQlOfc/hwg9lXTYhrK+iSiZfzqGUEyy946f0
         s0chDp59e0d913IZJYSiAXs9zNEGqVw9BiUldEhCCK9UHAW54FloxLHH9dGsTq8Df+7v
         d4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777015016; x=1777619816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8uv1ap7wfpWSK/rjkumTWgHiVOSnLQXCSFDMADgPR1Y=;
        b=dBsHc6ijLUo+HLAIi0o3cP91Fmms9JTYuw3xIAVwQaHbOSqntYDt2VMrb+QxyPQ8CB
         Aw0VHorhzwUnB0d+KTP+BnpYP0wIg9zW1Hrn9K+9uhqPuDXMRomFl58nc4yBZ/9hx340
         3I37H/Rbyl1GB7qPQWj6J3GrAir6DkSdvh1upzotzV1qxzr1HLGV5H7Fq0wA8iUEZ3cG
         4UtsBUFabztEp3DFRXP3iY/yxmoiPY4Uk6hlJqalcaii/5RPXPuLoC/1VLHK3m2xefix
         oJCMDpHG5A39Kb927wchwC9htRyJw0TMaMbeEOksEOf9wc93K9sJngUiv+ZLDcstTyof
         +AmA==
X-Forwarded-Encrypted: i=1; AFNElJ8w3x1wECJWbLCKfUU8vo5lxGX6pOrje9q4c8Z98ZQBsmI+FWaT8riDvMYu/jFcmhHE5bIpZmuiqVf6@vger.kernel.org
X-Gm-Message-State: AOJu0YwfGhL6Wm2kYYXC6g51TS/XugpIjSx1/NEHsWU8GhAJ8TO5w4So
	ZNXVtTOJSMeO0ZTzX0QDbpwn/ToofFS+i6OWrpXobS76WY3ffzbY4lRkIlEWsbF5U+lXW63FI6g
	kI9eL5alMZ2pSyPnJd5iVhHpF23iFpT4=
X-Gm-Gg: AeBDiet7BsXNNkTVnaCeu7j5UAeOJT2KYZCx1wENeuMqOIIM1g+nrV+waQk6M669XcW
	K6PLj5MutZ/cb7NEA5sJS0blPFnIh06aY9ownbbZx4Q5VoX4KAD1wEpzZ1NCceV9xsEXqm9STMf
	e84ZRpA2zL6k+Hz0aueevMBru39HszjqPqwv3ppbDg9SIyNzH1JZyjBue9+iRggvm/Yrcziui7J
	oIfgxJd/ZwB1lBNh0IGFJhaO8cX5gQtlgNBPxtEQWAFmaDGFYJYf2HC6mC9lKY3RjqT+s+EDJ1v
	DXFM+CrKuTEeLLanQrPMQ9lvDQQ42nGdMUn2Mv/lSAQIZGtgS6Q=
X-Received: by 2002:a17:907:1ca1:b0:bad:dfe1:6a56 with SMTP id
 a640c23a62f3a-baddfe16c2dmr60367766b.30.1777015016077; Fri, 24 Apr 2026
 00:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776808209.git.mst@redhat.com> <006f9142e591ba8c340c3b354aee76aec5c285b9.1776808210.git.mst@redhat.com>
In-Reply-To: <006f9142e591ba8c340c3b354aee76aec5c285b9.1776808210.git.mst@redhat.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 24 Apr 2026 09:16:43 +0200
X-Gm-Features: AQROBzARFJV36R4zYM7xbfHPyy5Ua1V3EjGjDIipUn9qIBzgKGxem5ahIafz8os
Message-ID: <CA+=Fv5T83qH-c0U4eXO84HQmG=225SepaxVYzrpQh_CWMhG5hg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 10/19] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jason Wang <jasowang@redhat.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	virtualization@lists.linux.dev, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 12:01=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> Now that the generic vma_alloc_zeroed_movable_folio() uses
> __GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
> x86 that did the same thing are redundant.  Remove them.
>
> arm64 is not affected: it has a real function override that
> handles MTE tag zeroing, not just __GFP_ZERO.
>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/alpha/include/asm/page.h   | 3 ---
>  arch/m68k/include/asm/page_no.h | 3 ---
>  arch/s390/include/asm/page.h    | 3 ---
>  arch/x86/include/asm/page.h     | 3 ---
>  4 files changed, 12 deletions(-)
>
> diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.=
h
> index 59d01f9b77f6..4327029cd660 100644
> --- a/arch/alpha/include/asm/page.h
> +++ b/arch/alpha/include/asm/page.h
> @@ -12,9 +12,6 @@
>
>  extern void clear_page(void *page);
>
> -#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
> -       vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
> -
>  extern void copy_page(void * _to, void * _from);
>  #define copy_user_page(to, from, vaddr, pg)    copy_page(to, from)
>

From an alpha perspective, this looks good to me.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
