Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EDE43C04D
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790247572; cv=none; b=QNc3AcGxP7O7urB0UtVGcav3mumq7gBrHB+Ck8Nxvcv8ta0z8lm0sElFkI9w6+XKRxtck2V7PgmOm/042sHKTYP6rWKf3g3RBJr1aTpe2GYmWQr/sdvsnefSdMDJ7fRK8vY7yBDaSdGI84rVXpIY/wNTnjDNku7pmDoIq6KMboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790247572; c=relaxed/simple;
	bh=c7gRiWtAdCSnhDeJTQRmVQMG0vhieqjwQA8l28EKLUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e74BSjvRnMajqgNeC6q2o3EtlsEjRmR+tsLwa8Q+tHZn5WFaXAWHrufv2xTdQ7KDVzX0QnzNumv3j88XnhHACWsCCyonaOn1JR8FfjuljjVLddvn99ZeobQqfnWRSmr2FwGzjYoA5CRfl8lxDRNbQXdl4j5t4jecvoiZ1mUovYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRQzx0wJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRQzx0wJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638771F000FF;
	Thu, 24 Sep 2026 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790247570;
	bh=c7gRiWtAdCSnhDeJTQRmVQMG0vhieqjwQA8l28EKLUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aRQzx0wJt/UYvATV/m8+1S0DFN1s90jU09voxj05d8S8HjCMdKeXyZqlKwqctxuAb
	 CdkU8dEC+Q6TIUDRgfwcyT4IiRs1fPlxaDXVaISReExZTFjVcWIXOY8idZApJSGzTR
	 IHj55wlLwOhijMQtvBINqgWYcL+uknua4OmJrzhz6DhqMcPaRHxbzajCLveUpsPi+/
	 MTF72uvbVNnknlOD5jaLB9fTW/R9E2M5JNWEkH7rwXybpJU/QN/vPDnnQstqzHxwFC
	 1WMrU9K3bs64CP3UWy22+BRavnHEX0yn1gvTxfuFBa7GLjzTr8SJeCAH//jVUp6Lbg
	 xkoogLdXJGOXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] s390/sclp: Implement resize for sclp-vt220
 console
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maximilian Immanuel Brandtner" <maxbr@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260924104732.1978942-3-maxbr@linux.ibm.com>
References: <20260924104732.1978942-1-maxbr@linux.ibm.com>
 <20260924104732.1978942-3-maxbr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:59:29 +0000
Message-Id: <20260924105930.638771F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add support for sclp vt220 resize events to enable host-initiated
> terminal resizing when using the sclp-vt220 console.
>=20
> This allows QEMU to dynamically resize the console. On older kernel
> versions, these events are safely ignored as the kernel drops events
> with undefined tty codes.
>=20
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924104732.1978=
942-1-maxbr@linux.ibm.com?part=3D2

