Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9537C23BD02
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578180; cv=none; b=JPWSxlrozMZ4QurGO2zGQ2O47zKZ6/hxi8sHdGE0PjAKihfNr9dEb6+B4p3DYMUeBSputj3XR3eUwi+nbySsFjOT5pcjifSh4OepP80zzX2sfpfwLcXJ/7pq7MuL9i2p4UaX7bhj5EKSXR/VTCBi4BlnVnEanQY79RKPX0ZRpko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578180; c=relaxed/simple;
	bh=ZUL91FCCqxcd5kLqcQffM/OxtNrrRcJnquwQ/H3S3Xg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o97Vejody2ESpiOkqGscb+Z3hb2H9RDtsoprZsXRtXSzEa3dapMRStHk6yNM5b9E884VcevV8wB+XiZfX5IFMNAnw2VxCEkdeUEDpaYa95YxDd1BkJVaG2vps48Ue5xfMCd2/7yg5T0b9SpEPUnJqXfut+0/ZsfN9pO9LUJbIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmLM6y5H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmLM6y5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FAB1F00A3D;
	Mon, 24 Aug 2026 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578179;
	bh=ZUL91FCCqxcd5kLqcQffM/OxtNrrRcJnquwQ/H3S3Xg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EmLM6y5H90m+eAQ0wwjly9G5PSLutRvsQpbuQo9NQlqIu7tsFE00v/N+P57ga0GsB
	 Kh1n3XDWhTvYGDuSbPGqpWnR0o8PHuALlJVDbIxvGqys+Iz3/6ZKujtm5sw/QxeEW5
	 knUcdqj8UXEILmU1eezq/fF4y8/RtuSW+XKxfSHmiMpPgG+AGQfrLFZyOMEweRuBcy
	 konqQT7tRBAKQ/AQlkHRCCP27/1JVv95zV5Slf0KKbXz+BsfI7k8WjNdfsGT1Gu0dn
	 LjMhTGQqdKCG5GotpdTuWT987yzIfxRBXsw8Am+WatlA7JUW1SDP8ukIiSLC6sNWrS
	 ayu7S+W/qcNYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/pai: Move locking to event init and delete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260824131751.179275-3-tmricht@linux.ibm.com>
References: <20260824131751.179275-1-tmricht@linux.ibm.com>
 <20260824131751.179275-3-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:29:38 +0000
Message-Id: <20260824132938.D9FAB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move mutex locking from per CPU allocation to event allocation.
> No functional change.
>=20
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824131751.1792=
75-1-tmricht@linux.ibm.com?part=3D2

