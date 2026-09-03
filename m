Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84E33260B
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422349; cv=none; b=JtJNkmdgl/qed8NaY3s2w5pD57/Z/iJ5U0oXfIZVlSr/X9xruMDlCX8iqyoGMVtueoAQPOmWAWC7iHbKaksLUTwmPBqbEeFsIaQXPRtSqyoJUaskcpotZPyNt/S9fhq2BJBCdrq/2keEa2b+cDTckzvex3bsS9iHw+1zAqRppyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422349; c=relaxed/simple;
	bh=BjnsTSP1nGhJDPXU+xz1tvi5x4oFVXlTIwaSPnoJNlk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=je/HHlv1aF3DBN2qpWC7gvyf2wzyRUHq2i/ciI6GpI+9UsgNUhD+lybGKhTgqAQG5q9iLQSStaAzO+OaNinDxqlX5jSIY7xuPt4efj5YReeP4fhWFwPtsJy1sjX+hqRCbITgaLVLV9buDUgSR606dE/47OwXx4clpMbwjVuVJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksTN+oCa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksTN+oCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6371F000E9;
	Thu,  3 Sep 2026 07:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422347;
	bh=BjnsTSP1nGhJDPXU+xz1tvi5x4oFVXlTIwaSPnoJNlk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ksTN+oCaVbwA8N7ouie/jyw9w2f3w5y6MsTRHpUA6e0ofjuF6OMtr0SlaCx+u3gky
	 /0WLZzg2irsdvmZbVBMUnrBxAiTDA5C5NQHOAQcdlAfnuOMXWjg5kDOyuXViLYgiZp
	 bdle9cMfkRjTWNdpJRD1+dEqDqlfCtrBJM5W+R6hJMVrEwihgaCQHK+vI9VH6oqNgg
	 qmV5qM3wHnCTNtAck2bVrMTzts2ibDU89eu3iWfiMUw/idNPE9JOHtUKOzGoVhmHJg
	 o/g9qIn76jV7F897pb3r7DuBSWo2IOE73EdtKmQSD9gVlayVUas51iVP6Ox9WbSVmT
	 naK4HmCBCb/bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/15] LoongArch: Remove AT_VECTOR_SIZE_ARCH from
 UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260903-at-vector-size-arch-v2-8-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-8-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:59:06 +0000
Message-Id: <20260903075907.5D6371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>=20
> Move the symbol to a kernel-internal header.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-at-vector-=
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D8

