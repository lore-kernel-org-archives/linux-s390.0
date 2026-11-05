Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872908;
	b=BFO/nJiQfD8SBhpu5pwz1c13ob3yhcTxpCE67z9LoipQrzE6B36AQjCdraosJeWQ8k1I
	 dG/DvlyNiHJgos90rfi4aAaTr2Hq+OQhzkd6QdvlgRBX3gpJ7FNBFn1h6gLMMnkbX1s99
	 /gOK5JgBBaBirCxUxt2eotjIPY98Yn1Lnm18HVroSi5a146x4eYZy1snwrtrrJGfzxqlm
	 qjxl58aBMc3OL61ynmF2PcbZ7nnP19vSksOR+xY7amdM3Ej0VkIOxiZQM7Frf28sOniwb
	 +iv3awXBxvJ2Hwjdailrs9T1KtQWguYfRBwZPb0Kb8U39ubVLJHaJXYnudwFjnWpIlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872908;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=+mKdlgKO27T7zaM0EZirUNSUHhSIV/TKUV4SSUSBbFc=;
	b=IKlcvedHYOha0IJ9vy1fde1TMAtj0cROPJGfmeggOQcvAYD2ZQpIgw8GpI8Txt6FvC3d
	 RXLFLH7fG9Hxu8yZEIZciqaNShlGxjkfCfWfjr+kcvEhQxiwtfZdu1iqOry+aBiGieSn1
	 KQOxEeErP6EXVdS4nuUaqwwwVzWWydIx7II7yPIOJIq77PSVnXm/20QEA1IoMlj1KG13f
	 JD4Ql1srdPGoLcGhH6PgUAAppaMJfjE+uNlAycLsw8LggvblyyX2TJ96oZq8FJYarqdf1
	 6txl7ICXPvV/RuWZ8bJF63cffAkBmzOfp8IeH4syZohWjc02NgIi6dyfABzZlEl4jrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DEE606A326
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 10:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95DEE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-84e513874f8so1243686a34.2
        for <linux-s390@vger.kernel.org>; Thu, 05 Nov 2026 02:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872907; x=1794477707;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+mKdlgKO27T7zaM0EZirUNSUHhSIV/TKUV4SSUSBbFc=;
        b=AcSEgUZTpr8+zqy6SPooCI003+tPBXqi7AnykDz8+KNrZEafyurcCV7s+ejtv8ot5t
         69ImQ1F5IWQ1ak695KSuSAIyXF5B+Bd7kSqRKjs3X8ensfJNCHOGmUvUJrWZBPgk+7Qp
         ZyBEMgCr1BAsEp/jaHJk/PQ2N+ufB7J/kIokHJ9abB7jbRFjUiuuEbFOTjO60tbqxJZG
         +QU9+Kuqy7+bFcBybvxqEidBVuO5tPIMDuzNKzRQNcnmgx2J5z5YiltEU22M2fkvQfoO
         tbZZ4cbr003fXFKh845lf9X19jvOGFgEu4yoGGQyZgqoZn6Qu9NJVCnjaavO6ah6PHRO
         nZYw==
X-Forwarded-Encrypted: i=1; AKwUvBwwAkPJFZ382CPKeibY3tW1XXyn5HvQY77c1HSyZ4Z9QOYlUXRUVqr76jO0MLwnZ6jXdHj2omz5rUQC@vger.kernel.org
X-Gm-Message-State: APuU4Z8jP/BmoS5pxovbJE1wcgjwuKX0dRiN8r+XLHD4SAtQb4M4fdYF
	qTMIwxEshvM/QX6OiO6QZO0qNiRwk8SCVBj/irJX9jEDRcXRmB1iOdFAWp/3OMcm2EM=
X-Gm-Gg: AYBFou23RV4nczeTZ0GgsQfWGHnjvgUS6NNiKwQi1/bg2NXpVDpMN4aoQbPB+t2KYYb
	/1lZLLu1WDeenmtZieugfxkDrwA91PSt5RuBToszwIGHt6CYxqNhqIKKz8FFFo/XXffbbUYz4JL
	8z7SDVp28ohv4gZXsXggTCwXRo6uUOgGTwgy2LSGN1yAzFLyyei0ROJdaut+/dU2VrL7sqB99Ad
	vhbiJCc3Pp2B3qMjWTEdTl0IvSFRueorQvtqa+72xklyTXae4TK903tA9Y+G+3MkxHNTVpaDElJ
	DO2E2jleOOhfrl3nzWyUgVgIWyvLG8wH0DVI4TrwQdtr2MmsEvdOfO5qnvfBk+pq3Zo6jFb6982
	D6KyjsTtb0KqC4hYddlubAg1356VZ5ChP8MllmZOLwqgM3AFDLB6wg+iD3SXa1/zra+6Nnr+yUr
	X2mlKfcA6q0v/3RZgb4yT8NdvTD/j/BsJ5nMwkYGxyNEzBBD8exxOmk0z4daiTjwD2Z29dpFO3C
	CDcx0KqepuTxoDrTXgtnLmMqwne1S36WIlCGJgp2GcUCOHgNGc89pFkB4+Rxn2o4KRwBBRaAqzs
	Q0DJpKmywWzqYC046shd9AnTJnZK3f7ytgo855t02C8KKZGl9Pu7Fbg+8q8yiDDyBA==
X-Received: by 2002:a05:6830:8286:b0:85e:ff79:a340 with SMTP id 46e09a7af769-85eff79a4c3mr2956659a34.11.1793872907283;
        Thu, 05 Nov 2026 02:01:47 -0800 (PST)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com. [209.85.160.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3de203dsm4087875a34.6.2026.11.05.02.01.46
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:01:46 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-48ed0b68895so1038520fac.1
        for <linux-s390@vger.kernel.org>; Thu, 05 Nov 2026 02:01:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzQ0vi3qfHkRD0PfbaZa6BUVtuHXxhOEIWUDLz4Q1XIQHPM5nCaX2P5lwVWByvO9YqCpKZ7ObZZJ93t@vger.kernel.org
X-Received: by 2002:a05:6102:950:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d072bb3726mr8218716137.13.1793872596997; Thu, 05 Nov 2026
 01:56:36 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-cleanup-v2-0-1e6687e226b1@kernel.org> <20261104-work-procfs-cleanup-v2-5-1e6687e226b1@kernel.org>
In-Reply-To: <20261104-work-procfs-cleanup-v2-5-1e6687e226b1@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:56:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWkL=-oCgLA3HB0_Js_TdJ+P9FDBPF-u2z7uHrL+m7g-g@mail.gmail.com>
X-Gm-Features: AclHuK_YSG69l_UQ8CXymziWm2hhXR-Ce9gvdG6ZGXmuBEE26IV_RBgt33sxH_I
Message-ID: <CAMuHMdWkL=-oCgLA3HB0_Js_TdJ+P9FDBPF-u2z7uHrL+m7g-g@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 5/6] proc: drop the _buf suffix from the new methods
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 22:16, Christian Brauner <brauner@kernel.org> wrote:
> The _buf suffix told them apart from ->proc_write(), ->proc_read() and
> ->proc_ioctl(), which copied to and from userspace themselves. Those
> are gone now. So drop the suffix. ->proc_write(), ->proc_read() and
> ->proc_ioctl() are the methods that work on procfs' buffers from now
> on, which is what kernfs calls its read and write as well.
>
> Done with sed. The flags and helpers in fs/proc that go with them are
> renamed to match.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

>  arch/m68k/kernel/bootinfo_proc.c                   |  2 +-
>  drivers/zorro/proc.c                               |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k/zorro

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
