Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31421E507;
	Fri, 10 Jan 2025 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736491719; cv=none; b=nMfEr7FHAuDqk23XmqUzsH1LtwaOsXlsUURbR8v1QavjeEFaivLWbkWkQQJ9G+B6tcT/RhsE2hmXZvtm4lXf305fn4tRIvwBm1gnxxZ+dKEIXISymAsYDqpI5QIZFyJY23Cefx2vfUB+QHrVb0IoYmAt+Z2e/mLXLKrhRsbpHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736491719; c=relaxed/simple;
	bh=3Nvg+WFBMIpnGxasqalLGQ2+PZGNasouQMw9AqrCjlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCU3gopRg68h7lVtflcTZiXh1gzxODFk2P1MP7IuacUId99Sr8Xd9MtlMxSG9I5zqxyx3FYbnvC9lWv36omBV8/meIueIOlCGiIzP8CZAm7s5KpR0Vkfy7Xjav9ZE1/ku0SP3kq1M4LxEK9uxE5TIBo+a8TEBeUd2pABx8siuq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vr+w91yR; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr+w91yR"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso2142507276.2;
        Thu, 09 Jan 2025 22:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736491717; x=1737096517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BbJm1YUYeuUPYzqdaOCLia8KWe57xlNVx83qwQGxv10=;
        b=Vr+w91yRM7VAe7a15GJtAMVXM960qBe+KC5Ebiat3pCg/iDZvB3nHJBMoU4mvAc+0W
         5CRb9TK10r3Y8k9y5YmHBS1evGYOoLT40+KT3ZRygiCOYQcF5JBpOiAlKW688wnbN5o7
         VraDyxdXsv73hJvZInOpXBGNp13EWS4+F2g2RpSiT3Nw07z6jn9xb8l5iD7Q1Mvt8aIY
         5ZHi3/GULp8yOh6X5ix3YV5YWwmjKy9xuef1DkEtREZSJuQMkCV8yQagvHaQcvbLrj1i
         q8fzppRZboe+kByRGdxjG3M0viHalY/I9EgJWiELog0xpBXFSIR6XF7oMDLk402lrwqW
         MyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736491717; x=1737096517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbJm1YUYeuUPYzqdaOCLia8KWe57xlNVx83qwQGxv10=;
        b=GMQBdBiRMpJOna/8wEgSGl+6cGZVqpMcfaSD6kfVY0cVhau3m0fsreiKaIvpziuLiD
         WM20tIGjzzniZqhrx9un1s3A4z1lL3uvPdaWNxQjLFrPrRVDS6c3zybKbotkb+wBqCIg
         eZZt+xna6hqdhZDqNzI1bdPmrTvMsb23F37uQ09XZ5guc2kfvAt8oqo86J67UtSeuamd
         lvNITyM6d4lfChHG3/pRq6RKxgteJwUKsiXo7tJoNcGZzqbw1uJttU9bggyhqRThtEWG
         tTiokv1Z4ytVHQdOdiT6CP+tlt/hFyLSQrF6d2javaa0mushuDfNm2ksPerZrwK3Gk1d
         hkww==
X-Forwarded-Encrypted: i=1; AJvYcCUGa66f/neJPfgX8t6jiquJB9KgYeWr9fC2vmFSJbLy53S42eMbPtIyainFjBD83lCy1RPoYe+baQs3Uw==@vger.kernel.org, AJvYcCV/VyXCK633HNsWfkt8GA4zOXDHxe1WTr5H242l5Wq8kkbVVI0e8x/9xhWSpHgfkEtYsdbJ5Prc9eIlMAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8VX7HqbQN7F26Blo5XDv4FIrsU2+0SuyO10Q22SRsT2Xn3Xaq
	Z0VupOYBPnrdMwytzuvREzWV59HSztnoeqw0Xs4/h4mX62pe80wr4fN4zDaRQIkB10JSo5lJb6x
	fHBsri6egp9Ul0/hR6ER3DjS8f5GvMKeCpLZcDQ==
X-Gm-Gg: ASbGncuml0Pr/NDWHMgLXGmQeZirpoXJahklR7ELKV+rZ+6hCOb8JaKz0t9x6/SClub
	UHSoddjQRIG8zcm/488isZJTn56MxdbFX84OgbAM=
X-Google-Smtp-Source: AGHT+IGWXh/MZ6OXMOZxjgr1jv4Tphc4pG+hTilGnQ5B3eHrVZ2tKRbsePGN7HMxnFkj7u0GP9IviYajQw5Q6zQpv3g=
X-Received: by 2002:a05:6902:727:b0:e54:9bab:d934 with SMTP id
 3f1490d57ef6-e54ee1775ecmr7381031276.31.1736491716865; Thu, 09 Jan 2025
 22:48:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109033136.2845676-1-guoweikang.kernel@gmail.com>
 <Z3+ECLf7LHQe+Mdq@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <CAOm6qnkoKjrUXCbhCiSYviuwCRVES1FYCy17fwATtyZ+M=Aw7g@mail.gmail.com>
 <Z3/VoAaSQF5Tcy4t@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <CAOm6qnnxvVfxfoKTj8eO3iqZ9oj__JMJ8o0cH2fZuKkk7gVZYQ@mail.gmail.com> <20250109164315.b21f40e1b757b1cf9eb7e042@linux-foundation.org>
In-Reply-To: <20250109164315.b21f40e1b757b1cf9eb7e042@linux-foundation.org>
From: Weikang Guo <guoweikang.kernel@gmail.com>
Date: Fri, 10 Jan 2025 14:48:01 +0800
X-Gm-Features: AbW1kvakAeyXiDA4OXYW9dxia14hVayNOKp7iil0a924Byt1H8En7eSIg4izf7c
Message-ID: <CAOm6qnkC=TLm+2hDi-T+C54NY4_+yFEpNhssj3wvaTfewJz4vw@mail.gmail.com>
Subject: Re: [PATCH] arch/s390: save_area_alloc default failure behavior
 changed to panic
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Andrew Morton <akpm@linux-foundation.org> wrote on Friday, 10 January
2025 08:43:
>
> On Thu, 9 Jan 2025 22:53:57 +0800 Weikang Guo <guoweikang.kernel@gmail.com> wrote:
>
> > I understand your point, you want to modify directly based on the
> > original patch.
> > If we repost it,it may not  be v8  but  v9.
> >
> > Last v8 patch: https://lkml.kernel.org/r/20250102072528.650926-1-guoweikang.kernel@gmail.com
> >
> > I reduced the recipients for V8 because I remembered that the number
> > of CCs might
> > have exceeded the limit at the time, and there hadn't been any
> > comments on V7 for a long time
> >
> > > @Andrew, is that still possible?
> >
> > @Andrew, I can cooperate if necessary, I could merge them into one
> > patch and repost.
>
> I'll fold this patch ("arch/s390: save_area_alloc default failure
> behavior changed to panic") into
> "mm-memblock-add-memblock_alloc_or_panic-interface.patch", v8 before
> sending the latter upstream.
>

Andrew, I appreciate your help with this!

> But I'm not sure that we've completed the review discussion of
> "mm/memblock: add memblock_alloc_or_panic interface" with Mike?

Here is Mike's latest feedback on the patch, I have recorded it in the
v8 changelog:

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Links: https://lore.kernel.org/lkml/Z2fknmnNtiZbCc7x@kernel.org/

Thanks!

---
Guo
