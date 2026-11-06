Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992995;
	b=HSGNY6jKrmFNZmdj9xcFrktIf9iR6gzl/ysPZkeZd+O6JlLjuq9iQRyuupV/hM481eZD
	 mY47uon75ucsER/h5R0Wi9J0U3NBU99fitS3OgWgOaSfCprAnmbw2OVx135qvXo0KNfSw
	 3NbJWVvcYzdcVYkLcaiDE8UVm5H9KJdwMHJkoKeqfRxEXYLq3THkzzhpQCtI7oC3qMncs
	 SLrMwNpyr1sETZZdQftlj61F4d6ZXB7PECDO04v4508KPva9eERJOSFGenPvLf1Pwt7eF
	 T51bUwbySqtFA9knnrLYUAAO8wE3V+4vSzlrsRknnKweVvko3phW6/bCAaqN2rDp63Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992995;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c2UT/yaKheu72vXLlEmOUU9rxtczjqmzoLEUK7r4Edg=;
	b=rs9SnzGJ/2V0hkFzaobJiLAsUi82zu0TleHDa7WsuS8RaN+6ygalJniTnwNgN2DQ8jhp
	 NXZ2IVXns2BhHr9CbIr1kdruLiRep5zyo+UVs3MyAd9FwuLSxyrfQebOr/UrdFOqneOaI
	 LCEJTXyFADLU7KE3SwDzrza+Y1iGRnPud8vmgVA2OnG2ABhFBvsBSLllaP4tb7j3j6qou
	 ALqRoRIEvOUgSVrBjqtJjfqXhxC5jpeTLH3zXYGRakbS3/lUTygYG+zG51n5PcuyuWhoq
	 0LxULj4tUkorOyLc/fn209EK/OZrmW5jjDB1c2agqzbPMbqKou+k+JJ8AQDd9xEw6HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jD4BQTev;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B5B606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jD4BQTev
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746FA1F0089F;
	Fri,  6 Nov 2026 19:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793992994;
	bh=c2UT/yaKheu72vXLlEmOUU9rxtczjqmzoLEUK7r4Edg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jD4BQTevTOgVpF5NIwj7aq2vS+dbyRZLSlNJx3yzul+c1MRxg5Dld95V7TMhrMRVg
	 39ctCGJoB/XWDvX/jMZEp/DDZgK+2tzhxynHQQk4MqLPxo1QEEiHLcEhuisAabqq4E
	 c8XyIMQ8vw1mLyAq82b4lHKJwWqxQWdfIQIepx5mMcVPQrmZh9ncnnDKDx26ySUKVG
	 1EPKIzjbI9r0gr4wT1IqaeEwKKAzYZw/yvo11OpLjfbgYMOjUT21KAZ/EffDcZ57dP
	 CYfrU8xsyvNG3l6xfcnWLxNKoEET9/xq9hFkubONYby/atR7QDDADl+Vpn8T8FfqTm
	 eWLKWGk6ZUuBQ==
Message-ID: <sashiko-outbox-202149@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/23] KVM: s390: arm64: Use QAAF init save area
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-18-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-18-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:23:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Use the (cached) result of QAAF fc2 (Generate Initial
> System-Registers-Save Area) to initialize the Save Area.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D18

