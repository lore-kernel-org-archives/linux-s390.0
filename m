Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zh3omQw2"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D639124
	for <linux-s390@vger.kernel.org>; Mon, 11 Dec 2023 02:26:58 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f59fcb204so134523585a.3
        for <linux-s390@vger.kernel.org>; Mon, 11 Dec 2023 02:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702290417; x=1702895217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=52MMj8qKTft0Rgk5cZkkhNA4qD9/n7KR5GYlCADI69M=;
        b=Zh3omQw20Krzch/mGIwcw5r1EUTqZja8pb9GLFIJHoztBnT0jDzAB6dhWYQ8Ym//J0
         /vZUky6Pn9gCvHJTP+3yp1/L9HcFwZmfVu5kcvyI1CvHvKZVZf7eQc8nkvMDrntkUtFS
         OX1Jo2Ni0CiEwZ2SGdg/K4JG6Vl1+fChTkZeU1e9JFW+aPFI/tqUZyGDWWDmmzkkWbXh
         /PfTyWl7IrA8LYyOoufVkHnZiF9OD1EZrvmRjlXJBp/SjezNVHxXRyYtGQGd33HoKdtb
         g0aW0BrXbL8Y4pa07uxWN6baZS5QoNpLL+1Zef3IFgvPjv/IcPSvj1RZzTV2I5AaW30B
         UayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290417; x=1702895217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52MMj8qKTft0Rgk5cZkkhNA4qD9/n7KR5GYlCADI69M=;
        b=d9x+9tS86vZRpmPhhIhy0L3Jdk4mHInqzDHm+JEy0EjwjKkpUShe6D/uk9XZo/RWjq
         Qwa1+lS4wmxyA2EpZpMcblzPl/BELqJl+zqh5zDD45skwGIQ9NZCiKYEbZUlI9mMDRcL
         9AXM89P79IS0Gb8GBUTpJWG1EON3z/DVe1ygh60CHiri5o0B1BVjfkEsiM2W+PYiD5EF
         C8J/91u+j5sDOc61r+XYi8wpVndF9JbGwDGFKZ3tgip8zWh1/xHlzf7wBvf+gw14ag7M
         2rooGQcIn8hDc65TGLO0cb3P5YDzYrg3Fo/Fr+qAdlfoNoIIp6wW+BwNI4KRf8XAN7HN
         LMHQ==
X-Gm-Message-State: AOJu0YxBOBhVIKwqE3c4ITJr6HDOFwn2CDWHPy1Bd39jq5oYHT5zcg/6
	wl1lgi9lprogJM12lEeY3WmTiKFhi4R5DaSlUNTjnQ==
X-Google-Smtp-Source: AGHT+IFncEqnUG825QYYf2ZFoIyy2us7AlruhLwTzoqQgAllesCEy82DXX//svPjMiK/UR6l43FxrwiNWQPGsh4ypL4=
X-Received: by 2002:a05:6214:4c04:b0:67a:c4d9:dc10 with SMTP id
 qh4-20020a0562144c0400b0067ac4d9dc10mr3977857qvb.109.1702290417391; Mon, 11
 Dec 2023 02:26:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-33-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-33-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 11 Dec 2023 11:26:16 +0100
Message-ID: <CAG_fn=V5zMxGUQ=KmJh-ghTUHa-AZYn1CPTQNbf3x7Lu0w=HvA@mail.gmail.com>
Subject: Re: [PATCH v2 32/33] s390: Implement the architecture-specific kmsan functions
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

> +static inline void *arch_kmsan_get_meta_or_null(void *addr, bool is_origin)
> +{
> +       if (addr >= (void *)&S390_lowcore &&
> +           addr < (void *)(&S390_lowcore + 1)) {
> +               /*
> +                * Different lowcores accessed via S390_lowcore are described
> +                * by the same struct page. Resolve the prefix manually in
> +                * order to get a distinct struct page.
> +                */
> +               addr += (void *)lowcore_ptr[raw_smp_processor_id()] -
> +                       (void *)&S390_lowcore;
> +               return kmsan_get_metadata(addr, is_origin);
> +       }
> +       return NULL;
> +}

Is there a possibility for infinite recursion here? E.g. can
`lowcore_ptr[raw_smp_processor_id()]` point somewhere in between
`(void *)&S390_lowcore` and `(void *)(&S390_lowcore + 1))`?
