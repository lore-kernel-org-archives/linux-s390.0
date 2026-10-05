Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5D153BE9
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180164; cv=none; b=oT7XHMjsbNHdq1BOPD03O3UE01PAzBsjLYMdVOUBYrNgo9Xr1LIsoOtJ6KxAbqyfcYy0cif8EkS5nhL2gBs+O+PDMar0kwul1BZwGJzZdV/KGqfUusVh/tYJDCy9WVFQthageKtuPo69Mgy6NJN8FA2GWQBiTviWnxzhWGq5Aws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180164; c=relaxed/simple;
	bh=FvGxl6gQiR/qXLmhVgPUyv8gQ9HORczX80t7RmadTsQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WFDn44sERSAhVDyl7tFPX8OVqHyP4w7BQbJtS+41/tv5kvV9IY+QHhjrgpviQnGTiW21V2I9Kj9KgBF30BpCmFVW9BooASVItoQBMIygHJyGIOHjypnizdPX/8iPkQAyTmTmsHfym7OT35uo7XvEN3J8xrU3oVnzj0DZgkBLwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqavqnyJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqavqnyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CDC1F000FF;
	Mon,  5 Oct 2026 06:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791180162;
	bh=beeQ2OMdVlTqR/JnRT2v32oqu7ryC7ThI4ShbJ9z3WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PqavqnyJqd37O9Z3dHcLb7cORv77xCgqxQgNbwthvFoMsB6RzyNKgiMNc6Rn2b+V4
	 CXFbSTnBo/uII0eK31EuAjOIq5qmG1OcDBKAQI8orbk4w+eM6oX27QteBxG0UFx6cz
	 bFDejDcJzP/FxZTXTkaSeiRVA6mjOR7OwjBE2fKjzvp2mn9o+vz3n4z7TJYj7+8LmC
	 jVbLlA5RgcbFRHyI2PJ6MlLWCm/GNkcp1d3A4n6mBA3rkVyHyFgXBR/LwNJkVXIHAi
	 4NTnzceMJMflMampLaGt4+NwzS+bVFvhHiXRTuqR82VH4acJ46wEASMBgvrg6Sovox
	 QzSKMMKqeui+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/3270: return -ENOTTY for unknown ioctls in
 fs3270_ioctl()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shirong Zhao" <shxzhaosr@163.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261005055825.20-1-shxzhaosr@163.com>
References: <20261005055825.20-1-shxzhaosr@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 06:02:42 +0000
Message-Id: <20261005060242.92CDC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> fs3270_ioctl() initializes rc to 0 and its cmd switch has no default
> branch, so an unrecognized ioctl command returns success without doing
> anything. Follow the ioctl convention and reject unknown commands with
> -ENOTTY.
>=20
> Verified against Linux 7.3-rc6 (a90ee4305c4a5df72c11b31dacfdc76e00fcf78a),
> the current mainline master: rc is initialised to 0, the switch covers
> TUBICMD, TUBOCMD, TUBGETI, TUBGETO and TUBGETMOD only and has no default
> branch, so an unknown command returns success without doing anything. The
> file is byte-identical between 7.3-rc5 and 7.3-rc6.
>=20
> Sibling audit (same snapshot, all NOT bugs -- do not re-report):
> - drivers/s390/char/keyboard.c:kbd_ioctl HAS default -> -ENOIOCTLCMD;
>   do_kdsk/do_kdgkb lack default but only reachable via whitelisted
>   cmds from kbd_ioctl, harmless.
> - drivers/char/nvram.c:nvram_misc_ioctl inits ret=3D-ENOTTY, safe.
> - drivers/misc/tps6594-pfsm.c inits ret=3D-ENOIOCTLCMD, safe.
> - drivers/misc/pci_endpoint_test.c inits ret=3D-EINVAL, safe (error).
> Only fs3270 inits 0 -> true positive.
>=20
> Signed-off-by: Shirong Zhao <shxzhaosr@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005055825.20-1=
-shxzhaosr@163.com?part=3D1

