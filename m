Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571420767B
	for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533995; cv=none; b=aot+29XwR/HRLG+4fKzWpnIF5/+0h2BDrzQ4Gzu9czbmcjLhjzWq5wVIctbybRUr5SaAXck7Fg/0SOhJpbLjM5dR4HMCRnA8l3Wk2v4tIyTCCIto9IQ2qmp988dP3sG36aKdQOwJqJEFxXF1EaeWW1hFSU6qrbDdhoUlFZv9eIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533995; c=relaxed/simple;
	bh=Il81pbgAr7mWoe+tp2T+p6Hy+y2w5km0wZwJlJHjhmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNUYigrVSOtbePrNlqoocCmBiKsTNht8gyTVQ8RPdWoKxn9KMgBw1L8EzZnFMP+u3Gh6l3oLnr9NP+l5WTHEXBMpwSBLYtJtJfhyOE2SL3RRUqA2Cc62+SfDlvzM+kfUd7kNvuJP7cxC3rjOJewoF3T2kWGpJZvkF/LAZFDVJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AgIaZNSF; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AgIaZNSF"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso3835536a12.0
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 10:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736533992; x=1737138792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ztn+xx6/hhaGVps14838so7FLIOxsLeLWEES5e/LNFA=;
        b=AgIaZNSFYkfQi6RXsMGPcRLboBQn3PjnCOzXzKbLm6NwnX/YyhEPPl3419F+Uve+Gc
         Cw6+F6zQSO9t2fFW/1NqzGQ1UluVwyKdRiEaEZet4Zgl2fJHLDja8r3zercUwWcC/cmw
         l+K6W1SAR4WUmRm0YxJ/RgP1QLgWz+Msh//ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736533992; x=1737138792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ztn+xx6/hhaGVps14838so7FLIOxsLeLWEES5e/LNFA=;
        b=ufh95nyzkaEk9hmcmt4QfFKrSzTXQCF6/5lm5d/xS0TlIervy47ZySOiJWI1V1rnd4
         BSY8/Hw7iYycllFhN/ggyirDfuH0blt1UkcnnUIIB6xrQHu2SAC9ZfRtVUCJymPxhWTc
         vD2GfvhIUXz2/iFVRWoc7wiVgiB8qOE9xQu2Vahjixi2zr40L4ig1x9gPULYHYvMuHMW
         a8S1dIH9C6nrc8EvUQOwY/WcE7LItQZSAGboa94HMgsM5uHl5eCStMsIxVnENfCbpQqX
         2KC1f8077+FUVKmJ3XkzOi6G0P9qmOt7p4UoD7KNwFbYL9htzpA/MT0ziLFdZIRBL40J
         qBDw==
X-Forwarded-Encrypted: i=1; AJvYcCWf7etOQ6TptqwezdTk0IF8Vw2QY+c/Sx61Gbepx/3E86v4b1vp8ap6jA/WrcIuKfhLXOdTYHyFIK6b@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Ul5R7k/4Jig7qTFuCBqDrQOON57dH0azLROssCUSjZmyTGuU
	5MikyXVPcVefVx6t2oG+S2rUuOGiC6++GxvgWTJgiFnHYB0qUemNDny2+28xD6JEUs38iBJAoC/
	Jhg4=
X-Gm-Gg: ASbGnct4k8hAcCsga/opiu1eiG0qaps+KYX94r7LTmsD36Hoy2FXbX15FElhJI4iK2B
	IPbMT1qr/6qJL2/lOz5zv32tSAuz3JjYXNCI4dWkHDNKtQMtzpPAUsM2OIJFA1cmw68jR/bSw5R
	PIt4VQM5RjXnM0y0i5qoW5HucNkVAa9shLbcVeovCWWkBkkMqlT5Yd3hz5kaggHc0Fxyd1FRTDs
	XTDqdOwXsU8eX7UxZbWPNvpp9iuQSFK+0a4BBnL7dQXjgRHoY3oZ4Sobs0MYXYiOLNzzG6BWP3a
	hLIwMVcKyRDW99zU6O4XIIplUvpuoNE=
X-Google-Smtp-Source: AGHT+IHQwG3qsQo2+DPPmJvEgLKYGThZlnIYpF/+x944CesLNl4WOAURIh6LuVbGfLNb9TJZpaWkAw==
X-Received: by 2002:a17:906:794e:b0:aaf:1604:bc5f with SMTP id a640c23a62f3a-ab2ab70ad68mr1077433766b.21.1736533992093;
        Fri, 10 Jan 2025 10:33:12 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95625a5sm190655766b.114.2025.01.10.10.33.10
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 10:33:11 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9e44654ae3so362605566b.1
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 10:33:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsgig+Bk7pCz/ujwuKEYTEnGDJPE5g8Dm9DD9sKFrf+1GtTXYR4KzIPi7K9jwplppzCa5z1Pd9w3lZ@vger.kernel.org
X-Received: by 2002:a17:907:7f90:b0:aaf:300b:d1f7 with SMTP id
 a640c23a62f3a-ab2ab709c82mr859127166b.13.1736533990540; Fri, 10 Jan 2025
 10:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110082744.457067-2-ardb+git@google.com> <CAK7LNASygf5gRdYOOa3KsKbz8mny9nnn5RduuGtP5WoWgXDTQA@mail.gmail.com>
 <CAMj1kXEPq6VU19qzmW9DNVG=nzoGbnCMt7dE5nXeZCqk2JPE3A@mail.gmail.com>
In-Reply-To: <CAMj1kXEPq6VU19qzmW9DNVG=nzoGbnCMt7dE5nXeZCqk2JPE3A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Jan 2025 10:32:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGfhxb4q4T2=W=Vg=sHwZwwMTN2EaDYbmS0VG1Srdb-w@mail.gmail.com>
X-Gm-Features: AbW1kvbigeb3lg5NVlMToaCtct6NB4aRMHwzUjQ-ItkeRzFo2HtXHrJ7EE1mr54
Message-ID: <CAHk-=wiGfhxb4q4T2=W=Vg=sHwZwwMTN2EaDYbmS0VG1Srdb-w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Strip runtime const RELA sections correctly
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 10:11, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> I suppose this is a consequence of 8962b6b475bddc ("kbuild: print
> short log in addition to the whole command with V=1") which introduced
> an $(if ) where the else branch is simply ':' and so it always
> succeeds.

Hmm. Odd. I don't see why that part of the commit exists, and you're
right, that seems like a bad idea.

And removing that odd $(if..) and making it just do

   cmd = @set -e; $($(quiet)log_print) $(delete-on-interrupt) $(cmd_$(1))

doesn't seem to have any obvious negative effects.

I'm probably missing some obvious reason why that $(if..) was added,
it's been that way for two years now.

           Linus
