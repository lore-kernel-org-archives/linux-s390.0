Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4744606C
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515985; cv=none; b=GdOPv6xNn+Z9DeFKDfJ+C7RjyDG6IOHqdmyyst6GWNq5mi+jWpOkeSM0c4KrUcxJusXOqhs7f5peFB7zz3I/XGcH6Rih+ZvRnYP8qgpTRCmnGLKAw0kk1WYTnJW16zQoFXyhx89fCMVJ6ODGfWWk8pxs6//6flv+i/XZ94h/q7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515985; c=relaxed/simple;
	bh=j5hKuYW/ghSJtGtPpJdLtoWtKYMyjRTtrECIkh32SP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dOZ3ZBxJ7fxoSXQN7Xzb7K1zd+diEADl3T3wM8RhU9k/fMDaTSfTvMYD9c54mi+FuEJkrperETm0eLrndrE6XybAb79GTMn5OzVoCewThkLjgboXd7eEJpMlMY8WkTYWvmWJnmn+e9DNj2cwMLP6Y1Ebfupi/9Pu2lWaso039h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5hCnaba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5hCnaba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1FD1F00AC4;
	Fri, 31 Jul 2026 16:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515983;
	bh=Q3rqTLEuwzlFBgr2VikQHyuVhfVLSflYaQANNBYjm8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5hCnabaajB6pMT7JrjLrRncuZPf77nnX2xswBbX7xYqeZcDKAQuP0zOm5ohZWO5y
	 lxijSSU7aXl5ZGh13kdiltk4yiYjdbGBGByFp0N2jyP6FoPv/7zeQi3nvvIrYWkcad
	 FyKT7CIjHQrjKUtmneIQStyLVyvjM111XLlZ+1uAgxRDQsJvPVZgoQrleoJeKfzvP3
	 Ecnfa2m7nCpOrJnP9vIfWwgLocXIWwJzWQS9VRBuZ4XmJkb+aA11LP0z4Sp/UJ6nZy
	 fYb4WxizVNcvgb+8BhMFEOOijhjGHLpbPK4ZHiwl1aq4fd3XfXEnIM9oJoR7kqfETS
	 JJX9pDfNFSx4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/17] s390/dasd: Report ESE capability and format
 mode at device online
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260731153842.1729627-16-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-16-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:39:42 +0000
Message-Id: <20260731163943.5D1FD1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the `BIODASDRAS`=
 ioctl crashes the kernel on DASD devices whose discipline does not impleme=
nt `.is_ese`.
--

--- Patch [15]: [PATCH v5 15/17] s390/dasd: Report ESE capability and forma=
t mode at device online ---
commit a8b5bcde61b1c7e9effa84a4b07196f1129e6ac3
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Report ESE capability and format mode at device online

This patch extends the device information line logged when a volume comes
online with the ESE hardware capability and the on-disk format mode. It
derives the format mode (full or on demand) from the on-disk format label.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 8f7ffbeb9a6ca..a7d874e79336e 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

This isn't a bug introduced by this patch, but while reviewing the ESE
support I noticed a pre-existing issue in the BIODASDRAS ioctl handling:

drivers/s390/block/dasd_ioctl.c:dasd_release_space() {
    if (!device->discipline->is_ese && !device->discipline->is_ese(device))
        return -ENOTSUPP;
    if (!device->discipline->release_space)
        return -ENOTSUPP;

[Severity: High]
Can this logic cause a kernel panic if a privileged user issues the
BIODASDRAS ioctl on a device whose discipline lacks the .is_ese callback?

If the .is_ese function pointer is NULL, the first half of the condition
evaluates to true. The && operator then proceeds to evaluate the right
side, which immediately dereferences the NULL function pointer.

Additionally, when the callback is present (such as on ECKD devices), does
the && operator skip the capability check entirely? Since the left side
evaluates to false when the pointer exists, the right side is never
executed.

Should this condition use || instead of && to properly check for both the
existence of the callback and its return value?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D15
