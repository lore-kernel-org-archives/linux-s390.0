Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1570325B0A2;
	Fri, 24 Jul 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903168; cv=none; b=apD8V62PEWSEgBSXnggOzuZUE6fkBtF4xUPET1UqUteQBbFPzcgH702zXeIXWMbDIj0Q1cWwmqHAS7MvQhAJ0IhG8pHYgtgk3oGTP7n+HErLrLbkeEdbKQjrINTrrKBDqn0iKmPQuzi6gGjIx8DgoZ6jnqg4YVYuLCcijUni07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903168; c=relaxed/simple;
	bh=zDvHui/ruUyQHfSmKov/I/yccXU47rZ9bf+TcM25jDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sq/8IYUW8ajJfuRRg++jVMeui4CFJypmoV+LThO6gz/RIP+fpx1WmF6R4/w6BNG70kEOzG4UJA+6kSnmWi94zj4/sec9SIaH+imWC9HNs8oSLKEkImAtyvTAnYhVrdh894flVc9IPCTlp5VgZ1SHu7bwtl+4zXBBDHVGDP69U80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MledMhVO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MledMhVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08AB1F000E9;
	Fri, 24 Jul 2026 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784903165;
	bh=zDvHui/ruUyQHfSmKov/I/yccXU47rZ9bf+TcM25jDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MledMhVOhDhBG9zVPVMEMIsM9uYn7/mgt8is8nnK9slfvW46NU4Ojf3OGssDfqSl0
	 qxKHAsp/VpwFYOXTl1/qBKkSnTtlPmvJ/mL83TNhr7TVC/o20lYgxa91YRdido/esU
	 7aaGJFTUHwnVIpQTxFq3eJeC3l5c+7fw7+xsjnl0T798008VuJSK71zCEIXLK8nbwH
	 N5iodCh3klLnd3mEwaF0n2LpEs7svqaHdJBQb7O8Iv5o/00Nfxo+rq7S/itUwfbvBo
	 HzT7q0DLXZg5ME2VksQ+FY2dSP9cNnUNowriduPnc/rn6bILaM1IMwcdpEfVHFvdMo
	 AQPHkSNP3TsBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] s390/diag: Generate CFI type information for
 assembly functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260724141318.1037434-5-hca@linux.ibm.com>
References: <20260724141318.1037434-1-hca@linux.ibm.com>
 <20260724141318.1037434-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:26:04 +0000
Message-Id: <20260724142604.D08AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use SYM_TYPED_FUNC_START to generate __kcfi_typeid_ symbols for assembler
> functions which are called indirectly. All assembler functions contained =
in
> text_amode31.S are called indirectly and require such annotations.
>=20
> Reviewed-by: Jens Remus <jremus@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724141318.1037=
434-1-hca@linux.ibm.com?part=3D4

