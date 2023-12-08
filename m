Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDDwHLv7"
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB991212D
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 08:51:11 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67a338dfca7so12968056d6.2
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702054270; x=1702659070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIcp9jypYULc/a0PN4uogFYiIDljiHAuDtNHVxk71mg=;
        b=YDDwHLv7SUyZKqLAN3Dp3qQ2a+bpKXd61JPV9sC/ojIs/BY69CbfdAf/3HMmJtKvIo
         xOYIXIpEKPRmzEzOTeLerjXq1EUeuggZUlkssAXPSYqJsxVruf5wXoBgtC+qxQ+u1Nsj
         J+vN5onqVkCDgZ/PvwNBbjR8gaIbVE5Vf/xJu+HRU1F1RjxEprenqLznBT+SJPkW5DrJ
         cFFtkUTSQVtTcB8D4yTMp88UUD84FXuAawzAr4qaxMNjkeX8YlzjJggChl5AEVWPO1+i
         OEmcw7+vZgO8zYqBF2XfNMHgoTFGriK98bH+3ci++yyTgwB24VRQUs5Z+RI28GAjV5E1
         jEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702054270; x=1702659070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIcp9jypYULc/a0PN4uogFYiIDljiHAuDtNHVxk71mg=;
        b=izK+L7ShIhEmshNynblSwS7lF8U9cL9p5p/GimI0CN9tQxxzs/jUz0t4ptOAFiJ3Sw
         zRoB2Zhy2ewztTzQRyHqbKCGQ6GR2kOswZASC+bmTF2TcsjBanrILgAo2ZOgtbLLq2Ny
         oEWwHCkAIBSlwSBX+pf3Kf18RiXg8/g9G0R5pXnxt6X748ExBUXp06UQbmgSHQS0TEU1
         JIlaJ/HvJXrcrUNmd6O7GJWMMlLspL6uLHnB9jPVXyDE4zH9OWHJfyAJm38TDzTe9ohf
         D6BSWtQckJ3fdUvFyYRF+lt7K8XnpbehBWI4WbyTD+0+U/qQ9zMYqVtFmzNeCgWGn8lL
         9i6A==
X-Gm-Message-State: AOJu0Yy/nmFKz/TugxBSSVDsFA8DDKmvHPAnXByo0xDXYbn4Vd1VyiXV
	Z5kLtqOhecHnCt43smguocVZ250ZTngIMVkcl8+HYw==
X-Google-Smtp-Source: AGHT+IE/6Nwbhf4SS9TLr4ojb1XW8J/22KVeKosnXzUvx9TzWSmL9hJNlMtz5gJPuHi3WKCMxewFNFHWT3ygW1WZWRI=
X-Received: by 2002:a0c:ea88:0:b0:67a:9a7d:ee10 with SMTP id
 d8-20020a0cea88000000b0067a9a7dee10mr256389qvp.0.1702054270555; Fri, 08 Dec
 2023 08:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-19-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-19-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 17:50:30 +0100
Message-ID: <CAG_fn=XQkhecLYFmJugOG+GawvDQ5Xsj5fTRbOAhU8Z5CfsjPA@mail.gmail.com>
Subject: Re: [PATCH v2 18/33] lib/string: Add KMSAN support to strlcpy() and strlcat()
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
> Currently KMSAN does not fully propagate metadata in strlcpy() and
> strlcat(), because they are built with -ffreestanding and call
> memcpy(). In this combination memcpy() calls are not instrumented.

Is this something specific to s390?

> Fix by copying the metadata manually. Add the __STDC_HOSTED__ #ifdef in
> case the code is compiled with different flags in the future.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  lib/string.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/string.c b/lib/string.c
> index be26623953d2..e83c6dd77ec6 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -111,6 +111,9 @@ size_t strlcpy(char *dest, const char *src, size_t si=
ze)
>         if (size) {
>                 size_t len =3D (ret >=3D size) ? size - 1 : ret;
>                 __builtin_memcpy(dest, src, len);

On x86, I clearly see this __builtin_memcpy() being replaced with
__msan_memcpy().
