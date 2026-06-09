Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4D33E95B1;
	Tue,  9 Jun 2026 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992385; cv=none; b=EtI1gj+UFjjWHYAcvTItJLlaArZUJeRqNjCCOyJILeiK+WSl3zl7Gzct4OiMLmUijpD5vU5e7SVJnDJRm3Mr4PxRvckcMNL35lkSL31EYQN3eYLwaUqI3HTvu1VzCwYSXl/No9SQ3+gogZuDOa/w7XZ+DRIYjuJFoynL9DiopFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992385; c=relaxed/simple;
	bh=qwbcgQ/WQsVIsTXkXunVAagyi9kEj56i64FLMZACVYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jb7/CmQ9hW7ewpWgtkH3VnkvaC/Mpqe7RSQGJQjqw+p8gYkBhqkpTNgrmG/hf+d7RU8gAmz1FEWHm/w/C/OkKOzWo4+CxhdCyTMrFG2RTrELRumG/xWGAWU9RoFIknRpQJV6+JA1wOnQjb9WFF1iHaUADo6L1mYmcPvq4FCLz60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Le6kKzpb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Le6kKzpb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 486592681;
	Tue,  9 Jun 2026 01:06:19 -0700 (PDT)
Received: from [10.1.29.25] (e127648.arm.com [10.1.29.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D91C3F93E;
	Tue,  9 Jun 2026 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780992384; bh=qwbcgQ/WQsVIsTXkXunVAagyi9kEj56i64FLMZACVYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Le6kKzpbUjoiHGhxUJ9PVimGhMg2bwpTBrPEfPdyePRQK/9hvH76xmCErt4nL6IPb
	 45gi+/BkZ89WZ5ClhOwWBsJhxXLyWeTthgDcnMDowqtw/BzsKbBE0Fio2L67Q6J78h
	 9TMgZJBqwERGj/ITSfLAP9ijrCEmyZWqvY4thmLw=
Message-ID: <2e07e79f-dee9-4ae7-a51d-eb132cc4abfa@arm.com>
Date: Tue, 9 Jun 2026 09:06:16 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] s390/idle: CPU idle driver
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260609075213.31094-1-meted@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 08:52, Mete Durlu wrote:
> This patch series introduces a CPU idle driver for s390
> architecture that leverages the existing cpu idle infrastructure and
> TEO (Timer Events Oriented) governor to optimize idle state selection
> based on timer events and interrupt patterns.
> 
> # Implementation Overview
> -----------------------------------------------------------------------
> 
> The driver implements two idle states;
> 
> **Polling Idle (shallow state)**
> - Busy-loop implementation that prevents SIE-exit during short idle periods
> - Zero exit latency, optimized for latency-sensitive workloads
> - Maintains CPU with the guest, improving response times
> 
> **Enabled Wait (deep state)**
> - Traditional EW state that signals hypervisor availability
> - Higher exit latency but more efficient for longer idle periods
> 
> The TEO governor dynamically selects between these states by monitoring
> next timer interrupts and system interrupt frequency, choosing the most
> appropriate idle state for each situation.
> 
I don't quite get the TEO focus of this series, on principle menu works
similarly, did TEO just work much better for you?
If so do you know why?
