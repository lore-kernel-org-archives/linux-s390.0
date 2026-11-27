Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803059;
	b=BoixK/OKfvyM23nleQM6OJ43qTw72LrRlnSEO8yiNy+Pvi5r9YkEK0CN707WP4DhhxeZ
	 FPbT1NhVn/Gkphx4D2mV5xsLSCAOwwG00C/o3RXSEOdH1lNbABhQKjb02rA9QWu9Gxit2
	 vZszQQ68GHKU4j5KNcNkecZ4CLYwhk+NTCIsSbQCCpcxqQkWdO/3TQvIQC4pJgHVKvKhE
	 omKrfSZHlO1lFDHHeTbBcqbgI6eEIwRDc0VofPITaS2A1821YyzbCWIq73DW/wEo7jlLF
	 0Kyuxx+QM/5VtBxw1sJQ1rrzbY9MMmVUAJmcmU8yifjwdCp7lPuRD9HYQssbNGFpifw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803059;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=hkSeaRzJ5GweQZSGSk+XYguRf2EecgnZtdu8u1GWWsE=;
	b=h4L4Fq7SMpCiM4NoBYenH7o1PQQgGHPCPL0x2pZbmXxx/bR+sLOO7aJcGThEo6U7+grc
	 4+69FTU616ROS0p8JNFwapmYtKoJ4BHEv09DM8zp+JOMI8PwiTqr4oDaLtvLhrtNRcYco
	 XXyKyb8hphIQUsKU0dTSH4vWm53OnS5Dd1TVPZsQSjEeJCJQ/3oGCWx3sjLqo9TRuWUi1
	 IFsSxAHuALQKCOG24TP9d0nU/3hSDEes0HnR5v2HZ4TfnCzOwitmqHSF5Tj+gM9PWdKkB
	 zJOqHmV/qfEu21Yv8CT2AkCgxh1tDElryHaAn0Exu7dZnxyLSOigBIDMS0XTduRzsVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcyMgydX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B8606A31C;
	Fri, 27 Nov 2026 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcyMgydX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA771F000C1;
	Fri, 27 Nov 2026 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795803058;
	bh=hkSeaRzJ5GweQZSGSk+XYguRf2EecgnZtdu8u1GWWsE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=BcyMgydXE/byR00FK5SRtaqH/mA/pg4qjmxFHSBvlSiHM1sLSebMAWlP1PqRbNp2g
	 tZs+LLGFzNc9GX+kA1bv1DWi1WrkFpq6W8M9pbihW9/K8BjvQhlz/4iSZAKuZttUtS
	 sjs7Gm2IEB8sBFYHLi80zH2PcbiUHSTF0F3HImZzVvFsxLj5wBlrlmy/618ixsHeqj
	 ptic3g9POgJZAqZfdxiocahLkMf7sz1U+qqu6ejf4Qwd3QTnRYnmqRIEaKpikAPfNV
	 aQEu0yLuGh6u/c9AeskF3c6pPre31mn2Rmv61h/WomlNnj0n/K4cyAlHRcZqdfkTyA
	 wAeJmUpUO25wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A4D49392704E;
	Fri, 27 Nov 2026 18:10:58 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 7.4-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261127095136.2292357A6b-agordeev@linux.ibm.com>
References: <20261127095136.2292357A6b-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261127095136.2292357A6b-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.4-3
X-PR-Tracked-Commit-Id: 23a04cb4f2bdbfc87fc4e1c15450e7f8cfc9842a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27db887a98fe217ef96d2d9f0c61804f63a145f6
Message-Id: <179580305729.1619291.16483662589871849097.pr-tracker-bot@kernel.org>
Date: Fri, 27 Nov 2026 18:10:57 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 27 Nov 2026 10:51:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27db887a98fe217ef96d2d9f0c61804f63a145f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
