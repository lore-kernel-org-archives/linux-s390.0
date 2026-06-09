Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6764A3ECBC4;
	Tue,  9 Jun 2026 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992774; cv=none; b=Muql0BNH+IvlCH6dSiIGQDr/W/lpsaCHL8IWL+KH/J7uIVCzbeijKH7rbmo/gPyy52ZLKZVgP8jQ8ZXLmLHRaslbaqp7j55GQIKW+u5uxbD5IdePff0QYIr6dKLt7PcY/3ZUvjnAtEp1qILnh0BwL31Gv+FKtTV3KXtaD9SzVO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992774; c=relaxed/simple;
	bh=yJF0UHgY+jnn465JgycG08/PxhYbnXFSBO05Chxk9LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2RMiwYVYbe8/PXZlAufKL3MgUZhP9sfQ2znYk9pJtGKAEYGSER5L1WpPBmAnpXsH+LPmx1Ygw1ULSKdF6iq3B5VLRBs66QlW3sWRjNAUDdmLqkQR0tmu6Rp8w4HqLQRx1B5Vzs8E9Zf6dkJV81QH1D5ff841Rl7V0cNbO9N3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=E90h1xPk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E90h1xPk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F33411570;
	Tue,  9 Jun 2026 01:12:47 -0700 (PDT)
Received: from [10.1.29.25] (e127648.arm.com [10.1.29.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12D163F93E;
	Tue,  9 Jun 2026 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780992772; bh=yJF0UHgY+jnn465JgycG08/PxhYbnXFSBO05Chxk9LY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E90h1xPkLejI1heXqdbsoc68uGE9k0kJsLsnRrAiFVd5ZPET9wxaSD89bLpHGZxJg
	 TiCf+z0Sjst+jMrvkBfAwtzZz+fgi56ad+Hz436lxcXGQFEpTLnLVpJ4qzVlgtd/Yl
	 6W+G7aLnxSegYoanumACZl3BkCo0zO+MFGRQ1Wvg=
Message-ID: <5d9a3d2e-f083-49d4-a311-7801e70ac1a2@arm.com>
Date: Tue, 9 Jun 2026 09:12:47 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] s390/idle: Introduce cpuidle for s390
To: Mete Durlu <meted@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20260609075213.31094-1-meted@linux.ibm.com>
 <20260609075213.31094-5-meted@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260609075213.31094-5-meted@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 08:52, Mete Durlu wrote:
> Introduce generic cpuidle driver on s390. Use a two stage approach to
> handle idle scenarios and use TEO governor for idle stage selection.
> Two stages are, from shallow to deep, idle polling and enabled wait.
> 
> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
>  arch/s390/Kconfig              |   5 ++
>  drivers/cpuidle/Kconfig        |   5 ++
>  drivers/cpuidle/Kconfig.s390   |  12 ++++
>  drivers/cpuidle/Makefile       |   4 ++
>  drivers/cpuidle/cpuidle-s390.c | 104 +++++++++++++++++++++++++++++++++
>  5 files changed, 130 insertions(+)
>  create mode 100644 drivers/cpuidle/Kconfig.s390
>  create mode 100644 drivers/cpuidle/cpuidle-s390.c

Since this will be hard for anybody without the hardware to maintain,
would you maintain it? Or the existing s390 maintainers?
If either then please also modify MAINTAINERS to reflect that.
