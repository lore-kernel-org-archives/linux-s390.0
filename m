Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147C38C42B
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973799; cv=none; b=nQPcEa1D/Tq4WQHt13ym5nh5+YmfyUn0932Oqqb6mq3ysRonUgWWHz8O8OXEJZStSrmrJxQdkNySESth4Rt0ZEFRompr3gHqz52gBXCax9dfslMJg9APkRLQA9Mo7VXPkFFGt7y3NZ6btsA5XopHhzOK50tItnj+WVoCAIjkHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973799; c=relaxed/simple;
	bh=gN0AO+H7Nr57B3X9CS3D3XRRfptNlWFCT4LGLwB2JIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oyL736gbpztHsTbS2M2wZBumVvt2uHlvcn9soZfLavgJ3VyOF381Jiur2iEmRvVh/MGWnPWUkRZqkjgmLsWUAkz5fZgaoXgnlykQK9HSoq/g0iOYo9Y+Tr6GIbMhG+WLryd1j9LO+TKpjkeL0fRzEDhuiWHbcPhEWSvmzYn8xlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtAph3UI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtAph3UI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA4F1F000FF;
	Mon, 21 Sep 2026 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789973797;
	bh=gN0AO+H7Nr57B3X9CS3D3XRRfptNlWFCT4LGLwB2JIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XtAph3UIpDj2PktMdecIp7tywpCyNGZ97Wy2IwJc0xz1Hh7Q//YqVojsYzRc7CoKW
	 dtdI5O/3B1JoHIeHfdCD/AXnXF2O0wKIXYsnqK2vo6hN6QUFSKlh1AlaOOZaJNMoOg
	 C+ZT1pDbcsbDvd33UBkPbN3MBG2xc+FI3/jJMS08VFvcBx+flN7SME/4Ecd+5Aal5N
	 ceZ9AgACd4Sh9bGtFejwQSU5Cnb8xzuIynx8B3F/T6vZirCAVmqjS1ZLLvkpza2EVf
	 SzMeBlW1MbKDunVCrukbnJRQjLhHQFh8esDNpZ56HVje3M+gpcJNO1vg43j/ddoeh4
	 JFNwnT9XO6rRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] dma: swiotlb: Centralize default pool policy
 selection
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260921063628.362078-2-aneesh.kumar@kernel.org>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 06:56:37 +0000
Message-Id: <20260921065637.8EA4F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The addressing_limited argument to swiotlb_init() describes only one
> reason for allocating a default SWIOTLB pool. A pool may also be needed
> for memory encryption, unaligned kmalloc bouncing, or swiotlb=3Dforce.
>=20
> Replace the boolean argument with the SWIOTLB_INIT_ADDRESSING_LIMIT flag
> and have architectures report their DMA addressing constraints through
> the initialization flags.
>=20
> Introduce SWIOTLB pool policies and select the policy in the core before
> allocating the default pool. This separates the decision to allocate a
> pool from the policy used to size it, allowing subsequent changes to
> centralize minimal and confidential-guest sizing.
>=20
> Set the shared-pool state before memory attributes are updated. Also move
> the pseries secure-guest setup before swiotlb_init() so its initialization
> flags are available when the policy is selected.
>=20
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921063628.3620=
78-1-aneesh.kumar@kernel.org?part=3D1

