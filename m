Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3B386C39
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660698; cv=none; b=ABvto4GyGf6p9kucUaMI+XybSDzw/fPqYkd3gmYgVhHxyEeIOLbKeHBsUPuk1lrHMZNUf8XaaShBjG9TIC/MhOowTidJ4nETlg+d9tCUYEsPypd++1pWkuObJFp1v1q8HR4IRD+qsiEh2zZF4aIK7f+nYvZkD/yxc+QfTT7/P0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660698; c=relaxed/simple;
	bh=MCnl3703hmSDui2zq+4WF9aZzkwShv0xNkQwWZoBMbU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jeyrwLpHfrNeS6xCwt1a0ui4NvkIM0qhlB8bewzGWGOi5xCLzJlXyVExEJa85lj+9DGwgQ16aV7Yclz4cPsqPlhhuojwHYheU9UAirxSHKvgeqsCJZgfrSxXRRJax19UuovBPaUP5npLx2IWTjIaUxFtGU4BtVtdvLivSyy9+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDW6BT4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDW6BT4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6FE1F00A3A;
	Tue, 21 Jul 2026 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660697;
	bh=MCnl3703hmSDui2zq+4WF9aZzkwShv0xNkQwWZoBMbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WDW6BT4EhG/81PqUEaFWQwrUC96YC9oqcL2CHSM5OxVRNXee95eK8AbGv12K2LMmu
	 u/TAoIOxVW/MnPHCA6NagAPg8pzDeICMh+Gmg1F5VgWkSvET/LELHDsNvaRQ9yvyPJ
	 ZlSwmGon51QfPtQTsk3c/8d91ZEpzd1FaFBgY6y1I7YRPchNrpb99I+mgba9kR1lhb
	 Q2ymDIPqy7Wue2kHsHqfJrn/yXec3optSn0R9FARoZVA3ylh+WlqCtyOPy/4OYWqDN
	 ZPc0KkNCb8YDMbhTN5bkLmlp+fS+G2Al41jcJotYZAn1Yxt9iK4FESyFMzDlxA5WX0
	 YiKg2yJpJHgPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] s390/ipl: Improve readability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260721-ipl_refactor-v1-2-4d5938de9a70@linux.ibm.com>
References: <20260721-ipl_refactor-v1-0-4d5938de9a70@linux.ibm.com>
 <20260721-ipl_refactor-v1-2-4d5938de9a70@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:04:56 +0000
Message-Id: <20260721190457.6B6FE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use explicit decleration on all shutdown_action/shutdown_trigger
> declerations and reformat shutdown_actions_list decleration to
> improve readability. No functional changes.
>=20
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-ipl_refact=
or-v1-0-4d5938de9a70@linux.ibm.com?part=3D2

