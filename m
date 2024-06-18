Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F89F149E1B
	for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721515; cv=none; b=FP6JP5xurS51QXdYIuPILA6s/pSrHePoProwrs0tp4OMzSP83GSMxOdz4nrwb2ULLxfizJwbNioQO66LTkW7k4ZCIAWNWWE6Tl85bN3BbXru+RN8pT1J+g2ANRvcvXg1QaX0g6fd1uf/JSNFu7BZNIZP4O/yBS8iwultN3297J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721515; c=relaxed/simple;
	bh=asXpl0JeYor9a6fnYwHucBKXJR1r4vtn+68cuYeq1jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYwbG+ZTfxNeYrFk1wZ5VSmucxkl8kqSojb8Jj7WFuVXOcN5VCBNdXyYjxiN9IqO9sCaBciOLVDWevvkTIZy7AjTI3eLbJrOd7uqf3u6nzdRIzlI2rVYIkZXxHdaDrGUsNSgMrI9TxLWZYJb2niRZuill5VcP4GUEEx4EoH1g2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2DWNxsjk; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2DWNxsjk"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b4ff803ef2so1185116d6.0
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718721512; x=1719326312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asXpl0JeYor9a6fnYwHucBKXJR1r4vtn+68cuYeq1jQ=;
        b=2DWNxsjkfDnqP1LPkjLJazw5K1B9X+xJZnvH3stNIiPS1NuZPErg8WeDny0sVuAxTY
         Ko3M7I7dseGaBL42cI5ZbXrq1MyRgPmOZwl79rtEoPGVX09BFiTzX5ZzYRxbn3H0DnvR
         JLESnoLbRrInBiexOGOhGkYdGW+M5vXv+beHNqRruub0LSk7tT4ncdsJ/HbuNJW8o9IN
         KP/iM1R6XPaC5kuvj83c/Yuh7L0SU5wmsIhs2ssIT4GUdCQIqB9+bYZKr197c2uYpg7c
         Mvr+mkf+nFq0tvukpg7Yu1bwOyoIyCFm6G0sLlLgSNK6DBJtlowgKX0MsAItzXa1hvyw
         7Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721512; x=1719326312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asXpl0JeYor9a6fnYwHucBKXJR1r4vtn+68cuYeq1jQ=;
        b=FMNdTo5XuwzL/yHfGGORCF76/C0YrZcZ8NQfb4NRPQDqpyKMZMvUS6kcx0Eou7tRlE
         6eTCaRJWrQpc4eUCP+Pf7nIwjOFp6J8cZsR2mVTuShoNlO9mEmHr11RffgiOIrEumSof
         N7JGHvuPOW79KOVQBX92ilUsn3CCmBe4pu4T3+CjTzzGjJndMF3WqKQG1Tk3Bxs6at9L
         +Hq+rXGfiVO/fir6O3kUJP89Ccf4BA7eX8r61hg5JyZzTBYSvw5VVloNFwkWbfrrzEus
         FqABTjtEnMxp4IUKX9hMHPdgevsMl0aIO4l0nEWcZuMNhEsiv8OSwlsFZazyw6y5p2a5
         Ybdg==
X-Forwarded-Encrypted: i=1; AJvYcCU0AfphhwcVgn2RvwubIrx4atFEJs9cpYFZkPq0s8QZVPXl6BY/jbURipSwJshO9cYwvvdM15PxAVsICSRMvdGt0GWLGoAOkUkgzw==
X-Gm-Message-State: AOJu0YwCvXStLM1pY1NwDud+o2CWjAs4ahLo0jfXQlw3Mn3lQ/cyJkfm
	DgbvX9li7ueXg4sbcpjuCqGFl1UYhhGIenod2gjNMfnL1ADzXOZhOS9LcJdjq+fSWmQnfqeAK7g
	bHcmLmStmq2rdgHgyQ+YdZ0qTbsMk/pF2SsHt
X-Google-Smtp-Source: AGHT+IG4JaLnVUVMywHgKWR5RLAZx4PZdexzuK6i5qlGKBVjqac751o/32budwVfajonH+PxBsa2bq093K+sijHFr4Y=
X-Received: by 2002:a0c:8e47:0:b0:6b0:7864:90ac with SMTP id
 6a1803df08f44-6b2afc6efb7mr135971756d6.11.1718721512230; Tue, 18 Jun 2024
 07:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-15-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-15-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 16:37:55 +0200
Message-ID: <CAG_fn=UZ+gCgvgYtn7=p0o8P8sj+iDkD5t-PpihMNNN1W33XyQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] kmsan: Do not round up pg_data_t size
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

On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> x86's alloc_node_data() rounds up node data size to PAGE_SIZE. It's not
> explained why it's needed, but it's most likely for performance
> reasons, since the padding bytes are not used anywhere. Some other
> architectures do it as well, e.g., mips rounds it up to the cache line
> size.
>
> kmsan_init_shadow() initializes metadata for each node data and assumes
> the x86 rounding, which does not match other architectures. This may
> cause the range end to overshoot the end of available memory, in turn
> causing virt_to_page_or_null() in kmsan_init_alloc_meta_for_range() to
> return NULL, which leads to kernel panic shortly after.
>
> Since the padding bytes are not used, drop the rounding.

Nice catch, thanks!

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
