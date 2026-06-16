Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560E3769F6;
	Tue, 16 Jun 2026 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579078; cv=none; b=ZoU6xTQm+U2Zgd1QFKjCGMIfse7cojBDNFT/ZqH+RxGQgLJVf6+C+hfgazV4MVq315JRQ8kj5zGzsZGG8Xjn+Yjqx6xx+0pKL69j0ytsiblWSIqw5JqpXWiQgUyJs/yZ0o7Ksrssj8oHNasUHerVtgJrZnOwwUbm7XGYyzbEg/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579078; c=relaxed/simple;
	bh=C1dL1K0prG3fQPpJnD/+ZHKOzTyQugyZG8Gk1LycBbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDuBobVtp0/lBTekkyR1V8gcJbClab1Bu6sGAu0T6eIzUZ7U6lw7lwYwiRGHX9zVmZF7IOqnK0UgE5DDvCXRbqXxuCc13ozZVd7a/ghZG9lhDKhxk0bbeoxq7d6uYgn6Pql8qTo1R0f6BC6aIu6bcNeJMEO7gEAbDJqu+V4cdoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOYCw4l6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOYCw4l6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44501F000E9;
	Tue, 16 Jun 2026 03:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781579077;
	bh=n5HAW6YBJHZ7HyEQX9BmLx1ZIXSXhME0+yooX8MvTjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WOYCw4l6MbiX/uUiM8aHxQMNddneICe5qJAEDKJ3JIHMpQU6S9Lqb8PMaodf2uJoX
	 Ht2SbSxRwJ7lX1qxhX5dMzhO+CZFRubYkt+mq2y3QIyJgqTPhntufdml8WQsiRJ+WX
	 ATtw8myBhJyMTs/Q7CWTdmBB/CLpBd9+DDc6OF9Qi9mXWmPVJLEdCwU1K3g91Gi3rh
	 VT6EJ0+UDBmSCZdOw1YW5Mw6oRxdSUCqospQ6FACF+V7hmYTPpWVFQLGW/xB6PO730
	 3r3GJCwzHa8xcXUL2i3U/YCBmYnbLtyWtNlZckeLgf7poKQI9uSI+3ktHDAULkLapo
	 uTx46clCvsM5w==
Date: Mon, 15 Jun 2026 20:04:30 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jan Polensky <japo@linux.ibm.com>, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
	rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] s390: Enable Rust support
Message-ID: <20260616030430.GA3415270@ax162>
References: <20260608181451.3734956-1-japo@linux.ibm.com>
 <20260608181451.3734956-7-japo@linux.ibm.com>
 <20260615164013.GA249489@ax162>
 <CANiq72nkm2YwxcV+vwDj+v0svd6e1dro-W_0ybVms3pG_oJiXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nkm2YwxcV+vwDj+v0svd6e1dro-W_0ybVms3pG_oJiXg@mail.gmail.com>

On Mon, Jun 15, 2026 at 06:45:26PM +0200, Miguel Ojeda wrote:
> On Mon, Jun 15, 2026 at 6:40 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > With Rust 1.96.0, I see the following warning several times when
> > building Rust code in -next:
> >
> >   warning: unstable feature specified for `-Ctarget-feature`: `backchain`
> >     |
> >     = note: this feature is not stably supported; its behavior can change in the future
> >
> >   warning: 1 warning emitted
> >
> > I assume this is expected? If so, is there a way to silence this warning?
> 
> Yes, it seems so -- please see this thread:
> 
>   https://lore.kernel.org/rust-for-linux/CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com/
> 
> If they are OK with it, then I guess it is fine, but it does mean CIs
> can suffer a bit from it.
> 
> I hope that helps.

Ah, thanks for the pointer and sorry for the duplicate report. I have
gone ahead and ignored this warning in my build reports for the time
being.

-- 
Cheers,
Nathan
