Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B6488741;
	Thu, 27 Aug 2026 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846910; cv=none; b=IA9tUm2LF7/Kzc/bf5GZcC0F1/P1QK31YR32udrGlQgZwNEdnk7L5j3byASyJQlI2lSgFyzkVGM0Lsxk6CiFSfuvzYMAQZ8jy4FHaEMPZx1UVmiM/SNXbCuv5pVJv7zbbCJhKWIJYsiOacto506qJEb2oQ2JOeLhZGr0cYWZnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846910; c=relaxed/simple;
	bh=75dHeeFAqAxDlLDkzTpjdQyVKk8edvvTY0PaysreWb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YMYYVOUcIiytXff1yujTdiQPTHg+l3hWLbnSCrhd2Sta4V5zCp2eWX1RnNMUuvP5XYhoCY0zFH7GYG1zyFVMT/J67Fcp12uPM0xqU9fsy/hie97hj3D/Xh6MwlhjalXtdc+WsJax+Y+lNnCznIxZpVS++4OotweR+MiqoyHsMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvQ6uPTs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvQ6uPTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415A81F00ADF;
	Thu, 27 Aug 2026 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846908;
	bh=75dHeeFAqAxDlLDkzTpjdQyVKk8edvvTY0PaysreWb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CvQ6uPTsH8mZmRVpae5Za+wD+umtp9c4ncUZnGz+xk0+uJOUrkeJmD+KLgOt1sbbg
	 AcYIJfWAFTjr8DZSJH0+F9ZI8LnGmtyTv58AS/N39wvFt23RzMNIwMLDmWU3dr/Ubo
	 /nOV7ruyGQp5gRNbuILua9EByon6NfSSYfsxQCF+6IG6nX/we24kibpSdQaFvTsIzA
	 ZlwyvNxICzB4aulBHP6u86j7LSLNdVHnD8u9DdC3xGGgSnoX8X3l6kM9XjYssEANrC
	 pHmjRf16tw5Pi+e41z2YY3BE/zpGPLaOZkg8K6eqqdmh5BiZaT7U04GzjaYpzSig0G
	 fOiscz1Gh4zVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 20/21] KVM: s390: vsie: Create minimal scb shadows
 for not running g3 blocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260827-vsie-sigpi-v6-20-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-20-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:08:27 +0000
Message-Id: <20260827160828.415A81F00ADF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Instead of creating a full shadow for vSIE control blocks only create a
> minimal shadow for SIGP purposes for currently not running guest-3
> control blocks. This reduces the overhead to shadow the whole guest-3
> configuration.
> The minimal shadow only contains the information needed for SIGPI and
> SRSI. The shadow will still be recreated fully when a vSIE is entered
> with that SCB later.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D20

