Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984B366052;
	Fri, 31 Jul 2026 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504042; cv=none; b=YoysfesNIlMb6/uXEXsRaK8nths1QrfWeZp0l0ttT9yiHD34ikYpIuot5gJJ8b7E4M61fWzlPaTTtXANsEERSc7ZFIFdevZjkBIS9WprDvpxRe/niiK3mlqTiYKHuUy/62JPtI/FdiKIegMPT1ZgYuHmC2/JnboFJAVZpK5iW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504042; c=relaxed/simple;
	bh=29vt+G/HoPh3tOMY1FK+pl3tAE+abG/cMOHyTpDM00g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sYtAtqejRGM6wROOQiCMijftdIodCmRqsd1fx1YeQFnO9+c9VKBXeYWpimGjKUeP36pqwfdKmS1+WAW8EPJxv5T3QtLkkjXIvGB/8ek/FbTCSXoqORBPwe8wu5/itRi3tiCIK0HT7BFdFk3MQpiRw0CEzPgVIgXsCuBoxI8DZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVoM/T62; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVoM/T62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876C01F000E9;
	Fri, 31 Jul 2026 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504040;
	bh=29vt+G/HoPh3tOMY1FK+pl3tAE+abG/cMOHyTpDM00g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nVoM/T62+KHEmAmzLhQ8u2iMgwnzxO51P0lhtZFx5F0h5guK6tDgievRw6YB1Mf9l
	 Tqri8nF3IpveFsctGnlXQrh9QtQoq8/p57r7N/IuqXR5MZw+sar1spcFzFwF2W7M4A
	 xqYUHvRqGdjSJGCDiWBVHe+7ct1CS8qS7BHPR8vxK/IEqAFPDvrnRJ9woaKMM7Sp/d
	 62XH55lW/pWDE5tlJFtMHD8yeL2Fk8BrJxW5iug0NJ/9bPs+a5yBm5Oi03A4PIWSdR
	 rpNYC/NQ7WPfJHkTePlUl3jzSS67EwEHfZV4au1SjhhO9eWP/k4usevIHEW1bH2zRV
	 zNL3LNVloixpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/14] KVM: s390: Return -EINTR if a signal is
 pending while faulting-in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260731130138.173983-12-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-12-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:20:39 +0000
Message-Id: <20260731132040.876C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If a fatal signal is pending while trying to fault-in a page, return
> -EINTR instead of -EAGAIN.
>=20
> Also fix unpack_one() to handle -EINTR properly.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D11

