Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C660E3E9C0E;
	Tue,  9 Jun 2026 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992615; cv=none; b=Udw3xQ76C7MoR/9Sh66jUxuR0v63zwBLEj82CKpSf1M991hoNnkxhAG35xpAkCcafa3I40erTv7eu/fNMVtfXJD+vtYO5gWHx4wFCqt2IY1fSrljVN5/ekiW+WLdfxNtFTmodX6mDiJ5lwHeok1m9sB1eccOwI/0Di9xKJh/MNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992615; c=relaxed/simple;
	bh=o6XEB081Zn6a71wVbDe2KCxbKCNt14+1fzWvub9Gi/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8ejhgnaDSkw95iqkaIg4RxsFSnunknJ5zzUqqOUYw2Ip5bzxm4mTQnTbe5luhynEkP6qnLysAlWCELuvaS+pSCpAj3uPRt9R6Cv0T2ehVbaZmRR3cWOimeG3ReTuSiRa1QPdnYScUO5n5wGvyHpHfXFRO471by8gTfvimmp5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tT0cF06s; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tT0cF06s"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21088236D;
	Tue,  9 Jun 2026 01:10:08 -0700 (PDT)
Received: from [10.1.29.25] (e127648.arm.com [10.1.29.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B37DB3F93E;
	Tue,  9 Jun 2026 01:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780992612; bh=o6XEB081Zn6a71wVbDe2KCxbKCNt14+1fzWvub9Gi/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tT0cF06ss2VfuAv/FPVUqlaky1WYy0K+T60POfNTxkmIHIaKEjMHDKUF1JrwlRqdd
	 shumgbGZIfeCwYrEv4FEQibMLlZTgBNptMs7Nc7n8FdoYC3aW+FB74Ta01vqjUC5W+
	 KCtCSv0VyGEe4ktfTzYK1u0bXONwcywoe24FY0ms=
Message-ID: <e70007af-aa98-4870-985a-6648564127fd@arm.com>
Date: Tue, 9 Jun 2026 09:10:07 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] s390/tick: Remove CIF_NOHZ_DELAY flag
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
 <20260609075213.31094-2-meted@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260609075213.31094-2-meted@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 08:52, Mete Durlu wrote:
> Remove obsolete tick delay heuristic [1]. The upcoming cpuidle driver
> handles frequent sleep/wakeup cycles more effectively.
> 
> [1] https://lore.kernel.org/all/20090929122533.402715150@de.ibm.com/
> 
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
For bisectibility does it make sense to move this and 2/5 to the end?
