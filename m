Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C93D1AB9;
	Wed,  3 Jun 2026 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502146; cv=none; b=Btm79K403oFxeGE567Z+QbE3khkHacn35IcxPTW0tHSUTHEND0plWxyFvSQ/7JXucnLua4guOESr/5Y3RNwQE7ONPHjNsuYqiMOgc3GaTXwUB7Tsr3WOvsTEHYp57T4uyRY0/kVMiUABn9dPPQ1XSbQ9MLUhigcfMjLarLsXAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502146; c=relaxed/simple;
	bh=CpOEBci1S0yDrojRiu0x6Jvr78Xec38h1qPmQyLe6yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuHX/IqbZYrTuHrCHHYBcqhJ3XbnTIE2JSvmn6EnPtG6bMi0tvId3xd6uXGxfxCs6mZzCkadbfv6WJDSaQX9XAp4VupVdCdoF4g/F7YBav6QSKU9YbGFkTU40t07Moh+hg2t1s0uF+jtIP9SV2oSg+2fnj93A41+8Yy1J5jL/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=CoBNdgNg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lKw5N7Ze; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="CoBNdgNg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lKw5N7Ze"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E8871D00123;
	Wed,  3 Jun 2026 11:55:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 03 Jun 2026 11:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780502141;
	 x=1780588541; bh=7i/oZn53Y2C8KfYj1KoYmGPqJk2N5MSRWpMtA2+SDQQ=; b=
	CoBNdgNgAh1QvX3EyL/ICs+I5hkD+ZJeyfXV4GKKJgMFkB7aIu7yRyYMRmEYNkrX
	d4dNpHGGQtvf6nImu7mU5GC+pzG8FynYpS5E4kytmEQrPIyx4ykAutCmfQsZJePj
	a7QeboC5wU7JbTU8F7S41XE96Xz4hpnHytYFOdHob1UltlRrKrV2XsaD+W22Pt6t
	3oAP9EdAezZM9iQGGWIcsVgBM07nmXp3uO8B7icsLk1g16cq5J3IAbiEHhJWmFZw
	D/yOtzN6n5hcFqri7c3UPM+YT/DvCWnp6WBYYXLM86P//OMK57JVv514XFw0MYH4
	s10mFiZD+M58mcnN8uEKLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780502141; x=
	1780588541; bh=7i/oZn53Y2C8KfYj1KoYmGPqJk2N5MSRWpMtA2+SDQQ=; b=l
	Kw5N7ZelfiZZOI/D2AfXCaYslNlWa/aJWfPndlvanoX1zO8usi6n7lq3cR2b8Zn6
	wnUOKe1Tv75KevfzromuOIcoP+DQasSrWRJFbqU0K76Gd5RrSRP32s3TrQR2EFqo
	tILMG/OX7pqflE1P0m3YPnTSBabnlwngdR6hE+yYq9TDs8EJQFHhER818iddTFaZ
	91DOeKsil9v0L6H6GrlK9yo/+TvQuLKjKnbG/y6NzlTeMff3/OVTk966OOPTa0tF
	DAAYCrYNLSQ0hL0FluHekHc+49ZZXB05+rjJ5GcIs5ZyrFTaCPvE8UYYT5wmmww/
	J/yMFC9WchJgNRLsohOSw==
X-ME-Sender: <xms:fE4gaj8q0_iMz3fnYKNpxpbKtKWchFCyPb4GZB8g2hlI0X6MmDZc1Q>
    <xme:fE4gahEuDKALcJ_5bJvg-5NBHYuqT7hI7LILyXlVPi00WpuViJtRus5-GivFELQpm
    k4qiptW_Uppqr4u-kA5euPNSNch6qeWm5y2_Vz2sr8eKhUenNg2z2Q>
X-ME-Received: <xmr:fE4gaqSi9ee5VTfrDisIwuWni_1Btq4s7THeqOEjI0Edap-b7z8mmd7d_gU>
X-ME-Proxy-Cause: dmFkZTEn0rqgkoZnG7xgVdki9RX1mvKYhiMqjaAIJARt4dSwQn7SWdu68GYZQP2Ze72dgq
    YdaFE2sjcWMsTbTibBWJljW/WqPFVQgNlDoscQ86enXckwmSz0jK29ukFFg201Ol8881mq
    kOYAGvcsTUGWP50spnruXiWaeGduSsbGIffZZVa5e1tqY45+v+Qw7SJ4an8DBmNRMQ1JV5
    m4XMogjV8RM6sa2Y5ByzD0EJTSmhiR26rf7IyNJXMZqd01ZsrEz5wx87bkXI7oXM/0IG+m
    LGm6pDJ89Cf3VJy/F6F5xMRx+e/zW88ALUx5xxd8CTU3nCNtT48dOyzNyOdcTpHmyPy3VX
    av21U09MuxCNRHriEHWM5I7eHm5Xgv41awjvgQob8lPYcGGOkLNdQ2KMyobYr3YsAx6Kk4
    xzA+rYKPpoqi34oVGKLG/jezxax9xF51hqabCM9bzmD4Z8wMk8xkkkUy4VmbmHn4+lA3nE
    KirxC3ssG2ngvKZc4rs+1QRgUVI0dh4BxvDaHeGTN0AE7ILbDUfBFmdtLSoAY5sP5WbpIB
    RSVsLNe1BWpRqaoyPbWcqDF2k9Wu1yJJuBlc7f3/mP7buFq3SzRsmH3QYE4nsPcBVP1RLu
    jAVYL6d39Y/i7z0yR+ZAdpZocwqQw1RxHProjhTJp4GKWfS1hWqmksLhSsLQ
