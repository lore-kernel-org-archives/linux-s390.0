Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7747B405;
	Tue,  9 Jun 2026 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017587; cv=none; b=ZBKfxTNhDQKGJf1ZtYCdbF4n35fp5M8wk9wY3dxSWFe0ElCOcBX7KFTgXWx/wYabjI4bGX3hfuaNMKbOC6tKXGwIbW6GA/kyX802L7A+TlLcsMw+omJxm6C5B32JLdPsyNMhw/XH4WaWbUqHedMjAkZ2FQk5h7At2pMgsPp6SpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017587; c=relaxed/simple;
	bh=jQ8mZ+jLNIPyWo7g9aJQMBRuanK8xLNh75/phBYe+5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MdereQkgN94JBIbA0tjPImfZSEatAQNaeD0tOrz4yX/XgMT7LiWPxcmqdeBnkEIp0iOdNuTYLIjMl/doGc6tBLWSBqjACZvPBhr6YTHMjEE0umZkArQRIueTpQF51SFiOpa/WRS3bau9Qt0SMXHEYNENCKfflGlF6oGdqmfxvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRHoQeWl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRHoQeWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDA11F00898;
	Tue,  9 Jun 2026 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017586;
	bh=jQ8mZ+jLNIPyWo7g9aJQMBRuanK8xLNh75/phBYe+5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HRHoQeWl2GXtwBkAKPqGsiixcJ2zi4wNGzVhMLR+bJYPndZx9IB1lFt4ouwctlkMM
	 +xfRieoxrFZfEp3fhSvpUFv2XVJ1nlkUobeB66gz881veGeq8i0+lLpdbIFEotSJy7
	 8tnUpitWq15NA4F55VbJjRiFgUhkNJxx6AdBD862gbktwXTYW/e+/WP58HIKDjeW6S
	 qOJiFGucUHZacujDL6+3wdrwsjc0DfY2VMLb7L9b4Xsrrl7B1XEgQ2GJRZYhmXJ3Cr
	 ICbSiGOG4bFMnb7pIwc9PCLZnkHyirllf+XH18Ordo4rb3sZfc9aYjgInsBUViL7un
	 tvXP1H6UEh/cA==
From: Thomas Gleixner <tglx@kernel.org>
To: Mete Durlu <meted@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@kernel.org>
Cc: Mete Durlu <meted@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, linux-s390
 <linux-s390@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] tick: Remove arch_needs_cpu
In-Reply-To: <20260609075213.31094-3-meted@linux.ibm.com>
References: <20260609075213.31094-1-meted@linux.ibm.com>
 <20260609075213.31094-3-meted@linux.ibm.com>
Date: Tue, 09 Jun 2026 17:06:20 +0200
Message-ID: <8733yv4utv.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 09 2026 at 09:52, Mete Durlu wrote:
> Remove unused arch_needs_cpu() hook. No architectures use it after
> s390 removed its use case.
>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Reviewed-by: Thomas Gleixner <tglx@kernel.org>
