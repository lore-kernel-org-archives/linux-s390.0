Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmK2XbxC"
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE808122
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 08:57:05 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67ac8e5566cso14264226d6.3
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702054625; x=1702659425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7eBdMYz2oO1gCYv2gO3b03vyzDyBixdRfjwy6xmbYk=;
        b=PmK2XbxCIv3dIWNCXiX6whjWumGAUc6xF5Vo/I/DNguZMP6/AsTyAAF33DgKQjsU69
         Hy+a+8Vsqf1eFR+dvvO4N0R8iA3lHLf2z2xLk2ioso4X+JVX7PvxpNZk9aA861nTMOGC
         ozE1gdUK5vTQESIwfQS8jZHFUp8l9inF7ABOzL1Q06E/iNKqmcDt80fC495/+NtimrBa
         PkeRnJKPT8ws4rzxnaIZVHfwnvDf0NtKq+CoACtgp7v+RMfUSdJv4tCLgrf46MJ4eATg
         oiopZPdry7Iuxvi2BJFBMxINisVddJ4Ue5X1R7GgwP/WJppiEA2XEMD7yYx8/KMD50y0
         XnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702054625; x=1702659425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7eBdMYz2oO1gCYv2gO3b03vyzDyBixdRfjwy6xmbYk=;
        b=ZD8DBBORx7Hdq/NIZId0VJ3pyqz3znbMvYSRwT0uhq6P0m5OCnESb2aSMIeb28unqZ
         +lvge2gvDGXsj3VLENkVcNTu6bCuN/frJ+af2+vsbSM+dozjYFpx6zbfaShVEVTEn1Xv
         H6OggofArvMYZdTIYdcL/q2siaQUwJBoVwhKT9fCrN/h8IEVMmRmQFysPuGWSTSdNNmh
         uMZf6B6iNT26vDoaJOwnAKNr2Y49tEDT+ACy7zLaSeVLsIjKZu3eFx/tl6Osd+QMNdzJ
         MmLBTfFRzeqOb8SaJTQcM5glg3RNjSa6A1FmA9x/av6oOUnYlpJ3DsyDAt6qk0B1ImH/
         LPJQ==
X-Gm-Message-State: AOJu0YxqwonEGZKO2096fYCg7noTZR0rjrv2hhowVkH9H+ENzowuqh/x
	x6K5meQkF7ao3NXrwWuk784ARbgiu+7Uh4wt3iUS4Q==
X-Google-Smtp-Source: AGHT+IFqYgMXAGDwUGZm2GmXNNwAMogbqw1hEfBIGvEGXG3bN5nU/GorXmHvariAzFFNL09Kz1paH2mUu+0Ssar9SoY=
X-Received: by 2002:a05:6214:d0:b0:67a:49c5:8cc3 with SMTP id
 f16-20020a05621400d000b0067a49c58cc3mr269853qvs.32.1702054625028; Fri, 08 Dec
 2023 08:57:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-24-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-24-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 17:56:29 +0100
Message-ID: <CAG_fn=UBt2A75bOgZmh7q_dS08d0PD8wJRHpoJyUDXRPRk_exA@mail.gmail.com>
Subject: Re: [PATCH v2 23/33] s390/boot: Add the KMSAN runtime stub
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
> It should be possible to have inline functions in the s390 header
> files, which call kmsan_unpoison_memory(). The problem is that these
> header files might be included by the decompressor, which does not
> contain KMSAN runtime, causing linker errors.
>
> Not compiling these calls if __SANITIZE_MEMORY__ is not defined -
> either by changing kmsan-checks.h or at the call sites - may cause
> unintended side effects, since calling these functions from an
> uninstrumented code that is linked into the kernel is valid use case.
>
> One might want to explicitly distinguish between the kernel and the
> decompressor. Checking for a decompressor-specific #define is quite
> heavy-handed, and will have to be done at all call sites.
>
> A more generic approach is to provide a dummy kmsan_unpoison_memory()
> definition. This produces some runtime overhead, but only when building
> with CONFIG_KMSAN. The benefit is that it does not disturb the existing
> KMSAN build logic and call sites don't need to be changed.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
