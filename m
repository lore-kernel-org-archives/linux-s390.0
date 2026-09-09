Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189E49AA3A
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944156; cv=none; b=AaGoc5zOxOF77U8P7seQCNicmepoI/INbIhnchSe3a5JuNu6BkfLVrVfy9QQoYbyNB89UrNSu0VUQlplgM0TxJm+W3IaWkfeq1Llcsi8CJ2EfdKaOz6PwRpVu9LIG8NZriPrqYBhcCwkgT1DFQHZa/qr7wPDN/A4Cd+VHIls+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944156; c=relaxed/simple;
	bh=Zh7Y5N+w0O0n8uuv0RYOVZXVAIyxkIPioHbJGU/ILA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pH0Yj7n4G7ezioKxe68rVMwUVijtDIrulQ8LESFLscPP+uM7ALQwne0cWMFmlvsW8tWVB/2U7ErQ/cutljbzyl8uTAw0UY9fooRCXofwqiURhGF1tFbqDXcflVRexlLx+jvfRBBPCHPLSeXZaHvs1XQXuTZZeFsX8PTQZrIFzKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zge6EB4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zge6EB4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77781F00A3A;
	Wed,  9 Sep 2026 08:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944154;
	bh=Zh7Y5N+w0O0n8uuv0RYOVZXVAIyxkIPioHbJGU/ILA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zge6EB4sbnj1i1VsxCf7oX893Q/GqJ7hrB+2WR6BENVRjaSdg830u50xLH++BYc4c
	 5vI0G0k2V2QKVhQm+GrGH3IDGwQSoCGZAEKlQekcx05SXp90aAY+FbePyyzbVKfCoB
	 kXltsOOEn+4dTCYzY3fxDD+7e0WcmE9ztetWuQ2kHGKB0sFGGxGKh/eUJtqvvB+CRX
	 sLAemNIXlErsyzedGLy6HRlZYjlU3x2p8sQb+Oz+yE8YipZjsHpKXXhA/vGKHYNupN
	 oCbhljejz78xvomM0z3bwv2WvQp9n9Xw4963k5uypQeq80mUQAuIw626L8UFFIEsw/
	 Wjl1Xg2ZOiUfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] sparc/vdso: Delete asm/vdso/vsyscall.h inclusion
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-9-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-9-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:55:53 +0000
Message-Id: <20260909085553.B77781F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The inclusion is unnecessary, remove it.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D9

