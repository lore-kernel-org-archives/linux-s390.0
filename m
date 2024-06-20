Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85B17554A
	for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893185; cv=none; b=bKKKIQXSZBUXqm9qyffsSSxU4PHr84NVKnsBdRBkc+Gjb+sWIb9QOIQWkD+fFa4x9oUclKng109TM4IJhLj5bWfWHQEHszZYbVreQ/qfi3Sltp/gXsf8WeYX3SJSFv1vpOuo+8WZOz8qU++tBQG3cRmv4G5/Fo0bsO78brD2A4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893185; c=relaxed/simple;
	bh=abQgNmtRulhb91gD2TsheJQ4g1bpo785JUq7/ZYZy3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jv8d4yYcCV09o1qh3odgrVceJadSsYLg8CwpeisngXU6TxzvR8XBSyWmnpyel+tsP8oXiCy45bwmaJjNSb/H6+3nWPGmZCF3o2I9f+heTMxVveDuxy7ErSNVbHt6ORyK4IZBqaruwBWt1jBgPAzlkjmeOQLRQ+KODUzzruWG0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IALLc9V5; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IALLc9V5"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f361af4cb6so394906a34.3
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718893182; x=1719497982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv+xOEqws+KjvoyS4k7q1BnMnYne+DLlcGkvkV1YXWI=;
        b=IALLc9V5imLL7VTfHVbdkAz17yrVjApMNA4Yzu9ztPzdX8aJsLf8axFimeA5ZhKQrj
         NJM/Fv4oue15cbHdrAIS7zppPSHzcfFajPSu+rCLKe1J8YyvnkEuj2WUj0NjCb/TfZpv
         gvmzDlyrwKSaxfmUY/vbzeO4DRe0OSbe/o0pQ2QOHxVmoFTRtZpN92iFfWPrFRoshWBc
         w4pvcBXKebElc+prOPf+UESE5+GNeP4WTuk8MzpAqtOpH0CYkGNNDSlPK+VfdRhVjody
         1GggdzEoi+aSMPEYZKrP0ap+HFc5mzrYi8xaVz1HLrUZwbi1MR8++WNfGSq6ia0HbLj5
         MENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893182; x=1719497982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bv+xOEqws+KjvoyS4k7q1BnMnYne+DLlcGkvkV1YXWI=;
        b=BFmM3Mg4FbD7sLmKdKRnMj64YIDjlZKfjsBtVHkBZIz8y6ji0o9hKYTyofSsOpp9et
         18vizeFrz1X9vdvd2PUgHsNBpuiLYIR1TfKgnAc0UL74RjwB2Wa6I3aWF5hico0D72Mj
         SA2dn0/H2AasEuF/iuV5xRm6h8mgiZ8RT+5fq3ZYaHBfvnA8KyV/MxBOY+7CC5aC+c2Z
         2cokQs3g5lrs0bNv7r068POFsmQ6PZP0dkNcYdpUwoIl4JrzCD1Ktwme3OTf8LE+biAW
         KmM4rPADJgSxi3F2VyUKDcnq4jiAIrqU4tHDmD9qz/zK9gBjT5nrg1K/fKaa4GgfHoeH
         HFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwNHUV6ou9OOK7BxKt9WF7LyXhgkDlf27u6cTVP+z5+iafIOJKhnh7fi+nuw78K+hNOqsLmwS62fUQSQ4zwfrZIwH3ed6BoBqWBA==
X-Gm-Message-State: AOJu0YwPLj6tLKevDoIhKEgMM+IY8pfAl+4VW3e+XGlTXLZD4mfg6zzz
	jRc3Sp3GPQngCKVRSPXCDLRtolOXM+W/Ys/O+8tnxl3J1EUcmDD7Mn9sxQdxTnTKAQqY0TDG9BZ
	aFsx6CoZPWWh2UFiX95dRCRAMGuSVKrKHMRZ3
