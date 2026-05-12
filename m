Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4C347BC6
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620638; cv=pass; b=nc2xqLH2vy8/dvoSi9HX7l8FT5oi/ribSqKcyL4+zWAoCWImj0McJCpsdNoIUdwFyEJjjEpDJByZ/f7ssEFrCl7BaCkOtWE1yiu2OR3LPes7H6kiUnIDTgDja1Fo/QRwX/Cjozq3JGPTcwdUFWFZW71aM6/PqnjcPkqf+F25cy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620638; c=relaxed/simple;
	bh=5zh4msfOlywozry5XquR1R9jhEz2NzPVF1rCKXwj7Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCNuslr9ZK0Jves87zLSir75uyvoxb92sQolUVjLaugeQau8AaJ0S8LHkLwM++tS71KOPleiQJojIPFksvgxjJuvo2cUH+lRtHteSTxgSgFer7banfPP4c9bdWFwbVne/a93pZKjSnH4gbFfpxb+BwNxV4Uc7AQwoHcSdonScnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6ln+zxR; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6ln+zxR"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1330d6bb78dso2643538c88.1
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 14:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778620636; cv=none;
        d=google.com; s=arc-20240605;
        b=PhKtyomgXm3FibfPEBhTgPqXZHIcPUys1w9V3uex2p6reU4djGUrhheKD92G6MROYS
         upntd7wbRtSmo1rr6r8ZDc21UMkM6SweLycagVcbz8yIHlkBA5c7dx4O3hd4rcrtj2Lg
         WFKtlQSGxqwPlbWSsaD/OXnpec+NDwGIu+KV1tAabp/AYj3Ucdvcw7d6QQElYBTbUuuQ
         cAJmunHb8m2oS5e5CBb7WlvYTtYAPKN27vwVET+IMiaZbC034qtPqfNhYCILrGpmX6Rw
         8hYN6u1TNJ9LjdWlwjtCJ0q8d2cT9/SElhs5p2u+0rFq2DUSO0PUUsvKI6i4jJwYSsxa
         bi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5zh4msfOlywozry5XquR1R9jhEz2NzPVF1rCKXwj7Sc=;
        fh=1ZYY5w+3GFuUayTcONjVfqpmVT63MXKVaOaze5BjGi0=;
        b=B6+5TZoUshOSUfCF46ixezoGTW+HRyn5tdQVf/SDp3dQrqTShzZJ1XEqEH5oX1kckb
         TJqgVV3W4u27aYAjYQVOPIB53Pze0sI2avAQYYmcPlaZjpGjIaFt+VM/zcsAJU7yVAM4
         jt8ANV+Ef/ibZ+QD3Gx/kgJEo5e0UG4bcgIfWLhMUdrHW5Pm9LKzj6e9NVz3apG0x8ro
         IoCAyRzPtp9NIMP16sJFzXhaEcZpPVaVA4fS+Ikwq52JAS9+7cTD2XSgJGQQuPLUlNH6
         X+c0aSw2lXRs4Z1GJVq4ZLt7WffByHNsAelNBjIwiawdcN5gWiA607SgLLWOtk51TEa1
         wOGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778620636; x=1779225436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zh4msfOlywozry5XquR1R9jhEz2NzPVF1rCKXwj7Sc=;
        b=j6ln+zxRDo1B6WA/fqal9hoyGJY+GHdc5hcSBJxyaPOFACKYsGxSc2haFPyH5HHaFK
         OiD793D/wCTqETVP2mHSHluXEOzWh+64HjXrSL2Bp4tTyn72/Bl9DbpEoGMMaTJswN4F
         uppHQxY1H2eDglxKkYgcjd/za4uI8Wsyz7B19QyvexNaIavh3byUXAvVMwRv+25fwuKn
         iz/Mmhvrse4cPBJQtpQfWTG3Cje8pYgHWKmBlZX39x1CawusW6Qx6xsGVcYnwVU3bgTm
         Pdgnz6aGnfEsHjQGspCmYKfTgeNA6X4jxBkrHWacfHoGJgwt5iGmfqQjRwc4AzxjaGrR
         UJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620636; x=1779225436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zh4msfOlywozry5XquR1R9jhEz2NzPVF1rCKXwj7Sc=;
        b=aPB1mtF9X0cNDhj2vEK3W9F0SO2/YikHs9xSlL5/Exf39VcLp7mcWz7c2Rcfidb1Mg
         HVT8QXj1X3cqZJ0yfTVraYs7H4LRreQbwWxPG3PTZT31ZRRfCd6GxTdIM4kNQIfiINDY
         wRq0dxs6VVoDIcFu4ooFlmH/+bKZVs+5yYkgs2psT7I0ZN5LOg011B3NughwakrtV7Jv
         G/Vk5onHBo3lEJG8pm8CdmfrBF16DgtaKgmU40y2XJ04vENiDKeP8Vyb8QcNmghrLOkO
         F4W0DAWfDHm+f/tBg8oi4o8YDYZINpJQX5uXPttlB4SPsPBc10NP9/yUcBlW3U/Cy7X1
         doHg==
