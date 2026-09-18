Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FF502776;
	Fri, 18 Sep 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744565; cv=none; b=n7JiAom4RHXISQMp16oNeucFPQBJ6QsE3D8yrgC2O9gTe7u2KBzUp+ZPnPYL2ql17rPdImotPo2E9NIesjG8AikTjpOLni3IGUib8bahZ1ZxH1mVwzg1eTupZz7gAsq6bHvoDwBoRexdmLK5G5nK7ZzlKfhn1J9NyJqR85IV6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744565; c=relaxed/simple;
	bh=S4A9eaSy8o6zFW+//rfr4YN2LoEw5G0OrVdId4V6k7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z/ZRll2ZwWRoFZUum/Pu4X4X4qvmENTymQTH7F4hrugDkJLok3xNW2dOYA49P2EZXJyO0hRERHQYQYVy6IF+/ZHmWvszVYvWL0F4gz90A8m/L96ir86GUjmrxlkN3I/gYHlNql14BwUnIMqWbaBUZCUm/fScOMyce8leMZIxeDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3+CCSBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3+CCSBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD311F000FF;
	Fri, 18 Sep 2026 15:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744563;
	bh=S4A9eaSy8o6zFW+//rfr4YN2LoEw5G0OrVdId4V6k7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i3+CCSBXuT56jL6n2Ie+DsBuLF0xCxiosOqJd/3vCwjofGiEgPYK7dfQD/hILo/yp
	 OUvTJR98UrbM4INMAndqiVpM4lI+XbNbA857atrOcS10jdoAOLhotwzcVkqoDTcPM2
	 +bWwJEkRrRQuNsuleLdKgxyQSd5aliyJ9AgSp95lWcPjyF4EZ+DXBQGGpJbEmr8LWr
	 CUfqTm58Rr8pCAzAca2emuUkGTRvatHdKygu1h/VI3gxo6uiM6kmq5SvwfJkJuK/dX
	 hu+KvddkNhFEc4MxLvEtSlz/e3FfBk4H1w9N/FhtasHuL8ELbheOrfMMJIo5o1ZY1A
	 95bO2bz5zut4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/29] arm64: Use proper include variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20260918133107.1042730-11-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-11-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:16:02 +0000
Message-Id: <20260918151603.3FD311F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use <> for including the sysreg header as it is not discoverable from
> the current directory.
>=20
> Fixes: c07d8017bceb ("arm64/sysreg: Enable automatic generation of system=
 register definitions")
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D10

