Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07421B1AC;
	Thu,  9 Jan 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434475; cv=none; b=B9ab+R5Gazj4PaunzIG9Gr9WQwt36tnTcIytVMfhoFczAyQdFrAUTKvNxt2/JWz+oAMNrTalTUYoQP74/x9kWtcI7Qls5FSpvATQKoUWXRFyX9mdUBZIQbBBV9FLcVe4biTzCoNbYcno/Bl+HCYnESWMP0EnLHGR+J0QxGXc1qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434475; c=relaxed/simple;
	bh=EcRv6oQIKfOdauxa/GVg3VUGcw0KyErn8R2tuMdx3Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNDpg7mqqzzpoiIEpwPCtXaEszG3TFn6MS20wQOx/1x4ACodKMmcoGPk91eB+fSOLJ2szpewcc/t35Ji0s8SUsEpPRZDiJCd4JOaRorRGHJfKLM0F5wR3A8+DFH4cw/RUFwbkbkVutpSWP0ohMU63Jm7n2dp15CJyc/yCMadyA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdPXjY4g; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdPXjY4g"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e46ac799015so1298682276.0;
        Thu, 09 Jan 2025 06:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736434473; x=1737039273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xV8SfIqQ0/kHqPmPgrxngZfJFM8b2XcRfoBCM4cwpI=;
        b=VdPXjY4gwHC+Leun8wfAMFw2zzGYKcVhA26/Kc3EgzbgvlYVtKRGLudQLsuerCCnES
         Dg31kW6aGfZv6YJbZe19QZdnPmWxRGdI0dhIBp+jZDullebduO6SLqJjYtw+FPbrDggk
         lZ2jIZwbjodNK1z/rh7O6zIGLGeczCNMpPTLO2t2UYDla463Q3IRDUQFUVT7yOYxOSMq
         cJ3fwWeFX8D+ZOU67qO2j/aJkU1xUdHGZkIjbRdY4cpesNmqJsSiyheVFnaAM7GMf7h7
         eN10JknNhhVrDdr9zSO5n2yiTr/keVpmjNlfTA3M/O/K16++L6pg/t7dq5fbuKW1QwWi
         BPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736434473; x=1737039273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xV8SfIqQ0/kHqPmPgrxngZfJFM8b2XcRfoBCM4cwpI=;
        b=Bk4Qr6ki2MWazUkAethaFYuvgweoPZpnpFxdcpLqzoHyf+Y0bjulG6F94UQbK2Lesj
         ErS42zJa1CWHgo296gXwY1yl8S3HA3Wu2OuCzPox413wxKUp+UVbyXgwH7axpKoh6B4H
         6l6a61O1XGwkuB+qUEzbET1iH3Vu7uYA3qnvCuOLNd0XJfwyBQw/M8CHoO+ZjNdbxCDN
         rf8ip9EXJJkhUCbsCwwdbcYvtcB6a9sxxxhxfjem1ljrIDCg+Hf3UD7f+XpxNdwalG2b
         u8r4Faktz3T63zf8TBRnpsDtyEwZL87+fTOHDDfz0JgnoG+KXylzsx0MOh0AYolYJEIu
         qEdg==
X-Forwarded-Encrypted: i=1; AJvYcCWNLJc44ogJ/7ZoMR5ctrbCk7ZxKBdCFO6t+1CAoHqW1hJFw5yo8JEk14c3V4o8glha49doPiXAK6Zlrw==@vger.kernel.org, AJvYcCX5hrSvDJU3jzUjmZBx/Cnstua2U75WeXPjq5YQjCU3kb541MPDsu/fB9lEPORAsE5I6VynROJXWfz6244=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy60PiH8U1E3CR6oCIPGqj9w0S0zfhXzv6XxhO9EewaPKDHINYQ
	93PN/84D0hvvvMWL/ku5p+HyXj+ATLN+ROzbuK3spE/TykymHiWFPbxlCMJMtIthXaeouvXKp00
	xOJOacwpgH1fjI717q9B1RtiKFpc7msptvwt0NpYr
X-Gm-Gg: ASbGncurblaejjsGKMC6ZCMFtpSSrVU0nPmkWXzfn2pBH+AYKJuH3hQvhYKQnZ+gi02
	SLYvloFsOh3I6F6wt25RlD5FaWSV0F1lXRXLYDNc=
X-Google-Smtp-Source: AGHT+IGNPVIuQEBv8uS9iGe3W6qJSOqE/vqK9HyVG1/prW2lpfr0/THqKqT3WKMWQJMTOi51ImVnyf6SducKzLdH3BU=
X-Received: by 2002:a05:6902:988:b0:e4c:1b6e:5937 with SMTP id
 3f1490d57ef6-e54ee1530femr5630582276.30.1736434472866; Thu, 09 Jan 2025
 06:54:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109033136.2845676-1-guoweikang.kernel@gmail.com>
 <Z3+ECLf7LHQe+Mdq@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <CAOm6qnkoKjrUXCbhCiSYviuwCRVES1FYCy17fwATtyZ+M=Aw7g@mail.gmail.com> <Z3/VoAaSQF5Tcy4t@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
In-Reply-To: <Z3/VoAaSQF5Tcy4t@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Weikang Guo <guoweikang.kernel@gmail.com>
Date: Thu, 9 Jan 2025 22:53:57 +0800
X-Gm-Features: AbW1kvacx_A21bU90tO6TCIKhuK75IssVDgtyVfcjShQ1QFQsf2XiswypYIQnAk
Message-ID: <CAOm6qnnxvVfxfoKTj8eO3iqZ9oj__JMJ8o0cH2fZuKkk7gVZYQ@mail.gmail.com>
Subject: Re: [PATCH] arch/s390: save_area_alloc default failure behavior
 changed to panic
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexander Gordeev <agordeev@linux.ibm.com> wrote on Thursday, 9
January 2025 21:56:
>
> On Thu, Jan 09, 2025 at 04:28:06PM +0800, Weikang Guo wrote:
> > > This patch is a follow-up to v7, but instead it needs to be part of v=
8.
> > > I guess Andrew would refresh mm-everything (or whatever he finds appr=
opriate)
> > > with the new version.
> >
> > Sorry to confuse you, `memblock_alloc_or_panic`  is already merged
> > into mm/mm-everything
> > by Andrew, so this is an additional patch specifically to fix the
> > problem you mentioned.
> >
> > This patch is based on the latest mm/mm-everything branch, and it  has
> > also been merged
> > by  Andrew=EF=BC=8CYou should have received the email.
> >
> > @Alexander  I hope I cleared your confusion.  ^ ^
>
> I do not think I am confused. The merged patch is not good enough for s39=
0.
> This patch addresses my comments, but it needs to be merged into v7 or re=
-
> posted as v8.
>

I understand your point, you want to modify directly based on the
original patch.
If we repost it,it may not  be v8  but  v9.

Last v8 patch: https://lkml.kernel.org/r/20250102072528.650926-1-guoweikang=
.kernel@gmail.com

I reduced the recipients for V8 because I remembered that the number
of CCs might
have exceeded the limit at the time, and there hadn't been any
comments on V7 for a long time

> @Andrew, is that still possible?

@Andrew, I can cooperate if necessary, I could merge them into one
patch and repost.

> > > @Andrew, please correct me if I am wrong.
> > >
> > > Thanks!
> >
> >
> > Best regards.
> > ---
> > Guo
>
> Thanks!

---
Guo
