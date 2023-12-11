Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCSFYlSx"
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D3ED7
	for <linux-s390@vger.kernel.org>; Mon, 11 Dec 2023 02:14:03 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cfc3a48ab2so35490327b3.0
        for <linux-s390@vger.kernel.org>; Mon, 11 Dec 2023 02:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702289643; x=1702894443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z6zY4c0Tb5+ieU4d3Nz6Jn4MLK8nHKOQpLlbBpEjKg=;
        b=NCSFYlSxaMBXjGEeo9r58onG6AqzMDuUvTpfYB7xy1IT+ia+GZbt7Y3b7ivuFErQis
         qGzAtEYfMDOI0O+bMzCTklMFkQI8m36CqZHD9qClzyaVvPFR0XU6tXeYei0SfuIohZA3
         g5YRmTWwUZx8vZdTGOcw5Aknqj2f6oh1Nsbyo5OKXYMcUoc0nDYv91KoSDBJyZ3rnZlm
         Ntiku1i/R5DHBday/ia+Nj31jiwNxr6l3QT3rpYE2y2TbVRrO6dKcB9cbtSLUehEUlLV
         oGEkH7ngxQqx14u/IaWe1SuX9yJ73+lXUab+jhwxMg+yDau9RZUnmzqfRBTmJbGubwyb
         XETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289643; x=1702894443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z6zY4c0Tb5+ieU4d3Nz6Jn4MLK8nHKOQpLlbBpEjKg=;
        b=XA1tiLHOnKNJ0ATBERW/lMoMEnlsk1B5UbP31C5h1likuEIF5Lq7Z5lsnI5qfYqL08
         d+P3Xu5J7x6in6Ab9JkD1nRAchQ2FaJT8y12s+XocNj8wIyfCYeREMJ7m0zgUC/jU+C0
         tvxxg82XTG42sLrQfGdQIW0uEB0rVakpal0sAaEGayJE5CCXlHssYsTr5mBJkwS6spRA
         CKAgKAZCskJf3Q7TgQiRUpAe5d7crejKbhRC15vLPQsQNb1gYqueLKstLkTcS3YTRXdU
         WEa1M3UmvnBuo8SSoNQo691AhhZEqR2SP8yBskG4FYrrooqNF8lHbwk7WoENepgmEqQg
         XnYg==
X-Gm-Message-State: AOJu0Yz1BYsuVPijF8DYl6UyDO7YUdyZ6d0uNr+9MCgixR+LKFa6GyLl
	7xazfAaDHa3cHtlcHMjTgYu+x/vktNpP+cjO2mCyeA==
X-Google-Smtp-Source: AGHT+IEk5OVTZiB661DV5dZOhAvgOHAleqdnumLHRqN/Lk2fp+rcFjIzeAHjQGdOci45RI7ZRYsN0u4klnWKa7xixF4=
X-Received: by 2002:a05:690c:3249:b0:5df:4992:9f90 with SMTP id
 fg9-20020a05690c324900b005df49929f90mr2222920ywb.34.1702289642775; Mon, 11
 Dec 2023 02:14:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-28-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-28-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 11 Dec 2023 11:13:26 +0100
Message-ID: <CAG_fn=VE7M590AqPceT1qjtf7qS1QGBfvnprz9s=0U2WgRmK6w@mail.gmail.com>
Subject: Re: [PATCH v2 27/33] s390/mm: Define KMSAN metadata for vmalloc and modules
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

On Tue, Nov 21, 2023 at 11:07=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> The pages for the KMSAN metadata associated with most kernel mappings
> are taken from memblock by the common code. However, vmalloc and module
> metadata needs to be defined by the architectures.
>
> Be a little bit more careful than x86: allocate exactly MODULES_LEN
> for the module shadow and origins, and then take 2/3 of vmalloc for
> the vmalloc shadow and origins. This ensures that users passing small
> vmalloc=3D values on the command line do not cause module metadata
> collisions.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

(hope some s390 maintainer acks this as well)
