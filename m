Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D76413DBA0
	for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238454; cv=none; b=m6uFp1bXo/ewSfxpC3v7RabPZxqA7J4TKFlQVNXgjCT5Zy6ovC9uX4OAYENit2QkUGmnfNg7v8/dvtYLI9cV4kcNVAqFr+iZWvN1uskmZnL37dUZpIWUKcxUQwX5d2+KFpTZIVrx0bqC0X1esVgggLJ42PsDWwbuUYgscmxfK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238454; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9IDa67ee3Q3ll/pG9ey58w9hnUPfXhCIcfCr6qeigIKsWkh32L3sr7qAXTDrltTdU4IWK6dm47DZ5Z6I/zpHiuMdJO2A2mlDkeRB+HqrKal5+gFEEnaK0p0HraRTvcWvXJMhtCTm1MyBO0bPzOIr2erqNwAd/LaRn0SqvdyKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b93698bb57aso170581366b.0
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 07:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238452; x=1773843252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=j4iTyBj425/0BpQypW939ZK1PiV4XNQ+AapfhPRTsv8/nqqUYuB9RS5E0e6M9Uht8t
         4ay+7KAbHMe8GdKJZb0o12ZHYiGCanbBoeIiiVEUF9bfwjFxsfo84D5ZMjZddSV8lGha
         Jh5CBQQrZU1jxzFv9QFz3M86m1ZTE5TnOKNQ+LCoyMlAOcK3NkWyD48jFL0M1JxlhAXh
         d5ikvu8OHlBVmrITD8yHu7ySsjg+IH4v3g7WCJyauPfrMBd9Yk+4MzV5rtDGn9b2kftZ
         GAGgKv48fm5NlCRFLRYgkOZxLo9D5EAdRXgOEQ05bhkyUkNfk/Vow35BNDJ9Ws4UVgtu
         RUAg==
X-Forwarded-Encrypted: i=1; AJvYcCWPgAk+eBC2hEf1cYW+Z5umysOi5zeteojzCFiJi/bR3YGKQ/3fcshQW2hWGPdfhVEcqEz+Z8Geg21+@vger.kernel.org
X-Gm-Message-State: AOJu0YyFeJDkzxG44MzHM/kDlkhgxQrqsFyuOkwf/bHANFIldteNm/pp
	OhwXrgXF0esuczmh0LC46M5rawpJDZjvs3FFHuCWAL7kVeHy0KkNEEIRl+4q5N2MabSg6w==
X-Gm-Gg: ATEYQzybK+iSkKLJUsUJtVZb5SpdCDLXdnDedkJtuOYwZXj2HBvA0XxSuGadkdhykVp
	k2awDx3HdBXQktpWetidq+Tj9sX0c093BskJjtUcwZFucYqp4so+siO7nhxFjnSAAWt0ernWwTU
	kK2vQwE9Tjqirv5N3p6uwKrYV8LkEWKZuk6+N44TV7YB41mLuDvGnzJz8Of7ZYqt1nURQwzLpAc
	+Qt8evMLIgu+UYiaE5iHXt9KArSdigyjQOTWvPRZOXomMhl2X2Sdnsb7wR6VEdKpe1dHGAICvWk
	U56Uts3J8aAmeh3nIRbPT1lbZrrEUrNZIdDvfraGRpZXMwjJ/UpZQpFrE48K1QULQtKmz7evPwu
	BixJCuAWP/1LiKrkzun8/biyrNRg5AVGp/MyZ81aDOD9sv6pWq3UQemAIDFQBouOOxm7MtKswsb
	4pGng5B0LdCHB5ElnBfmnG6vDyto1DwN/C8urBEUVKquYPII6m5mXDXCceMK6P
X-Received: by 2002:a17:907:a46:b0:b88:5894:6ba1 with SMTP id a640c23a62f3a-b972d88441fmr151861366b.28.1773238451326;
        Wed, 11 Mar 2026 07:14:11 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972e14aa2esm58203566b.38.2026.03.11.07.14.10
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:14:10 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b942b36de08so190834266b.1
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 07:14:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWarknofEZ9kWBUVDh5hO9Men2oJFJXBYqsGtpKMtzvBHaOwV4cwAVpmKAihHQdxeue8VhosH/riqae@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
