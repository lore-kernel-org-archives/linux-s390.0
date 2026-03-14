Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5640DFA1;
	Sat, 14 Mar 2026 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773526010; cv=none; b=gL+qsximTkaFn71AHzlkB+wK1/gx8+pF+7PETWLN7vO9/iLO0U2oHJ5bNDsm8UBtz3XPPwyWwUNyEFfqguPqmvdGmxnFht1cETTWBoXR6/3myEx1tJIXFcbJlC9pS/4SJ2SlXi4Thyr8MGwAdve1XaP3SzCyz9xJVVarRYNlM8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773526010; c=relaxed/simple;
	bh=qFxp43Mm4v3Jwrh3SFQJoMvzIOQudIZXdLxg7F2u1so=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JE7Qocllrwr1BYcSKQ78nMjPu7jgCa4xhQvlUdZNTMCahE83Q3dpoQb8SO60YTLqeG7Yw2SRimTosoTI4HLPhTZ98GBxbfJQgRiNL+huFhGOMUMrJYtGSGQJBnhpH8s320Gpv9P9Xd6tXqDtqoGoZ4f6qDJxe7TqhtLw9TG2as4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=l4gL+N6n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="l4gL+N6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D9BC116C6;
	Sat, 14 Mar 2026 22:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773526009;
	bh=qFxp43Mm4v3Jwrh3SFQJoMvzIOQudIZXdLxg7F2u1so=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l4gL+N6nnqHyaoEQiL7IxfxGqTBigZvjoFyxvfgdugUwNmpsFDLp+eExHsH8GXC1w
	 qMUYGKxbg7K1B6cNlBk3VnyceL/pat1Cw3zhR+Hqp1zPP13eoRcSgEafdKqZZoWn+w
	 FfK32JPY+HB6NU+yDwYaEhnsBO3tWRP1ViV4FLlQ=
Date: Sat, 14 Mar 2026 15:06:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
 Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [PATCH] debugobjects: Allow to configure the amount of
 pre-allocated objects
Message-Id: <20260314150649.9a7c4bf4554b1288eb471edc@linux-foundation.org>
In-Reply-To: <20260313142620.GG2161595@p1gen4-pw042f0m>
References: <70f06193b3c3581802710ebcef74671e50c4c979.1772035270.git.bblock@linux.ibm.com>
	<20260311100431.GC46248@p1gen4-pw042f0m.fritz.box>
	<20260311104727.8f7b1492141b6d61fc1b2791@linux-foundation.org>
	<20260313142620.GG2161595@p1gen4-pw042f0m>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 15:26:20 +0100 Benjamin Block <bblock@linux.ibm.com> wrote:

> > obj_static_pool[] is __initdata, so the consequences of making it large
> > are very slight.  So do we really need
> > CONFIG_DEBUG_OBJECTS_POOL_SIZE_SHIFT?  Requiring a rebuild is a huge
> > hassle.  How about simply making the static pool much larger and leave
> > it at that?
> 
> I was thinking about that but then couldn't decide what would be "big enough"
> as constant value for "everyone". My test systems wasn't even that "big", and
> I'm already at 1280 KiB reservation to make ODEBUG "survive" the boot. Not
> sure I want to make this say 2 MiB without config option for everyone.

2MB of initmem probably just doesn't matter.  Annoying.

Do you understand *why* s390 is using so many objects?  Presumably the
current much smaller default is OK for most systems - my googling for
"Out of memory.  ODEBUG disabled" turned up very little.

Oh, look what I found. 
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1807440.html
What happened to that?
