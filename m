Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF243FA5DD;
	Fri,  7 Aug 2026 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096786; cv=none; b=UAQT0gCzQjBqbSuKWD5+9G16TRgV9Y5aePFn4wf/kHTq7KSJavEsQiHV7nYdn/iKZaw9U9rd39UgfaK9BTNCdV/yH4TEB9cSRY+gWvo1GLoBdwDpDpvlFDAJ5EzR3gBxDQk0dPhp6rsPsbTWlS6hkvhUsyc3oNuyht6ZkMerhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096786; c=relaxed/simple;
	bh=VNTze01ZVkv4Qlq5V2UvMdlnKoy/E9vHc88s59ILYLc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HhUVJArArsLbjdYI+X+xmnBmnY4MH+RiCI5pNIpuekeMZ6V3CTjz2rTFrzzsZndAq4WfkxKVZLulxUn5m8BMXezXs0T3zFhE98jETXIOoeHmSYU+sr9TMbe0ebUGiSFEDUmEl1NaVI5udKuvbYB190DVq4JrHJYa3w6uIv0cswk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sqh2Lb4c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sqh2Lb4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CC11F00A3A;
	Fri,  7 Aug 2026 09:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096785;
	bh=VNTze01ZVkv4Qlq5V2UvMdlnKoy/E9vHc88s59ILYLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sqh2Lb4cTJO8nO1kosEi6aEwJLjVANH9nubrqNCDd6RMwSQG8is27MdEwq+ZLk1Wu
	 DUiy4jUG3nmuOe6ORC+Vx4q8SI8xqBEjiUAXlWTrA8YlybenXULUzhZpRTtE8JF8zi
	 PWhfJlJXZPImv2WrUUdHesgoT5Gg+16kb+gdMP3nLYyLUOHeDo3LCeu0/D4oor4RJb
	 R8WM2b06p/PnVVehjK8aVbAbVfJ7xxIJn0YVDkMHeYD2js4l3heLc86d63nRoOiwHy
	 sW4Mtg3EwSeaPLOV0vllguV9fNLnnih8x+4YR6xAib9g7xBsDUnmn42RjlI/4HQYgy
	 LsU90OUscd7CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] KVM: s390: Remove double 64bscao feature check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260807-vsie-cleanup-202607-v1-1-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
 <20260807-vsie-cleanup-202607-v1-1-b18659b55e3d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:59:42 +0000
Message-Id: <20260807095943.E1CC11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> sclp.has_64bscao is already verified in the guard clause a few lines
> above this. So we cannot reach this code if it is not true.
>=20
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-vsie-clean=
up-202607-v1-0-b18659b55e3d@linux.ibm.com?part=3D1

