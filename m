Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sosVTcFy"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262B171D
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 06:18:53 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77f3b4394fdso89472385a.0
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 06:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702045133; x=1702649933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4aUU7dNjS/w6j2yOU1hBuNM/NL6fqAI1SOBM3IICMA=;
        b=sosVTcFyu2GzDo3ZpJ9JYMr9x8cL+nfMjaYe5l6NX8B6UjAvCK8scD//SXdLHsQqws
         8jver1uwXhTGs3Brw/1qWLHLetD5hgsBf5HaZTlga6jQWFov3IlLaBKBU+g/++aPAvka
         IkhhPdieQJvvQduKvns0CaQ6/T1tVGY7TVWPzKdgWurcQ+bqI3XAVicUoqyyXYeES7Yr
         sy7h2SbV5iGg5IC/090vF8bmTMkF1ByDo0Qhtgg3TcDBqOqm7apNDxsla22HOA4c7fl0
         W03DqmLDlqNMuXrHeiy14+TMGkKSbv9dfog+IzqfpOO/JlXiLVEPPaxhI94SW8xe9ml5
         lB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045133; x=1702649933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4aUU7dNjS/w6j2yOU1hBuNM/NL6fqAI1SOBM3IICMA=;
        b=AIrUG8BuSNQpqY1ZFbVPUVio8XTiuwFryMi8zjWy2tq/9XFYAitAkXhnb1lun5deGR
         xYP/lnZj+5Q+2BOYjlu78Y4jUtLQSmNfsrlGGpQe+1fia4D/De4Qf6uLIIo2FoG2SEsf
         rnp+TrcY5MAWjhgO/rUbFcvbTIlZzxGIzCCthJCeIrk5oHaG22FA6ODegTThNPyq27YT
         FmzN4qAbAP2oN74QizM98zc8/62+L1Td10YnZ2HFXYLydQixoHQxsoovaShzSvsW3wI0
         uSCzcJmKOjD0Abqa2xA2BqQH+pGZDuV9syAQlcfeC8KYIQr8CXutiR3zbrp4wL22+Zy6
         kFag==
X-Gm-Message-State: AOJu0Yw72mF+pTFYOqaNV8BMQofWMmHWDQIVcB35u3oCmuR1gd7k9N58
	0Zhu7I+YhZS8JF78Myao5lGpNJEE0JnVRgskwSkwog==
X-Google-Smtp-Source: AGHT+IH8EMqb7H0OjwmlXGKXc/KMyqDWbzvWyGHpM5I7Qm/vaxWs0Al1SPzWhhi4fZH80FWJcx2+zkplz4DLr+7aWfs=
X-Received: by 2002:a05:6214:1023:b0:67a:be9a:e9df with SMTP id
 k3-20020a056214102300b0067abe9ae9dfmr23702qvr.17.1702045132939; Fri, 08 Dec
 2023 06:18:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-27-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-27-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 15:18:16 +0100
Message-ID: <CAG_fn=UBaF8SnvJ4t4wbBZKbNEBWRyGBY=FA+CTB+k2+pa2qEw@mail.gmail.com>
Subject: Re: [PATCH v2 26/33] s390/ftrace: Unpoison ftrace_regs in kprobe_ftrace_handler()
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
> s390 uses assembly code to initialize ftrace_regs and call
> kprobe_ftrace_handler(). Therefore, from the KMSAN's point of view,
> ftrace_regs is poisoned on kprobe_ftrace_handler() entry. This causes
> KMSAN warnings when running the ftrace testsuite.
>
> Fix by trusting the assembly code and always unpoisoning ftrace_regs in
> kprobe_ftrace_handler().
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
