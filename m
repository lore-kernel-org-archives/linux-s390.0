Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2713248C;
	Thu, 15 Feb 2024 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009625; cv=none; b=jkfrNzWGXEcMWN3f98s/jWkm1rqo9IdlGllc2B6W3JMg1fk1d0YB8SOXten+2rMafccCuBvGOFUb0L9f22/yy791QF0zkuo0+kbRa74mjb8JOoTbRS739fGlCBzuVksFIgC5fxj5gFeAtguQMzLmULiLeUTChKP+kfahGNywkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009625; c=relaxed/simple;
	bh=APbTYbrFKsK1aFlZYDmNbwlcHKD8AvqIn33+kl5q9Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvKNfeaQkVBTVuW/lThxXHCN2gFU5NWLGCy4nD04j5sb+ZSJwkuO/8SodkvirBUt4f0/FJtkzQZOHrPOSrrM12mxw1vaz5N7uXMswYaM6rNpoW9NCCmwxZrQINtN6uvAjpSVMHs1H5CZy9kPC0Pg6kwWD1+zYff62IQQTDee/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6CMUpjy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6CMUpjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD018C433F1;
	Thu, 15 Feb 2024 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708009624;
	bh=APbTYbrFKsK1aFlZYDmNbwlcHKD8AvqIn33+kl5q9Zs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p6CMUpjybOvijzJAz14N+SxauIPXop8vdct1x+z6embZyTHJTPNs3V+5oSqFVq7nA
	 ncvew9PwtqYtSYdNydVEaw4ATxcEvBePDg0QTJEKFWCgevl+Gx2VGtWUx4VtK0MB8Y
	 RolV6FhYvXiimJCMaq2MIOVzTlk1T3AHdBELhhmUXZ80uJPsa5srF83+cGFe9ISB0Q
	 J3ZijV/+eaW/PWSFcDqgcC2ROddPv6yHUvycyTtku9kYuFNFfXtHjMpg0TQMCMGVsa
	 popozFcVHZSx4MiSe/YNqgwdjxvBGmJudrTSqz4cc2cFv+HD2MYjvzPyg16x1Qq6uu
	 U06aBDnSPO7Og==
Date: Thu, 15 Feb 2024 07:07:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, Wen Gu
 <guwen@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
 <linux-s390@vger.kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>
Subject: Re: [PATCH v2 net-next] net: Deprecate SO_DEBUG and reclaim
 SOCK_DBG bit.
Message-ID: <20240215070702.717e8e9b@kernel.org>
In-Reply-To: <20240214195407.3175-1-kuniyu@amazon.com>
References: <20240214195407.3175-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 11:54:07 -0800 Kuniyuki Iwashima wrote:
> Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net:
> remove SOCK_DEBUG macro") removed the macro.

Unrelated to this patch but speaking of deprecating things - do you
want to go ahead with deleting DCCP? I don't recall our exact plan,
I thought it was supposed to happen early in the year :)
