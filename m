Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9C1E2309
	for <linux-s390@vger.kernel.org>; Fri, 13 Dec 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102430; cv=none; b=ul1rSo1bPa0tFu9RyDg9/jCMb+cikYw/C6hBCXSJfmqmFoHmWtCtQL78j8yZbRXigAnAt1J230kXRnMZE/U+p2InAD1wQQpa3Ambd9Cv8GyH0iNo2/aUNQjunQmwHRilKZrVffuTFpJSg2Zmk8l0Iq0TN2/zsY6irN0JcRHUIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102430; c=relaxed/simple;
	bh=KeUbuHRKIgv/HogaL/+ErSJahryWzkcm/96Y35zfph0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jn1J8QFK7IIWuzs4M5evC4WzjJoLUfjyqycmdKpGe+jab5Cc1ZCwVrpMw+3k2yDxLhOwKSIxzGsmw7HRiZh6jHFCnqhuRjRuJLeq52KfYUhq2DyeCxCLfPmKICS336XnDSa5l8xAQlyhOFXGQ3mCWILnKnS8GZl5GNtQ8p2enV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dioN9aaw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dioN9aaw"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163affd184so114845ad.1
        for <linux-s390@vger.kernel.org>; Fri, 13 Dec 2024 07:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734102428; x=1734707228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOK+EabcLART//wNWq/2bx90ZPHXhDUCyx5nSPtp/mo=;
        b=dioN9aaw/9KMyHpTwSNpp4K2e23br1VUICzq0u7sx/Z2OEIT08f10GnwlPi1FkVhdT
         A8NKn1q3C91kwEPoLS6wYmjZvS1vxfY+t8cVqAqyMQLHWjwybzu8Bn0UEUAMLteCYJNb
         b7AM5IZt0kn77HIEcfGmrve4zEDEVmbuYHnYhPEbmqsAfNow9Bkost0+4+cPi8OOptcH
         gF+CS4pJLqSjF2abo0DXwFHi3zvNTt4k1HitUlvFLvGJiqYu2/QEAykQ7gjOxg2mAMD2
         kP6f0RWNw9jWPX/3fb/mhOihWVLSog9DX8StQv10FIEAi5bG8vgK2T/IeK0ovRky0BWQ
         YRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102428; x=1734707228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOK+EabcLART//wNWq/2bx90ZPHXhDUCyx5nSPtp/mo=;
        b=AHsdMpM1nXSmkuRKUAIRzNimHHsv2X9+2N1EIMw9kGRDQGezOOMAsFtcPHp7L3dJ0u
         RQm8yUUvmA9BFYhGCZ6OVAcvH3E4eD9OJj2SIXLYrBRLmabUQXUc123A3yheGsJJuqfu
         Q6ei3EclgtiQzkQz8rZT49zbAAnfUBkPn4l0rswzPFM1cxQjTCWOnPH736VLqTgZj/ya
         SszFESv8Kb+6Cq5dGYHoBxzcgguSMTz1ksDuwZso+fvnqL111jbn3tMv/X0CyO992aKj
         3QYZT90793dYlHaCwMU3t+i2no471drvTDOSYxl0TC1iH2zElACbYHZYjgzuKzqmUmOB
         XG+g==
X-Forwarded-Encrypted: i=1; AJvYcCV8yP8NFLwOmiT0B798Glq5u3N3RThF88d236U/rzdYLFHCS+G+vQ/230L5H2yU/WoIbNCE8xJ2ob46@vger.kernel.org
X-Gm-Message-State: AOJu0YyyiGrhkrNqJ2hKq/dh8pipdw7p/gxoVid9vZQY1YIjjRJxjtIB
	VVp5iolro75yc3H1UARYRC27/FBEadSB1iEJQe6Qk4bgohuSjiPcFuYRNgn9CHx8anfFVg8pWd4
	/i6MNdYtdif8PI+6Yx6M/RFkHRm8EU6a/TA60
