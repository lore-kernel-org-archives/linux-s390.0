Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1793B2D39;
	Mon, 19 Oct 2026 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416200; cv=none; b=jXqbNvFmWjI52Wu4pJjGngilmYTpU4yqTW9tCiRqF1nP2pRkYU9KBOTNvV0OwSPUhIMYzDA6Ec6sUMBPbrCroNN4KEzbCUTBhF2JlkdUfBrP5RvZGq468GhnoWdPsc77E3hRy2BeKKyeMiJo5pzQqkrWuOB6OUgdHKjZDnXC55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416200; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rVw4dGWlkCtzAsqXzjE0zwVB3uHNhr/LHlJDRM9onh5YlYF3/p8C6Ju2F1WdYzhIdeS4BhmWh2cx0vxqiAnglf1qCfOrTUDE0JGD2UdUCLSSo/NmG9Zr3FRck77SSOIO0C8B5IqXpXUDRyf9JKNMXFI6KQHrl9CYpKOGe6Fidfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyLzfyOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyLzfyOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F1D1F000C4;
	Mon, 19 Oct 2026 13:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416198;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lyLzfyOcEoHsdsqpiMRf6uAvhLKQlAeLnwnwr2+4EL46wF1P77ABU49MPB99rCWm3
	 /+ov75+78JrAaDdanMpY+rB5gghO9b1TbMn+ibS7mPmUONWhv/+44HHBigIGQ0bpPq
	 KvoqDlOQ3ZyDi7B/WJ1vNX1Q/8KZOAEtwbba7DNo2Dc3BHQ4shmCSWNdnVJ4YGaH40
	 t9QNHINPSwau+92fiIPU4HJ2NfpnHsg1Phj5/kvReuaeheIKLQ4XAzQS0T6RhZ21yF
	 9j2zAjaBKfAXkIlOZg5Jh3fh6e2VkBI2G9yLzpXjCCII76gGfQ82Jy6qeNy9XGUdFP
	 af3DLsvNhKV1w==
From: netdev-bot+sinfo@kernel.org
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iucv: fix lockless sk_for_each in afiucv_netdev_event
Date: Mon, 19 Oct 2026 13:23:17 +0000
Message-ID: <179241619773.3290.4572866808123264878@kernel.org>
In-Reply-To: <179241612354.5916.12881323209252769976@whr>
References: <179241612354.5916.12881323209252769976@whr>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
