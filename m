Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3635836B
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080025; cv=none; b=O1kLTcv5tgzzj+a5voE7kckeLrgmYC15B9USKHI9uDZSNKF1YoR4FKW+MinqbK3fbmFRJhQbaOEHBI6dtCvIoUD+Vmj3eXor8p/+dgeoylSfIKa9M+YUreXdsP0XsQRdn++6WSjzRPj0iKwmZKMFxgA3GAHWSUqdpoeYSr3kGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080025; c=relaxed/simple;
	bh=cxA8tM5dh3I3FMrLRqVtspMINUesL3110lPAu88ay6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQh+wfAIwXM+n+1P8tY9p1xxYzscVTB+AJisbASE+TzKgN+ambnltWtBZuT+tfheYBmZW7NhbslOSxrr4VqAUREkY7xRLXyI/s0B9RMfsho7or+nhQ8292QugDd0ATMAgN5oMixq+zY1Zcjl0YACPGiQyxOzdxl/QqAPtWdnfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LubTbo/+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CFytY+y6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LubTbo/+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CFytY+y6"
Date: Fri, 3 Jul 2026 14:00:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783080022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxA8tM5dh3I3FMrLRqVtspMINUesL3110lPAu88ay6s=;
	b=LubTbo/+sGsgRDt0BMLAXB0AHUs1HO38dHCXG7I6SlcOUQ74HIIw2sjeTpooeCIZTT5M1Y
	VI3/m4iHRNBz+CJaJ5RtG0JxLXr/c+v6UcnLwkaKwg+Ye9MZ3qXs1zhw7UGxQPsX4pZ4tB
	ZhuHVGY6CSdg68fGjMoH5K8TUpOSmAVNPI/Sfk12+GCOcbBAzKkZHmS4aEOTLpSn70BtWI
	SqmpLGBiM8IztU28dpZ0CUFsZpxEwbEFl/8vnehFscRd9W04hCvVfk43k7/G/J9wkdNAr3
	Tvl08SgLcZO6bvtUi5NtMhh8qARgf97pr2yR1OMeULUzj72L0O0wyeE1dZvnZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783080022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxA8tM5dh3I3FMrLRqVtspMINUesL3110lPAu88ay6s=;
	b=CFytY+y66swUzhiLQdGFSgIfrBYxIHoqRHunU5UUuCcflzfV4iq+7ioJOAqMRAPKKRvzpp
	sbml7KLd6U+PccAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390/zcrypt: Delete CEX2 and CEX3 device drivers
Message-ID: <20260703120020.nXkZQZt-@linutronix.de>
References: <20260703100320.qvFoxNbp@linutronix.de>
 <28892518-5e79-4410-8cd1-1873da752818@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28892518-5e79-4410-8cd1-1873da752818@linux.ibm.com>

On 2026-07-03 13:39:15 [+0200], Holger Dengler wrote:
> Hi Sebastian,
Holger!

> Thanks for your patch, but we already got another series from Rongguang Wei
> [1], which has been already applied by Vasily.

Yesterday? After all these years I am off by a few days. Duh.

Sebastian
