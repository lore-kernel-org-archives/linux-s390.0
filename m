Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629434D931
	for <linux-s390@vger.kernel.org>; Tue, 11 Nov 2025 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844425; cv=none; b=UI0VzNOwByH9TEW8Gm3clF3odGosaQQkcPPBvOPRD5KWw61n9uwJ4ikCIHGhDeNlcGoOxPYa9P35+pG1fn0o7hUs0usnQhMJW0DYA+VpO61YEKlW5N+9TxWTlAOayLXmfvhBf/9MCh/pFKSmWDQiz1QE3W4jlTxR1/m+J1LAt4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844425; c=relaxed/simple;
	bh=lkoyytZzlJir/rENDnqrYHU7rJ/u7rlWl9dM0tePmqU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=If1CvaiRDaJQ5zgB9dkfNDvyOEeu/udhHWy/o32x8VLFhEMBlXb5E9SqaJUGuJtH8vBvD6Flrocu2noxZKpH5lMCauIMTBwDnruDIvMHfvc/HX3Sh1BEEFFFXfQsVBUTW/DejE3FMhDFb6+6Y2KICglULBG5qRcuXxDic4HerfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bTGk8HB/; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bTGk8HB/"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762844411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKizkMmVoN2fp8ZV4SExztn9QwUvKPF0m1z1rnF/wtA=;
	b=bTGk8HB/wfytTP/uAxt75Q8GD5jT7jBfTt5KdC2xGpmqFyjstiPrFZRVKHDExo8qyxvZrN
	uJcPeTanJuXhKET6AwSKAXC+EOL1ohzcjGQrBzeiNQ3jMUSGcOVT7YCMi4KK8Bp4LerS5P
	uB74PhdUwRspPUv6jkL2hHN/CulQjsY=
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/5] s390/ipl: Mark store_status as __noreturn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251110150635.15528B2f-hca@linux.ibm.com>
Date: Tue, 11 Nov 2025 08:00:00 +0100
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7AD8A2F3-96E1-4C72-8E06-55BA50C9CFF1@linux.dev>
References: <20251110132803.1520-1-thorsten.blum@linux.dev>
 <20251110150635.15528B2f-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On 10. Nov 2025, at 16:06, Heiko Carstens wrote:
> On Mon, Nov 10, 2025 at 02:27:51PM +0100, Thorsten Blum wrote:
>> store_status() performs a tail call (BR_EX) to the function passed as
>> the first parameter and does not return. Annotate the declaration with
>> the __noreturn attribute to improve compiler optimizations.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> arch/s390/include/asm/ipl.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This doesn't make any sense. If a function is called, which calls
> another one with a tail call, then _of course_ it looks to the caller
> like the function returned.

Hm, I must have misunderstood this comment from
arch/s390/kernel/machine_kexec.c:

/*
 * ...
 *  The call to store_status() will not return.
 */
store_status(__do_machine_kdump, image);

