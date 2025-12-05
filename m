Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727735A927
	for <linux-s390@vger.kernel.org>; Fri,  5 Dec 2025 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955456; cv=none; b=Z4cJMahEeql3tZsthAn1mfEwY+9ODYLvvqVKDjqvEXOkn8IRlng0c8a0Ws1HwIzPI3y8fBjXizEXyW1TiR2ZSgPdpK5aoXvoTfi3EjYQ5I8XdvQESZ8oRG2LE9qPiwhRc1P+VopLhebLktqCzcP/Y62JqELp1atngA+X7TqKrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955456; c=relaxed/simple;
	bh=s0iVd2RsjlWS/9TR2zy9YAOZbmjboSgGnXQyMW8/G3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suXuOpEBB+JLEAcUoWHaSZqMzZudHToSMeIFWfigSuFlka3ETOW3KaKLX9DReXcmrEcuHw9aTypfw9yClmKj0iAJtHhdjbwj4TjLU26RfOjYip5r8hMt2UXe8q3Ww1ED+bIo9M1SrgKhNav/Xt40NYe/6naQWxGCpsPoKRARfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FHEzxf+O; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FHEzxf+O"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso4162401a12.1
        for <linux-s390@vger.kernel.org>; Fri, 05 Dec 2025 09:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764955451; x=1765560251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8lYM8vTuWuligOXJDgRA/sVu98AQZ0ojWGiXce05Ou0=;
        b=FHEzxf+OGyuOmUg42/qlEryOiZkOi2y1BnJsFoEcATBFd2dUlmqm6Tk540/niv4D/X
         mbKC4adYvm39t+we/3lFIGpzag9SUIGLLTi6a2+UEneycGmMBKqAsjOsWAXgw+kSwE8D
         ywbUisxU80JII7go4Jw38yiU1MM8e4OFwzmnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764955451; x=1765560251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lYM8vTuWuligOXJDgRA/sVu98AQZ0ojWGiXce05Ou0=;
        b=wDfCverB3uA3ijnKb6xVD2u60vdPH6M4Uz9W2b3Y9GACEs7LYFF5E0pxDEgVryIKdX
         276cS5XAqvfVxpeapBBCBx9ljXiPnRPxF2+oR07aEfdm4IqjenubqRBXOS3MXf+3l6iN
         OswddzPG14wDJJPL9jgqOV+rQsuETOKBnx2JMffwPq3iIgeMyg6fluPr1JJc/aUB3jO2
         KZTFkeEi96shAE/HessBXDGNwlWLlXqC8QSC47qQAOml53exgpRPd1sfgcKpcmCvkYcG
         6Na+sGFv3d6rfueUKZnKuBVps0r5F7wmjlKHjTfBI2cMorfgw6WuFif5CPQ+F2RIVZ66
         Daog==
X-Forwarded-Encrypted: i=1; AJvYcCWhk4osppgI1/BaaVa2E5NYnhSQClZoA4k3IwHwocXv8RUpefRLWvKxYXf9lPOPymVHkUPZDoBGiBga@vger.kernel.org
X-Gm-Message-State: AOJu0Ywupcvdbfa5oK4q0aKjUPwbSF6sFMDPg6AMaUB7uWhbg/diqPEp
	3nEiV0TVIS+Ln9yTwMtN8lkZPjJVRofz+3cwjuer30wQXV7xJxLFYcBU2O5g6OlfpGM6IpMys57
	NZz30vYQ=
X-Gm-Gg: ASbGnctNyYOwAr4YngDKF0Ul7NezqsMRrrDRa1Qky7Kb6jYAAUaLRwbNfbtasZwCw7O
	G34AM2zCigvv/fIgZkn7GBI8heNNLIIBhcjL0ect/zsgc6NgSAPZuFzmFu6np2J+vWjIkgC1qhd
	nio6NGZx4KHF8m2DLVRQahIfTqoSq96BG6VUC/NIMJYMCKSNMlzVxCj/tZM98i9tkM4VAnNJtLp
	1kvGCp+LmEXL1FjxOuqX4rOfkCyS/m6LR6Z2UiGz2jWBKRlO0ReLafuDcJKIPNyBqlQ38PC0ri+
	ZjZnv+yAxEMOLRp6ly8ShbBujCGT8VpCmhe3y4VYfpzQOyg4Wx4wFT6egbEJpuKo1/tFafQxYWl
	gXMliixulQrfI41yT+hKfqGV8I7OPPRqh/LL/jSbrAFqgasf7WYrQ6fsSvGn8l1LFO9Jel5xzWt
	W//A0RfFT/CYZmiNsGCNp35GTVe5JGKcg6W7g+apVa7FhJzaFXB6stExHSxQgR
X-Google-Smtp-Source: AGHT+IEkeM+dwmF9S+ia4cBsy++KVXx3I4lQnjKHd2eLYXRBaUBOrMTUe8DaxC4S3ENeOayGAjBpyA==
X-Received: by 2002:a17:907:1b05:b0:b73:544d:ba2e with SMTP id a640c23a62f3a-b79dbea899fmr1054450866b.25.1764955451081;
        Fri, 05 Dec 2025 09:24:11 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49765f3sm401097666b.37.2025.12.05.09.24.10
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 09:24:10 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so3573128a12.2
        for <linux-s390@vger.kernel.org>; Fri, 05 Dec 2025 09:24:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+OwXegOqYxWVPdHfPvcqC838+nEKvb/flen241QVJx6pHIjUxGd8Dqdr2UpgWco09S9e8eGpbyU8P@vger.kernel.org
X-Received: by 2002:a05:6402:5244:b0:640:e943:fbbf with SMTP id
 4fb4d7f45d1cf-6479c496412mr9886451a12.11.1764955450397; Fri, 05 Dec 2025
 09:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205171446.2814872-1-jremus@linux.ibm.com> <20251205171446.2814872-4-jremus@linux.ibm.com>
In-Reply-To: <20251205171446.2814872-4-jremus@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Dec 2025 09:23:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4_BPvniQZqvEQ4cCC3WfvQqruWk0b1Yek+0d5S1LuxQ@mail.gmail.com>
X-Gm-Features: AQt7F2qyEU-sRiqYQ9Tvu5NNk8tmioQu9za2N5evR27IqNXhvz_m-7r0eTXQy38
Message-ID: <CAHk-=wh4_BPvniQZqvEQ4cCC3WfvQqruWk0b1Yek+0d5S1LuxQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/15] x86/unwind_user: Guard unwind_user_word_size()
 by UNWIND_USER
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Steven Rostedt <rostedt@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, 
	Dylan Hatch <dylanbhatch@google.com>
Content-Type: text/plain; charset="UTF-8"

 Random nit...

On Fri, 5 Dec 2025 at 09:15, Jens Remus <jremus@linux.ibm.com> wrote:
>
> +static inline int unwind_user_word_size(struct pt_regs *regs)
> +{
> +       /* We can't unwind VM86 stacks */
> +       if (regs->flags & X86_VM_MASK)
> +               return 0;
> +#ifdef CONFIG_X86_64
> +       if (!user_64bit_mode(regs))
> +               return sizeof(int);
> +#endif
> +       return sizeof(long);
> +}

I realize you just moved this around, but since I see it in the patch,
the #ifdef annoys me.

That user_64bit_mode() should work equally well on 32-bit, and this
can be written as

        return user_64bit_mode(regs) ? 8 : 4;

which avoids the #ifdef, and makes a lot more sense ("sizeof(long)"
together with "user_64bit_mode()"? It's literally testing 32 vs 64
bitness, not "int vs long").

              Linus
