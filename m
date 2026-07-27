Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10613E49C8;
	Mon, 27 Jul 2026 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146769; cv=none; b=rhTOgo+ycES5aWk9jmRHO+rV2QTdzL999H3H176ZlJQDHbEq9P2JqSZ3DAu2trlMZVBk6qr3uWeesHAzM4fcqrHcUEyZJhR/mpb9f2nVoIxFSca6A/Cb+4S+isyBte56strzJmYvEZcmC3SxsWnyPydn3/HNEtj6AasMyElrhiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146769; c=relaxed/simple;
	bh=7iPpvJhkBlZHQRW/Dzj8eNS7luS2Lz8BpJnvE0jlDWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mXZASFpMwFr/31sMqhuMsYBH9FNut4UF01uKZas0Kxo9gnOjK6EQnKnKNuS2QtOPERVhC3724A2uFIvJCzvMkV2zLzXnkcj8QjJ3dlXkhYmB9Yl9PGWFXFshTOSFuckRrCHOnWGik69vWV4ierTTMgrzTI8a7nSE30PPr28r/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+i7XTdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+i7XTdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D451F000E9;
	Mon, 27 Jul 2026 10:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785146768;
	bh=7iPpvJhkBlZHQRW/Dzj8eNS7luS2Lz8BpJnvE0jlDWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G+i7XTdI0jcpE10KaGv1Pvq+US8Vr28S+ZzPU8UGqD5cZBrb+cSFvKVUvZ+YDRn+t
	 Ir7Kf+WFJRE4KscZYFm9NL9Fimq9Wm18K2iKP05hFnlWM4ZNuzpi5OXI+tZNV3xj+n
	 5p/0IdpWqEbZ2++4ZK6TtuE0SF80zkr6FTibQG5D27/UeSUM3HREeeHl5swAOrzBWL
	 vKsrd83kv2wytqAC0qWE+FDXih5SI4NT3KxVwR5XaOr0fxLT9wQFVTvf6wxMguInKH
	 tEzASU8iVWcrL3SyLk0am7QKGoQUBqEavLtUnPDRZQwr+w18CCoByTYv0zekrmiC5q
	 Pxp29EiHN1aCA==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 4/5] KVM: s390: Improve kvm_s390_vm_stop_migration()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260727095359.107671-5-borntraeger@de.ibm.com>
References: <20260727095359.107671-1-borntraeger@de.ibm.com>
 <20260727095359.107671-5-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:06:07 +0000
Message-Id: <20260727100608.06D451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>=20
> There is no need to clear cmma-dirty state if the VM is not using CMMA.
>=20
> Skip the CMMA-related code if CMMA is not in use.
>=20
> Fixes: 6cfd47f91f6a ("KVM: s390: Fix cmma dirty tracking")
> Fixes: 190df4a212a7 ("KVM: s390: CMMA tracking, ESSA emulation, migration=
 mode")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095359.1076=
71-5-borntraeger@de.ibm.com?part=3D1

