Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D817991;
	Thu, 31 Oct 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730335228; cv=none; b=YSjvURNAVN0ppDAuqP9FDXK5xV83NIomm/mI46vctyAr8M2nYa8JzML9j4KDIJUtW8USyve8HWTyEipr8PC/erCS7DGbi+8AeMKxHGihq8p/U/qlDdUhG2ttc0I8/J0dgpoQ5Cie+cb44siWjapFaIai14BUPayMlCfG4D7r4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730335228; c=relaxed/simple;
	bh=b9RT9JGlGTX+RDJ9hcguDOIkwZ4dtLpQ+i9tQfITK3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A76jZ/gBeytRsRdNuhy3DoG2dm8tf0a0bicU5UU3aQUewmAFpi0JFk3WEkW+4zvDmcItaZNC5IIhTMej8nZ17C37Yn/qDN9/5BUGIuH3o8NCwbyu+3UNGhsdjtAi8uRk172p36jqnJxSXFjvV/8wxzY46qAZHpej+6OsRPylCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0pi9SJI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0pi9SJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4774C4CECE;
	Thu, 31 Oct 2024 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730335227;
	bh=b9RT9JGlGTX+RDJ9hcguDOIkwZ4dtLpQ+i9tQfITK3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P0pi9SJIevWpKWkehImpYL7Mwb6FtkUHvXOEBYNI4n0IHz3ndhPDY7CoptTQIcr56
	 SNeXZbHOViNVBxTQVKWRkYiC2nZyumf6oP9+pxLu7JU9pG6TBZelVHCCuhRL+ZMZ2B
	 uVKsTYMzM8bK/Ut73jx9+v45+UD40owTXDwkJPxmjLJR0kMUEWZbTCAigz1Nq8tNQd
	 OqmwdEjzSB4AACSyWW1HZkYFFOPxjZ50kKcysvb/ubU3gvMoHMpgijON2M2BQF1tWr
	 jWeUOQ/WN9EoGxwgy7lEQmMj1k4WoDTaOYEct0JzHt/25A7VNuEKkrdnDR+wlwnHUz
	 +Vxgnlcvss+qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEC1B380AC22;
	Thu, 31 Oct 2024 00:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] PtP driver for s390 clocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173033523551.1505862.3155518781506705401.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 00:40:35 +0000
References: <20241023065601.449586-1-svens@linux.ibm.com>
In-Reply-To: <20241023065601.449586-1-svens@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, richardcochran@gmail.com,
 gregkh@linuxfoundation.org, ricardo@marliere.net,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Oct 2024 08:55:59 +0200 you wrote:
> Hi,
> 
> these patches add support for using the s390 physical and TOD clock as ptp
> clock. To do so, the first patch adds a clock id to the s390 TOD clock,
> while the second patch adds the PtP driver itself.
> 
> Changes in v4:
> - Add Acked-by to patches
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] s390/time: Add clocksource id to TOD clock
    https://git.kernel.org/netdev/net-next/c/f247fd22e9f2
  - [net-next,v4,2/2] s390/time: Add PtP driver
    https://git.kernel.org/netdev/net-next/c/2d7de7a3010d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


