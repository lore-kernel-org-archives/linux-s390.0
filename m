Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693A421EFB
	for <linux-s390@vger.kernel.org>; Tue, 20 Jan 2026 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912383; cv=none; b=lxsZpyc1WzFFT73Hp4OXRbMg14q1ZqhrewonHOYpEtFpyqR4ZT3YHyXJZbUK8v9J12jQ9fJDQcq8QGwoUp++YUZSICkqqlg+f579mkfmlUc5hLmXhoIDif/XBqYyP3PFXZ9EltL8hQGjvMxBfJ6PrD2jJv6RnOhnrB+9cbAqUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912383; c=relaxed/simple;
	bh=hKUek6FSuV0wPD4SWpvfkGywVOzCCmdIBKSJNwkt6Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OU4Yzp6nNqdx+/R//cpDqlOMFMenxMRShc87GDc7sWdncA4U0IVDro58kNtSch4I3QfSpYIkJZvWdTfbiqpBfkx2kC45u8OjDTSNOV7guLhfeIHnkJ4G2ZZ1PMCQxSF7Cnx1lp8QR1VLWEC97AoaG4geJ5KBAfdj7odEeJ1yAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVWyH7Q4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVWyH7Q4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0296CC16AAE
	for <linux-s390@vger.kernel.org>; Tue, 20 Jan 2026 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768912383;
	bh=hKUek6FSuV0wPD4SWpvfkGywVOzCCmdIBKSJNwkt6Dg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YVWyH7Q4TCe+TRUc/lOMLGuLkZu02SKSLwY1q4JletUR2PKc7/gFISQcU6prwzCFg
	 Ux5NYqe1XhID7Ekn0QJOfUK8edzBnXIYZk+7HNDbdGpjAZt3vZ9aXSaQ7gULvoTP8/
	 lBdRmkkhrV23eglu9nIQSheVyQJ5v1OsdXP3V/3sY7qrihV4MnCwYjiU94IXzwiMTb
	 Mw/XBK09AEhLTJIVaAZdeohQtWClQi/ZtTwfX5wI+HSOESDLL1yb5mz6qVsk3mBoWX
	 S21EtCbAHIIpi9SVxh637bT8kdnYK+SEUdxE4OrtPR8PBKqwHSsRqdSJgkVItVpOkN
	 eNE2dxA+q1twQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45c719bb855so2800175b6e.1
        for <linux-s390@vger.kernel.org>; Tue, 20 Jan 2026 04:33:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5vflmgRrKvLzeU4aD1rtndx+mOkPV9qq0f3BkYz3E53AedIbzRPX6mpBfQO0AXn8I61bophIt1ltV@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCmVnLo0KRn9VgQD9iJW28Xq0Gx7HV83AdNrXiYGBe/HoV0c9
	kLP3fHGyco/aG0Fx6EmTKklpRpMg+OBjJpGGYaAH4trkbIdgOqxEFRvXmUiCmcDJHMhfzn/q8pQ
	14kIArvsrtOzS0FGmnsDnh5l4QwGoZPg=
X-Received: by 2002:a05:6808:448a:b0:45c:916b:ef9c with SMTP id
 5614622812f47-45c9d78a867mr5196389b6e.29.1768912382060; Tue, 20 Jan 2026
 04:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116145208.87445-1-frederic@kernel.org> <20260116145208.87445-8-frederic@kernel.org>
 <CAJZ5v0hn81J_0N0Hy6QYtc3655w-9hDqVgWWY1BVhW=DT56Deg@mail.gmail.com> <aW6rAjJ5hz5BYuAR@pavilion.home>
In-Reply-To: <aW6rAjJ5hz5BYuAR@pavilion.home>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Jan 2026 13:32:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gfT1A9OtEzeyp0MJ7JmrPJXF0PWL-8dSdtJXp4pAE8fA@mail.gmail.com>
X-Gm-Features: AZwV_QjyzkHKMnzUGE3i8rgFOfKwikMCgd-Rrc-fDFsp25Vo0PeauBuKiyLm8dA
Message-ID: <CAJZ5v0gfT1A9OtEzeyp0MJ7JmrPJXF0PWL-8dSdtJXp4pAE8fA@mail.gmail.com>
Subject: Re: [PATCH 07/15] cpufreq: ondemand: Simplify idle cputime
 granularity test
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Ben Segall <bsegall@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Kieran Bingham <kbingham@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mel Gorman <mgorman@suse.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Valentin Schneider <vschneid@redhat.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Xin Zhao <jackzxcui1989@163.com>, 
	linux-pm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 11:07=E2=80=AFPM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> Le Mon, Jan 19, 2026 at 01:30:07PM +0100, Rafael J. Wysocki a =C3=A9crit =
:
> > On Fri, Jan 16, 2026 at 3:53=E2=80=AFPM Frederic Weisbecker <frederic@k=
ernel.org> wrote:
> > >
> > > cpufreq calls get_cpu_idle_time_us() just to know if idle cputime
> > > accounting has a nanoseconds granularity.
> > >
> > > Use the appropriate indicator instead to make that deduction.
> > >
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> >
> > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> >
> > or please let me know if you want me to take this patch.
>
> The patch is standalone but the rest of the patchset depends on it.
> Now I don't target this patchset for v6.20-rc1.
>
> So if you manage to sneak this patch in for v6.20-rc1, it works because
> I'll rebase on -rc1. Otherwise I'll need to keep it to avoid breaking
> some code assumptions.
>
> What do you think?

It can go into -rc1.
