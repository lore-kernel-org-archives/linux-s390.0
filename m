Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBCE2EACEF
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851493; cv=none; b=ukZWmcveVwfhyvE65q0ug0SAc5f+f6Teh5qm+w/TZiU92ikmezM4FAbTbJmuCiFHWEv7IXZyhqPv43gHMDdynBKO3EQJvQMWmj+bh9llZ8wODTGbtU3/mosdfAxfskuCaqkK2EuJtBRHeh13dCWEiHbRqJgRnJSMOGXjJbaUg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851493; c=relaxed/simple;
	bh=dl2IGIUsL+im8nDxVIO7h0xpze7+VSI/DtVUkJ8+Zjc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DsmAcm+45DmeC5620F8n9HYWAIXAWUypNELjkN4zUeYH9jnjZk3RM6jqe8ptRSO0ewyB6XBu+9ySAm6FdmhyxZrZcXnYkTvP//Mx1oqJ9ECwb1pdmHChBzSv6gbeuXz4/rAeXqeXnGHxWhn4xF9fB8FpRzqRmkMnDwdeF81uR+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzxHwC+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzxHwC+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3E61F000FF;
	Thu,  1 Oct 2026 10:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851492;
	bh=dl2IGIUsL+im8nDxVIO7h0xpze7+VSI/DtVUkJ8+Zjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzxHwC+JdXxxUgLeyTIOT7JmcjOt6ucNCIU3UEuh4Avq9YnZMYFnPpyjRtSNW9uEU
	 LuepTtjoNtIUsC2J2zdlsRP59b1fbOfQxxpGXfKVUTCoIWK6bDAFjGqZvdtEnsU4SQ
	 5AyP5FyoHwj800ifau/JmfP6fZ+AmQASaThA7X9WQOMoRtYtj8nqW14VLH8R0CWmdm
	 C8AxlgnprBTlwnrUUgx8x54HbvGUdM/21UGGXwfcnQKYWTmzqd+y6Bkald0+piPZwa
	 HOQ4lyuLhBl95MmXggGH4haki821zC27uIZKxoCBagl26kKXHTYoLWnz1UhZ83mDRn
	 2LxB05DRvIXiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/32] s390: Clear pt_regs flags field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-4-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:44:51 +0000
Message-Id: <20261001104451.EF3E61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Clear the pt_regs flags field in the early program check handler as well
> as in the stack_invalid handler. Without this the pt_regs flags field will
> have random values, depending on previous stack contents.
>=20
> This matters currently for bug reporting and disassembly, where flags like
> PIF_PSW_ADDR_ADJUSTED may then be incorrectly set, which could lead to a
> partially incorrect disassembly or wrong code markers.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D3

