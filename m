Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80B440624;
	Wed, 19 Aug 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163871; cv=none; b=j1KFxGbWzReQWjW1DELg4PcZPshcKD7XPHIp4UEGM8NhTXcaOSLBHnYN7xNeZiMY7Nng+OC+aCRhbIvFRp8yVAFCLtrNnIfCCXlOugUjHuSEW33C6yoxvwV7hr8LEAaHry6PZEjj0cnjISnf+MVvtwQqSwS701yLwpslWw3pqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163871; c=relaxed/simple;
	bh=rdwUx3DAw9N+QIpGn2W84MZ6D4+yFhtruo7ZG3eJznE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KvdwrxMNrip7+txjoGP+VAQ6lNH7Mmxtltw/FefuPauaUUGuzJZEUoDflHGlaUrVYtwV3a3SOjDKXJVdSYpVyA4BuEjGEPxVoZoEs5Xh+ubDOMrLWVGXpCMfNu6v/UPIGknQSueoO22D1vx9BoFi0hLqsitPwEnf4q46M/GAabM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH8bjsdO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH8bjsdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6669C1F000E9;
	Wed, 19 Aug 2026 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787163869;
	bh=rdwUx3DAw9N+QIpGn2W84MZ6D4+yFhtruo7ZG3eJznE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PH8bjsdOD2aqLI38xR2UIJBAhMGP397pP/wMMN57VkFNh3YQUwBN8Oj21bF5iycgk
	 QnddBYZgrb0OZzlKokhPYygLqcgjy7eLBqqx2NjBTOBSqHPdPU2W+B+Jxy+kFpvmp6
	 2+GrX98L5L5TdU1GAGeKhupIKLjmkcKIJYwv9Vob3MpyzN+IrRKJqK5ShWSGnoSano
	 4Zv9r0vJX4OiVts+QY64N7J1e76kOE8duIPPJGVKuKSmRdS6iMkl80H9879ub9qr7W
	 /NDFh6fMMUhzc77Uuh8e9weiKY9G9m0l37HAJyodaPqjyV3jFGZbPs1k8a722NzVtb
	 dJlYxEcdkZd0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 09/13] sysctl, ipv6: update
 register_net_sysctl{_sz}() callers with template arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, bpf@vger.kernel.org, mptcp@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260819-sysctl-module-aliases-v3-9-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-9-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:24:29 +0000
Message-Id: <20260819182429.6669C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The sysctl table definition and registration must be in the same file,
> in order for the macro to work.
>=20
> Add plumbing to register ipv6_{route,icmp}_table in their own files.
> With this, ipv6_{route,icmp}_sysctl_table_size() can be removed.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D9

