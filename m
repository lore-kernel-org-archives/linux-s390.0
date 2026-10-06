Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE23AB28D
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791285859; cv=none; b=onj3cVCB6VgzNMoeaaSwZ1bpxoCV9yPpoqIyONS4dM0AjJWkTtueQj7vapa1IPK3pK60astpMzVYlJ+joPRmvJzPqkxdppcETFoFWLS1plft6FE88QO030M9Nkdg12s66TUHyrcrIoR5Ek0xqB6WMYelBlcGky0Y1joKrJOZduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791285859; c=relaxed/simple;
	bh=ij931my2iezkJvYNKfnl1g1qlSc6DL7sdc8p8SaMTb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JbG8vN1KqO8cXwuN2o2AgMMLbUfpP5q/UjoK2hk9lhvz7d3pH61S+9EUt8xxVIcb9Eh4WHidp36SuKwaDmt3mpCF6SEXppK6EodDPZi6dIcf6SISRkgacQSRLpSJREvGI+aZt5jwQoNvLqi7BATkgTQdtPQk4ou20Sbx5VoNkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb8AEODP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb8AEODP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8181E1F000FF;
	Tue,  6 Oct 2026 11:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791285857;
	bh=ij931my2iezkJvYNKfnl1g1qlSc6DL7sdc8p8SaMTb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mb8AEODP9IByBpXntHwVPV+ezIDGUrndpcC26lo/9vvUA425D74xah6CKc6RDhfs5
	 qryt6TAz5ESP8Zne//yjx/sS9CY9nIfs2ZIEW69577ROfsWX1qydg6ZjcbkGnepzYC
	 WTlU+8BSfJB3VywUPOoIXdmw4F/U8oMjk7PbALn8p3h4dlOazQO7+fDTYWhZtJt260
	 +ZvKk07Pa/2F/tRgHOhFSKQm/mnmNpvHjZSCX4Q0XVVV25wuEd//iuhb3SOEk1GB0k
	 RzVTapnMPc6l4r6k/X4n30OhOuTPziYZgxxMST2nhM7FvQvR1IvnKj6Y1QloqgDSHz
	 fVm8gZ1X/E9HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] s390/cpum_cf: Check session mask before cpu offline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sumanth Korikkar" <sumanthk@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261006111304.4023017-2-sumanthk@linux.ibm.com>
References: <20261006111304.4023017-1-sumanthk@linux.ibm.com>
 <20261006111304.4023017-2-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 11:24:17 +0000
Message-Id: <20261006112417.8181E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> cfset_offline_cpu() stops counter sets for every active session without
> checking whether the outgoing cpu belongs to the session mask.
>=20
> For example, run an hwctr session on cpu0 and a cpu bound perf event on
> cpu1:
>=20
> lshwc -l 9999 -i 5 0:b
> perf stat -C 1 -e cpum_cf/CPU_CYCLES/ sleep 120
> chcpu -d 1
> chcpu -e 1
>=20
> Although the hwctr session does not include cpu1, cfset_offline_cpu()
> decrements its counter set reference count. The subsequent perf teardown
> decrements it again, causing it to underflow.
>=20
> The perf event keeps the percpu state alive across hotplug. When cpu1
> comes online, the hwctr session is started there and the reference count
> moves from -1 to 0. Stopping the hwctr session then decrements it to -1
> again, so the zero triggered counter set disable path is skipped.
>=20
> Check the session mask before stopping counter sets on the outgoing cpu.
> This prevents the unmatched decrement and the resulting reference count
> underflow.
>=20
> Fixes: a029a4eab39e ("s390/cpumf: Allow concurrent access for CPU Measure=
ment Counter Facility")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: stable@vger.kernel.org # v5.14+
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006111304.4023=
017-1-sumanthk@linux.ibm.com?part=3D1

