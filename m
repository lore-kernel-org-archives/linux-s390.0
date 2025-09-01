Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2E3AC1C
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739193; cv=none; b=bLNLp3nBfLIHB4MVX8tRdLQ319MmZmTNDB7sY8iyJtvx894jD0jmOb3SCf3qP1iZjRYSqvD7/UDTm3IOmZfrKqo7AzGuZJ8oKyoTzgmwHEVVNpa/mDEsBZeDvWfOvzNGUd819hezKvF1r0UKctsAUoflrrwA3/IdJs63OU4tFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739193; c=relaxed/simple;
	bh=RTksJ8/0/nMOSHK1v6hFgH7Xl8rur3P7qYdlo1+hL9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1+arlffir18A5JxRJTdLqFJZkmmlgmcCBGJLlR5l8KS31jkeQjYLR5h1ZOSZ+iaIxtD0sfid+KXPtDeRhmxIDIpZd3igVlO/RqPSJOSYFhBPtIVgxf9LokEGpgofxk5e/1vZBsZFR0ru000mYY0SuSk1/xcdwzgYueHAmCYKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IyVq172b; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IyVq172b"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78ead12so724123366b.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756739189; x=1757343989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bwNSdY68Wls82Q0k25WMNjJlHUk0r0pQNA4NzN+C5M=;
        b=IyVq172bBaLcYBrl9lLB+7k/X6SfaztrXkqA6O0iqHoUsJ4lzBzbgcL9gvPUNB90wF
         V98plQRUO8aCDpp1TxjvHB4sNQbfgVaU1r6A/qMFGeOAwt3007eIRCKb6cX8QhW3JTl3
         /FMlQvPXhq074a/+q2pHf4fx0DL++gG4yrr5GeNqQvOsdLHbO21enQjAtsjibvnznilV
         r3fSbXiowoecUTw+tHR9UJ8TSH88rZurYZBrNKjX5xezi1TPDwQbmPIWhgi3iYkqLkHz
         iS/KNmAY4cfbOl7YDy7grDQCm8X9R8g9PgMFiSlE285UcKhVXiLstSkvjyjuTitCT+7f
         7b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739189; x=1757343989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bwNSdY68Wls82Q0k25WMNjJlHUk0r0pQNA4NzN+C5M=;
        b=GiAN4jpvuAdzwSHxYevmwWGH3mM3SH0ghPczUnyEhCDXlV+eaE0dZvqZVTN1NPRHed
         Jif9Ooj0pqQ6rllNyvcfRKzzluVtoS5ExkaXDQaQESNEljX/mnFsdlEwPzRcdXb6LGX0
         WxzynIoF/evy34g4gLxEvFU75JFWsGD/wVcwVxIh8Ws0yIo5jk7zZ+x9TGs0dBuTrXLk
         LBK64WdlzS4M8+MF3JHBBxl7P6Y2S3+OepuXE5WoOjQYzjipEmTIu3QvGvgG7H1rne24
         sSnvKHYVsJ+cCKUimbpEmzM3Cow3I+1RcyIXWq+KMacoik1IUDTfDgDKwVMOTk1IRAJP
         f7rw==
X-Forwarded-Encrypted: i=1; AJvYcCWPRL2IzGZxGIOqtRrRBW3EHEpYYFVcWmyWLOJ53SwceRezhVsGzZCI/JH7Nrv3FumQFB2BjO+jXYIe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7lzxyXZJJbRrRxxUx7hAiwTYdMfzbClAiEhdFThsl0m1L30uR
	2+/w8yS+Qe8M6bUAINoUqeHXxEyL4iQAIbadESRj8mBhOY9x1E5z5yJtEjIsogofCTnxSW+lKLh
	MrDSuQtx6ZG0NufVQHrJwH+yrdKXGMUmxO0iWJg0xYA==
X-Gm-Gg: ASbGncscDGvMXnpfzMu1+yjMARW2mhoGY1GZuC/mNrvuwUhR9svHWsxavUQppKMkif4
	SGs2ySfXG0fT/mryg3nEgZYF2dL57DK1wL+L8WhYiXCrgeAachz6azRObb1gKlSwXMrGRjQKSDL
	nJTXAHEJcUXM8WcoCfLzZ/hA07WeibKhBg96VMbPHVl6v9SBAvP6GEHu2eeMtsvL+uqrbh2TqKJ
	DNauqg8H+lXz5e52DtNE97ys7U764b0ae4R/QBVz7Xekw==
X-Google-Smtp-Source: AGHT+IG0FxeUic5SFzE3UNYIN3B9+gaajPRoU8Y0dXCHXgh8kVRRqajKZHy7y0TqbZFDzgzomSvfHMhYlurHNOihACs=
X-Received: by 2002:a17:907:1b10:b0:afe:85d5:a318 with SMTP id
 a640c23a62f3a-b01d9755f83mr810176666b.36.1756739188996; Mon, 01 Sep 2025
 08:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-9-max.kellermann@ionos.com> <2ad655ca-7003-4030-bb2d-1c4bcfda30cc@redhat.com>
In-Reply-To: <2ad655ca-7003-4030-bb2d-1c4bcfda30cc@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:06:18 +0200
X-Gm-Features: Ac12FXwds-_H2NdWifPwev4VbqOwXfa3OcMVFnDeIo9bGQG09tjqsarnzZrb6S4
Message-ID: <CAKPOu+-_bPwE4sCcb6n-nfi3nWy6L0gBAoHgRz3qwdUHByE_Lg@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] mm: constify arch_pick_mmap_layout() for
 improved const-correctness
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:58=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> > index 2201da0afecc..0232d983b715 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -178,7 +178,7 @@ static inline void mm_update_next_owner(struct mm_s=
truct *mm)
> >   #endif
> >
> >   extern void arch_pick_mmap_layout(struct mm_struct *mm,
> > -                               struct rlimit *rlim_stack);
> > +                               const struct rlimit *rlim_stack);
> >
> >   unsigned long
> >   arch_get_unmapped_area(struct file *filp, unsigned long addr,
> > @@ -211,7 +211,7 @@ generic_get_unmapped_area_topdown(struct file *filp=
, unsigned long addr,
> >                                 unsigned long flags, vm_flags_t vm_flag=
s);
> >   #else
> >   static inline void arch_pick_mmap_layout(struct mm_struct *mm,
> > -                                      struct rlimit *rlim_stack) {}
> > +                                      const struct rlimit *rlim_stack)=
 {}
> >   #endif
>
> Should both these cases also use *const?
>
> (for the latter we probably don't care either, but maybe just to be
> consistent)

Actually, it would *only* make sense on the latter, because the former
is a prototype...
