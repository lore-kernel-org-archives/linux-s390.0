Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC8528980F;
	Sun, 12 Apr 2026 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776008826; cv=none; b=kv6PX7XO2sM8vHO/dgg/oEaRih06euMScQLthUyVKQNrnpgo3mYd5erI008cypF94yc+xC2oWphAFYhC6neR87RwJUBAmmgHM6A5kzK7qE5KmBoTr8C5wosWkQ6nlHHGT2RHi5Dq2KPhxSmTRjjO9LKJ751MqyBceLgiA5wGMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776008826; c=relaxed/simple;
	bh=cnmGgbyzL9dF3eVwO0CewcGdhsTjOcznZUNtjlbj0NU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zwc2LQZ/xroi2q2Bx10F7pg+X2J+oHp+Gr8RpsyJheCX46Qkv1bLwdyoHsLK7nIj89/WrPAcX8kOuYB4iiuu4MAG45e9yoky53Mr3N7eAHIuaEPjdkFE0koZbbpm2HEO17mJiNtOYOr41RFIWQGQbaeIipXAsb+mXfHwO1l1ah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmcxhTYt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmcxhTYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CC4C19424;
	Sun, 12 Apr 2026 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776008826;
	bh=cnmGgbyzL9dF3eVwO0CewcGdhsTjOcznZUNtjlbj0NU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BmcxhTYtNtwCFvUAcuEMetGDwmgiWnUQ0X52EqlZ6u6Q80ZyBTgMqgxrDDZ7L+GZ+
	 k4h1RYM5gewN0aHH9/oUK1M52zC1joYvrXPYGWQI05PMIs4llQbtSTVQh0cDm06oCF
	 9Fm8i1Zi6vKsJW6eouzHZsT5iANfd+67NrTmnSTYvl+WD5RyKgTO2orsYZfZtgdswC
	 V/gd1hKUiIepgEvGNXKREOJzDuwZzNJVnQa8x96O+d0wcWZm+n9XJmFppuwmfZ+H+7
	 7AbicT3sko+HPW1mRO0y2o//uwPHRBQ9G+BrxeNjRuQLA4W31nwpZmSj4GWw0Cba8u
	 T1U5Lm1i34ZSg==
Date: Sun, 12 Apr 2026 08:47:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: dwmw2@infradead.org
Cc: Wen Gu <guwen@linux.alibaba.com>, tglx@kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, jstultz@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, daniel.lezcano@kernel.org, sboyd@kernel.org,
 vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, yangbo.lu@nxp.com,
 svens@linux.ibm.com, nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux-fpga@vger.kernel.org, imx@lists.linux.dev,
 linux-s390@vger.kernel.org, dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, mani@kernel.org, imran.shaik@oss.qualcomm.com,
 taniya.das@oss.qualcomm.com
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
Message-ID: <20260412084704.743482ad@kernel.org>
In-Reply-To: <20260407104802.34429-3-guwen@linux.alibaba.com>
References: <20260407104802.34429-1-guwen@linux.alibaba.com>
	<20260407104802.34429-3-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Apr 2026 18:48:02 +0800 Wen Gu wrote:
> +PTP EMULATED CLOCK SUPPORT
> +M:	David Woodhouse <dwmw2@infradead.org>
> +M:	Wen Gu <guwen@linux.alibaba.com>
> +M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core

Hi David,

Do you have a tree to route the patches thru? Or do you really have
access to the tip tree?
