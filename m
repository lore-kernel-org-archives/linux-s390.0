Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2235280;
	Wed, 25 Jun 2025 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750890081; cv=none; b=SgB3anQZKwZpJkCyolxND3DFL0Y2fDNS0AL+bGCsqultEDcD3HTdcyrzWDbBegubb0A+Fd7sKXhQIWPNk2Ms4P2lhCozZ7AQfEQxdsjzRzLlgxeKJyf6ZHbfogxh1vsWcQqMTIW/k2H9eVjoOSXNxVa2z+funJuH95M8NnoZrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750890081; c=relaxed/simple;
	bh=EHRE4bDw1wZBTVYejDSJcF1Y90GWOws1EjWU3XAP80U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2XWSYNUuwJcF8QNfxbTcMzLMYwUF8By2umxOl9JjZEnu3uoPLlDEFzci34WrOSqL0MYU/o5iSU69jbyg33lJ4vKSVlHO1BT2A8t7rxIUi19zR8gP4lx3ipcMnZHtcpozuD4Wx73B+L0kF99nwdmhF37INlX9v0/4cZuYJWJKzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0hM9S3h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0hM9S3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED356C4CEEE;
	Wed, 25 Jun 2025 22:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750890079;
	bh=EHRE4bDw1wZBTVYejDSJcF1Y90GWOws1EjWU3XAP80U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f0hM9S3hrsVTmiK+akBdQQFhYtZDHwb5i/0YTHoI0cXQS37utomFAAMxUCoaeHWWx
	 oEKebR5FS3W+TXMeOsijd5ang5mqi4z3rnsxc8P3TSiPkVtJBUxN8npcLxRS5Pf8Ly
	 vSx/W5QDqeqFpaB7VdJyq3ZPlhCvGcxmyNcIhchrbJOWJKc7+B4HvJySFBH3/AhyyL
	 28vg8UdMmUZ57r93kjHdckccQ/7ogdbHFFsNJMwJKUmZ6SvjihDwqGsAKRGwlDWl8L
	 lSpKCjaANxvkiuGEZzLQyAOPzLvGq4UOsH4ZeCHaGngWb51oeOKxXe2KaazP5nO+mN
	 A9KPjdrg3hxKA==
Date: Wed, 25 Jun 2025 15:21:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Alexandra
 Winter <wintera@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, "D. Wythe"
 <alibuda@linux.alibaba.com>
Subject: Re: [PATCH net] MAINTAINERS: update smc section
Message-ID: <20250625152118.77fdd8fc@kernel.org>
In-Reply-To: <20250625235023.2c4a3e8d.pasic@linux.ibm.com>
References: <20250623085053.10312-1-jaka@linux.ibm.com>
	<20250624164406.50dd21e6@kernel.org>
	<20250625235023.2c4a3e8d.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 23:50:23 +0200 Halil Pasic wrote:
> Jakub, would a respin with
> s/+M:	Mahanta/+R:	Mahanta/
> and the necessary reordering work for you?
> 
> I'm with you, we should observe those rules, not only because they are a
> community standard, but also because they make a ton of sense IMHO. So
> my proposal is to make Mahanta a reviewer and revisit the topic of making
> him a maintainer after none of those bullets apply to him.

Starting with a R: sounds like a good compromise, thanks!
