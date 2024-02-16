Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3519E
	for <linux-s390@vger.kernel.org>; Fri, 16 Feb 2024 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041912; cv=none; b=MRGcJxMrzNH1ygdB1iF9yWDaalTxHINgn9U7JXZQXSbBWCX3o8OtNDQkxdbJhAFUkixXmOYFpnMtRZWhq9tKfebbwvafJ0tP3EYNV3BdwqeoDe5DyYL0emRaUBOlcZbcT2We3QGD8ASGlOPUVVGcT5kcpvicdpsF62NhxA7nRS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041912; c=relaxed/simple;
	bh=LoOnC4FQRv0F/O+cUjwXbOIDhDRls+e8GzdMRDc8KhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYbYGZSf0uJnKcifrlbGxmr39HEEguKAUSkExEZ1XNbARZL0HToDRhsPO/+UlIbDktI7M9qYr2geDwU+T0CBTCpKHtgdkpsySVu7SHlIPVLGI5RqQrAUOpw8wwlTnTu5kMIUDmXnOkfIpOul+ArTnDnQzTu2w0oWxcIapiuOOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IR3cI7bt; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IR3cI7bt"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so886348241.1
        for <linux-s390@vger.kernel.org>; Thu, 15 Feb 2024 16:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708041910; x=1708646710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diXWtKNJBAfA4PgnFo0WoPDjp1XguB77YFwSlLLsiFQ=;
        b=IR3cI7bt53zqM6Rc7R51ECix2OD1Bni9dQscoOPEc91+WbeHHbF3BCKuMNlasG/U4U
         OwGBqeehAdnI5o+KOfuLE90YqX2QiLNHIozy4XyBdQwCjftvbbNkKnC3C5MUUpf35MA/
         EonINoUytCJwydT/Bt33pRiYJ8z+OGM00rPJUwOTMTzZRAlWX4aM7mbLwkm8rrPs/XqZ
         pGiu0YHAl+h7ferrSZGBT/iHOpbLNGzfwzUvyuDzebALNlQxVrjRA0l8BNkvqh6hK14y
         NKwp4TSXgA0LgRim67alJuaPLOly6jjXQYe+KlEfEv08q0nLMrnze/MBx9UBx7rPTRvJ
         nM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708041910; x=1708646710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diXWtKNJBAfA4PgnFo0WoPDjp1XguB77YFwSlLLsiFQ=;
        b=Nq3PhCyesD6U3pLB0yCO2I7uWb2f14/hJvAymnJOjRIqmCKUb3fgtoTWiMVVraSD4s
         Nul7rbnm/XncF9HrgVhH0XQE7tUzf+tS6uKsN62hmHyDan5obSyBrmBNRGEuAhDdj+vE
         YzIXeFnd2H2HVBPfPuP3lsswBuocEvbJ+7SacJ39sRcivQWo0pHywvH3wANmYShILciW
         NRtreW9dZvy2NBKWxf29b5MNTWbBtGYi0BEPt8bMAAWgV+b0Xr1j7mhyjebsnDUJdha5
         31QVtQyMPYINUnE7oJGyCz7raATuHPZooxMWwLPePREoz/+ei1nif5y5JHE4+1rgC2vf
         yb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvggOCVKCqkE4lTD5JahHhjLnfGh2jfBdE8MrYJDuKNt6Z61IiRMNrmX6LJdaI/sScMmpCT8QnCpGvdVFZyePZPVVDRwl1IN+k0g==
X-Gm-Message-State: AOJu0YwnGVV96JNuap/7irbiD0UcpaOSCgWegyQom/rgKS2nC9SQWMwf
	KNr+7gdKoneClDNt80BYclI3VijGkhszsG8G0qS76dlC6wbUVvdccu1j7XWH5qc8r6/amaKOwsc
	+Uv475VMuTU0N29sUWEsBw4JJEKtC34hTrtJ2
X-Google-Smtp-Source: AGHT+IFIplzGzmriL1xaco+Og2hYr/egwhzq10LIBoz2G6IYXCZo3nz2w4ZXagy0mqXn2T0wS9sEvcT0l7HtxNN29lo=
X-Received: by 2002:a1f:edc1:0:b0:4c0:2181:81ac with SMTP id
 l184-20020a1fedc1000000b004c0218181acmr3240323vkh.14.1708041909812; Thu, 15
 Feb 2024 16:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADVnQykqkpNTfO30_aswZEaeSkdu5YNuKag++h-RSguALdeohw@mail.gmail.com>
 <20240215201627.14449-1-kuniyu@amazon.com>
In-Reply-To: <20240215201627.14449-1-kuniyu@amazon.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 15 Feb 2024 17:04:53 -0700
Message-ID: <CADVnQynSy8V9etoiL9jLMgqAdGwbLXnCYia4j3pp60pxbdg7zA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, jaka@linux.ibm.com, 
	jonesrick@google.com, kuba@kernel.org, kuni1840@gmail.com, 
	linux-s390@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	soheil@google.com, wenjia@linux.ibm.com, ycheng@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 1:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Neal Cardwell <ncardwell@google.com>
> Date: Thu, 15 Feb 2024 12:57:35 -0700
> > On Tue, Feb 13, 2024 at 3:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> > > removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net=
:
> > > remove SOCK_DEBUG macro") removed the macro.
> > >
> > > Now is the time to deprecate the oldest socket option.
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> >
> > I would like to kindly implore you to please not remove the
> > functionality of the SO_DEBUG socket option. This socket option is a
> > key mechanism that the Google TCP team uses for automated testing of
> > Linux TCP, including BBR congestion control.
> >
> > Widely used tools like netperf allow users to enable the SO_DEBUG
> > socket option via the command line (-g in netperf). Then debugging
> > code in the kernel can use the SOCK_DBG bit to decide whether to take
> > special actions, such as logging debug information, which can be used
> > to generate graphs or assertions about correct internal behavior. For
> > example, the transperf network testing tool that our team open-sourced
> > - https://github.com/google/transperf - uses the netperf -g/SO_DEBUG
> > mechanism to trigger debug logging that we use for testing,
> > troubleshooting, analysis, and development.
> >
> > The SO_DEBUG mechanism is nice in that it works well no matter what
> > policy an application or benchmarking tool uses for choosing other
> > attributes (like port numbers) that could conceivably be used to point
> > out connections that should receive debug treatment. For example, most
> > benchmarking or production workloads will effectively end up with
> > random port numbers, which makes port numbers hard to use  for
> > triggering debug treatment.
> >
> > This mechanism is very simple and battle-tested, it works well, and
> > IMHO it would be a tragedy to remove it. It would cause our team
> > meaningful headaches to replace it. Please keep the SO_DEBUG socket
> > option functionality as-is. :-)
> >
> > Thanks for your consideration on this!
>
> Oh that's an interesting use case!
> I didn't think of out-of-tree uses.
> Sure, I'll drop the patch.
>
> Thanks!

Great! Thank you!

neal
