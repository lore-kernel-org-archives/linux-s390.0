Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122476;
	b=GQ8Zo66zbaLkJygS6BsFO+g5iGNoQpVMfYWJRG4W4vQ1u+jhuCndM4yK/VDuj7EELJHa
	 r8NqhEg30Fpd8lDp6w7kZTyZwC6ftKygcH0R4Gffxh9+Tsv8scUVSfYLHlkKT35vCiwEi
	 rCbBIF76n3ksGfbngzJsDSo8q9MPiNeml0DXlTa6b57dkkvX2dqFU0F9d2DoMlnJcl1ID
	 4xcTIrhbPZd0AZFVYNvFEOkTCKIoAq/NZDQGKiA/i0VS1fHJ9M2CfysZlqb3pAmBcqH2+
	 uUghT66AJzJE2no5OQ0rolBXa42evRooaGV87s2UlYRiR5ZRc0g8x/38tzCJgtZxKHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122476;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8cDH5JsVspO8wP/dmAWnZFn+FnswOZQWIo7zrvcmGvk=;
	b=lKI7RkLae83DoLBRU5mjtOAR3B1lv2zMVYFMFJ7iYR0Y0bsK1GFR6SK4DhoAuhZKvr9v
	 NdSBNr9oT4X1H3Nvl67AV+cENV0Y2NcBjlJ1c/PUIH7bjTJRBYc69RTJvzWKufhnVDYRS
	 nmIZIjG0bQoCmboydKuhAdvJiWbWobqlbepH3acQ6KTOWDCoWBDiFBoA6VXyX8nxJLscf
	 vQJf6wRNE7yYvhM0uqUrjqLrVDv3yzuJmNXVcFzbk7DxkBfi5SISUZ9Ahk/DnZCDFn7Mu
	 teRCQx2GEetd1a/ltyURtvuanzyDeQ5lw1Y/mtVEh8Xf/YPn+cI28dDxi56q4OrVefw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNl3rsFS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D703606A31E
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNl3rsFS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9041F031E0;
	Tue, 27 Oct 2026 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793122476;
	bh=8cDH5JsVspO8wP/dmAWnZFn+FnswOZQWIo7zrvcmGvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BNl3rsFS9DlDLHusiTF0TWuhabQ/5l/LRnw3dhj06njbZC76Ey/xDtiAbNu59Iwms
	 LF//4DQVR1E6lwd6KYLjwtFX4BCzqflXdBAUJK710lKh6049sNvZQDcRq/j9uCWqmN
	 7DojJKLkQA5wkiuVOeI/n8VWnkj4PmthQrSiRsAJh30wkNyzxuLTWbmfV6MidOr5x1
	 N8/1oLGKUTMNHd/wmopNe6tA+r7J1412NHLWe+wDS6FC1b95c9VwpmL0odIsLwx7Jq
	 AGRf6RMPlGOK2tcLAhI0ze+l8k8hNWFJUvTDHV9AwAQqwR53yYZ7lNAMhILsQkyZTf
	 kI1cTwM8wJ7Ag==
Message-ID: <sashiko-outbox-186989@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] KVM: s390: Move some skey functions to headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027173239.224849-3-imbrenda@linux.ibm.com>
References: <20261027173239.224849-1-imbrenda@linux.ibm.com>
 <20261027173239.224849-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 17:34:35 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Move some storage key handling functions to headers, since they will be
> needed from outside, and they are small, so inlining is acceptable.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027173239.2248=
49-1-imbrenda@linux.ibm.com?part=3D2

