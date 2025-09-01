Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46A030F923
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722021; cv=none; b=mho2xtBSlfwFEtORrt0p0Q4RHHptWg4XJPo9A9e+1sp0cL269VFcXy7Lfq6tK5fz3ITtGK78wLnGeyTNM0vXFnVu/k9sWx6ko4Hr2jr46xO62zMcZUASy8r6t/98NL41sQ0xTPG8n3cjNf7qQjpACtsV9DyeObduhLsZo+2gWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722021; c=relaxed/simple;
	bh=YyqGpmFOP1CozESKRlIhwf69hgCDF5ny5+BECrJEMtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qg4GXn6a7/+2VPrUtciSkZx6As87A1qFzhacoZK+tWIA93OSkvM+DSV8eSQ2ArXSI2IdqhYdI4szmEyfpbOL2osOxgTCHhWFAnMhDMn2vNSd8g/ZdZSqRSS2rsG5BR6fgsKtN1cU7pKZXSWZKxj3rfjPviSFbZSNQD0fWKuMq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EZ8zmMsB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EZ8zmMsB"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b00a9989633so344390566b.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 03:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756722018; x=1757326818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyqGpmFOP1CozESKRlIhwf69hgCDF5ny5+BECrJEMtA=;
        b=EZ8zmMsBjqU4jyjvoxZj/rhv2EZPok4JnYYvhsLtaVBtBqSLjoo+Qqy6KB61NOTIO1
         UNeNzLzZwgEYyF5GYzM7Qn7AOd8TxxVQS4Pt58BgqvtwugF9D7kVZjfw2clzKaPS9HgU
         YcWkk6RTGlza5Mz1Pi+mGnjvuGZ/ZqH3Ao2rmxLuJFoxjmBjVFLhHmmYb9Bh5XrlFYTv
         YuksFGl7GsV+VVn/OmDx+GqNaiGBNov8QXto4KdEEf6a7nPAWirNuW6NffZLOtfI33v1
         8SNuVah8ddpKUwjUkclTu8/MPZR8YRkcGI2ur2SB5T6Xzsy+Ku+uPO2rZR5etTdFBJQO
         KzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756722018; x=1757326818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyqGpmFOP1CozESKRlIhwf69hgCDF5ny5+BECrJEMtA=;
        b=Nm2/eEAj4k+w+NkAZrjmBh4Ms08XU+qdOz5moB0mhGGGrLn55NlwnD/9flVvweDUml
         j7DUKGkDNfegEpeFxNH/hkuOShkFEjAYZ0x/A8aaENzg686g3jtHRsNmDL9rVfkQSZE9
         oSNdSHRbmVAeuIxwlN7+R33GCXOpPGeWvxhlDGjHlkz9J3BxUH0lfZwoxJZieQzU2fwq
         StbyL2tta2EQFj6AUr97ceCXZJCeVkwHV2JSTOjGDDQqDO47nmzAmCjnvR3x4fFvi/x3
         qSIGYyZ6xVowousFwA0LWVCcFV+Pkmz/ctV9O9H0V1W5jFAyBMR/TX0SjpMgW2WNrhPs
         m+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXz76JLpI2bq7DowdTYCIIEny0ZC1tymhRHtGIr7dofsmJLVqAtfzC8qiiSLS5nNW4cKWWvPl5eJH12@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0GfLj7OTDDgQ5MaYlInbSMYU27h91oFfdGltTc3E7VrhjwMZ
	QPuloVH7nFr+zK/gVQZYds7Eh6ULNIBhowAoa4viadwTLxueJ2RIEYScE/RZsoDW0u25FMw+ZG6
	aADljAND65UY8iuUIk5kILAcYpgGfh3psuc//UMqsGQ==
X-Gm-Gg: ASbGncuIpygrCSwdtEtGothyiS0iNbgj/9yN3VBVHSRKnF2EAtHILMdQD6bF7151ihQ
	xqWQCxFz7QM+IAWN5NWmrOsRP4nhBAl5qPyS+OW3kmEB/Nf/xrglQL9n9GCnvJh5aOcRfljo+Rr
	baaRSp4mj3zZz98xB3rDnI64N1fLaYahZPT+pRHMzi/ok/9tZ/MgKNMeAvEs0hw/ihLOYuaUDTb
	gHM7g+wqAALSfbfPrFyjM0WhUuzrhSshajYJO8zkTlAEw==
X-Google-Smtp-Source: AGHT+IHRKz+wtDfHjdv0i5A+vm9diAzSXKsWI+GdPRTMwnCU9IQk+aGQJmcC+iBCuiF2MB/L2hTHURmHYAPvlQUwTmg=
X-Received: by 2002:a17:907:1c9f:b0:afd:d62f:aa4a with SMTP id
 a640c23a62f3a-b010817fdf5mr709865766b.9.1756722018168; Mon, 01 Sep 2025
 03:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
 <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local> <CAKPOu+9smVnEyiRo=gibtpq7opF80s5XiX=B8+fxEBV7v3-Gyw@mail.gmail.com>
 <76348dd5-3edf-46fc-a531-b577aad1c850@lucifer.local>
In-Reply-To: <76348dd5-3edf-46fc-a531-b577aad1c850@lucifer.local>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 12:20:06 +0200
X-Gm-Features: Ac12FXxSSqkbs-4UPdELMOg7slq5QVAQH_82ZObPwU_IOehvXv6qgw0xhHiTSTM
Message-ID: <CAKPOu+-cWED5_KF0BecqxVGKJFWZciJFENxxBSOA+-Ki_4i9zQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] mm: establish const-correctness for pointer parameters
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com, 
	linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com, 
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net, 
	jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com, 
	shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org, 
	osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au, 
	nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, conduct@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 12:04=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> +cc CoC.
>
> On Mon, Sep 01, 2025 at 11:54:18AM +0200, Max Kellermann wrote:
> > On Mon, Sep 1, 2025 at 11:44=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > You are purposefully engaging in malicious compliance here, this isn'=
t how
> > > things work.
> >
> > This accusation of yours is NOT:
> > - Using welcoming and inclusive language
> > - Being respectful of differing viewpoints and experiences
> > - Showing empathy towards other community members
> >
> > This is also not constructive criticism. It's just a personal attack.
>
> It is absolutely none of these things, you admitted yourself you thought =
the
> review was stupid and you used an LLM to adhere to it, clearly with bad f=
aith
> itnent.

There must be a huge misunderstanding somewhere. I and you guys must
be talking in a completely different language. None of that is true
from my perspective.

I never called any review stupid, nor did I admit that. I disagreed,
but that's not the same thing. Remember when I told you "Let's agree
to disagree"? It's perfectly fine to have different opinions. Please
don't mix that up.

> >
> > (I'm also still waiting for your reply to
> > https://lore.kernel.org/lkml/CAKPOu+8esz_C=3D-m1+-Uip3ynbLm1geutJc7ip56=
mNJTOpm0BPA@mail.gmail.com/
> > )
>
> Your behaviour there was appalling and clearly a personal attack.

It was not. Maybe you felt that way, but I did not intend you to feel
that way. I would like to find out why you felt that way (because I
don't have the slightest clue), that's why I asked, and why I'm
waiting for your reply. If you would reply, maybe we could clear
things up and resolve the misunderstanding.

It sounds like I won't ever have the chance to do that, so... farewell.
