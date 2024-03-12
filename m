Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B8946447;
	Tue, 12 Mar 2024 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285412; cv=none; b=Mu89EE8/IwovUkuA4kPL5uW4yEZRtJ4zFDJtQbWVcslr/x1oQtZwiJKXK5Dob5hBeGtfkZSSuFOkLj4p+oaFx03ErZHha4eMvMzc4CYn2ydnchsCxazcCS0WXHoWK0yIhuT1Hux+oeR1apQDBS6Sz+I+Cens0+fXoRuP14LMyCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285412; c=relaxed/simple;
	bh=oaPJDLki3A3HqO5AiIrDHVFKQWx9bMTXxeJGXgBQDE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEZ8ngmjjxaT87xT/uzwIBGrBtdVf9GF8Wh/TX3C07ZVtak097ePnEwfu0sOyCcUZQanlPM+XCMNruquQ8URoQuHJoBnLGCHlZRVmE4r8Iljt9JTIWQIzCBCkrFkAzWjmYO9SnSISNibQYOmuC137ixVGD8io5FkBRxyfvfT2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWrnTYyG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWrnTYyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF90C433F1;
	Tue, 12 Mar 2024 23:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710285412;
	bh=oaPJDLki3A3HqO5AiIrDHVFKQWx9bMTXxeJGXgBQDE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RWrnTYyG6x4Kw84+kFFPVSxbR5imBb6tHgJVsTSmrLk3pD4Do1gZKlvg+Cw3jKnV0
	 QOKGp8/QeZWwOubiWWj3zcSauxI7n2XGDRwzbAvJSUm967+WoON/Kw3ubZsxYas/rR
	 uTEL0ocMIO0F/J3LbgC4SqgMUSgg6Uc3K8nxQLTpo0C9BqLbOLTxQrYYQS5/DzMEVr
	 ohmF6cFhoQlYvk1UDfG8CQhOCVfApH7/3m94SVf/BQWBlY3W1n/jqAT7AwfxxI0ZHJ
	 AocgUaxbs1Oi3tq+/9oytzxfdL71r6SZn/ZvPmQA6vmxtbFkUB6aSts3qgrw6UL+Pl
	 ybPuvDNRawbAw==
Date: Tue, 12 Mar 2024 16:16:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Kees Cook
 <keescook@chromium.org>
Subject: Re: [PATCH v2][next] net/smc: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20240312161650.2799f6be@kernel.org>
In-Reply-To: <ZfCXBykRw5XqBvf0@neat>
References: <ZfCXBykRw5XqBvf0@neat>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 11:55:19 -0600 Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.

## Form letter - net-next-closed

The merge window for v6.9 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after March 25th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

