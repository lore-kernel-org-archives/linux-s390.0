Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2O+yaqN"
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5849E1706
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 05:56:33 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67a91a373edso11883896d6.1
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 05:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702043792; x=1702648592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlUqBCSJE7b+NOWHxQNrRwEhp2gTAvY03mAPrdADOdo=;
        b=H2O+yaqNA/Ire4cgW0btDC0qdoE8ugqwlXmk/CYzER8bM8kWjsS5c9gg+INrHUH5cn
         nB6V3BVZijge9perTdtiFse/qsI142jfCN3L/JG3PCG+0nEpM+pE5rBtbYMHRG/P/P3I
         m1RhsF8rEtVR2/k9WDDU+EYEpLNwZp6ejIqz/wpVoMTv8GfvlWGbWocbheokZP46/L3Z
         RSMuL8C4kNBxUInWgM1wnV1m+MfncrUKyrH7gQXYrMFNos+z7syaA17HyoHcqPXUk6eA
         Kxo46Cvmh6T2vr7s7D7CJu+IC+y+ow+nz8YZxTViB83+8eU+wpo04jKShu/JSufgeZ5g
         a/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702043792; x=1702648592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlUqBCSJE7b+NOWHxQNrRwEhp2gTAvY03mAPrdADOdo=;
        b=pJgqtnZ9bYZfxADcBCHuZSpLhv4pNSPDNyFf6DgxXTb+tzfHqgE5PCnRfw+gvF+rTY
         N4U2+ROh8abBiErtZoc9NMbNQoM0Ci2Wv515JLnX8gC8fT4255SSer3x7vYF6Fj/6Pnw
         sRzaN47heupuqU0NkunisVPIJEXDtp9LyQ3zygYtw03fLlYwaJlhDlyisdPRVbbaxfOW
         CyNkoFmF21F+VkvWiMpUnZtGxe8Q89AV8eED4ETpt2fd/8S+fY5lPHRI9E2m+H2diaSX
         98CugA6k3SWgApcID1tR4PGoz77IFoAGLYDGKSNAEImKF3p97uuvJKxgKv2gJ20DldAI
         88iQ==
X-Gm-Message-State: AOJu0YzwwgpDxXi3s0X90u7hzytsGE2U5KYes3DzrqIcDYYRtoIIZWv8
	jtkCQRH1UG+OxUqK1aLqj0V5qWcTUNOl1A5bWWlIdg==
X-Google-Smtp-Source: AGHT+IH23iVUpBsOBONYMPHwppBBTzpfL3Q8/bvfC4kzRpEJUfOAA07YjvKi0Z4sAx0eXzRBOWPNA1eAjy4CZz3bJdM=
X-Received: by 2002:a05:6214:5802:b0:67a:a951:7fc2 with SMTP id
 mk2-20020a056214580200b0067aa9517fc2mr4258051qvb.119.1702043792410; Fri, 08
 Dec 2023 05:56:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-18-iii@linux.ibm.com>
 <CAG_fn=Ug6MFyoj=J_yabfd-V+3vGYNS3-CS+fhW9Tsc847xMtw@mail.gmail.com>
In-Reply-To: <CAG_fn=Ug6MFyoj=J_yabfd-V+3vGYNS3-CS+fhW9Tsc847xMtw@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 14:55:56 +0100
Message-ID: <CAG_fn=XbDFa_7BWMzR5cVEVp-GuHxK2fyFAZJgXqXb8qL1ZhAA@mail.gmail.com>
Subject: Re: [PATCH v2 17/33] mm: kfence: Disable KMSAN when checking the canary
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

On Fri, Dec 8, 2023 at 1:53=E2=80=AFPM Alexander Potapenko <glider@google.c=
om> wrote:
>
> On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.=
com> wrote:
> >
> > KMSAN warns about check_canary() accessing the canary.
> >
> > The reason is that, even though set_canary() is properly instrumented
> > and sets shadow, slub explicitly poisons the canary's address range
> > afterwards.
> >
> > Unpoisoning the canary is not the right thing to do: only
> > check_canary() is supposed to ever touch it. Instead, disable KMSAN
> > checks around canary read accesses.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>

and even

Tested-by: Alexander Potapenko <glider@google.com>
