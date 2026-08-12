Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F703346BE;
	Wed, 12 Aug 2026 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549952; cv=none; b=eNtOVoJA6w8q6WBII6H8Z8UMZIJQ/jK2RjskRr/ubj+6PhhsYEDbjDgm7OTiBdd188HJcsseNGDlbLtBjY7vQuurd4OSK04xtspGVblEyZ6F2f678DDFDAMme1S0UGt46GCl5TdSsL7ejBy8DYIRKAIoIuIw7hSokHz+Cyb9ofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549952; c=relaxed/simple;
	bh=TuWl3OERCrcy1g6oa1uFxMihHC/xFFMM1uq1D9Fp3Z4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZHbHxQUu9A1WJ+SLxQPDvL/jKfAVCnS5kxr36SQbY2dx3eTrH041vhAEd+7NBB856253drcHvGB+TxBs8qh7mMIH2ySvwLl5+EheLBP89J8ievGgqegakQo3FptDDrt5p66T36lV5ko9Ap+LmqCFZmeH1Tvh9gOhKKm5HqctOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkdaWzsM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkdaWzsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8397F1F00A3D;
	Wed, 12 Aug 2026 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549951;
	bh=TuWl3OERCrcy1g6oa1uFxMihHC/xFFMM1uq1D9Fp3Z4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KkdaWzsMcA6E7n4zVXbrKOivbbGQCw4D9dVOT6yHnpcQOJxlWk/GFdB1wzmo1Od2D
	 aOJSTfpA8PR5ntTMZXFLq2Bsg2a08gJlAQSzta8+0rFWfWWRsoCo/34NfGwp79tNCX
	 wX4c1n8rk/hxGxysCPwmuxa4IgdoOHZLKoxLON7L7RLWauEQnx0SURtMDU7whnd4bC
	 w0obhBPlisJ/iPPnzLiLKx7WDym5qImGqolWgKy9MxA32lqAG9hNSyyQjgR4hUEtp3
	 8MOqE7zRPP+8uvjR6nk7lRAppbzlb45F+zAwouogiCd11LwGnNBvkrohhp0dBxPbkh
	 wmeyW6mPiKSSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/33] arm64: Prepare sharing arm64 headers with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812153631.3376090-10-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-10-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:52:30 +0000
Message-Id: <20260812155230.8397F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Prepare the sharing of arm64 headers with s390 by moving a few
> definitions inside headers to reduce the number of shared markers.
> Clean up some includes to further streamline the sharing of headers.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D9

