Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D163009CB
	for <linux-s390@vger.kernel.org>; Fri, 12 Sep 2025 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681430; cv=none; b=SAzudSU8nMbK3SF6V5ioHzN05IvRZmavdLRejkx/9MpkQM5VmyuOOmiNIySl0BIGAtoLD+79mrpXezmrt0qpCX2odCQ/W0MidloFfJrnRjWIWvzialR/MoUo8As06oKuasvBhOazCWH5E9yA+atsDwc6G5TXUgIdC8l0ZUaSYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681430; c=relaxed/simple;
	bh=1oQXwWv+lJSNtgMzc7cQmQhi/nz00C7zSGZfOqlTCPs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pK5Gqck4ECgKEGkKP7tbjMWpnJYyYQsBzxaFzaAGHiThLMfnA0U2yPejZXYBF3NuCMWTKmLqASTYV+mJ56OdynbQdRiw7OywnKnLIIXSkqHSI0Q192Vd0FfodJ7EpxRpVJLPcHQmFPJYAlrXBNpwnUcjV3c8ff9KhXXwUOkZATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eRBTg1kU; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eRBTg1kU"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757681425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYq3AqU24weJAslNrHOd3hJqC0HeulXIDNwwV6Fs/KY=;
	b=eRBTg1kUDpov12hPolDE9KMaj4VnodINYcyfhQqLmN64t3PaZITFcmFVemf/Iz5lK/EFEY
	MXHpHgYtpFegIrJX9e+1KlXgIN33e0az4PgVT90O/2eVE3S3POQCc7oOYDcREVySMXo9h/
	ZYbgVGMbS/zPG6oLF/BSFz1pfSEtp78=
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] s390/hypfs_sprp: Replace kzalloc() + copy_from_user()
 with memdup_user()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250912110619.10147C7e-hca@linux.ibm.com>
Date: Fri, 12 Sep 2025 14:50:12 +0200
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <BABCE4F4-7C7A-4D25-AFB6-1CF9476151A9@linux.dev>
References: <20250911214539.1483234-2-thorsten.blum@linux.dev>
 <20250912095620.10147A01-hca@linux.ibm.com>
 <D56B6A09-8633-402D-A942-1C24AE465AC8@linux.dev>
 <20250912110619.10147C7e-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On 12. Sep 2025, at 13:06, Heiko Carstens wrote:
> On Fri, Sep 12, 2025 at 12:09:43PM +0200, Thorsten Blum wrote:
>> On 12. Sep 2025, at 11:56, Heiko Carstens wrote:
>>> This is not an improvement and also incorrect, since kfree() may now
>>> be called with an error pointer.
>> 
>> Unless I'm missing something, kfree() works just fine with error
>> pointers. See linux/slab.h:
>> 
>> DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
> 
> This is for automatically freed memory, but not for the generic case.
> See cd7eb8f83fcf ("mm/slab: make __free(kfree) accept error pointers").

Interesting, I didn't know this doesn't work for the generic kfree().

Thanks,
Thorsten

