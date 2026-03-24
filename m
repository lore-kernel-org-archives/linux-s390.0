Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D1386C14;
	Tue, 24 Mar 2026 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318955; cv=none; b=N4PMpi8ayckPYtqRHWIV3vDTKDocnxQuPUldE2atNa4NbI4N/q73AX2zToK8Q78ETt7oOD18ILWzIgkQpVW0N9xu6qrD2m12fOSL1ZinlprF/7DKZ/G2KtR/r7qwlhPRy9prG8mJ6LmlpoPifYoASVddcJltDUg2oWBPjTwgcJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318955; c=relaxed/simple;
	bh=dhcqtiZ1+Z6bHtcY+FeNQglwKzvJjFxeELs9lZgVjGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmct4wgYGgyXwWar+Lxji5E8AzHyDcMKBSJUkweZA0DBfeQ1K/fWjjltBfG7SPTWgz3SRDuBNGxntzhjT3bUvyN6CdXIDiKrabP56Fn734Af4PbBxZ1ARVBlHwGMkr804TI5PAWte9qJoo9F8CpmFTyzxUU39981YuCG8Wm+tV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APvBhOZx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APvBhOZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB29C4CEF7;
	Tue, 24 Mar 2026 02:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774318954;
	bh=dhcqtiZ1+Z6bHtcY+FeNQglwKzvJjFxeELs9lZgVjGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=APvBhOZxUUobsb7TolEGT+eOmL04buwmjJTsphGqTs5unlMLCcuwIOAXd5krZuHXm
	 ZO62XznK5PKfUVE45KEi5wz+fSvDzAxl3mVlqzDivqctOCmpwWoaiJF8TFNVkCJnxY
	 QFN5jaDM41njuipFNhcSIgGX5bSHvT4bNSLtir8ac0Ikfk/S/jc57seC3NGB24xjip
	 Uri0WFgavXckiig/FvWvrj6SqAOiD12F/Mvs/Pfl7XWQHjGshBRBCIpdzgWZo/Ox2L
	 KiY1INBId7N6erlT0pP3f6zyGQA37ntmmQf9wDbVvvuTwIKKJA0lQCI2VEaqsNSLjJ
	 ul2h3c0FRoW9g==
Date: Mon, 23 Mar 2026 19:22:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: tglx@kernel.org, tglx@linutronix.de, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 jstultz@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 daniel.lezcano@kernel.org, sboyd@kernel.org, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, jonathan.lemon@gmail.com,
 vadim.fedorenko@linux.dev, yangbo.lu@nxp.com, svens@linux.ibm.com,
 dwmw2@infradead.org, nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux-fpga@vger.kernel.org, imx@lists.linux.dev,
 linux-s390@vger.kernel.org, dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, mani@kernel.org, imran.shaik@oss.qualcomm.com,
 taniya.das@oss.qualcomm.com
Subject: Re: [PATCH 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
Message-ID: <20260323192232.3a5205dc@kernel.org>
In-Reply-To: <20260318073330.115808-3-guwen@linux.alibaba.com>
References: <20260318073330.115808-1-guwen@linux.alibaba.com>
	<20260318073330.115808-3-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 15:33:30 +0800 Wen Gu wrote:
> +PTP EMULATED CLOCK SUPPORT
> +M:	Wen Gu <guwen@linux.alibaba.com>
> +M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained

I thought David W was supposed to be the main maintainer?
Two moderately known developers from a single vendor/company
is not enough to delegate this IMO.
