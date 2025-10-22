Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1421FF4D
	for <linux-s390@vger.kernel.org>; Wed, 22 Oct 2025 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124585; cv=none; b=JpAUs3K/N9S7RNZ0yIb7vY3V37JOsw+BZlP/KaoxsAe7kxoPcs3m8bNcZaytyMm6XpnyLmqHM/T5P/pdBpi2uMX+x7kADJwcTpi56ktRnqDcM0b9TPLRLbF8psL7LFj237lBiiJ/O+Q0sIM50pHbth+LGuLdtJGfjKLSvoIG6e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124585; c=relaxed/simple;
	bh=HUnjO6dtk5AWT9DiSovCBAivfwsSKV6yep5fH+0IyYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEzYQnY7FNp3sBl68j5A2BBnuVgnbHLBi7h3C2/mhboMAUuw/wXMeRhp3OwOmbni5OuzuZPJR+SH0gLFEv/+CSRbefSlAB1k/cxi9JhzQpz06TyPexp1HrvSS/xx8gxBi+hoBAj+2R13ItNbBcvsBaL9n0ORFaclCJZSsWlYdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-59d576379b9so2296713137.1
        for <linux-s390@vger.kernel.org>; Wed, 22 Oct 2025 02:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761124580; x=1761729380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jg0fiFle/a5r0E/SHz3YpwUQml9X2EJGFYzOtSP4KZk=;
        b=vB/bUNwxyy8HdKdyKE8A3N0jF7guFBkGvDdd8F+CJTi+GoPCZHHUTUMT/xtCRaf2W1
         BkZVdWXbMr0Xb+jq3cs1NAGWEB5huFChZouvYS2RICCA1pV+LLKXw4U6ise50GSeXXUh
         0w2ocavKui9x0SwdcM0OOX43P4DYvo9tGC/OanVCOaECUyNWMzA04/NFJPES39dvN8ie
         SBSakKK3vs7+cSe4zmUqENOMBpd7wb4RvIJtHP4eP1tWKDEy7COL17nwTKxfxA87RTzU
         eAowYFesj3Bs8/fV4+mrV//LIlrtv2hjnBXNoVv7/p+YpEFVBuWf0IORK31DNeXFh+Yx
         HKiw==
X-Forwarded-Encrypted: i=1; AJvYcCUr2ts6/w6pwwcQUR0IYhc3tCfp4/ZQIfYYgHgZHLeGiQ6eCPVw2DDu7goP/u4MAjiXzkP/fJNrhsYP@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMuOGFZRcvn9mu0IONygrERy/D+Gi/FdtM3GOfD2fJykM9QSk
	AgUCnHg0iu8cqwhYujd9uD5Snwhrm4Sz04GVqzIZyIn9d/UnZtZhDg3WmsEk+Qgn
X-Gm-Gg: ASbGncufV+yQoyxTpQHz8IqajhytTHx683ACq7v2xQkDb+l6vaYDQcOchuQ5r/QGXgW
	OpDLcb9yY4RXrnKbCxaxkaM21ufxlRUgnkJJ+xQQ7dgjoBE1C8KL2NAQBBKLgQ4ZKRWsBWL+j+e
	eSCHRw1WkoJeP7LAMO/NY1iytY7marqLsMx+qEQCeYjTRj4OlayVcKjpZTp++8kB4cDetVxwZOl
	k1E7iJV8iydBdJ/bQSKKXNF0IcU1D76H3MuF02VA/EFY80+lrCNxLSJyNE3an3t0mkZTboEYAON
	2t77yOxDH+ahyqG2C0S7lCIzXiVOT05N5eJyrWPlAYQe6Rv7q6c8H9sC28vi6Ttil7RKe3c89zx
	kGFYP166vPxMTWFrOKsw2Pw9+qdHiH32ECnltjgvIQ1+IUoWO9lVKegieTKAByt0VburScjkWHw
	ZFjox3fYKsEsYAsYb2aMviI1h6r8YpFRbz9xIAAw==
X-Google-Smtp-Source: AGHT+IFUo0A4GfTDzfsuwOB+jWX4FoTvuBd/DQAJmX7tUtHDpyd94qohofzBGs2ZYvyntz0egjMmkw==
X-Received: by 2002:a05:6102:3f13:b0:590:f704:6dac with SMTP id ada2fe7eead31-5d7dd46de9dmr5330112137.10.1761124580220;
        Wed, 22 Oct 2025 02:16:20 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c27a17dsm4421240137.14.2025.10.22.02.16.18
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:16:18 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5d40e0106b6so2946937137.2
        for <linux-s390@vger.kernel.org>; Wed, 22 Oct 2025 02:16:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZ+60GzItqtWdJnzu4BcBVeARWD+LN9nyBW8W8xMNn+t/hltvRhPISl5fWOqa0gc08yB5R5wSiT+c1@vger.kernel.org
X-Received: by 2002:a05:6102:c48:b0:5d5:f6ae:74b4 with SMTP id
 ada2fe7eead31-5d7dd62a873mr6134044137.40.1761124578028; Wed, 22 Oct 2025
 02:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021173939.v2.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
In-Reply-To: <20251021173939.v2.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Oct 2025 11:16:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWAbMoQdeM5-F1YYOfEdcPrkTxdbsU8+TAYO=WuMzCqCw@mail.gmail.com>
X-Gm-Features: AS18NWDsxMzaMxqdF62ijuMGcK9XAjP5LOhXCPu3LO_xxxu4TtOf5AC9v2XSFYk
Message-ID: <CAMuHMdWAbMoQdeM5-F1YYOfEdcPrkTxdbsU8+TAYO=WuMzCqCw@mail.gmail.com>
Subject: Re: [PATCH v2] init/main.c: Wrap long kernel cmdline when printing to logs
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Andrew Chant <achant@google.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Brian Gerst <brgerst@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Francesco Valla <francesco@valla.it>, Guo Weikang <guoweikang.kernel@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Douglas,

On Wed, 22 Oct 2025 at 02:41, Douglas Anderson <dianders@chromium.org> wrote:
> The kernel cmdline length is allowed to be longer than what printk can
> handle. When this happens the cmdline that's printed to the kernel
> ring buffer at bootup is cutoff and some kernel cmdline options are
> "hidden" from the logs. This undercuts the usefulness of the log
> message.
>
> Specifically, grepping for COMMAND_LINE_SIZE shows that 2048 is common
> and some architectures even define it as 4096. s390 allows a
> CONFIG-based maximum up to 1MB (though it's not expected that anyone
> will go over the default max of 4096 [1]).

Of course (unless the kernel crashes) you can also look at /proc/cmdline
later.  However, that seems to be limited to a single page, too,
as fs/proc/cmdline.c:cmdline_proc_show() uses seq_puts*().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