X-Google-Smtp-Source: AGHT+IE09fsEZr9ZoSHdbUKHBdTeeBAjnGuixlRzRpM0AHsB+sO1SZNTjr1raJ9+9DFih0kA9gjaCoNKe5irm0Thh/4=
X-Received: by 2002:a9d:5f14:0:b0:6fd:591d:9e21 with SMTP id
 46e09a7af769-700771e7dc8mr6110157a34.33.1718893181456; Thu, 20 Jun 2024
 07:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-37-iii@linux.ibm.com>
 <ZnP1dwNycehZyjkQ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <f6ab5d6e0aa90ad85e239a2da9252930ca9a70c3.camel@linux.ibm.com> <CAG_fn=V-_8q2FDEDtvcNmS3rizPEM-RX+vHPrus4ECNx6AZfGg@mail.gmail.com>
In-Reply-To: <CAG_fn=V-_8q2FDEDtvcNmS3rizPEM-RX+vHPrus4ECNx6AZfGg@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 16:19:04 +0200
Message-ID: <CAG_fn=XcDDFBAxq_0pij0VFU7ODJ6cUKd3AqBD-EgkbfnSLJNg@mail.gmail.com>
Subject: Re: [PATCH v5 36/37] s390/kmsan: Implement the architecture-specific functions
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

On Thu, Jun 20, 2024 at 4:18=E2=80=AFPM Alexander Potapenko <glider@google.=
com> wrote:
>
> On Thu, Jun 20, 2024 at 3:38=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.c=
om> wrote:
> >
> > On Thu, 2024-06-20 at 11:25 +0200, Alexander Gordeev wrote:
> > > On Wed, Jun 19, 2024 at 05:44:11PM +0200, Ilya Leoshkevich wrote:
> > >
> > > Hi Ilya,
> > >
> > > > +static inline bool is_lowcore_addr(void *addr)
> > > > +{
> > > > +   return addr >=3D (void *)&S390_lowcore &&
> > > > +          addr < (void *)(&S390_lowcore + 1);
> > > > +}
> > > > +
> > > > +static inline void *arch_kmsan_get_meta_or_null(void *addr, bool
> > > > is_origin)
> > > > +{
> > > > +   if (is_lowcore_addr(addr)) {
> > > > +           /*
> > > > +            * Different lowcores accessed via S390_lowcore
> > > > are described
> > > > +            * by the same struct page. Resolve the prefix
> > > > manually in
> > > > +            * order to get a distinct struct page.
> > > > +            */
> > >
> > > > +           addr +=3D (void
> > > > *)lowcore_ptr[raw_smp_processor_id()] -
> > > > +                   (void *)&S390_lowcore;
> > >
> > > If I am not mistaken neither raw_smp_processor_id() itself, nor
> > > lowcore_ptr[raw_smp_processor_id()] are atomic. Should the preemption
> > > be disabled while the addr is calculated?
> > >
> > > But then the question arises - how meaningful the returned value is?
> > > AFAICT kmsan_get_metadata() is called from a preemptable context.
> > > So if the CPU is changed - how useful the previous CPU lowcore meta
> > > is?
> >
> > This code path will only be triggered by instrumented code that
> > accesses lowcore. That code is supposed to disable preemption;
> > if it didn't, it's a bug in that code and it should be fixed there.
> >
> > >
> > > Is it a memory block that needs to be ignored instead?
> > >
> > > > +           if (WARN_ON_ONCE(is_lowcore_addr(addr)))
> > > > +                   return NULL;
> > >
> > > lowcore_ptr[] pointing into S390_lowcore is rather a bug.
> >
> > Right, but AFAIK BUG() calls are discouraged. I guess in a debug tool
> > the rules are more relaxed, but we can recover from this condition here
> > easily, that's why I still went for WARN_ON_ONCE().
>
> We have KMSAN_WARN_ON() for that, sorry for not pointing it out
> earlier: https://elixir.bootlin.com/linux/latest/source/mm/kmsan/kmsan.h#=
L46

Apart from that:

Reviewed-by: Alexander Potapenko <glider@google.com>
