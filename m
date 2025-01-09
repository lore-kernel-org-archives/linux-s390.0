Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA861474A9;
	Thu,  9 Jan 2025 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411323; cv=none; b=ZUSjVCH0/W9uSLcTbFC9ltLuxLl2XJOzAHp+pq7rvLUg7YciLOM3XvKPeDe81QxJS9LhGGHA2thRLmbgRBiXuxasfOm73m5/hPO0pXo0jpQr/9rQCEGpgmSwKDufaOkJ1gW88zZA6rCJWPx6iI5SaRbtIAnE1n/IT3O9Dd8dvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411323; c=relaxed/simple;
	bh=1/qBE3/GdcGQ/2g5qMOGSRv7sxaWW6lgwTrmVZVdbr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGAlpAj82jCfvt7+fSApiGe4S//Oi7vBbey0uHtvfS3YwWmzWoLFdSq2n8bZ1qbILKkWLL88XLIe734i2v10bhtCun5QA61F8iqgq8gA2VATzJdGe4h0yfXiogi2/vJBXPa2E/X9vU8NOnmHE9p+T/59ftJGyIoeBsfGy6QTKzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIGUOhYX; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIGUOhYX"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e461015fbd4so812438276.2;
        Thu, 09 Jan 2025 00:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736411321; x=1737016121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ntTkjgxuiepBBR2xyDwRTMrrHsN8lAhMeazmuGXDzY=;
        b=CIGUOhYXLx5ryhGawLNQVEU2evvcwW5JqxTopFrQGT+RUbx+Arz5lWYUNhHaK+E7Kw
         vqpZmuQxa/wZEc5Kafj1KE4g0+C9fAop/TPqjudGgIJ6rVwU/CTIq33tiZRlsrzJIAxj
         ab7AiIPJDCPNRU0NLrEk3u1DMhm5vr4n+Rgf69cJMtNqDRdNvGSB5zUrk83qmDjWTWh7
         jX/Q50SLfJ8tMfON4X2OwOiVBfOeBq8zzbZZJqCY0I9Lim4yg3tUSrXaG1RDM92R5QJ/
         GauqfYVkWohNaawDFQRrNslz0X4gUghlD+2R4lal202ZyhRh4qsZ3Shm99hnq7Mmimue
         sJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736411321; x=1737016121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ntTkjgxuiepBBR2xyDwRTMrrHsN8lAhMeazmuGXDzY=;
        b=NE8iRvlMozsj/S91FXEz44X3aimLjab8lf7JhZnZ+1421QxZ2CWCYfb7ObkjZp5g9N
         zL45eb7RFIg0q4riLUa9jdZJl6Ofc7Ts8lKjt/Dl1QTQOmYCX8WgRRm14NobJoq0BBNy
         P3bOGNCYSAy9A09oiElj8UEBwY6iox7mn5ZM5tuDkH9kmimbpfIIxDOaoD5/jT0Egtj6
         PLBagqKNFySeehbkND5Wt/KeeQB+KA8gL7QydtPFwQDBmo3lYNVvm3PfWjWPf9xukQN6
         Qfj9zjNx5+kxADHVoM8x5igrLvbhQPe+iQM9Zg3VpL/gsKXLtMBmfvxERQpFWe0Mha3U
         NgNw==
X-Forwarded-Encrypted: i=1; AJvYcCV0UGB/2h5RDxSIZN5YsCc6vCHlBJGozJ+BqEVjvp1nXvDn7UNR53Nvm4i9vcnd+f5tmVWP+LFHDvyEdw==@vger.kernel.org, AJvYcCVVTuGB7vXrDit8o7jpKhF5/xrdaRK8CFCmbUjBQp8Fgw/ugGPSdouOz1qISCsQzm3SlXP2tBmZdNLPX20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrVY9ykS11FVMsfh9Ny/f0ZY8xraaDKSSYTSn2/duUqkYaJbZ
	69MyRMz+meBSWSD9cFfL+ELyG+9f7KJkUZWp/rcPqfjCtDs+UOhgTuhkoZuVNmsmk500+QtYEpa
	ZL7k+7GEMrK8E8F/IXf5nXVqlgUPE0aw10lbdcWZG
X-Gm-Gg: ASbGncvAVHGB1rFCYLbvV6TcoXuXE45SdniUluJ13f3JrytznPGqXAykc14Qk/Bz3SO
	yUmnEJ+MRi5ksk36FlPP5me+yk916GdfHYXDova0=
X-Google-Smtp-Source: AGHT+IEKF8udQ2Qn4PyN8Z0ntaVBS7+cYzu4t1/vdCcPo9D8nlW2XNm3khBGrnY9SBS+bCKPiIkDm01iSjrROyBRkTg=
X-Received: by 2002:a05:690c:62c8:b0:6ea:98d8:a61 with SMTP id
 00721157ae682-6f5312d6badmr54247427b3.28.1736411321112; Thu, 09 Jan 2025
 00:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109033136.2845676-1-guoweikang.kernel@gmail.com> <Z3+ECLf7LHQe+Mdq@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
In-Reply-To: <Z3+ECLf7LHQe+Mdq@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Weikang Guo <guoweikang.kernel@gmail.com>
Date: Thu, 9 Jan 2025 16:28:06 +0800
X-Gm-Features: AbW1kvbIcLva0XRIP8n0t9SsnPvuIwbBVTfP2lt7L9s7M3vdIL_igJWGPbxJZsI
Message-ID: <CAOm6qnkoKjrUXCbhCiSYviuwCRVES1FYCy17fwATtyZ+M=Aw7g@mail.gmail.com>
Subject: Re: [PATCH] arch/s390: save_area_alloc default failure behavior
 changed to panic
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Alexander

>
> Alexander Gordeev <agordeev@linux.ibm.com> wrote on Thursday, 9 January 2=
025 16:08
>
> On Thu, Jan 09, 2025 at 11:31:36AM +0800, Guo Weikang wrote:
>
> Hi Guo,
>
> > Now with the memblock_alloc_or_panic interface, save_area_alloc no long=
er
> > needs to handle panic itself.
> >
> > Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
> > ---
> >  arch/s390/kernel/crash_dump.c | 4 +---
> >  arch/s390/kernel/numa.c       | 3 +--
> >  arch/s390/kernel/smp.c        | 4 ----
> >  3 files changed, 2 insertions(+), 9 deletions(-)
>
> This patch is a follow-up to v7, but instead it needs to be part of v8.
> I guess Andrew would refresh mm-everything (or whatever he finds appropri=
ate)
> with the new version.

Sorry to confuse you, `memblock_alloc_or_panic`  is already merged
into mm/mm-everything
by Andrew, so this is an additional patch specifically to fix the
problem you mentioned.

This patch is based on the latest mm/mm-everything branch, and it  has
also been merged
by  Andrew=EF=BC=8CYou should have received the email.

@Alexander  I hope I cleared your confusion.  ^ ^

>
> @Andrew, please correct me if I am wroing.
>
> Thanks!


Best regards.
---
Guo
