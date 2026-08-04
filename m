Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0235C193;
	Tue,  4 Aug 2026 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785807649; cv=none; b=MHy0OJrK6f92QIpVA/49e9Bo90Pogn7bYfO15/5L1W9lCMiQDn5wLJmDZSAhUOz7Xz5SVZ7xMWLCaP9DsJrSLZGfo3zd+FGB0p/k4CVA3koi9c98QXX2VBmFCczcF3lTdYTCXTvKfLx4ey5ZINQ0Rq7ZvyqyAPbBwLOubdkI2Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785807649; c=relaxed/simple;
	bh=sasgzNGlNBE05J9hIIj92BDQPsT51uRUFXtvzgBTe24=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QJ0lFe1AYHlYmniU6j3+pqGh77x7wijLa1wQYB//LmuaCOvx81zg2FpeiIRZhB7T7UYNzrHd77YfdQyj1pFquRsv5uYG0532+tbEUnDoFeIaRD/coggTu+ljpXCCVCtfgmlu08aX0oeqq3inaP6Su4QCb8QAMec1AwB6PlhLTis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDVaMzRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDVaMzRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8265A1F000E9;
	Tue,  4 Aug 2026 01:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785807648;
	bh=LZtb7oc7kQiLY38WCCZajRE5C+TASe3DOvt6sr4rsQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lDVaMzRrzE+2A0hiKWn1dSTBq48Kv7/gK171qaIXg6tXH4I63TQiPw03SUjvlSaIO
	 nP+H2PUKBygcufigm8TbduGkULetrAqRAoWOz9kqNVwfnTY+t/XtMy91US2UX/Ce47
	 rwVU37DlomeBGgGeDU2CFAHQo4L9tKGiRLnc0p/32eq9cbsOZYQB3gEokumP65b0YA
	 px65t5CSDWFcXEGgSCRV8Nv6+8m35blx/wBeIrSaXKVAB4lu3EJfUk5HP8QX8uF12n
	 NWrk0sy5YQ/LhGppX/HqIXJKBmaHQFPxJlczZoCwBs6D9LE0yIkebVgqQZzqGjDIEp
	 rHR0G1sZQoTPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939F63924467;
	Tue,  4 Aug 2026 01:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/qeth: validate user buffer length in SNMP and
 ARP
 query ioctls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178580760915.2910544.4513512271107471606.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 01:40:09 +0000
References: <20260730142216.218309-1-hidayath@linux.ibm.com>
In-Reply-To: <20260730142216.218309-1-hidayath@linux.ibm.com>
To: Hidayathulla Khan I <hidayath@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, wintera@linux.ibm.com,
 aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Jul 2026 16:22:16 +0200 you wrote:
> qeth_snmp_command() and qeth_l3_arp_query() allocate a buffer sized by
> a user-supplied length (udata_len) without checking a lower bound, then
> set udata_offset to a fixed non-zero value and pass both to a reply
> callback. The callback bounds-checks the copy with
> 
>         if ((udata_len - udata_offset) < len)
> 
> [...]

Here is the summary with links:
  - [net] s390/qeth: validate user buffer length in SNMP and ARP query ioctls
    https://git.kernel.org/netdev/net/c/d141f087b1af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


