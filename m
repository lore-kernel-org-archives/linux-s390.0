Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCA421256;
	Wed, 22 Jul 2026 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740628; cv=none; b=Qugf8r4I2BDUvV3uzS2Ueewtx4xbpNwb5g3bFXE9bZLBuASvVHC2iAR2YyTpmrfRNIqnCMWprmYNQ+QJyDaR9SQWfwdo4yoUZS64qqQCDV5Aq+kTplU+YmfZY04wn/qL3CtjpJGPWMyUeC74Dst+H7MUfBgrRvX0BCzJCeEX+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740628; c=relaxed/simple;
	bh=bqX7XqaFZjnKnfkDTqOQeN12QrMPImvxp7G9+0vDw0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k8sAY579UGknvI0jTaTDm29YQtwh6qzzascYjTk+VewXV95+XandKHJITq/JiSQXvSNSk04CF5O7fMgzqmFoRffHGTIVRX6NrHD4JRB97j/O9WjVl5drb1pZbe0E5Ab8bdDFFJSL8Nv1h9FyH+djk/QvaUesI3gmjvNoxIMU08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSFNu502; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSFNu502"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB961F000E9;
	Wed, 22 Jul 2026 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784740625;
	bh=bqX7XqaFZjnKnfkDTqOQeN12QrMPImvxp7G9+0vDw0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VSFNu502ALnOgBFiXDeBl3QcEmn9yXF8vvratgYOHsYjuk+B1zApA10f3V9mz+Kzm
	 zES1LqWCd0DZfnad2fnFKTqjDzA8rWOQQQWGTqPPgAkg6RsygCQPBuK+HyBXcyL+RF
	 9aZ6eg71SnKw1C+fpdSUYsAArdhDoXlgz164HHRzg6EX8vvTAX/wtwTwaiQBVPB3vw
	 tksJdCz0XBwsKah5JfaOOkwwXoEwOlbDiAg6W4bkm2KuS5M2OTFi5ZmcInJ+dC8ukD
	 9bMr8t/l+J+LvdFyXhK/lXG5PWfLvkfG9i0mLUu/XRm+Jb63TMlAjQo5duo/qBA+82
	 QGFJ0vPrG13Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] KVM: s390: pci: Fix missing error codes and
 memory unaccounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260722170621.1686-4-alifm@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 17:17:05 +0000
Message-Id: <20260722171705.7EB961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In kvm_s390_pci_aif_enable() two error paths failed to set error code,
> causing the function to return 0 on failure. It also failed to rollback
> memory accounting on failure. Fix both by propagating error code on
> failure and calling unaccount_mem() in the cleanup path.
>=20
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disab=
ling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722170621.1686=
-1-alifm@linux.ibm.com?part=3D3

