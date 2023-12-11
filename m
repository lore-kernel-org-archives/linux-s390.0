Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z82uxumJ"
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C4DD4C
	for <linux-s390@vger.kernel.org>; Mon, 11 Dec 2023 02:49:55 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d3758fdd2eso40497857b3.0
        for <linux-s390@vger.kernel.org>; Mon, 11 Dec 2023 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702291794; x=1702896594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcKQpflfU4B5TCVP/h08UJJZWjI+RvIJpIXiYwS5E2M=;
        b=Z82uxumJs410fLvWZ+MsX7MAn/uD3m9CJEIHdCGkswx4mTsRZFKb+t68brB8HGfQf6
         z4wEczY3Uk4d5Lt2iCfDm2IAqNr9HQXrEga+T+mUe3Ognhs0xW7fidenVB5zF5/3N1qL
         lf9QAOGAepwBq/jcUuOfrnRLZomaaR3W0waBr6Oa5Idx1t9Tju3wAFhC16vq2hmiBbpX
         IxqSFt1scuLNfZlxlc8Sv1x5ezO8E4xn25TX8Z7N37sOS7fyiq6z39BR1O50L/Aj3NKN
         4rtlIBEpkIcTCflcA7E1PErLN0oRWTNK/RcEw0dSE19MIVJmUUrtCUF+D2h138JZH5i0
         PhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291794; x=1702896594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcKQpflfU4B5TCVP/h08UJJZWjI+RvIJpIXiYwS5E2M=;
        b=LfzfuYQcOND7P9B4kE50mVvXKijkH70ACRkywGkwFQ3vVYL7Y1kEXtDzpgIqG9J9cA
         UtIIDNOkxR8IKE8INpJrvBEaEvRNi+FQJwlVl/QsMaDetPjg4po5l0g1OeJbUwzCK4AU
         XutDjO9kAJe8wE6mkJs1v1StcjSHMUjQpyp8hye5MZEW8yu7+XgqJsMquLnj7olAZPUp
         wo6pi8MqVKhrfNkejWtbyh4ZYvvtCRnp2ln2AsULI1j2MazvjkBE1wdHOk04kuD10ARh
         C++V+lkc1tz0w19yvOY9crKR706d1tl9HzNvp/fkB2QO+zcMv+Xt4D7hA9+JMwv/eUNt
         1wKg==
X-Gm-Message-State: AOJu0Yx5AeNT6LspDF+eXdWkfNeptXhB+RawbGZbHx7pNbXqSoNOjF85
	YfkeZT6IJBW/G7lPtG7adWKq0lP/cBy2TNgxZB14iA==
X-Google-Smtp-Source: AGHT+IGxEQoVh4ByA2qBjx0LydjxUGju9YawLR3Q97ogewINErRGg6NuNwBnUwitc38zjtVfZw57S5a8HV/G/pvaPFA=
X-Received: by 2002:a05:6902:1aca:b0:dbc:5dfc:9d6 with SMTP id
 db10-20020a0569021aca00b00dbc5dfc09d6mr2177747ybb.35.1702291794335; Mon, 11
 Dec 2023 02:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-29-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-29-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 11 Dec 2023 11:49:18 +0100
Message-ID: <CAG_fn=WjEV4CP2RTX1xeuG=kd9Lj5X1Tf4QCRuNW-vzDUpzBGw@mail.gmail.com>
Subject: Re: [PATCH v2 28/33] s390/string: Add KMSAN support
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

On Tue, Nov 21, 2023 at 11:03=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Add KMSAN support for the s390 implementations of the string functions.
> Do this similar to how it's already done for KASAN, except that the
> optimized memset{16,32,64}() functions need to be disabled: it's
> important for KMSAN to know that they initialized something.
>
> The way boot code is built with regard to string functions is
> problematic, since most files think it's configured with sanitizers,
> but boot/string.c doesn't. This creates various problems with the
> memset64() definitions, depending on whether the code is built with
> sanitizers or fortify. This should probably be streamlined, but in the
> meantime resolve the issues by introducing the IN_BOOT_STRING_C macro,
> similar to the existing IN_ARCH_STRING_C macro.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
