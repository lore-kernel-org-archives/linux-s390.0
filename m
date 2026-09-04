Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E73911D3;
	Fri,  4 Sep 2026 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788564068; cv=none; b=fU0Ps2tF8ZdticL4PVSqi0jwVaDNbBhFzat2qMuxRS1AVSIL9G2flRP9mvQOnAMs0jsV3++6KIkQiNJLXZsBYD1O26AkNz4z/m/qpyWGjAJSGZ1XsHyJrHzNg1bbtlCV+WURKLSbPT6RuK9pYIR5MXBe0iSczMNwjSU0VLbAbZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788564068; c=relaxed/simple;
	bh=WGZhmnQOogl48wgi2aqd89A7QELHYf0Bi9CQdmq86zA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BNQyiu5Ge0zrSQgUsbWgSi/0qHGiFMaqYQy8Cj6fJwIVlFnsYdGsO1KzC55Jf8ZQJyWtKvd0AZveZOtQ9zz0zcZ9sO0Yh1WKPYeMXnYlvj04Z/d5+96gXNELeqhvsurdG1WRwsiSFbkUlWLDKrDzIxDReVvD6I8T2IoYgCrNiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El9P5IVH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El9P5IVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02541F00A3D;
	Fri,  4 Sep 2026 23:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788564066;
	bh=a9P2gEGbU+vso59Kta3MJ8dJr9QzjuBZ0pND5nJyUzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=El9P5IVHujnm1fqwOM2iOXVMuONRhkEPL+GkOC7aljuyWm3nDzyTqy1vyK0MO2jRX
	 akKMIxvvoLTLVzY7vJNbXo4w2DgsL1LTUwsIdhgBse0RADIa4W/VZDgTydu5qpYgFv
	 R3mEuIWw9m4fg6uyAjbhJ8L8hpDT+ubMNWcxpERjjobFOhz/9PqyfRic12PbbCn5P4
	 3zNznLSU8iFzeYomwVYOk71bD9WfZLrOHB9YoaNoNXxdnttdHJEVBIxy2Lob/6RsQI
	 T7U80DC2ArViqrPbyogURs6XyaERR7itZyX5nWOelDZiSOMpe3XWtGQjcVnwQRn2nE
	 ktO7v6KF9WJ7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B8D3924A7F;
	Fri,  4 Sep 2026 23:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dibs: Unregister dibs_class after error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856400715.1013351.12940036598096810427.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 23:20:07 +0000
References: <20260902143438.426664-1-wintera@linux.ibm.com>
In-Reply-To: <20260902143438.426664-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, julianr@linux.ibm.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 16:34:38 +0200 you wrote:
> In case dibs_loopback_init() fails, e.g. because of -ENOMEM, dibs_init()
> must unregister dibs_class. Otherwise dibs_class and /sys/class/dibs exist
> even though the functionality is not available. A retry to load the module
> fails with -EEXIST.
> 
> Unregister dibs_class in the error path of dibs_init.
> 
> [...]

Here is the summary with links:
  - [net] dibs: Unregister dibs_class after error
    https://git.kernel.org/netdev/net/c/1668a31e3b1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


