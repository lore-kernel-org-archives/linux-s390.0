Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzGZGL40"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EC31732
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 05:49:32 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a959e3afaso11650246d6.2
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 05:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702043371; x=1702648171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyp/ZFyiUOjenQgn6G8kYMLVmsBPMd5m8mXyGEY1Mx8=;
        b=HzGZGL40VCq48hRUv4ni/hFjp8bYozGF/tTJeOdjnidmwhiHA7c/5xRV5VmDuzdIAO
         nKXClPDibILMmg7YfybvldwgIRps0nw/vntbReb+zPihNUhm/90sSGnZbeN1oOvh9Lqb
         8baKHliajyRWOu4i0/v4vnqkMUnaJdBHugn45qz7kDw6C4UKboMz5+yDNagxa1xhbSYA
         LVGbFg4LUi6yekPeRD5NFta3HXo4G+ZI3XSb4bCekE9ocyFl/2cHtpYbsUBGmgv1QvUa
         A8r5ZEntXCy+T4mYu5sdOH+pa9DR7a/bGsj6QsNM++0u5wtlHfYxD8B33Ubto4HDCuIW
         PX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702043371; x=1702648171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyp/ZFyiUOjenQgn6G8kYMLVmsBPMd5m8mXyGEY1Mx8=;
        b=Bq2WA+WLSfN0eV4Ur48A/KnnNQdgf02rSDXk6rruHqrxbu1BLLx+tNkdZylB1gbUnF
         KFjth1K+06sNb1TH+7zSlmB8gVbQ6aCyNciZRZO7atw1+2T7Xt54IrnmF4VAuA5Xno5k
         CZxXd7r1GPOIlAzKraN7bd/imY3JO5Z6QKQKm/UNhSCjs5DzrcHpsG5lp+wYao82z3GW
         61CzraOvlsx5kZITry0d0bFudh1HNojLb2YcAXOJj7SU0c4EoR0ExjaEfRM01YrtGLmQ
         4d+Z0od3IfUENQ3GmTnWEbsW6Doz2cM/komaM+JDhqB9lxkYphK5yDDgKSYSA/oWSJTE
         MXYg==
X-Gm-Message-State: AOJu0Yx9pCTHd3btgBHgag/tOj42I8L6gEOuroBd7CCwEZka8OFjDWLy
	9LXn/sAFAcVhqHMKcs8wPsZ7DOVOlO2Coq6IFW6GEA==
X-Google-Smtp-Source: AGHT+IEr68RmSA5aYBUgmYtuiSsf9rYsZogw9kLYvnY2zqG64Y2/8MrVDe8thwflyfC3jwZMQ9WgLXTtXopCNqK1OqA=
X-Received: by 2002:ad4:5de2:0:b0:67a:c8ff:1641 with SMTP id
 jn2-20020ad45de2000000b0067ac8ff1641mr5787725qvb.79.1702043371101; Fri, 08
 Dec 2023 05:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-14-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-14-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 14:48:55 +0100
Message-ID: <CAG_fn=Vaj3hTRAMxUwofpSMPhFBOizDOWR_An-V9qLNQv-suYw@mail.gmail.com>
Subject: Re: [PATCH v2 13/33] kmsan: Introduce memset_no_sanitize_memory()
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

On Tue, Nov 21, 2023 at 11:06=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Add a wrapper for memset() that prevents unpoisoning.

We have __memset() already, won't it work for this case?
On the other hand, I am not sure you want to preserve the redzone in
its previous state (unless it's known to be poisoned).
You might consider explicitly unpoisoning the redzone instead.

...

> +__no_sanitize_memory
> +static inline void *memset_no_sanitize_memory(void *s, int c, size_t n)
> +{
> +       return memset(s, c, n);
> +}

I think depending on the compiler optimizations this might end up
being a call to normal memset, that would still change the shadow
bytes.
