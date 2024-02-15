Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07F12BF03;
	Thu, 15 Feb 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013406; cv=none; b=Ym9f0hUpCZuFcqn5/27uXP7IZ6ZJClfveWn9SRmfmdzKhHwV4Xs7ZpIPN75TYuUipe+Ixw13PEzIL/Xz4FrGJOn6JdVKtRpfral/s7F/NhwnANZh+YaXg5XHoZuylG21tGKlOrXEntBMVfZZ2qF4c+YNke5hsRLRe56K+TZiGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013406; c=relaxed/simple;
	bh=vwNpAdtl1OHboj2vNKl1sp+tpZi3p3HJj35PZmu4XP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObEW62SczKQnjPHVCFQrVtqOa45RoxxzHnW1qdi7erGSlOhhOJGHrnP9nEzOvIfi+CH7oVWtN6JZe+vrli6ZWllvzSuGew7cDuJpituk1oYt3+lMa3kVxX986dmW96N9+eFip+RWfUcpVhB39zl6aBWzLwlWrvXta1Uc7p0fbLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEkhF7uu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEkhF7uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB8FC433C7;
	Thu, 15 Feb 2024 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708013406;
	bh=vwNpAdtl1OHboj2vNKl1sp+tpZi3p3HJj35PZmu4XP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OEkhF7uuMmKrFvCh5zAUujh2KnH0fW1quNzlj2hm5F89NHA4p0f21HIPaczzsPcVA
	 25GfJZXsPU6bi2Z3jT3ZINhcaxiCNkXPWmwSsjzir8p4brT4xTe+a1KXoh/DMKqPto
	 WNemj8fbeh90cIAcnVLtDqcUvoKPPmYAE73GbXDi4TML2tJFy7PGCjM8uMy87dj/x/
	 NijWj8GY8QdETMfBuKb0riUPizKM2JWt7fPWFGD8suDMdMZJPAdwq9pichkAf3cZyi
	 ipyehWNytPwKWF61GX+J/5v/yLp+0Ff72DG9fQZRQg7LGvyx5YXNKD0X3QyXKIgmmC
	 KMOeViLanC6iw==
Date: Thu, 15 Feb 2024 08:10:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, Wen Gu
 <guwen@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-s390@vger.kernel.org,
 Gerd Bayer <gbayer@linux.ibm.com>
Subject: Re: [PATCH v2 net-next] net: Deprecate SO_DEBUG and reclaim
 SOCK_DBG bit.
Message-ID: <20240215081004.7055a9e0@kernel.org>
In-Reply-To: <bb560ae4edc37d4d66cdddacb849f4d04baa7dd7.camel@redhat.com>
References: <20240214195407.3175-1-kuniyu@amazon.com>
	<20240215070702.717e8e9b@kernel.org>
	<bb560ae4edc37d4d66cdddacb849f4d04baa7dd7.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 17:05:58 +0100 Paolo Abeni wrote:
> > Unrelated to this patch but speaking of deprecating things - do you
> > want to go ahead with deleting DCCP? I don't recall our exact plan,
> > I thought it was supposed to happen early in the year :)  
> 
> My personal "current year" counter tend to be outdated till at least
> May, but I *think* it's supposed to happen the next year:
> 
> https://elixir.bootlin.com/linux/v6.8-rc4/source/net/dccp/proto.c#L193

Apparently mine runs ahead :D
Thank you!