X-Gm-Gg: ASbGncvL3FYId9JlDytW08Uu3ccMJI/nqmTYzEISGVhLW4qYby/+e+sA2MpdWkal0Wq
	D2IcoWFmYGDBoFwUGzJjAucTZ5ORfb3DY5nKqZw==
X-Google-Smtp-Source: AGHT+IEFkkLrbUVuE/cQvOQQfUpzDKI51xwKn+aUa2wuLKN/e2/s4qkcLn7DHuV9QVymd56Ir4cx8C6BN8kJhz8qssU=
X-Received: by 2002:a17:902:da82:b0:215:44af:313b with SMTP id
 d9443c01a7336-21891d3ead6mr2786695ad.0.1734102427757; Fri, 13 Dec 2024
 07:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211232754.1583023-1-kaleshsingh@google.com>
 <hmuzfspqjzb36xlj2x44keihacrrhzj5madqrfbcnhqouzredv@wo75achgkuh5>
 <1818e2ea-f170-4a9c-8d93-2a24f2755a41@lucifer.local> <20241212173609.afd41d1dffbefe0d731ed4ed@linux-foundation.org>
 <695eabb8-ba28-4031-bc4d-66dc4f1d096f@lucifer.local>
In-Reply-To: <695eabb8-ba28-4031-bc4d-66dc4f1d096f@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Fri, 13 Dec 2024 10:06:55 -0500
Message-ID: <CAC_TJvcdz854DmBoVRkb_B5j+u-t=4zHkLtHVeB5RJ=bXcBJag@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2 00/16] mm: Introduce arch_mmap_hint()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, vbabka@suse.cz, 
	yang@os.amperecomputing.com, riel@surriel.com, david@redhat.com, 
	minchan@kernel.org, jyescas@google.com, linux@armlinux.org.uk, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 4:00=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Dec 12, 2024 at 05:36:09PM -0800, Andrew Morton wrote:
> > On Thu, 12 Dec 2024 22:51:34 +0000 Lorenzo Stoakes <lorenzo.stoakes@ora=
cle.com> wrote:
> >
> > > You've fundamentally violated kernel process and etiquette. I'd be mo=
re
> > > forgiving, but this is at v2 and you've not cc'd KEY people. Twice. T=
his is
> > > totally unacceptable. See [0] if you are unsure of how to do so.
> >
> > This feels excessive to me.  linux-mm averages a mere 140 mesages/day
> > and it seems reasonable to assume that key people are spending their 5
> > minutes to scroll through the email subjects.
>
> In practice we did all miss it, and I don't think it's unreasonable to as=
k
> people to run get_maintainers.pl to avoid this.
>
> In any case, I truly do think this series works better as RFC, I mean Lia=
m
> has already voiced the kind of disagreements I share with it, and we need
> to rethink how to approach it in general.
>
> So if this is simply sent as RFC with the correct cc's (and ideally with
> some review feedback applied - a better cover letter, etc.) then it makes
> everything easier.
>
> As mentioned the timing is unfortunate here, this is a series we really
> want to make sure is properly reviewed before any chance of merge so agai=
n
> this points to RFC being the way forward.

Hi everyone,

Sorry for the delayed response -- I was traveling and didn=E2=80=99t have
access to email.

Thank you for the feedback. I realize I missed some key reviewers in
the CC list for this patch.
When I ran get_maintainer.pl, it returned a large list of recipients.
To avoid over-CC=E2=80=99ing people (which has been an issue for me in the
past), I tried to trim it down to maintainers and a few others I
thought would be interested. Clearly, I got it wrong and missed some
key folks. That was not my intention, and I=E2=80=99ll make sure to fix it
when I resend the patch as an RFC.

On the technical side, Liam is right that the copy-pasted arch code
has inconsistencies (missing checks, order of checks, ...). I agree
there=E2=80=99s room for further consolidation. I=E2=80=99ll take another s=
tab at it
and resend it as an RFC with an updated cover letter, as Lorenzo and
others suggested.

Thanks,
Kalesh
