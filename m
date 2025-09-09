Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3079E2459D7
	for <linux-s390@vger.kernel.org>; Tue,  9 Sep 2025 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405312; cv=none; b=LMFnHrr10nEXgJJ4EJiIJ4YbjJ0ffSD5CLeY9el6XC7McC+T4zWE+HNEw2MJ/UlUMKndRmzroL6C8qPKphQrBf/u4kwJF2sqAmiAbGzZTvhr6trXW9BI0S5kEoVl5F7jjJDPaYDzOP2LN2PvVKCocKaqCHlq5uLgVfrQP1L+TsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405312; c=relaxed/simple;
	bh=Hmu9KwXDkZaoAeYjfvjgDpFGYIXfNrE+7BfpMSVwxvw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JORNCsiGMh0OeJCPGTkWEpS+5NV0fe7nf5GeLHa0CjfApAMAx1AOnrhe3eCvFxrXsiHOO7cabd8YQgXqSteJTWz4ohsa4B7s/dZ5CeMAz3mXoGl1TsvKySt3NvfD3ht9AWY6PLXXBApTd0BmhXroqkXL3oCQ4kkcY4yPlcbhOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c9P1qOg8; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c9P1qOg8"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757405304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeCy6rDe75jPH1TgHGyr4cgF59Lim6HqxL9skz46sME=;
	b=c9P1qOg84FL7MhdmiPZ+ysoISwjx10XIdVx051pe0kt4Ug9g1kICNVyfYSANmX9dbT4OJW
	mJbwSWoogwWjKnO7zRjpU9jdb+2IVjb8PqdhrABq+DctZ4xsyl1R4MB6yt2c+/NkQSZvNh
	LtAS8dsFT1233SVKLMZTu5FiE0y14Co=
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] s390/nmi: Simplify return statement in
 nmi_registers_valid()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250909062501.8968Abb-hca@linux.ibm.com>
Date: Tue, 9 Sep 2025 10:08:10 +0200
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <87A2F1E0-17E4-4C28-823A-3D6C3379DF41@linux.dev>
References: <20250908153221.383589-3-thorsten.blum@linux.dev>
 <b1bf1f70-8b4f-4e96-908a-907da1748377-agordeev@linux.ibm.com>
 <20250909062501.8968Abb-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On 9. Sep 2025, at 08:25, Heiko Carstens wrote:
> On Mon, Sep 08, 2025 at 06:52:11PM +0200, Alexander Gordeev wrote:
>> 
>> This change does not make the whole function readability better.
> 
> It actually would decrease readability since every if-statement tells
> you one condition when registers are not valid. Negating the last one
> makes this harder to understand.

Ah my bad, that makes sense. I didn't take the whole function into
account.

Thanks,
Thorsten

