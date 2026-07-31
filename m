Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92B543F0B9
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512774; cv=none; b=S7Vxh9Ez8H5taacrNrWKLgG4QarLvfbNsSQubGtsSsrkn1ICEYwkpHdpBnomeoGEvw77XU7KftydfNfHUR1YIEnWHF/aIhFIeioduNRz3M/cyYUFSLZMEDKXIjRf5BAN2Kb9iZDvPOltmPoXiAymVc4Y7XCTp3xUgY226n8xVpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512774; c=relaxed/simple;
	bh=4iS8VlBa918wkdFXvn/tv6Ekw8tHmhdMYFSSBSNvmCQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EROWVBYKyizWE0iOolYce2J6nX0dOxtlNfxbwXLb9r/1hjcTjHTEbDypXrCbuLlmO0EdqttFwie+9wgNbw1GCFgSQdIEYNwbMXWE09iAybD8mxBWkv7W3yNmkNT8LO2C1BDsRHDYmnSvcbyqkfUgmcwPoZLLP1ioOEnM7WaD/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKbKosoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKbKosoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D59B1F000E9;
	Fri, 31 Jul 2026 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785512772;
	bh=4iS8VlBa918wkdFXvn/tv6Ekw8tHmhdMYFSSBSNvmCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nKbKosoWt3ZMUD123YpcFW547VWwXf56GOFURnC8AUdJhwUCJFPsLu4BU9x7jaVa2
	 3xmzbIr8rO2d8xtbl+eQCpP0dnW4Hj6XoqEuxnGJu62jYE+3523zaRGx/NhYygR1V+
	 CR85XxF4esrp5S7XhZBxFzC0j8ugIQHOcz45WqOvu9Galpcx48b0LDBvnsm3GasODG
	 4fvurkvlvQXi9AsNFHRzJqGTxH05ibDWeqfHJ+rYiSTBf1A6dDvyosPw7tbEgoeSZ0
	 Y7ySqwXfPRQxFay3wMFeSxxdFyyeCwFV4XT4HE6e4NFs3WW/AUrdtLoVmG7KFtJqYp
	 F86ETRAKN7nqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/17] s390/dasd: Optimize max blocks per request for
 track alignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-4-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-4-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 15:46:11 +0000
Message-Id: <20260731154612.1D59B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With 4096-byte blocks a full ECKD track holds exactly 12 records. Lower
> DASD_ECKD_MAX_BLOCKS from 190 to 180 so requests align to track
> boundaries (15 full tracks); full-track I/O is more efficient than
> partial-track writes, and 190 had no alignment significance and could
> let a request cross a track boundary.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D3

