Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WrWRZwAt"
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCD9173B
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 06:16:51 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67a894ccb4eso11926316d6.3
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702045011; x=1702649811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0j5IioITwyG/4BP+tqSeHc4KXtugt22zIQNy6+j6UA=;
        b=WrWRZwAtpkfw4vfemJLPRLJrK69voIyMiJCRba03O6Lnsm5A9G3nMKpU+uygsSIXpG
         V0fw0KAteakWBw3coannnaJ5ioNyd4STAfGc5lCI2EHXEfVv5V2vDkB1GrKG93BayMsa
         55Qv1t7HqdUNnkjTJX0838kjCXtfn97lc3FzyrJD8IB0HyUQ8xCLQ3F0UTy5bhYPGnAP
         RfYAERTM8yZsc4ce+ZvlbcgNbC6TWFZLRdouczS5e6VEJNvJUh8EguZWFFoM1u61faii
         F7Uga2X42hbYCpkIecybPcdjz5IwW8NBvBU7jWwfBB/OmH/kzcmk3BRYKfGBvkG7YGoR
         iRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045011; x=1702649811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0j5IioITwyG/4BP+tqSeHc4KXtugt22zIQNy6+j6UA=;
        b=HByMMmb4imiPhFFsKe/mC2QNirMdZs37qnYTnsbtqNCi15+RgvqlPeh5opWkUe92qd
         sZPZEgKvQqQgW+n8cQZKRQM5z1fVta/1svZvTMRD12Rh+KPuuWI4hg05PSXPpsYHLyuK
         oUb37XgRzTdFgRQSJwhL73onBh8RJnp9Gee6vNn8x3WUlkPUdwuHWUDpk8j1/jRz4Yaq
         Mabi5AHTYzVUa9sLdKTESp++dDSXvuX4sC8z6B54LdNjmvac523w0870FP8RTCsqdYBm
         lwaGuA1ZWwYGtJb1k8m7/wf2CSY0rmKVZN7W7yVSBZqNSmZpKVGi0CkUGAyL6m40bTPr
         acmw==
X-Gm-Message-State: AOJu0YwF4nm47iiPTMbQoEH+FMUDfpFJ6eUB5c4K+51/ffAIo5F9R4/2
	hlV2f/WiaE4ys24FzF611nwItOU7RSBateMaz9Wf3Q==
X-Google-Smtp-Source: AGHT+IFKfJa8W1iCMwjchi2t+lHUhYWH09qaDJjCUhvv9aw60UsIUANSwwIZQ5lRRrqoFrKO1oLXig0+0+CIwOJDPpY=
X-Received: by 2002:a05:6214:4a50:b0:67a:a721:8309 with SMTP id
 ph16-20020a0562144a5000b0067aa7218309mr3763142qvb.99.1702045010694; Fri, 08
 Dec 2023 06:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-2-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-2-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 15:16:10 +0100
Message-ID: <CAG_fn=WHf0t=-OJL0031D+X7cX_D25G7TG0TqROsT34QcEnqsw@mail.gmail.com>
Subject: Re: [PATCH v2 01/33] ftrace: Unpoison ftrace_regs in ftrace_ops_list_func()
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
> Architectures use assembly code to initialize ftrace_regs and call
> ftrace_ops_list_func(). Therefore, from the KMSAN's point of view,
> ftrace_regs is poisoned on ftrace_ops_list_func entry(). This causes
> KMSAN warnings when running the ftrace testsuite.

I couldn't reproduce these warnings on x86, hope you really need this
change on s390 :)

> Fix by trusting the architecture-specific assembly code and always
> unpoisoning ftrace_regs in ftrace_ops_list_func.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
