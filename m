Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4CA47F781;
	Thu,  6 Aug 2026 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786057070; cv=none; b=J1rDkcKlhfPTQ+H1uImVfBAJMknyA0PjWg1ZhL1Wbo21WmBuEgRY7km3P9QuqWt+AMjig9AOUwH49Vl+UWQeU1yrZDE07ETeQHv0VWgxLotrhP9fVWHj5A9vTUpYu3xyvHWcjj8P1AvbARY5FteSkmouJBzexofy4yITOjEKniM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786057070; c=relaxed/simple;
	bh=Hk1fJhllpUkCCMeesjvqZxWrAshUAKdRc1lk9kvEgOQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MqKxrz8ep8hIFzUWfkMbo7iVBxx8+DPIhkE1KH5snf0HtUnoWyAU69R69lURuAQUkWxLtzEhuzhRwPNk1CaoLHdDACucBSmXgDLFiqZWaJHPccc3k4GRRx/TfKiypz+Rdqo18tvFhQl176niDxVdhu8HTAB7IiERSFDYOE8YR1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ikNoYIR4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ikNoYIR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9473F1F000E9;
	Thu,  6 Aug 2026 22:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786057067;
	bh=BI+X85dq4LlNRPfEIbWIwO8lispM8mVV7OtTMSzPm4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ikNoYIR4mHOhB1ta+N2cWs//xXsTyXml9LnV/JFysMCvTFr9m8nkw0aNpq5qWrr9p
	 vO+ell6psXcgESEDakVye+kSM6tTz9diOZkE0smIINh5tZXDb8HsUbN8JwMEdsJl2o
	 4EaPfQNxMbKoCCQv0wh0UYMVorMEAsgMZi5T3GVc=
Date: Thu, 6 Aug 2026 15:57:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wilson Felipe Pereira <wfelipe@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, linux-arch@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] init/Kconfig: generalize config COMMAND_LINE_SIZE
Message-Id: <20260806155746.0c3590dc2f3228e7d65e986c@linux-foundation.org>
In-Reply-To: <20260806061429.474992-1-wfelipe@google.com>
References: <20260806061429.474992-1-wfelipe@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu,  6 Aug 2026 06:14:13 +0000 Wilson Felipe Pereira <wfelipe@google.com> wrote:

> This patch series promotes COMMAND_LINE_SIZE from arch/s390/Kconfig to
> init/Kconfig to be generally available to other architectures.
> 
> In some use cases, such as netboot kernels, rootfs configurations, larger
> initramfs setups, require larger sizes. While for embedded workloads, it
> can be reduced to save memory.
> 
> Since COMMAND_LINE_SIZE can be larger, it also makes sense to allow
> INIT_ENV_ARG_LIMIT to be configured.

Thanks.

AI review pointed at a few possible issues - I eyeballed a couple and
they appear significant.
	https://sashiko.dev/#/patchset/20260806061429.474992-1-wfelipe@google.com


> Originally-by: Maciej Żenczykowski <maze@google.com>

fyi, it's minor, but Originally-by: isn't actually a thing.  It's
mentioned in the -tip documentation, nothing else endorses it.

I have no issue with it but formally these patches should also have
Maciej's Signed-off-by: 


Please let's target 7.3-rc1 for these changes - I'm deep into
stem-the-flood mode for this -rc cycle.

