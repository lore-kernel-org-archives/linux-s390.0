Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1A01741DB
	for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871311; cv=none; b=Vr9+31Xf3VsHY9UsWJ8qTuT1mkEZF8ADdS7/z6by4DfooDS6Qff8fr65GfTY8bMBtH/peNZj1MS8TYKL7oK3OUUNMjK0fQEBQmRrwI27s/5i8qxBs/8H5rFZya1bFRROqNavKfyVNHXXIIZS4iMFpkrX3C7o9lkOstbB6KfWuac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871311; c=relaxed/simple;
	bh=ZHRuGJFlUYdLamnB6sF47nsjZQIytquVYyRv7K2ZWxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXiOJaa0+EPzLXIqr2OXv/V3YWrJStDKQYNt3darBxIz1ahS0AtDhUBnjvazbj6Z0PPQX4gz+sRBp//+3KasB3mN+Rd8plUaAlWFRFH1SK6dDOG2iBsnwhy+mpGjXAS9q5gIwK2a9vaJ9Scz9FSXnil9ur1vWr48BQL3HCMS0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0q1TTYUR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0q1TTYUR"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6327e303739so5805807b3.2
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718871309; x=1719476109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkDyjmmo2mJ4eSIsOzioTK+npaxfD4Q0PqQ0hVQZ66Q=;
        b=0q1TTYURnIp+/XFb/EoH4dDbQF63DjNb0U+1GNE+ogoI/17YREMvATQGVlZ+Y6fAfV
         AUyJLwDnn3FP7lwBsoNp10YgVAwp2QdsHCllE7PW+Y5wiCoHKW9McjfSfQmbAGkeFJym
         bKwrSSW54DfizLu/IGad6MaLecomhonc0iXvbQ6NaAmX/1LGC4LlnLAzzP/6QR6xkQZT
         7yUta9lsPaaNfJt2bbaMYrrgLINexvn9ihcRooPYTyFSmrEnZ2DgSD7Ayr7jPfwl1PaD
         hW6+/vbc6A/NQ5p3IHkWvGy7W6rwj8y3qTN4L3rZMG/H49O8GUbelgrAroLH7vhEQgKS
         crhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871309; x=1719476109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkDyjmmo2mJ4eSIsOzioTK+npaxfD4Q0PqQ0hVQZ66Q=;
        b=C4su4wOjjO0fcXhdtxHNK9i0Erw2BrGWsj0ZDT8xrUSX7Ta98qPcBqHp4tYdHXfhxv
         uhe2oiAAxvbs8JqV3edyUc4gLjooAkLzgvdQA9qb0YRhlOPl9ATj7BagjyywWmzExINm
         joU+KGzyYuPIWSYOTI8IsUqBl2yaqUf/rzsKpXIblqlJD17bV7QdSGILXVCWrWSwe0hQ
         zhAGs0370XbYUc14sd5ulpw5ur6QhmCc0UF0mIrFAnSqFUiMAm1soHgpgvLxzlmC1iv9
         Ww3ssD5LGkVekVCc794/WlpFKs1pPqyyBHx7j6gd+PmnKZ+98n2H1Cua+0Db1n0gvame
         tk1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNduRhK4PGN1toQvsEvx/57FMsrTxEc/y9ZWZRvoU3623aiDS/r+fixzGCatu6lKs0ULC2ngt74a//hj44dBJS8XWDZYZz9bxTig==
X-Gm-Message-State: AOJu0YwEduzvCi+g6xcxd/dfyKzdoOIdPkNqezjimm6/1EygRHYbxX1b
	xALAJUM9+xIFFHuyN6z5fFoVh3YUu1lQ56Rc+4buc2J5MT4a++lEXizR4B1hnQB3860yCpmcC2n
	TEY69NKJl05U5Ugfc6DI/q+hQlpsGjr9HMhyX
X-Google-Smtp-Source: AGHT+IEov8tA6WgC+NocZnlJNfskZn/sCcpgNQNbOkch4CKnuKF2F+01qvPEG14FlebgcmBeM68GwMaerknT5zuvZsM=
X-Received: by 2002:a0d:f185:0:b0:61b:3345:a349 with SMTP id
 00721157ae682-63a8d44ac47mr43240177b3.3.1718871308642; Thu, 20 Jun 2024
 01:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-13-iii@linux.ibm.com>
In-Reply-To: <20240619154530.163232-13-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 10:14:27 +0200
Message-ID: <CAG_fn=W6L0Yr_GLHEok=LmL0-whk2r+-E7fVHj8pA8GCtgze=Q@mail.gmail.com>
Subject: Re: [PATCH v5 12/37] kmsan: Introduce memset_no_sanitize_memory()
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
> Add a wrapper for memset() that prevents unpoisoning. This is useful
> for filling memory allocator redzones.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  include/linux/kmsan.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> index 23de1b3d6aee..5f50885f2023 100644
> --- a/include/linux/kmsan.h
> +++ b/include/linux/kmsan.h
> @@ -255,6 +255,14 @@ void kmsan_enable_current(void);
>   */
>  void kmsan_disable_current(void);
>
> +/*
> + * memset_no_sanitize_memory(): memset() without KMSAN instrumentation.
> + */
Please make this a doc comment, like in the rest of the file.
(Please also fix kmsan_enable_current/kmsan_disable_current in the
respective patch)
