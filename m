Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5983939DE;
	Fri,  6 Mar 2026 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802527; cv=none; b=qgRkbkeaeVMRLQ9lyV8VQoeScUGjv9NVDaOnZxTcolbDPaKIPgfQyYW1DAtEbN5K5bXoRw1wXAKRXo2AckWjdUEHNjWDj5OkzRTmSLUcsRI2PO5ZSYtPPxYOWr6p7QWW9Zh15Yj0+SycyfioTkIL6JNQzDPLLVtaJvt5x8Z1PoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802527; c=relaxed/simple;
	bh=y/zO8o9RwsztSYgTFMsHIfBqFy6ZWI/iPStI6M+0Pb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NprPKrFGkQGHnJjwZq3Lzy3cTMRXWcpTHRJRJ4zyeKDEB8zDXl0x6lSRFMSTpcrQtB+NsyWgTIuY53pY4JsNB+kOIgqP+UFmef9fFdeGw43uDa4EYuIP77sEs03x199eZ+ZBHayV2wmixPfchKoyT33zxCBmRk6T5hr3uS00jYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EebIOyn1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1XTZ5fbt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EebIOyn1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1XTZ5fbt"
Date: Fri, 6 Mar 2026 14:08:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772802522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1rHxfLLP4YKNg1WjBlVzgw1fLtfT2Y/arepS+6+PYM=;
	b=EebIOyn1GAkztXhhb/xOs7a50yTpFmXp1eD4k+lUvkDCKBPOfjcZoid4acV7G2wCcI6U/V
	FGYlHmTgtqYBOcT5LOUcDj48GKf1xI9dsZbtHFMVDfMD8QKWZnfBhAfIsC0er950JLst3G
	6JCXw0rW8FCEIqQ4EdRofZoi+7PToRjpFsfZWgq6KSWgxM5VzOzxkvFDckuV9HuDXNJY9w
	dJkHqusUNd2P6UJhs66+UdaGK3zu2qm9NzQTl7UvcHcis/8MEhXrw7hgxaVE4raAHdHgtw
	D5zt0ivPKP6gya6n3/1XNG1t57ugX6PbBXVeZtmUSg9pkp+kzgOb6KN8X6tx8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772802522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1rHxfLLP4YKNg1WjBlVzgw1fLtfT2Y/arepS+6+PYM=;
	b=1XTZ5fbtGTrjwv0i4R2ZCuY19THERe245goUh2z2oB9xbmf1QhzB2aBzdWp3Iq8hSDD9kc
	a+BxNXuHRPasJ4BQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
	David Laight <david.laight.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Sun Jian <sun.jian.kdev@gmail.com>, kernel test robot <lkp@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 0/5] vDSO: Use 32-bit CHECKFLAGS for compat vDSO
Message-ID: <20260306115350-ef265661-6d6b-4043-9bd0-8e6b437d0d67@linutronix.de>
References: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
 <96cdd223-5139-4535-b82d-831dac472cc3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96cdd223-5139-4535-b82d-831dac472cc3@kernel.org>

On Fri, Mar 06, 2026 at 11:43:24AM +0100, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 02/03/2026 ‡ 08:58, Thomas Weiﬂschuh a Ècrit†:
> > When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
> > are used. These are combined with the 32-bit CFLAGS. This confuses
> > sparse, producing false-positive warnings or potentially missing
> > real issues.
> > 
> > Manually override the CHECKFLAGS for the compat vDSO with the correct
> > 32-bit configuration.
> > 
> > Not all architectures are supported, as many do not use sparse for their
> > (compat) vDSO. These can be enabled later.
> > 
> > Also add some checks to bitsperlong.h to detect such issues earlier.
> > 
> > Based on tip/timers/vdso.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> > Changes in v2:
> > - Simplify __BITS_PER_LONG consistency checks
> > - Fix an inconsistency in the powerpc audit code
> 
> The powerpc audit code should be replaced by generic
> AUDIT_ARCH_COMPAT_GENERIC, as there is no difference between them
> apparently.

Agreed.

> A tentative was made in the past but was declined by audit maintainers
> because we were not able to test it allthought the failure was the same
> before and after the patch, see
> https://github.com/linuxppc/issues/issues/412

On v7.0-rc1 the test failure of filter_exclude/test is gone.
It also keeps working when applying your patch. Some other tests are
broken, but it looks that is due to missing dependencies on Debian.
So maybe it is time to resubmit your patch.

In any case, I don't really want to entangle my series with the switch
to AUDIT_ARCH_COMPAT_GENERIC. My proposed cleanup does not make the code
worse and if both patches are applied the conflict will be trivial to
resolve.


Thomas
