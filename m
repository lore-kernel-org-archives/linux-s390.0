Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08693603F6
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053347; cv=none; b=cpeTnHHHcC12wH7v/KwL9wVm9Xskgs9l07JmLZdgFVj443X2YS+NQviKRsgIikT4vBCqPYJPJIyjjTaO9SYJo6cNxYQG1MwcnEpbvTHE2e3eaibS+1dbItJW35jMl64qRbH8MKTqfgsaUsvag/mydYRt+0DiJCVWbfwUvG1z/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053347; c=relaxed/simple;
	bh=lfAAc13gln/GQ/bfejJQm8H8aZxm2KiLXuvr9T7Fe+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOG10EctJzw/nY9UX6QNGBBFeJ3wAR+TfE0uF9KeEwJS/X0rLp3efGdztGNt2WPmDAwuD42iqbJCPuXKFkOpu3TzPs2mzWKc/Ox6VGTnCbomKfzL2WzEYKZXN2qT1jyPsfXJ3DOQcruu4JC1FBLJkHpPCnm4avv0JQGdS1/trkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIWbcE5A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIWbcE5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F141F00898;
	Fri, 29 May 2026 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053346;
	bh=nYeYU/0vAdGNQ/yEJVfBOGYuIMQhHlEwriVqrOHO1Rc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jIWbcE5AkqvQwiwwzoUT3FGzTWPq2d/15Xb2BnFSTq/iXScL2lUG09mBBZs9KgASH
	 Pvi+wzW/QtaCzEVIF2MXj/IENiuzptBcA8ZVoQsIp4W7y/+f4s9upRwgpjwwCc0v2t
	 XDCnw6nKXzEzxNHWrISTNsaNftkOtpSz0x6nstI+3dIFNcppWMY90Jw53WFj009nGo
	 9lGAwHRDQwO4CTEhmiOPAaeg1423kw0hu5N+TntTYAD3LGWHkGHk7DcnfgW7povjkR
	 TSw4AkUDnzv7+ZBGHCked2i7TtGeg/O8cI8QureVsP0e9NHcfZLiiCAxMWzbDdLIGe
	 R6yOnvad8YFiw==
Message-ID: <e99df8fe-bf72-4f62-8473-b30d5445da85@kernel.org>
Date: Fri, 29 May 2026 13:15:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] s390/qeth: replace get_zeroed_page() with kzalloc()
Content-Language: en-US
To: Heiko Carstens <hca@linux.ibm.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>,
 Aswin Karuvally <aswin@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Holger Dengler <dengler@linux.ibm.com>, Jan Hoeppner
 <hoeppner@linux.ibm.com>, Stefan Haberland <sth@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <20260528-b4-s390-drivers-v1-4-b7108f54d722@kernel.org>
 <20260529110911.26496Hac-hca@linux.ibm.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260529110911.26496Hac-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/26 13:09, Heiko Carstens wrote:
> On Thu, May 28, 2026 at 10:09:52AM +0300, Mike Rapoport (Microsoft) wrote:
>>  }
> 
> Hm, another thing is that Sashiko claims that kmalloc allocations are not
> necessarily correctly aligned when slab debugging or KASAN is enabled [1].
> 
> I believe that Sashiko is wrong, since Vlastimil addressed that with commit
> 59bb47985c1d ("mm, sl[aou]b: guarantee natural alignment for kmalloc(power-of-two)")

Right.

> Can you confirm that Sashiko is wrong?

Yeah it's wrong.
Roman, can you adjust the prompts perhaps? Or we might have this wrong
feedback on many patches that Mike is doing (or planning to do).

> [1] https://sashiko.dev/#/patchset/20260528-b4-s390-drivers-v1-0-b7108f54d722%40kernel.org?part=4

