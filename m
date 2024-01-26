Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ABC7475
	for <linux-s390@vger.kernel.org>; Fri, 26 Jan 2024 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235576; cv=none; b=tjBPviw0o/y+bUPEWc8yHaujKr85GyRRtauC6GhDRIED8NtfvxqKI0Afpa290CxgHFhH1+D9F9Vza+BHBttLXYWwNZRXENBbNHrmsRNyFJiWWs6+yQT+Wone13vjAs9on9I93dx2cOVnjwbW58KuF8Aihy3Kpmz0lkwmWJt8L5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235576; c=relaxed/simple;
	bh=ItFgj4jgK5sZKOgTM9vrgG8H+a4jRjcTY7CINpA2Wvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqE4JOIbqc47SKzWL9M09hlf1Zt2+Mmj+qWA62f2lY3y7wgC47PamtNcHzc5gVbwy3yx9N/wIjSuxe8OyKo6x9g6JrQNBAAbtCU4JEM2SADI1f0P/ctOJz2wHkEXSVnHUbgPnf9ROZhsVJUUbf5tnxMCJdy/xT0CrQ7QCLzowH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVlvBXA8; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVlvBXA8"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff9adbf216so61717957b3.1
        for <linux-s390@vger.kernel.org>; Thu, 25 Jan 2024 18:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706235573; x=1706840373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItFgj4jgK5sZKOgTM9vrgG8H+a4jRjcTY7CINpA2Wvw=;
        b=pVlvBXA8D2UUX3rloFCXN8w4hmKxm0PuVKhqsOeyjNn8phFc/loAgzv9aHVEBtfQdn
         OZUFAEBvTyT9zyVWfOR8AVZztMyfKs8xkV5ZedQUiBTXCxc7X6vxLGlwjMyef3KgMT6g
         X4RRtovQ2YASTfTdJot8avTIifOLSNSwN+WyzfrzjqaDjdfp8dBQtsIB+0rI9/RTKKvk
         AUf+zWrcbT7cZVs+kjjxSUWFeY6b9RLtkF91GH6vxsdQ6wNKx8wnFQt8z56MglK4tElT
         NIOoM+rvASSeQMDV3fQrXKRoA2ObdxHq7R1ofyR4JQAdHw7u6D4aeN0dYyQNmntFvMEQ
         FFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706235573; x=1706840373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItFgj4jgK5sZKOgTM9vrgG8H+a4jRjcTY7CINpA2Wvw=;
        b=KxscI/+kyTU48xu7ZsPvXetymUcC6+OAOHh210MD80hxHEKMt04HKNXkk5Dr7k4fcH
         7q0z05h1ZSCxUjYbT7cxxdbejGlH5XqQ9zY2gDkvWCPHoWQZUp6Or83IWc8vrSC4h7uM
         301AqAfZUj59CGmAlON6rZGi1RW3wN+bjpA06t/bkPnbsLQYiqvBgDoCCfltoaM1luR1
         zD1mpVd3SgVmopmWOiBX8pkhjl6PiTDvN81tle+g5M3Ku5HXnG85IYXEs+Z0dD+SjstY
         FM3Adx6RwysKInk4Cv6PX3MwdRNkycFABshNbH4mREUjTFtdA+JVgXL+F3qE5fsSOBm6
         k4Bg==
X-Gm-Message-State: AOJu0YyLd6jgyFLZBEvqRc1wBorFR+2vi6IwJiwR26TocNv+u9/VIjzy
	2taquQKrOj3zJp0ud4gpqFNRuQQXVRrCeVr71fA9DHAP/I+N6dUPi8KbUeXnwVazh35N+ECl8ic
	BgABe0jmyrN3KB5F7mKErAM4NksnWdlnKsT0n
X-Google-Smtp-Source: AGHT+IGaiNJjkVpexInpWQwByTe3797L2nUjpt0NZIQ90tD35vlByjZTnFzZwYmbW6zfg0hQ6um63uQcPL9NRTHsJjs=
X-Received: by 2002:a81:a188:0:b0:5e8:995f:6a0f with SMTP id
 y130-20020a81a188000000b005e8995f6a0fmr805824ywg.13.1706235573358; Thu, 25
 Jan 2024 18:19:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123064305.2829244-1-surenb@google.com> <20240125180424.121455beae4d56799a0bac28@linux-foundation.org>
In-Reply-To: <20240125180424.121455beae4d56799a0bac28@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Jan 2024 18:19:19 -0800
Message-ID: <CAJuCfpGy=AmngLNMG737N4W_RXz=pRfisa1o7j9chBQ7=Mq6Kw@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch/arm/mm: fix major fault accounting when retrying
 under per-VMA lock
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, will@kernel.org, catalin.marinas@arm.com, 
	palmer@dabbelt.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu, 
	agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 6:04=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 22 Jan 2024 22:43:05 -0800 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > The change [1] missed ARM architecture when fixing major fault accounti=
ng
> > for page fault retry under per-VMA lock. Add missing code to fix ARM
> > architecture fault accounting.
> >
> > [1] 46e714c729c8 ("arch/mm/fault: fix major fault accounting when retry=
ing under per-VMA lock")
> >
> > Fixes: 12214eba1992 ("mm: handle read faults under the VMA lock")
>
> What are the userspace-visible runtime effects of this change?

The user-visible effects is that it restores correct major fault
accounting that was broken after [2] was merged in 6.7 kernel. The
more detailed description is in [3] and this patch simply adds the
same fix to ARM architecture which I missed in [3]. I can re-send the
patch with the full description from [3] if needed.

>
> Is a cc:stable backport desirable?

Yes, I guess since [2] was merged in 6.7, cc-ing stable would be desirable.
Please let me know if you want me to re-send the patch with full
description and CC'ing stable.

[2] https://lore.kernel.org/all/20231006195318.4087158-6-willy@infradead.or=
g/
[3] https://lore.kernel.org/all/20231226214610.109282-1-surenb@google.com/

>
> > Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
