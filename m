Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21701FC7F5;
	Tue, 15 Oct 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014865; cv=none; b=OA+vjqAyzUiPapotyDDofFZQ+lfMZwvd+U5qOKpQbrCeO9v2zrNqIxoxDDPqH8/EzE2l9R6acyHurGdcFY3C4AhnNr/77fs5uBrR9aqiNmrT0y3fxvPzpFCp6BKwGgAvMIJr57vpAyX0mrcxr9Qtun9228A/MY/8vWoqMItOsOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014865; c=relaxed/simple;
	bh=TKkHOtHw4EpEoRW4tFb7+DwqeGdvapb0bR/7pBnYXy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOBbAQ3x5L+cFmVmnAOaERa7RlDxAxGg6i0jbNmxBRzHaQk3tHBEVkw95AoC9imSnuJIXntT9lHrksI92m0+hZXRQARaikArG5Pl1cV3QGPA9MjU2XnDHFjmrl4/V19wwepJ1+uv1q5ekCYlzw+0EDdK0czlkinhQP6a3LTza1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSMyFVxP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSMyFVxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFEBC4CEC7;
	Tue, 15 Oct 2024 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729014864;
	bh=TKkHOtHw4EpEoRW4tFb7+DwqeGdvapb0bR/7pBnYXy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eSMyFVxP9HKDJ9mweMNbv1Y5coJepV6ePImSCzQbjQiV+PKmuxVQlQBLo6n46DPNK
	 yxWGG2WaGeOi4m88jtHjSlXEgpLEIL0YrCYb0DkDASCV1X/6tB7xzbiEJJ00ncfm3D
	 yrj9JwxTNhWq0p9cs64LUk/sl92kUZNKT7Vwa7x0SYdRyc5xlphLAJ6qfynfcZQ1V4
	 fCMzgq/7FHnq0hZPxFEaHKsSmQ+sSMDa6bxkDK3DZsDHivPIBLZkk10c0EEh65hTJ+
	 6eDSw0CRaF6lU9aWy6oms5CKqky4NCl9aPJDOnUaXFhaWNRB9C8MCh33XkKO8OTLmp
	 p4icCJVxRdQoQ==
Date: Tue, 15 Oct 2024 10:54:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] resolve gtp possible deadlock warning
Message-ID: <20241015105423.0f23c697@kernel.org>
In-Reply-To: <20241014073038.27215-1-danielyangkang@gmail.com>
References: <20241014073038.27215-1-danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 00:30:36 -0700 Daniel Yang wrote:
> Fixes deadlock described in this bug:
> https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd.
> Specific crash report here:
> https://syzkaller.appspot.com/text?tag=CrashReport&x=14670e07980000.
> 
> This bug is a false positive lockdep warning since gtp and smc use
> completely different socket protocols.
> 
> Lockdep thinks that lock_sock() in smc will deadlock with gtp's
> lock_sock() acquisition.
> 
> Adding lockdep annotations on smc socket creation prevents these false
> positives.

This posting looks corrupted, please fix and repost, if it's 
not accidental.
