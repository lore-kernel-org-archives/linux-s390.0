Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F85A25B093;
	Mon, 31 Aug 2026 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203919; cv=none; b=CdmSA4KeTGsMlAd1K6OVMu+Uuq2CNCcc7yBov/JGzT2vF8lQPO4Ii0wTd6j2WXirLBvwsWMhJHKL9UOBqESUxhYBLMdSbrMAqehC7G02tYqXGI5tIrueF9rQCf6YG1PGHgV0JEDIXyoIA0+0tR6Oe4lNelSyLf2lP3eJ0qpTgwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203919; c=relaxed/simple;
	bh=nkQw5gyBYzKIMolHlwd6hw+1nIOh3N+/j60aR8F06f0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZHIQTpbiZQRId18Lh4TsTWFS28zlnKis1fmmDLcYhUeYI/EEfqH/DJmfIpPiQslGkftSyUV1Udz3f3J0z0R/niLQFZGCy1z+sYIL2a3u8w4/bmwBTLBA6m3mIUPITJesA9PGmNR3NK4+PmYkbBvnBdlQQquKmTzuqsR9bCAkAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxIuC1qi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxIuC1qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773191F000E9;
	Mon, 31 Aug 2026 19:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788203917;
	bh=nkQw5gyBYzKIMolHlwd6hw+1nIOh3N+/j60aR8F06f0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxIuC1qiD0aF8h2bn5p3zylMH/XT/LoE04WJvUBE4r9ZKoCn9FhpvN6dMlifBSpQm
	 OaWBEY3pKa7FOkAilOujmktDipAozO15lZTCtFcfH8W+LdV5bUhg6m0Oi2I71Pg6Lk
	 wbyKB3Ynca5VDIK6wPXLHH13Un3YLv6GPZJawD4dWYaC44v/VBjh2h+3f2aFZrZNGO
	 k4BuFMWXtXSzyOxzy9AtBy+W2RbCnVQVo5Fh5tRnyDUvzM9GF94FxRNhbAw3doQObt
	 dgAgtfPmNMck40bINvSzFTg5LrB0UWVTLCz06okXzrGEwaQcI6RHjaBn3jsIkTchLw
	 rJsH12BjEAGhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/23] s390/tools: Use arm64 headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260831144802.834315-13-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-13-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:18:37 +0000
Message-Id: <20260831191837.773191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce a flexible system for sharing ARM64 headers with s390 KVM.
> Selected arm64 headers or snippet of headers will be reachable by s390
> code through asm/header.h.
>=20
> Add copy-arm64h.awk that detects ARM64_S390_COMMON markers and extracts
> marked section into a generated header consumable by s390. Falls back to
> full file copy when no markers are found.
>=20
> Transform copied includes by replacing '#include <asm/...>' with
> '#include <arm64/...>' and similar for uapi headers to ensure
> correct path resolution on s390 and allow for a clear separation of s390
> asm headers and arm64 asm headers.
>=20
> Integrate this extraction into the s390/kapi target, conditional on (the
> not yet existing) CONFIG_KVM_ARM64.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D12

