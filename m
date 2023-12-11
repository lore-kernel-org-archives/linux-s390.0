Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3oPM32MW"
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D70F1
	for <linux-s390@vger.kernel.org>; Mon, 11 Dec 2023 02:07:50 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-425a76bb53fso18981841cf.1
        for <linux-s390@vger.kernel.org>; Mon, 11 Dec 2023 02:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702289269; x=1702894069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iQbib7KuYZwXSs7TOXR8fysQbrU5Bbc58V4j1zKqFv0=;
        b=3oPM32MWcY8r3m5sBp4v1VNAomGU5lj7AxiNK+O0xMiSzwfAKUPlxDcrC+x4vbKYAO
         l+9pCqXKq6sYAqeISnCZbUM4m+Uri3nTRbYWK4WQZde9bOze32l/RvDvTo7isRHBj2/O
         qB+hUTqacDqDX9ZzpI37vdz/0kEQQMRq1FHHwNwD/3vOuNGG/yJ5mWfAIKhtZrCZtDLu
         yenJ+mFitN/m4aQa5b7eHtBO8CG9/lHSOuS0wGV30J0s44Ugwkzw482n9PzRd9ZJqS9r
         rSnnUIn2rtyZXDfLdZtQGsO23nSg315limxo8LprB6eNTM9s0KKcaagGr6IVXzyz34Fs
         GNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289269; x=1702894069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQbib7KuYZwXSs7TOXR8fysQbrU5Bbc58V4j1zKqFv0=;
        b=vTVZS0ajq/dDbbCVa+aU0frJWsHm5JPf6n096AXsSXmyq4WVITCh2feNxqhLRfB1mx
         NGYQ+T9PgrPvUFTI5cyu5OqcdJIhdMdQaPTTm1A065lqp2yu0ktxrgHeofMeeEYbJnPY
         MP4vS1cX1C+kQA85mcg7r7IONgtIae1gH4u1a2ClJLYplezUqpdBbFhRBH7TI5uHzBy9
         +kk9zE0H2VVQrCw8XS9JlGzr3I63QPVrsh/560VgC5ah80MF1Rrg/O/rmnOAoX1QfEpa
         fMzsxPBCxAdNePKnz3YaJzmWKH2Gb8GgYfJkeYUQJK/siZNQn+gSo4sRcUjf5NvchAUa
         JtLQ==
X-Gm-Message-State: AOJu0YwucuyP57ysrV9nF/e4CPCBevuG0DIHbyZzQkCN/D+JynYgrjbu
	wnG2DKqUxG/tYs6FRcglA2qf72uwtBjY3ErCKYYVEw==
X-Google-Smtp-Source: AGHT+IEy7sdK9NHIsRzMOTl1p7qUMH4EfMKrMOKxVRFyC96ArAp5QDcDdvRP7e3vCBuus6OXQDRK9VpDPAJXYCPOaGo=
X-Received: by 2002:a0c:cdce:0:b0:67a:9440:2b26 with SMTP id
 a14-20020a0ccdce000000b0067a94402b26mr7123627qvn.20.1702289269049; Mon, 11
 Dec 2023 02:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-11-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-11-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 11 Dec 2023 11:07:13 +0100
Message-ID: <CAG_fn=WVfh_E+5uFs1GXfQCVMj3EBvNGFTrJ6_DxVb4t3WnVPA@mail.gmail.com>
Subject: Re: [PATCH v2 10/33] kmsan: Expose kmsan_get_metadata()
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

> +static inline void *kmsan_get_metadata(void *addr, bool is_origin)
> +{
> +       return NULL;
> +}
> +
>  #endif

We shouldn't need this part, as kmsan_get_metadata() should never be
called in non-KMSAN builds.
