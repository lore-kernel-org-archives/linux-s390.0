Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9827AC21;
	Thu, 23 Oct 2025 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253937; cv=none; b=DBwbVQamJNYwq8Upg2RbMVT7h+SmRL4+TgPfRQqWa6fxT+OVr24cuzeKLtpeur0iJJQAbxk2Bm0lGcK4xPiHUIfo8H3VTHNw0uYFb8Y+85eQHxxRojc5+RPFEt0DjJ7dQ5el9WDFf3pqOCBu5chNZXqYR7zDFnXvDmlo9vLcTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253937; c=relaxed/simple;
	bh=VQKxUn79H341xpBQUEznTt3Qy5Gnhn+I63M8nHm80dk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c3pU4u7Rfb7WaDQl/u40lDOH9zKaKGlAnvOjS3sEjBw1Vk8BDSMfJ1IsRRSNnCQqm7SJ/i3llD7wa7tGTvPRDZTdyuUZwti72ubczv7TDcJFktQYoKMrtwkWvjaEdbIT9mLirTSpyZq3aslsthnMx6NOSzGLRok4daTLYckViKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pnklKNsG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pnklKNsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E005EC4CEE7;
	Thu, 23 Oct 2025 21:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761253936;
	bh=VQKxUn79H341xpBQUEznTt3Qy5Gnhn+I63M8nHm80dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pnklKNsG98upMY9Z12dFme/ilyMYHCznDwct1TgLqx9ZH9FAnPR3k1NVNyEAK8TrH
	 fGCSlNjl3wPfkg4k9p4YUpV+M1bjgnJCAwjnmbMg9ANeOC01u3Uaxw5w2yDwi4aS2z
	 Nb0G4wFwiEyXAfC0Dr0FWJH+lKdmnoISvLo30MaQ=
Date: Thu, 23 Oct 2025 14:12:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Doug Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Andrew Chant <achant@google.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens
 <hca@linux.ibm.com>, "Paul E . McKenney" <paulmck@kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Brian Gerst <brgerst@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Francesco Valla
 <francesco@valla.it>, Guo Weikang <guoweikang.kernel@gmail.com>, Huacai
 Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jan Hendrik
 Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, Kees Cook
 <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Michal
 =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Miguel Ojeda
 <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] init/main.c: Wrap long kernel cmdline when printing
 to logs
Message-Id: <20251023141215.ef068a57133127eb3f0fb3d5@linux-foundation.org>
In-Reply-To: <CAD=FV=VRz1tPLUUvpodCjYdtFxzHzyOwg1=3eHqpSMESnfNuFA@mail.gmail.com>
References: <20251023113257.v3.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
	<20251023123709.e6517087325a3a53221029d9@linux-foundation.org>
	<CAD=FV=VRz1tPLUUvpodCjYdtFxzHzyOwg1=3eHqpSMESnfNuFA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 13:46:25 -0700 Doug Anderson <dianders@chromium.org> wrote:

> > will make it a whole lot more palatable, no?
> 
> Yes, thanks! ...and I saw you added a followup patch that does that.
> FWIW, I'm fine w/ keeping your patch as a separate one or I'm happy to
> fold it into my patch and post it with whatever attribution you
> specify. Just let me know.

Is cool.  I always fold a foo-fix.patch into foo.patch before sending
foo.patch upstream.  And before dropping foo.patch, if that is to be
done.

