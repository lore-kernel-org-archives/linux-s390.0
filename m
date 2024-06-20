Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AE1AE875
	for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895560; cv=none; b=A1NUgo7Gml85UCPS7q9ncSwaV8MI2ENj5al6WhClbdGkMxT1dtqTVHIgUy1v6HOUbJSplzwU8mQqGiGPYDq7QgG2E6IgSf9/xph9iMfoyet2JjieD67BV7N7XpBloi+zghzJIZXCA34D16fHUVIFxdmt0aSooQAxLD0DQlGA90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895560; c=relaxed/simple;
	bh=wQFe7+FoQAQ/Ej8PGtCjqCQeTZhNJNzpwjveIE3kwow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLonfXhSV6ksRBhsEpyJCKWzRiqwC/qvx8KC8N0pY00tEEND6PptXURJxvEqkvaIdtgmFnkX2AOpMt2pG2yWPWE0puvJvDbsqQAV6cZ2Q+fUmOUFnlGSBmMol3kPxjRldt0ei3wJew5To+Zh+3db85gm/A+rRb8PtUqspWfuKxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sguj/13v; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sguj/13v"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7971a9947e6so54751385a.3
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718895558; x=1719500358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQFe7+FoQAQ/Ej8PGtCjqCQeTZhNJNzpwjveIE3kwow=;
        b=sguj/13vZL7ZJZO5z8sfE8DrKVERNW1EI60r5Q0WJ9TVYC6W4m34sdO+iOboFKkfQ+
         +Z0qBYrCevIxss2U6ib2gKp6C/8ayxteSLNgQLdIXa+DmtZ8ETGf67wOliFCGRmjU854
         GtQ68KVtCjwZkAbaLx4tUOII3g+agxv9tzSq4ccANHhir7PyNwHR2DsZD2gK2OjiJIJj
         6a//RI74MW5DaByoXfw+CG/c6dxOmGPbBK6IJtyMrECTBEJiiKB7tpGCQ6VPlo3MT2Fv
         vvTF/SV9DrVOY/S3TAq+BuSw2OYFpYjUTaNfi6mG2+3tHOvCnOUngqGL9N1oU3gy64K8
         7wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895558; x=1719500358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQFe7+FoQAQ/Ej8PGtCjqCQeTZhNJNzpwjveIE3kwow=;
        b=YoCX0JrT6Ww8H/WX0Z03gTtx9pa6ERLKsil85+bWsupuya6HMA/LGmEEG00FiB5vRn
         f/QAt90TS4ABd1rbaduoL0m9i/DItjEgGlogjqP5qsZe2GUVOeTi4+iGu20tEJPfpISo
         2JKxN1JfLQnvV19mpKfpgj80CuwXOgxf8+jMc5tZ0zy6uIAYTsZzCAnV0ja0zH5oddHA
         7/RCPiFyh+PwDFo2B+CcomOJELccAkGspyi0xOsYRLagaptZFigHI4v13c0QgFkqiqjY
         giGqbmlnfHeYqh/rT/xYO7tCp/Q53xEIaJ39mQHiqUL1oh09BVlzT64T7u47/YgOimOk
         xKXA==
X-Forwarded-Encrypted: i=1; AJvYcCW3rxjN223HqcKdx9eYWyp6Zx5j2qwpbArFsomhxB7SH1rzSSPZUE5741oYAIkfKLGF7nAw6ePTZOLvkQsAKSVGbV7/E0SVOGW6PA==
X-Gm-Message-State: AOJu0Yxk9nPcaPLm1wfrbIQLYUtYsB9316sRvZioy7wxUpm8/VC5aPJJ
	PueayLY+JovXwT0lCmsdhpDjOZGO+i2qjCm96uxEH61ilYdOOnxsN2+0R9hbP7iesBD5C/bkcOX
	kCBzm+8fh05FqarkF+uOlZ5xHotDS/2iKY/7q
X-Google-Smtp-Source: AGHT+IGeRuqV+cE/BwKBYEq3GJ1OZf5EGVZmjN41sQI94tB6oOMgdyEKTDLMRa7DT6aOW38eJ9+FxzAOQmbOR+cC/uI=
X-Received: by 2002:a05:6214:14e3:b0:6b0:914d:4a56 with SMTP id
 6a1803df08f44-6b501e9f7e5mr56738086d6.40.1718895558286; Thu, 20 Jun 2024
 07:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-14-iii@linux.ibm.com>
In-Reply-To: <20240619154530.163232-14-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 16:58:37 +0200
Message-ID: <CAG_fn=V2n_pwdKBK1jwvZ9Aw_M9-UgZ7xho2KS0uUddHWe6H+w@mail.gmail.com>
Subject: Re: [PATCH v5 13/37] kmsan: Support SLAB_POISON
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

On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Avoid false KMSAN negatives with SLUB_DEBUG by allowing
> kmsan_slab_free() to poison the freed memory, and by preventing
> init_object() from unpoisoning new allocations by using __memset().
>
> There are two alternatives to this approach. First, init_object()
> can be marked with __no_sanitize_memory. This annotation should be used
> with great care, because it drops all instrumentation from the
> function, and any shadow writes will be lost. Even though this is not a
> concern with the current init_object() implementation, this may change
> in the future.
>
> Second, kmsan_poison_memory() calls may be added after memset() calls.
> The downside is that init_object() is called from
> free_debug_processing(), in which case poisoning will erase the
> distinction between simply uninitialized memory and UAF.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