X-ME-Proxy: <xmx:fE4gantO3J5v6_Vunvdwi-qRWDIHm7-rgTyWgbgMiL_TyXa2YwCPeQ>
    <xmx:fU4gavD1Watyn1_h0mXnMEUYnjGFAentRBPJT9DQnViOori22pzQzQ>
    <xmx:fU4gase0ZrZ9Skj4HV8a_tFnXprd9xwssThz4flT6-sZqt28DUHIeg>
    <xmx:fU4gavoUidthQKWrC2FUVHYQYbxRnebpOc_0wieQiaF5wEcnLKq7aw>
    <xmx:fU4gat-MmJAQTubEKQ5W7Zk5eTThYxE122kNGw2gbGhFv0LL4FOu8Myy>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 11:55:39 -0400 (EDT)
Date: Wed, 3 Jun 2026 09:55:38 -0600
From: Alex Williamson <alex@shazbot.org>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v2 2/3] vfio-pci/zdev: Add VFIO FMB device feature
Message-ID: <20260603095538.65b07206@shazbot.org>
In-Reply-To: <395b0d85-3057-4bd5-b8cc-10ceea2d978a@linux.ibm.com>
References: <20260519224204.19154-1-oelghoul@linux.ibm.com>
	<20260519224204.19154-3-oelghoul@linux.ibm.com>
	<20260602162409.1ca3c765@shazbot.org>
	<395b0d85-3057-4bd5-b8cc-10ceea2d978a@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 08:35:43 -0400
Omar Elghoul <oelghoul@linux.ibm.com> wrote:

> On 6/2/26 6:24 PM, Alex Williamson wrote:
> >
> > Why does the user need to be able to control these?  
> We want the user (e.g. QEMU) to be able to control these so that when a
> guest enables or disables the FMB, this state gets cascaded to the host and
> all the way to the firmware.
> >
> > Doesn't allowing the user to disable FMB remove guaranteed host-based
> > monitoring?  
> Yes it does, but this one isn't an oversight and is intentional behavior
> to achieve the functionality mentioned above. The host-based monitoring is
> not necessarily guaranteed and is treated as a device-specific state, so it
> makes sense in the case of passthrough to have that state reflect the state
> of the guest that is actually using the device.

If we really need a SET for enable/disable, I think it should be a
separate feature.  It really makes no sense to pass a giant structure
into a SET operation to look at the state of one flag bit.

> > Since this is already provided via debugfs, why not make this a
> > userspace problem to interact with the existing interface?  
> It might be possible but it would undoubtedly be really ugly and harder to
> maintain. I think what we'd dislike most about using debugfs is parsing
> text data into the FMB structure. If any of the text representations of the
> fields were to change, we would need to update them anywhere that uses them
> (e.g., in QEMU or any other user driver). The ABI would be super fragile.
> >
> > Alternatively, couldn't the existing zpci mediation be extended to
> > support the guest registering a fmb buffer to be written at regular
> > intervals (the interface here seems to drop the reporting interval).  
> The firmware only writes the FMB into one buffer every firmware-specified
> interval. If we wanted to write the FMB directly into guest memory, we
> would either 1) lose host access to the FMB or 2) have to run a periodic
> worker in the kernel to copy the host FMB into the guest-provided buffer
> every time the firmware does an update. I don't believe either of these
> approaches are favorable.
> 
> WRT reporting interval, I intentionally dropped that one as it is already
> provided by VFIO_DEVICE_INFO_CAP_ZPCI_GROUP.

Hmm, I also see fmb_length in VFIO_DEVICE_INFO_CAP_ZPCI_BASE.  If we
have that, do we really need structured data in the GET feature?  Maybe
GET just provides a user pointer and the raw fmb data is copied to it.
Thanks,

Alex
