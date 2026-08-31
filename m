Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A0536826B;
	Mon, 31 Aug 2026 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216723; cv=none; b=rOcs3S1lXpTD5nSzr0J+otVSFCU4a5cFfgDlwA1F8hoYYZm4//ZScOVfdm8TjoCfsdGKvYUcoCD+/gUWXTLDgdutd08Hji7LXFmGUbcqF2FOZgDBxGhrHtJSxvqp/oryzrFXghaaxtrfa7ZfRDuEScQcwEwfqIhIXjOVZm4GnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216723; c=relaxed/simple;
	bh=t62I/CTvhNTEd4XT9IgKHbBUdDipeWLzG1fByAwLIeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9tDGjlybG/UE35MYrC8g2ooVKOLX/C0tUP7oWOwl+/5Acwpuv1NFPRRy99lU9tfzDuymUtyUlYuIIu/6uNjdc1g9JioIQVP29nZRS8b0fAW326EznbuTahLlgGeNkiuP0/jLcACziYjc333IRNtOocLwwUvI+3gFctzGy2qrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+y+0fZF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+y+0fZF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BCD1F000E9;
	Mon, 31 Aug 2026 22:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788216721;
	bh=t62I/CTvhNTEd4XT9IgKHbBUdDipeWLzG1fByAwLIeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F+y+0fZF7fesCd+otCMn0EuWNpstcVZ8moegACtK+gaY0OaAtvM7SK48VbgXqAILU
	 G7asih5gox1WAPPU7kL9K5ti2BpqZk67MR02IXLsCJ4mOQJTpGhm7AYO57H6TjYm0w
	 mUXkdBkHDx7b4pQRQWH1olq48pEOApTOkpFUVS6ZuUbYs03g1hBrRa/kHYN8AFW2tK
	 OlzP+2YzFC+s6+L93XCFXoPjDWPxe3H8E+iJoUgfD45gIs95Ph2Akg+RAg9Y3LE+cs
	 lLktsQkgE8QcikQ4+hrtznoyRjpUnTdM5Kw4oTPCP9/UFxv5bZh3uZKDL66bW4AgKc
	 Ybf0a8c0P6KdA==
Date: Mon, 31 Aug 2026 15:52:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: hexlabsecurity@proton.me, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Thorsten Winkler <twinkler@linux.ibm.com>,
 Eric Dumazet <edumazet@google.com>, Aswin Karuvally <aswin@linux.ibm.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Hidayath Khan
 <hidayath@linux.ibm.com>
Subject: Re: [PATCH net v3] net/iucv: fix the recvmsg window update
Message-ID: <20260831155200.34caad3a@kernel.org>
In-Reply-To: <e6473c2f-1c17-4dca-90a5-9cac8baf6f90@linux.ibm.com>
References: <20260828-b4-disp-33fac0ed-v3-1-e6d061880ee0@proton.me>
	<e6473c2f-1c17-4dca-90a5-9cac8baf6f90@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 17:08:54 +0200 Alexandra Winter wrote:
> netdev maintainers, feel free to remove the second Fixes tag.

It's okay to have more than 1 FWIW
