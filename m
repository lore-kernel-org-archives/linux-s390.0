Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB9F511215;
	Fri, 18 Sep 2026 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747747; cv=none; b=R16c7kLpiwVqom08nnkE0TCNkE4OzTxAHrkDsigquPsuu1hkiS1UaJ81O+da8YhJ5hlGR8hZG14WeAbAJIIlfrrMlR6PLYZrkMwb2nCiPTEyyV2sa3Pb96Af7hZFoIZ8xkqqUQhjvB7LfQVPRJZ1jIjFdit52vACejOg9y3twWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747747; c=relaxed/simple;
	bh=9h/8vPuI42EUW3jHnNQ7uoDbjNiePBL5KO+dZTZXZAQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mzCozTjAN7PaZKiFgdWJw85jLHsZJNbPS8ZalGeE5rAxLnqpkxS2KsJe7UYbUaSUfcXxx/M8oj5bL4OGmxbfTUnEnpeIpc22J4vU/3U0YUkFYtJEFczIGPZ5U0PSLzG+FmOJ2GeBJq6Lw/HwpvhblpqTJIXNbPiT62gMCXohxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDb7thmw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDb7thmw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512DF1F000FF;
	Fri, 18 Sep 2026 16:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789747745;
	bh=9h/8vPuI42EUW3jHnNQ7uoDbjNiePBL5KO+dZTZXZAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDb7thmwEOg/iQHCQX3Wn9G8ju/U2i+FZkTfmtyXjwy5DgHunEyEXy60DYk4MRHS4
	 AgNOic2aHK87udr9MpRLNqcXC6eO30W6HBdhFNZx2H2eHe9nNUTs0MiWBVhBVf91Gb
	 sz6Ukd+alzW6xgWCKG/iMbiOK3hLaP5KZNs3u9clZfEtGZBUsXbt2l024NLezYrlJX
	 B1PDHh7j+TD5G8kyzEU+PmB2RlAhuRgCda0oR8iqmU/6l5I1WC7oPrNh6MpBy+E6/5
	 +d+Bshxm4TaISZZf0lK9hOPhlU5XHVDz+NtCI+rYkjP4O4d5WeKb4TMlEpbEOWK45d
	 dbDBfJyVCL+Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 18/29] s390/tools: Use arm64 headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260918133107.1042730-19-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-19-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 16:09:04 +0000
Message-Id: <20260918160905.512DF1F000FF@smtp.kernel.org>
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
> Integrate this extraction into the s390/kapi target, conditional on
> CONFIG_KVM.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D18

