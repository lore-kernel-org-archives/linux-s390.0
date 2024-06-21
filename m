Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03C16B722
	for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2024 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958062; cv=none; b=plrKO3V2+SP3EqOU9aqB8Hs1IOsvW7Pf2mMVQjtgLPGVIP8xZThH6mcnMHtN2ZN8/PpS0T3JbKEgt65GN+LaRjPZpGetbm3xa1ziqQHc6mwKecNtkBjhla4PtPtusboMINEzjXgME9DyzvFgL7Mphw6iejPVcMUyGA1nnjof/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958062; c=relaxed/simple;
	bh=BHs522MQJBFhV9ohTCDDfuazR6Fijf/OOyDX4mfhwRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaNu3Js/lHmiFWzGlA6Q/yEGSJ0oQv0vDD/Imws42mQV04hBDeczuDOENI9Qh5Q1nYsncxdMsya+VOBoRoFFCoG1zdx/LfpEvcja3snJKqwI89bIVx6xx7XEPUEGMDTrXveccSWW8AE70M85Io8tOGcnpN3/PWd3uL6XSaUXVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVkSAAgT; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVkSAAgT"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-795569eedcaso96952885a.3
        for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2024 01:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718958060; x=1719562860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHs522MQJBFhV9ohTCDDfuazR6Fijf/OOyDX4mfhwRo=;
        b=fVkSAAgT9bU7aUKMxg+VmFqLwrlV6yjhzlTkf1rPaDDC4HI9Ll791piF+VazIGkU38
         zcGhuLEh/v8i8dkZUIYx9xou6cHPbG520+p7/Q7nPWQznGyKniKhyN5jsMwsuCd5zEDG
         nSWbB/eMaDGAsfDAVaj5m/oOZI6p7NkDWmceprYBQ5Gl2NtzbIeRQ2wtMDN5jaFa1sIR
         LwcMRreUJHaqW+pW/tsFZUsZceh/hKGAFNeoQs+u4wRl8/uLjsV6tiUmnh77ldJ4LCmn
         +2fquYU4FevidS9DM1Gs4Ji1CZ+XiFStymcw3eSyJPKIgcCasoObFVjk32v2cYyU02fN
         bDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718958060; x=1719562860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHs522MQJBFhV9ohTCDDfuazR6Fijf/OOyDX4mfhwRo=;
        b=mKPcfF11TAdwGqveBM7eu3eLgpzQmwoC9DvEuUUd/CX31i7/V7NEsRUTKweLOgSLmr
         A2d4vtnxf2ss0qKMsmNFoJ1KMeEHSjDp+c/QlN2vtvhepYx5kYq0KIM/ML/oK02TkmmG
         /Cst0MwhQs6IMVe+CJon9lIGsTA6AQwJzkjhWSN4IYB2oPMGAornvGL7+y3g4xiXCHYv
         rGtlNsCHHgFlqcYUCoupxlk9NKfV/SV95lcsQRiMecZIf9Xptdfqd81lYepEXd4fPRKX
         uELG++C5KXGcQoTbSeiotrRrKfCG0GjrE14zwoZWOq0iolYOMoNMI/8eKlODf3PZKd88
         Pu1w==
X-Forwarded-Encrypted: i=1; AJvYcCVpXOWSvwa8wPQ6QnNkszqzyxQUrt2mmS2mHAwi7cj0DPcN+9hhmajkAYP1uuGQGzYGG5CQ3rpxM4yxLvwfEKINuYf+/xbHAvyRxg==
X-Gm-Message-State: AOJu0YzS1ZFOyJisSqFLQ4bREsHAZUvMF5sqC3AHBiwReZaYe5wkCTje
	nssZhT7WmXqgxechbbNB/J3D8u4siirjKhIOcpZoeX45rUW4dhuguvlqfGdN0CgH0FLrjJMi+no
	X94FngF/0BuGc3q2zHK2vp0dq8rBndURxJD2Z
X-Google-Smtp-Source: AGHT+IGXcWKjE2wEB/FB3zctbVztmZY2T0ghhs3sX62Jp/C/wU0GXj1rKHaik6sGne1rqKXer3niMAyr4JKJZuHyBVU=
X-Received: by 2002:ad4:4e52:0:b0:6b0:8f42:2435 with SMTP id
 6a1803df08f44-6b50d8e188dmr52575026d6.51.1718958059567; Fri, 21 Jun 2024
 01:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621002616.40684-1-iii@linux.ibm.com> <20240621002616.40684-33-iii@linux.ibm.com>
In-Reply-To: <20240621002616.40684-33-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 21 Jun 2024 10:20:18 +0200
Message-ID: <CAG_fn=UNT0s1q82Jb=j+HAnGXJs2j=ip2FL6zut+jtnwq57pUA@mail.gmail.com>
Subject: Re: [PATCH v6 32/39] s390/ptdump: Add KMSAN page markers
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 2:27=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Add KMSAN vmalloc metadata areas to kernel_page_tables.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
