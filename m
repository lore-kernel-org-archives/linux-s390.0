Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C5156F45;
	Tue, 18 Nov 2025 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486433; cv=none; b=sUShadDY1opiaalDFwlF1GOig1SIefcV2O+wrdlB2oUi0QjpBnFsgOkD9YTggLklgHorTDBx5kL7sn+R32COGG/TbUOFmSwb5Qn4YPaul5i0f5hEGccFE6cvKwJWsKFBrzvLQSXWt0lyTsiNIz2vJdExxaC+DGHpqkcOUFaSkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486433; c=relaxed/simple;
	bh=K5fT4KSMw90wM8VcoXufheZInP3r4cHM0qNAYNpBwnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jLvXweDw7RA+OKC94zJQjM70jq/ehGX/80/ToWZt+mn8iyVxntWNh3ftYNGMCfanQeyk++ZS/b0pSffQbq7U2H5AjNDayLTR1Km5fxLcAm23oMS86Y/PQiQboaknqO57x59TaxZPzJZbeX0VW9SghKJigTVEL0SStBxD5XgTwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RxX1YKR5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hYQFjSjQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RxX1YKR5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hYQFjSjQ"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763486430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eMVT9I1wGDuH0608516PWTb0RCZLJxkNGpjYdj4Gp1s=;
	b=RxX1YKR5ymaCUlIVNIWgeh3V2sYXWo8YyFNV1Q8lDOc1sicpi7GDe7+EX5voyJWRhhuoYy
	BE7i1y6OQbwWoLMmZV7WB3rwGkx2cwbOKcctm9zd6XYDyFGiJmY/kXeyyBp5G/qYmmjuqv
	0FNjlwyaeLo3yAjn18KCsHSKci3P1U7KAKJcM3ZIUPu3wS2qA27C40G3rNj1A8a+1tmarZ
	tDR6hQXngwuCCJIpYCD74Bxb35jxSkubvXM+wPA6Y188E0U8WTsubtWUZeR0712DymVuDk
	w/iv4JDkmr8pcMC3RC5jru0qkAPgfTJZzXSN8xY0i3FIBcivufWj7buYBaccHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763486430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eMVT9I1wGDuH0608516PWTb0RCZLJxkNGpjYdj4Gp1s=;
	b=hYQFjSjQ4GmEp7revLE2Jqc3ExRuEfPiPmPyaKf65LdT7tmlSQIVh3gSJaFhHFmQAFog3Q
	u0nFdfYnwrc/UXBg==
To: Tobias Schumacher <ts@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>, Halil
 Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Tobias
 Schumacher <ts@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
In-Reply-To: <20251118-implement-msi-domain-v3-2-6fe8feb2a93f@linux.ibm.com>
References: <20251118-implement-msi-domain-v3-0-6fe8feb2a93f@linux.ibm.com>
 <20251118-implement-msi-domain-v3-2-6fe8feb2a93f@linux.ibm.com>
Date: Tue, 18 Nov 2025 18:20:28 +0100
Message-ID: <87jyznmf4z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 18 2025 at 17:13, Tobias Schumacher wrote:

>  static struct irq_chip zpci_irq_chip = {
>  	.name = "PCI-MSI",
>  	.irq_unmask = pci_msi_unmask_irq,
>  	.irq_mask = pci_msi_mask_irq,
> +	.irq_compose_msi_msg = zpci_compose_msi_msg
>  };

> +static struct msi_parent_ops zpci_msi_parent_ops = {
> +	.supported_flags   = MSI_GENERIC_FLAGS_MASK	|
> +			     MSI_FLAG_PCI_MSIX		|
> +			     MSI_FLAG_MULTI_PCI_MSI,
> +	.required_flags	   = MSI_FLAG_USE_DEF_DOM_OPS  |
> +			     MSI_FLAG_USE_DEF_CHIP_OPS |
> +			     MSI_FLAG_PCI_MSI_MASK_PARENT,

That MASK_PARENT flag is really only necessary if you want to avoid
masking/unmasking at the PCI level during operation
(disable/enable_irq()). See

f09c1d63e895 ("irqchip/msi-lib: Honor the MSI_FLAG_PCI_MSI_MASK_PARENT flag")

for a detailed explanation.

But as s390 does not seem to provide mask/unmask at a different level of
the interrupt transport, setting this flag and the mask/unmask callbacks
above is pointless.

If the flag is not set the PCI core will use pci_msi_[un]mask_irq() for the per
device chip at the top of the hierarchy, which avoids the indirection to
the parent chip.

Thanks,

        tglx
