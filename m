Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udy+8h0q"
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA7B7
	for <linux-s390@vger.kernel.org>; Mon, 11 Dec 2023 01:53:01 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1efabc436e4so2993179fac.1
        for <linux-s390@vger.kernel.org>; Mon, 11 Dec 2023 01:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702288381; x=1702893181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkurISIjMkn+2I3PnXKwVyMchslMNcfqaTJxR0Aia2Q=;
        b=udy+8h0q8QeRXLg6Y8Lf1YaXitekzhJ6Fuy8N8wiD1ZtVKdAj1LtzAiourNjqmAqx6
         tBJeWHglUuQFV0Gn2tT2iRpWaGKbRZF5awcJtJdZ3A46oU7GSFyvi0Gtl7c6q8T2uIPC
         p+NVuX9kKXc3lifBaXq34GtoBLQztFF3CYGJhOaJqH3/EIRkfD2iGW/sxUy3goEy1/WY
         EGAMzUAE+7tZR8wm6NraWDBqa3HcFqdrgJ2i9cBwANf/kFVxoyg6XA4x4MEtMKikxW90
         yPFn4vH9pcnBooUehdBW3XPsT96jXeftx59DcSwUUVTo3eHXydZ6fQhvr8PsI/QV7s1h
         /9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702288381; x=1702893181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkurISIjMkn+2I3PnXKwVyMchslMNcfqaTJxR0Aia2Q=;
        b=mrf67OY2/c0HxmXHk0Ndkth2H05l68eZ+bvO76BfGltz0+Udnt61bkqdw+zYAxw6nY
         74Ay9Aje9Pad5Av7+4IAJU85G37m2T+Ml1Mk3WMCsEsOShUILcXKtmHMupVNiJcXGgku
         hA1vqvpxOPnv23alFx7u1myxPTKFmFLHwk0ONKeCq72gsZa+79DdMo6Adzz2muEXFIik
         nL5RcrokPW+uxyhUAR4jJ2OxBTR4dThR5mM1UcR4LiL3M7ZkomB79xtm8W0/AqD2MTyc
         7sLTVuIZ9E7hSByblbIAdsKPHfHZM7UmtQoIQ3F5iMLujbgE4YVQEV4eVH8QIT7SOW86
         VJdw==
X-Gm-Message-State: AOJu0YzMEXJMT90bDhgZyI/zeSSBImCaDSJi1TvGIwtXhp9S2SAS2SJj
	qJOwVSLHvtxkChwK1XencHsPbKpdkjvJc7PlCIdSOg==
X-Google-Smtp-Source: AGHT+IHBzcyPtkbQDFQr+6LIt2oxnTSj1NsMCf/LD4g/EkcctNVYyjvt6+1REaXUAWomwb2Qz0o/56s8V04JUzAkCQ8=
X-Received: by 2002:a05:6870:418c:b0:1fa:406c:219 with SMTP id
 y12-20020a056870418c00b001fa406c0219mr4019357oac.28.1702288380928; Mon, 11
 Dec 2023 01:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-6-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-6-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 11 Dec 2023 10:52:20 +0100
Message-ID: <CAG_fn=UZs3-J-ay9yOovUZZr60vbQz+HC0-peRxuKPvq6N5Gwg@mail.gmail.com>
Subject: Re: [PATCH v2 05/33] kmsan: Fix is_bad_asm_addr() on arches with
 overlapping address spaces
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

On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Comparing pointers with TASK_SIZE does not make sense when kernel and
> userspace overlap. Skip the comparison when this is the case.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