X-Forwarded-Encrypted: i=1; AFNElJ9/mI0bh8DLEANFLaE32qU7IzSVVi0cyjGVwSd4gBSmc/dBnrhfCUzEYx04VxOSV0+hWKzNtKC+PoaB@vger.kernel.org
X-Gm-Message-State: AOJu0YxQb4YhjKFn5ONiN+cPaV9ogtyHuwWWU33Senb4VOT2EMHXfluF
	5ZqmCmE2mRNeqzhNnxnA9B6yv2fH8bcgp7loZunDPNdsj/PQcwqN+2h/PJnoLYlrB/f3/UJ1iDQ
	7Ke8qI+RM+WEOXD3yxkcChRiiKmjyyH+cJeL+BcA=
X-Gm-Gg: Acq92OEnfru99b6t+RvbRgdfiYjK7T6Sx+Q2KaZvUfkyU54z+s96DnKp1B8VAc1Prci
	FHgT88ooCiuzzwUEswE0TYLhcNx6qPseRq01PBPJS5qfYr7RkCeKp39ZeUHf6yYBLeBdDB3JFAf
	oGj8ieh1jwElyr2zCbK6w9x2yoNQ5hvR4PPvXLYoQcch8vvkPj7pVtc3uR0CzXp7x1287J9id7n
	st8LcG2g5RadNL791RgZxYlMD01S68cpxTX0vpiwHnp/YPNz8PCa3HFe9cHjMiSM6j5S15DgwFB
	bzkqJJEB0a6UHo4XU0hNoAuH8nWgn2RGtavzsO7+G/pElKnTACTqWBSUxeJxod2UNuSn8rztlCA
	vdJuEyg1N9FObI1utalNu/S4GD5iu8Ekwpj9u7ok8qO99n0DZ0wgD9JoF
X-Received: by 2002:a05:7022:326:b0:128:d219:e169 with SMTP id
 a92af1059eb24-1342ef3dc7dmr363352c88.10.1778620635128; Tue, 12 May 2026
 14:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c00-02.v2.ttenwd4@ub.hpns>
In-Reply-To: <c00-02.v2.ttenwd4@ub.hpns>
From: John Stultz <jstultz@google.com>
Date: Tue, 12 May 2026 14:17:02 -0700
X-Gm-Features: AVHnY4I9LH40rMyv4tDazzyMAqF7zbdeswmUejMJYjFYyTNiekAi_gdX1fiwGeY
Message-ID: <CANDhNCoJHSaiZiD7xgqd-L9LXq2-iGU-4FtjVGy0PP2uRpnxEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sched/core: Fix proxy-exec/core-sched interactions
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vineeth Pillai <vineethrp@google.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 3:42=E2=80=AFAM Vasily Gorbik <gor@linux.ibm.com> wr=
ote:
>
> v1 [1] consisted of a fix for a scheduler corruption where
> try_steal_cookie() could migrate a proxy-exec donor away from the source
> rq while that rq still used it as the active scheduling context.
>
> Prateek pointed out [2] a separate proxy-exec/core-sched issue: after
> pick_next_task() selects a core cookie compatible donor, find_proxy_task(=
)
> can replace the execution context with a mutex owner with a different
> cookie.
>
> This v2 keeps the donor steal fix as patch 1 and adds patch 2 to reject
> mismatched final proxy owners.
>
> The v1 reported the issue reproduced on s390 LPAR, but it seems to be
> easily reproducible with strace test suite "make -j$(nproc) check" on
> any system with SMT, CONFIG_SCHED_CORE=3Dy and CONFIG_SCHED_PROXY_EXEC=3D=
y
> enabled, e.g. on x86 KVM with -smp cpus=3D16,sockets=3D1,cores=3D8,thread=
s=3D2:
>

Vasily! Thank you so much for reporting this and working out fixes
(along with K Prateek!)

Apologies for being slow to reply, I've been under the weather.

I really appreciate this reproducer detail, but I've so far not been
able to trip this issue up (SCHED_CORE=3Dy, SCHED_PROXY_EXEC=3Dy and using
the qemu arguments you included above). Could you mail me your .config
in case something else is needed?

thanks
-john
