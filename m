Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F372DE70B
	for <linux-s390@vger.kernel.org>; Fri,  7 Nov 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522366; cv=none; b=uNdnBwerdfknRMAQ4wbz19iGY97TyUzZioHfyrHU4qYskKpKb7W1zvyckihIaqD50IuaSbCjynIQTmZULLtbWov+/SH6boEDteb0tr+ggUygRSprQe28MnPIqZPmyZySayBuTZq6tEABgcMvqPNoy3ighlTLsw460ZRypH6lovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522366; c=relaxed/simple;
	bh=yKsQnI7GU/jiO1/CSnAlcGv/+h2GSAkl/FAYje+Ck2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qoijn3GjdcUqm/RJhn8wjv7zvb8mdLkSgwofFVApymfOAapODNtYh6ryomvFSslsxM5NHS+ikeCtZBXIXtqOzV2O8UQjt63ac9PfkyTumoPT7uEaDFTE00ga2gkPW6R97zKT8WDY6gYQOLQxanWo/3O9dhiyYbEgBeTrtRQtGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FwvzQPJU; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FwvzQPJU"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88044caaa3eso8312286d6.3
        for <linux-s390@vger.kernel.org>; Fri, 07 Nov 2025 05:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762522363; x=1763127163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYGsUdW8QJxBbEDi2Itt5Jzut6orTX2cfcUNRJS1Mww=;
        b=FwvzQPJUdxw0sbM0t0liLDkt2JEp5y6ZebxynscwwHaj2mnGHpjRjbosCOGa8Wcqm0
         WLuqltIEfsZMyVomo7CuIhVaNnNcbK+b8Sd87DeMJGX7ucN2V0WYzzaUjr7tpKs+9+7Z
         AZbJnw7qXXaZaqBgGzfoU80kFSrFsm1rU5Z3wSMzyUEOvdLOHvNbrqtZ3iyRRCTvDqIA
         kq9NdL0Z6qyKA0Xm7ceWdcY/QZ5LQyd/f0j6+zuz8/HHgVxZxJErKOFhjayKFCi1Rvbr
         h1dPJNFZnP7uTFLUHaQNIbJDXCtT4WRt5kEBIHGjQ2nxX+NXBgZarJfqhywdHwaMiZfK
         9OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762522363; x=1763127163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DYGsUdW8QJxBbEDi2Itt5Jzut6orTX2cfcUNRJS1Mww=;
        b=IrsZZt5JcaSw7SYDrp1kul0Iwy1yxbZ8IfaKFsU38EUFWGlg6lBJhGNr6UxvO3yLUi
         NQWT9LWUvlDtudFfQbbOJXmkgNlSbHfIK3noN62kObf8SokniIwp2iqm4gA68PlgJf1q
         nepc+Utu2dJNnJQJngvxRtS8H93MBTbllTGAiiifZc4tkdKOHEKFuflByWVxTQw6sfkq
         HtUMYzTpEE/nZ20G+x5juOo9I/Y5TY/gRNuqR9/AfW+z/8HUGn3pqj8Io/ET/7ja3i2Y
         mMl1zNs4BCHRK3EDVMy5wx2sKL17r7J102xeCd3kYcJg094IRGHYMq9cSaMuCN47gcZP
         7PEg==
X-Forwarded-Encrypted: i=1; AJvYcCXTCzI49wODRalogM5wXrB8MHGSrAECn+lhC5YBDxyBOL6PyAPlGfNijS29jqMsM0x3p5+EYTc3NVvk@vger.kernel.org
X-Gm-Message-State: AOJu0YxKbGLtk9RazUG0Orqw9eIz+wXiIkDUCKYyE58F5NE/1cHIYjTa
	Uthx2As3/7K3DTSipq/HCJhc4KDuA6CaNkwyeQmdDTqdrRkFsYmttz9avN8GR0vam3Z933qMIQ+
	+XWfdXeIaDxi3lLhbVgJfJphX4xxsvypa60zf53WS
