Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB004EB85D
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110889; cv=none; b=FvRD2tPsOTYfU8cm88v8nAFUni9I//HTqUieEai7vwgicj7qB72EnE2W+UF0AiofN1S0bjbLmwBQcziOHUEQUX6AZ5rhj1txbjXp2AmNmgO8gixqkae1UVEhhXq5Qba7PLGhvY8MZIOXuEylcGF2473AeBwKdQcAGA40wR35a0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110889; c=relaxed/simple;
	bh=YncZ1IiG1zU/cvvOvXte/JVBdE8H9YvelO3aEDEd+tI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q6F3uIIjCgxIN0c/fE8qnRliUsuhFcKefHsbg4IEK56u3dCCmxgQa1S61OL6gXSm0sUlnz0fdhbpXkmIoOwtX/v58PyGjaRJmZAF2Gl3yojtvyMBFCtdWe7L6n/pl9XHZJlW1jeBapy+tyU314yXz1+lDIvIeATy6i2f7V7MISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHHuxae7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHHuxae7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D311F000FF;
	Tue, 22 Sep 2026 21:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790110883;
	bh=YncZ1IiG1zU/cvvOvXte/JVBdE8H9YvelO3aEDEd+tI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VHHuxae7BnQEpntlp2kNn7KWuK8Om+eQL02wx2UsWcLpRCHGjYu5zOc4OBWW0E1vr
	 CbBldhdJ2zoHTyu2XyajcUri+sRyOxMjKO1RHtDKCJthcgtoLB9iVTHLx/+dLLXwY6
	 C4DF3r5oWOq7/u3z5yCW8xoTMaiGsZk9itr3r7eF/wwFmD/Zx9W3+VV2K7nT/Y2jm7
	 A+k1huRdsvF1hXX0Q9bsqSy5qY5nMx7v4JNHtcwFcvhC6fSdPNhu2PyXnjlnyZqS3+
	 PiWuGMMsK8OOv6sMnTMgRxcedCV2ATRQy8d1NuYkxj2D0gO99qA2qo5L2FFPYRyP0A
	 S8ov7OMOf8JYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/cio: Fix NULL dereference in
 ccw_device_get_util_str()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineeth Vijayan" <vneethv@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260922204839.965043-1-vneethv@linux.ibm.com>
References: <20260922204839.965043-1-vneethv@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:01:23 +0000
Message-Id: <20260922210123.77D311F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The channel path registry entry associated with a CHPID may be removed
> while the subchannel's PMCW still references that CHPID. In this case,
> chpid_to_chp() can return NULL, leading to a NULL pointer dereference.
> =C2=A0
> Add the missing NULL check before dereferencing the returned pointer.
>=20
> Fixes: 199652309a4d ("s390/cio: add helper to query utility strings per g=
iven ccw device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204839.9650=
43-1-vneethv@linux.ibm.com?part=3D1

