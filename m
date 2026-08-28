Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602911397
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787960136; cv=none; b=G2rFuf+bIxZqjgtNr1m7aVihbMqEWCyR1oRs1LPefh9xs8bEWH3NYZXMNExBdLz1NEdYCFPRwuHoHFDIGXTDudQebBf2bFcbNkLfCZjb7cPABYbBFK8s1SycGl2KUK+QClZV/Zre0bxK5dJYaxyLK8pLoNzNQi9FCZvCu6ho29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787960136; c=relaxed/simple;
	bh=adpuASm+k7iH0gKuZ7TzFIj8k1HTk/2e8W2mBp7bWo0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EEhaYgR5nmiggunL9BAnsHY6+RwOusOO366raSBRzzoihsbDwprlry0Quw9Cd311n9J/mNstAg9Ib43TPtQRyUxenjkkkWUmjLGrpcjwOkzb416OqR+0QPSGWjf2/YDYMPv9FgYiErVmQyfRnFizjfqMz8mXJrQNyj/AkZWr4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+q9QesM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+q9QesM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA2E1F000E9;
	Fri, 28 Aug 2026 23:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787960135;
	bh=adpuASm+k7iH0gKuZ7TzFIj8k1HTk/2e8W2mBp7bWo0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D+q9QesMXbFlNf0tooMVixYq9OcY/Ug0szlYI4gCicd/8nM0eEuzNW8J/Kzzd5lqT
	 GNrQsF1jynsnl7w87iJVLYbUDesoJUFkVNXZk3w+79a4AP4AwMwGkjDH1yl2iA7qbF
	 +qZ5sddMqjvbdtoT/Ick5s/QKHYc6nyR8h6xiXKSmNVLAyYsUuSBbqTVR31SGjlvTz
	 mcxmqzn3HU5Ex2HYSc+Ij15+AHHgi9ebnrTWV+CDa/20vazKtyelUTiujqpAQHf/4Q
	 mS/IaEeZivS7rrGmhxn3ld5ivsrVzPkq6TX3VRB25P05HI2//N88EtDJ1uW598kU4g
	 ecZJDmWuYnsSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/13] alpha: Remove alpha_ prefix from custom
 syscall entries
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-12-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-12-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:35:34 +0000
Message-Id: <20260828233534.AAA2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Some architectures need special entry points for some syscalls (like
> clone3). The current approach is, instead of having a special name like
> arch_syscall, to name if as __syscall. This is enough to different the
> common entry point to the architecture specific entry point.
>=20
> Change alpha special syscall entries to do the same. This makes easier to
> join the syscall tables. Leave alpha_syscall_zero because this syscall on=
ly
> exists in alpha anyway.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D12

