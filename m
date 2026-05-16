Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E514883F
	for <linux-s390@vger.kernel.org>; Sat, 16 May 2026 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778889644; cv=none; b=QKcEM/WVOb0ehQZMzx58gviR0u0LthY2nZibK9EoEWpYc58DNc24ruqK8i3yOrygwOfW469YLEBMjdTPdf5EtLYiCFE3YrkAG6aMS1F3TGS5zEM20pFv7gOL9n3r2wm899Ab+1TKuVEZDthYF2J/oMnnaUc4h5iZK56Grkpt9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778889644; c=relaxed/simple;
	bh=6rznG3Hjk+yGQyMwPaLeWCQYPVbc8eXonwcNrAiTbgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRcp5NIYsg9NGEo47yLy2ypxV8JQZyRDUd2jP8VOO0A5AE62zO/TB8atfUvEiqlB435thvcmwJdzyLSg0IGlnHQDH7yjz/QFiVEjLHbKItaO49twmLJO2yU96E8ApkRqBPBLC8gm/dSzg7xdv7k0aqvHc3cj75dDXlWiE9Ts+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IJu4HCCm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IJu4HCCm"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bd394f4a931so90810066b.2
        for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 17:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1778889641; x=1779494441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uW71oVHB30vt4EIgGt8pF2rmJSEtvt4hUFu3tv0VEdo=;
        b=IJu4HCCmpl2WgIA+jggek72vBrdZzMjsOQEtO3HZ7z00vKqPj1dROPYdnhRu56cc/V
         rlb5UVeG7aADOAGkn9pTDXv3KQft9vGxGet2iCpRSkmhV7FUzMbQ1efxNzUFUSqtK7bF
         X0zwEdcQ/upzOqPrXEl/zJXfrlMxl0sLGdvP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778889641; x=1779494441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uW71oVHB30vt4EIgGt8pF2rmJSEtvt4hUFu3tv0VEdo=;
        b=E9t+4hu5JO1ZrYah8YUtEUbBiALP+MDLAJPfra8VfyQRMdMb+PtU36y/yFJIOd5Mo0
         ADqfsm53Xo3gdaeqM9DDBzp7vDi7kBBKRSE+VSn29mTlUWHzvx/+gRx9baqevBBDvOWw
         F5F+dWVvA6otidvDvK245QVs+dsx3pkkumSIRminaxTsKa12MCzwtpxane7yG5oydfov
         DilZEEnLwawX+fxHnYtLDqdIDURTmWUKGDwcnZJns1kiJdsXR0fTpQp6Xuh5aFlbLUYi
         G73T/LevMofk4YzsZQB0dgGHKKRTouMBNN2cufwDvDGiR9Df1emjwWbHDfK/HkedowAq
         t5RQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8eH1F07MyGWVGk5IWDDT+nfUunh6/SjMjcShP9gaUBTwqIalZ28MAuE7TGoYh/S9q6X5ZDHhFcB5n@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGNy+BRzwerhVHqlPaFKbpiyRXkZPkCGr0loeIyNx+o3suX6h
	zfjl04so6IDr994qRpvY5MTvrU07gn84XArmsUdTfW+x3OC5Yf1gXt0JdrjXsZnLwL9WST81scd
	DGmD1Sq0=
X-Gm-Gg: Acq92OGpfTxeKzRfkoTbs7lrUIjSkDuwI/p2o10h+gOHbEV3WfjWjmXROo4y43V9/uY
	xKF+7i0fasLUTeradxN6QqXkz5hVIapXdVii9I8S5oTeay5FivfuQmch0Cceq9NoYMIB6Wjl0oi
	1eaEXPRkAl0Yywl/Oy/lvlQPalFOx2Q25vIcdJkj/x+lCRdIPRQgGKATHROYhjb4uhrWwi7YORS
	JdkU3zyW4EFOdtOL7E9YlzqpXMs7N8vDc3lj3crjNVvxAjFzu6SsEtenPaUYNZC7QaTZkz4ZguM
	CDZjx/OUg+O2leO8fn9zkYup9kU3HKtyYF3f/YSLTr+W2CKfBulxNiOMktwv85vUgzgk1JvsZFV
	jVPKzp3xFX3IllPouASB891V7Tn4PBmIMJuoFe08oFuo/3EfYcGET59KBc04a7xKUv1seGGxjgp
	0SJD9whSAZZ6FEqcISwiYmrFN79qXaPQEf5p3tUC87v2kQ/uZsSPuyt5zKrUXuCJcDcdYVZGEeT
	iQ3OKsU5xc=
X-Received: by 2002:a17:907:c8c7:b0:bac:3bb7:268b with SMTP id a640c23a62f3a-bd517aa8873mr359805666b.38.1778889641064;
        Fri, 15 May 2026 17:00:41 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c3150dsm286493566b.24.2026.05.15.17.00.37
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 17:00:39 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67bc8609a9bso1053779a12.0
        for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 17:00:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+EQbrs2LQuynKYrcLX0QNNmDyF6sxAjR768JlvtunepNqBb5qwG8A6xmjgeurdnuhgbA6FiV1wuf37@vger.kernel.org
X-Received: by 2002:a17:907:3cc2:b0:ba9:2611:31e6 with SMTP id
 a640c23a62f3a-bd51780c5bemr340822766b.6.1778889637242; Fri, 15 May 2026
 17:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511214226.937793-1-minchan@kernel.org> <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
 <agd--WZpeTq2iKFW@redhat.com> <agefLhQeWpvil14M@google.com> <CAHk-=wiHfzbufXD2nuc9BhOVp-pYEmnVUYeThKmfZRXLU0kJ7w@mail.gmail.com>
In-Reply-To: <CAHk-=wiHfzbufXD2nuc9BhOVp-pYEmnVUYeThKmfZRXLU0kJ7w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 May 2026 17:00:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRbQhZPLfHFjikMNYyiF=ZwNCuQb-9b7-ssJJuvi2_6Q@mail.gmail.com>
X-Gm-Features: AVHnY4K1qAtNT0_ldZjhVwjRfx_9wYac0JueZzPmVNpMpI68VH0jl5IZDzRW2lM
Message-ID: <CAHk-=wjRbQhZPLfHFjikMNYyiF=ZwNCuQb-9b7-ssJJuvi2_6Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL
 flag
To: Minchan Kim <minchan@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	akpm@linux-foundation.org, hca@linux.ibm.com, linux-s390@vger.kernel.org, 
	david@kernel.org, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 May 2026 at 16:45, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yes, yes, we'd need some sequence counter for when the mm changes due
> to execve, but *that* should be absolutely trivial.

I guess we already  have it in the form of "self_exec_id". So the
tuple <mm,self_exec_id> should basically guarantee it's the same mm as
it was at open time.

Except it's not updated at quite the right time. If it was done inside
the task lock when task->mm was actually set in exec_mmap(), it would
work as-is.

This isn't exactly what that 'self_exec_id' was designed for, but it
*is* a sequence number for the mm of a task. So if a 'mm' pointer
value gets reused, you can tell that it's not the same mm as it used
to be by looking at the exec_id.

And I think the only reason for it being done outside the task lock is
that the current use is all synchronous to the task itself, so locking
or location simply didn't matter.

But there's some mqueue signal handling thing that looks like it's
actually violating that situation and would race with execve().

            Linus
