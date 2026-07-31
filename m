Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0B42A168;
	Fri, 31 Jul 2026 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503804; cv=none; b=CV+kI4m1GJumzgi5LT9PQwXp9zJjxk1iSPUZDFuzYdpfOrD6KJh/Nljw5GmawqtpOki7hERVHQE4Z1DDNUpRSNu8e67KaaKrc49cGcbU7baOnrPC2Sdezo91eJEYO9qsqTUm2IRfbeZB6psfdeGyKmPYzQpw396RfJH9PtxvKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503804; c=relaxed/simple;
	bh=/1LUinNR6bwQftO9dupmFVpcJuHhlSXMXq1yICjT2+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BamojnXDqvuI8t28uPCMpQs4PRywYOfCbQjdG9emej8jN79nExIzK66lSvJh+LWYMAA5TyZKBZdrhcuv2JCja03A5T8Or+c0q13Op8V5SgSWENjv8soaK0tM433KrCwd2TWikCQJ8e1i9nylmWFB4rd1dI8YdIqp6/UvAqktZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8r9b1nz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8r9b1nz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E987B1F00A3A;
	Fri, 31 Jul 2026 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785503803;
	bh=/1LUinNR6bwQftO9dupmFVpcJuHhlSXMXq1yICjT2+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8r9b1nz42/RVOqAofPZcP6K00gzy5dXch8+ajkB/K4c2F8q5Ra1b1+rBw3hGv1uc
	 WQofUuOagQHB25I0g8bCBa88sCZYwHNsoEpozJFfXGYj5ekEpUkCH4bZJDhNuLDxjp
	 lFhMmjwhipNMB/D3prMBK/qdH7UNbH7bfXmHgkHL57PwuuTMcc7vPxLtZ0TqAFg9Q4
	 psIlHHZXOB0EdvMAbzqDw/xm2a7gOy6AIE7Hu/5WkZcOLJ5CCyHDcxeKhEfguig0pD
	 lOJfNaOB511tKXZtZZ8IW1WjUh1WrAfr0bY7cXK03she0HZsxUjnZeqIlMU0F7JvM9
	 GPMkPWIZ6OSSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/31] arm64: Use proper include variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731130902.654679-5-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-5-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:16:42 +0000
Message-Id: <20260731131642.E987B1F00A3A@smtp.kernel.org>
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
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D4

