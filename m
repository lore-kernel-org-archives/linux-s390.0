Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280D1308F2A;
	Tue,  1 Sep 2026 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788221949; cv=none; b=VjIdFRxt8B+TigS/T52SV2bAmUJDo27er2Qzp4tkpVhlwRrXbgPYhAjLYUGnSdjBCy9L0CFi6t070WFpyAxoH6NnFsEyxDX5XXq6eNbIYdVx1vf/U30hLv55+nXcBNR0pec9tCpzoJt5MK0obXuN2QBnj+phVcqtZMKW82UxTVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788221949; c=relaxed/simple;
	bh=h4v4yw0i8M27JilqHBTnAZ60EEMT5nCjwT5oh9kL7wI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=argCHtGk3Jos+8L9+8TWd/3rq6CzIA5idmxPcdgPSyWs4v8+y/ydcbnfeVMew/KwfCjP26WIHAxA7dN0j2/WtQ//uEfpcEjeepc0Fk0ZDrKiMaAmv0qZUPOVxxedD+wChs5SdOaEz6+kKlf1JBLeBh/tBka/+YdKSENldfG5FX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=w/zHFTxU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="w/zHFTxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508A51F000E9;
	Tue,  1 Sep 2026 00:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788221947;
	bh=82TEb+7cRNQ1CIy5NUetbmTJtTQ/LgYe7J1CFJxI2Uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=w/zHFTxUTAfVdfpqcuLsdD7MFG9dcP7vHUilQC5Igec36mq8Zkwe4IGY6NfpAVGns
	 8V2fNzS7AhcpX8pbipT9rem19lSV2nrr+46TcgjIAzwn0GuAG+anEFF7r7BR7bfLi3
	 ogtHAyyQWn8tDkseCgCCIW6fu/6Z5vkwSaqHsh8g=
Date: Mon, 31 Aug 2026 17:19:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Petr Mladek <pmladek@suse.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Bradley Morgan <include@grrlz.net>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Introduce arch_do_panic
Message-Id: <20260831171906.7520833ab8ac40d0369b0228@linux-foundation.org>
In-Reply-To: <20260831-arch_do_panic-v6-0-a1e170a9e7fd@linux.ibm.com>
References: <20260831-arch_do_panic-v6-0-a1e170a9e7fd@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 11:57:14 +0200 Mete Durlu <meted@linux.ibm.com> wrote:

> Replace architecture-specific ifdef sections in vpanic() with a clean
> arch_do_panic() hook. Currently s390 and sparc embed their panic
> handlers directly in vpanic() using preprocessor conditionals, making
> the common code path harder to maintain.

Nice little cleanup, thanks.

>  arch/s390/kernel/traps.c  |  7 +++++++
>  arch/sparc/kernel/setup.c |  9 +++++++++
>  include/linux/panic.h     |  2 ++
>  kernel/panic.c            | 15 +++------------
>  4 files changed, 21 insertions(+), 12 deletions(-)

Why do cleanups make the kernel bigger.  It's often that way.

I'll scoop it up.  An ack from sparc people would be nice, please.
