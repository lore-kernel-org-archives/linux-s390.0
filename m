Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD18374E73
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278525; cv=none; b=YsNKo8A1rJT4zxZT+YzfRHttMJxNOUxuLUuBPUoNIqWnUZKtX/8LuzfIDkPOupE+ndLaf0dXdidWTi84ZbqTsV37oe788dvLzx8KHl3RFX88bi73da3pFJvg5j6D019XPxQia12ItWfE6eCY4t1f3B68WzkvYZmaPW8jOLf0fK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278525; c=relaxed/simple;
	bh=pX0xtB7qCSGFOA6F9Aq0yij/LicnmQ4RwNCwKukEzDY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DqGtW6ALdz8Aum6Ux/OUDHSGr8HKEFswDziL+epNAjxQmYUw7z4o4ARTW8yJs48enf+6PWP0ezL5qyy3AoTQNrnNwyjt+2QgDyHVmHd68NADtk8qRV6lxddc6um+L8JeETtOTgnTuq4PAZODoXT4M2eqngVlgLQdd7D7p7k7DKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4P3jI4w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4P3jI4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CD41F000E9;
	Tue,  1 Sep 2026 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788278524;
	bh=pX0xtB7qCSGFOA6F9Aq0yij/LicnmQ4RwNCwKukEzDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n4P3jI4wxgTwmEBFOtXVI6YHPasoHhp0nvfUN6FsKtwNvBzL7ZNdmtaBNu/ABWK+Z
	 3fq5TescEhXZhQPdZFAQap1HEd9iU6OCc8LkJmk4fsVw4zP4haUZ7CjhUkszLTj8VN
	 YskHZTFB4pvL78gsXWEiYM5OyltZPbJ92I59IxOSvf61lbSWcG6Dfl5HeIcinZ8Euo
	 +hKII8bWsk8E03chMvvC6WDfEp5sFliCO+OUW1EtIEtiW6FkYI6jl+7x31W+uH8l1t
	 jYFoiwhweqHPIVtDadzvvVrXCkd6WVgNAFV5jcZA+z+elFPOADePgPJe6guiW6XXYl
	 Nt4phDc4o7fKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] s390/qeth: allow bridgeport queries despite
 OS_MISMATCH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nagamani PV" <nagamani@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260901155344.3561483-1-nagamani@linux.ibm.com>
References: <20260901155344.3561483-1-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:02:03 +0000
Message-Id: <20260901160203.E4CD41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When HiperSockets interfaces on the same VCHID span different OS
> families, reads of the sysfs attributes bridge_role and bridge_state
> fail with -EPERM if bridge port ownership belongs to another OS family.
>=20
> As a result, userspace tools such as 'lszdev -ii' cannot retrieve
> bridge_role and bridge_state, even though firmware returns valid bridge
> port data for QUERY_BRIDGE_PORTS requests.
>=20
> The firmware reports IPA_RC_SBP_IQD_OS_MISMATCH (0x0010) to indicate
> that bridge port ownership belongs to a different OS family. For
> QUERY_BRIDGE_PORTS operations, firmware still returns valid bridge port
> data (role=3Dnone, state=3Dinactive) together with a primary return code =
of
> 0x0000 (success).
>=20
> Allow QUERY_BRIDGE_PORTS requests to return the bridge port data
> [ ... ]
> Fixes: 1b05cf6285c1 ("qeth: Include error message for "OS Mismatch"")
> Cc: stable@vger.kernel.org
> Suggested-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901155344.3561=
483-1-nagamani@linux.ibm.com?part=3D1

