Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013662E6CD8;
	Wed, 19 Nov 2025 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566512; cv=none; b=YkqZYimfzs4mB08A51FMnGs0LTdVwrZ/1OnsLcjmywb6QgtaTu4EAqTM2CMhSNVQlAbn+xUdXKOgiSSP+SiCoN1AVG31Xjo2bEgvVsff/Ti9h1EzX1ck22lp2ROD44xSMIi4idwo9+fPoyJq21tw3no6xc6rP/cOAKl0JpZFYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566512; c=relaxed/simple;
	bh=Ru4UL5QZvt85yHaeXigm4fxOa1xA2dR7whrh2QeyAvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cA3OAzMq8LooaqGjHTkktoU/bNcRtOPXd/9EcQWM9RHKHtgErhpdG5ou1+QTh5G3MNo+bJrxdXPt8iaAGVck52Stz3pkJJAxw2mEKxkNBiDigf2acd6bsr7mg7vosy3eL5pF7ReOzfOBaiLTOi4nnMR8DI6Osopx/BCVeIInSyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPkZS/jJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3G3H+zB1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPkZS/jJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3G3H+zB1"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763566508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2WvwqK7gkDlpCgm7tqGJFv9VVSpeE3X6W+G9zbaFME=;
	b=mPkZS/jJgWa2boCgDaPOxikXfMyAEosU/UOAblQPI9OYny356J2Jz7+nbfwbIZJp1Juvtn
	Cp1GTPCuXMJGYqzBC4dpLeg0FwUizu4RLwLOvk/DF+t3c1ku7MS8ZUGC1huUPxOpHHh0fE
	3FIj/1kIrlEfObtls3xZG2gVCXkvuhtMcWF9AXJ2knStJ9sVrB6rhE0oNwHiO0RFh3wKGO
	/hX0zVNCdD5ttIgIdiA4th72+1m5N5+XCltvyuGxoxJLS+uQIwbZzh6F7QAtpHndI3l/P0
	T32t6HLVwbLOa4K49RjKVAQB7xfSbOkxcjk4F5T1+e6mDPg5aHtiCZLFlRRhFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763566508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2WvwqK7gkDlpCgm7tqGJFv9VVSpeE3X6W+G9zbaFME=;
	b=3G3H+zB1HfB5HpHJ6wT22I7Af77ws4nonJG8fAqVE8i45bYqPfqsCiM3w/J7xr3HO+IKTU
	9s3vu8V5A/CSOGCg==
To: Tobias Schumacher <ts@imap.linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Tobias Schumacher <ts@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>, Halil
 Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
In-Reply-To: <57ab63b27a6729125927771e33d06f30@imap.linux.ibm.com>
References: <20251118-implement-msi-domain-v3-0-6fe8feb2a93f@linux.ibm.com>
 <20251118-implement-msi-domain-v3-2-6fe8feb2a93f@linux.ibm.com>
 <d16adbc5-600e-4260-abad-4a3e380dac6c@linux.ibm.com>
 <57ab63b27a6729125927771e33d06f30@imap.linux.ibm.com>
Date: Wed, 19 Nov 2025 16:35:07 +0100
Message-ID: <871plum3x0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 19 2025 at 11:12, Tobias Schumacher wrote:
> Am 2025-11-18 22:49, schrieb Farhan Ali:
>> Also thinking it out loud, is it this going to be unique if we have
>> multiple IRQ (if nr_irqs in zpci_msi_domain_alloc() is > 1) per MSI
>> descriptor, unless I missed something?
>
> AFAIU also for MSI there is one MSI descriptor per IRQ (allocated in 
> msi_domain_alloc_simple_msi_descs()).

Correct because MSI only stores the MSI message for the index=0. If
there are multiple interrupts in the device then the MSI controller adds
the index of the interrupt to be raised in the lower bits of msi_msg::data

> The MSI index is incremented with each descriptor. We could iterate
> these descriptors, but since the index is incremented with each desc
> alloc() simply implements a for loop that increments the hwirq number
> for each irq.

That's correct because the MSI controller in the PCI device requires
that the hardware interrupt numbers are consecutive due to the above.

Thanks,

        tglx
