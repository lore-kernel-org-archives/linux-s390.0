Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AA7426430
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778411; cv=none; b=JUgGQwFDSCesLUQ0dWye+qZOJL1ihC/W9f9k0+6nUXlF9xlxf5bYLKDoOCIkRXiMcchL27TB9uotVpNUKZkyWvmv9Yhb2MES3Yps6xfUhmFfLV+TBUd2VP1x0K+JqY0NsFc/I97jM6trgrMdKGqI6D+FEegF62rVJA9jBmguHtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778411; c=relaxed/simple;
	bh=sot+GLdXak83TUoNCHcQOUJgVn/ma71aRQVQ3JBx22I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rXZeCyOAVNqtpP9GW9dy67qhCPCG88HyZ5ubDXNfOU8NnMDNqr5elMo+wggGU4ABUL2cPXgYmyYLgofCh4xxca0RytuvMqu4lU1m6N46O3bDgmSdWkDo3VUG/c1WsTfP76qYYvl9sCrUTFGhUzjEe8iwbK1neqokHUIALgOjTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3ZNrKKK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3ZNrKKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D30B1F000E9;
	Mon,  3 Aug 2026 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778409;
	bh=2S0DYjpgTfKVZsIhuX6AFyfWb3GIAkVmdf/fcAdWQEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3ZNrKKKe+22A2jOluYtrpsOBivIo3zj8w6z4CXFriH6AqU58GJR9ZC4GoISLOZbl
	 SLds+4v7z/mBnMn7mlAp1XLZlnhUpmTgHBF/8IV9iWhY+bUL1hQK9Zh4fCi2zUCpZF
	 cNdVnxaWMfjBEj3qul2Fr3JUd9uqkdlhStTpMq3ZRSDwgM1tSCYFbukOCsovY7pu1T
	 EXhjA2q95/vUc5Jv22ZkSMx+Xv3rj09ZR70Tx2UsrbQtpmsHHebqbijG15N+2fK9rz
	 rHrfRQPMc3NCUqwRHkrN5VlJWErIgimJKTXRgP9VoMHHDXctN08TriYOXpTbr5icor
	 2uaMNGvmVRlWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] s390/sysinfo: Add context analysis attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260803172144.827049-2-hca@linux.ibm.com>
References: <20260803172144.827049-1-hca@linux.ibm.com>
 <20260803172144.827049-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:33:28 +0000
Message-Id: <20260803173329.3D30B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add context analysis attributes to service_level_start() and
> service_level_stop() to specify that those functions only
> acquire or release a lock.
>=20
> Addresses the following warnings:
>=20
> arch/s390/kernel/sysinfo.c:331:1: warning: rw_semaphore 'service_level_se=
m' is still held at the end of function
> arch/s390/kernel/sysinfo.c:329:2: note: rw_semaphore acquired here
>   329 |         down_read(&service_level_sem);
> arch/s390/kernel/sysinfo.c:340:2: warning: releasing rw_semaphore 'servic=
e_level_sem' that was not held
>   340 |         up_read(&service_level_sem);
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803172144.8270=
49-1-hca@linux.ibm.com?part=3D1