X-Gm-Gg: ASbGnctNuyctuSHpmBjvuKyrTq1bT5gR6ctIEhe/RvQgciS2vjNjAtaUPQTE7/Fy5kb
	h8XC2bewKuBugTmsAks83dnoJKI2Td2e8EkdNwMjESrCyGHciEq/CAz0i/J7ZeEj+lviuFwBlT1
	UTC4zYABw8Mxc2telhS/fFkH5U7Z1LSuMyHxU+A3Mhkj6NLLb+y0F8kFPeDXiqQfiEYaOlZ5guC
	px2JHE2OoyUjCTWr22JKl9RYjRUrcaEx2XCodrOC66ps6dBJRiQhqPA7tYdOSLvMHBf0cVEjhCS
	Z9MzrO4PleXbIyA=
X-Google-Smtp-Source: AGHT+IGMcx4JTyoiLXSjiI5ZnYiFYQ0QhaKKSOD4lt9orRKK4hn4fiBcmRwDE/b5ad2H8h/ilMH/9HIGo1JwDkoM2ac=
X-Received: by 2002:a05:6214:dc1:b0:87f:fecf:17b2 with SMTP id
 6a1803df08f44-8817678f534mr37024656d6.64.1762522362918; Fri, 07 Nov 2025
 05:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106160845.1334274-2-aleksei.nikiforov@linux.ibm.com>
 <20251106160845.1334274-6-aleksei.nikiforov@linux.ibm.com>
 <CAG_fn=WufanV2DAVusDvGviWqc6woNja-H6WAL5LNgAzeo_uKg@mail.gmail.com> <20251107104926.17578C07-hca@linux.ibm.com>
In-Reply-To: <20251107104926.17578C07-hca@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 7 Nov 2025 14:32:06 +0100
X-Gm-Features: AWmQ_blqrF6qkYIlKEriMvS8QB3DM2vAveh3NdlyDLE92dPFiq1osVICbBllaDE
Message-ID: <CAG_fn=W5TxaPswQzRYO=bJzv6oGNt=_9WVf2nSstsPGd5a5mNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] s390/fpu: Fix kmsan in fpu_vstl function
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
	Juergen Christ <jchrist@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 11:49=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Fri, Nov 07, 2025 at 11:26:50AM +0100, Alexander Potapenko wrote:
> > On Thu, Nov 6, 2025 at 5:09=E2=80=AFPM Aleksei Nikiforov
> > <aleksei.nikiforov@linux.ibm.com> wrote:
> > > @@ -409,6 +410,7 @@ static __always_inline void fpu_vstl(u8 v1, u32 i=
ndex, const void *vxr)
> > >                 : [vxr] "=3DR" (*(u8 *)vxr)
> > >                 : [index] "d" (index), [v1] "I" (v1)
> > >                 : "memory", "1");
> > > +       instrument_write_after(vxr, size);
> > >  }
> >
> > Wouldn't it be easier to just call kmsan_unpoison_memory() here directl=
y?
>
> I guess that's your call. Looks like we have already a couple of
> kmsan_unpoison_memory() behind inline assemblies.
>
> So I guess we should either continue using kmsan_unpoison_memory()
> directly, or convert all of them to such a new helper. Both works of
> course. What do you prefer?

Upon reflection, I think adding instrument_write_after() is not the best id=
ea.
For tools like KASAN and KCSAN, every write has the same semantics,
and the instrumentation just notifies the tool that the write
occurred.
For KMSAN, however, writes may affect metadata differently, requiring
us to either poison or unpoison the destination.
In certain special cases, like instrument_get_user() or
instrument_copy_from_user() the semantics are always fixed, but this
is not true for arbitrary writes.

We could make the new annotation's name more verbose, but it will just
become a synonym of kmsan_unpoison_memory().
So I suggest sticking with kmsan_unpoison_memory() for now.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
