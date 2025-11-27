Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C876618FDDE;
	Thu, 27 Nov 2025 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206444; cv=none; b=MYAHgyDqR8Q7Jh75No/AbLGQqemqv8wf1mSywySoqRO41BCxusNmRLMQDhmqEkW+E+NXY49MNUK9qDog8BX3a/uMK58WPQVtO1jRJLxCzMf6Ti0f3dfStKrokEN60dJWIxXXnMXsSgTRfrIw1cNRlqDYWdKzPONecRDra/fFoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206444; c=relaxed/simple;
	bh=wM7dKGQih8wNeHB3SYwddmyWbom77K0D1phrZv4gnCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dt/S5jdLYEtyiF/H2rx8/CBXzUdG5QadqeQFyQtK5cDoqAZm4vzYA1+Gn1vjsHmin5RYtuTQnTzb0pz0xpm8xT5B90pB6hKym0QbwXuf2tRo1nu+Qs1YnRwzuVD06Ai0mjwQWblBhdGEhdQd6kuschKjo/OL90oG2iPDO4fE1cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN10YqxM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN10YqxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D1C4CEF7;
	Thu, 27 Nov 2025 01:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764206444;
	bh=wM7dKGQih8wNeHB3SYwddmyWbom77K0D1phrZv4gnCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LN10YqxMrMqw1Ulg9TOwGWLMhZYG1iCgtJ+J2oBnv0tL5hPKE/I1bKqBj1lJ3JNIk
	 Tsuo8Rf5+u6hBiAp/226iOjr5W06DrbY4b5HvAKOMPAwdxmsSBxDmbBXZ4n8TSv+QW
	 O//PncOqLjLlyobWxEYJIefRh8RJh72/gpky35vJC9iQ+ZsicvS/9mWfSROPJAQCKG
	 5RnuEglKD08cdZxil8cSxVQLhKmNakhBeI0gzNZlYobrV6dWjLFJsDTydlGyV99IPB
	 H9tY/3Ie0Y+F9lT3HMop9tyGsQ7MC9DCa0NxW9Ahwd4pLGGNCbIHNHRG1JBtIHLeTT
	 p+ZV9qlogR+/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E83380CEF8;
	Thu, 27 Nov 2025 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] s390/net: list Aswin Karuvally as maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176420640585.1910295.5604261419675228939.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 01:20:05 +0000
References: <20251125085829.3679506-1-wintera@linux.ibm.com>
In-Reply-To: <20251125085829.3679506-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, aswin@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Nov 2025 09:58:29 +0100 you wrote:
> Thank you Aswin for taking this responsibility.
> 
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Acked-by: Aswin Karuvally <aswin@linux.ibm.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] s390/net: list Aswin Karuvally as maintainer
    https://git.kernel.org/netdev/net/c/b9ba6338bc6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


