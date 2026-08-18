Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD392772D
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 04:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787026742; cv=none; b=qIpVcdbl5cXu+w4bM97ceeS0Ca86YV7fb56Sx/uAqG2pknW1oeybg4/7KOXcBzA/3xs630NJEL8xPWeR5fSOWqMcJLkEGui5+myD6F+wEVqqU20RPaQUDiXte7js17PuLs0YWLGbo/e5tp+bHxVVq7LWnzZN/RPISS2LGwF6oXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787026742; c=relaxed/simple;
	bh=yCUIRmZbL4LkLChBVFGpHE+KtSp1bplB1vIknJ+0MzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aZBWUxQfUk5pniD6a1yvkIEXhSsvFpiynITmPLF3TyoqRm7RvLzpRjw+gvJx6/jX0VKCrEYgdkkKnorfMnVp6yfQzbjIZOn/tdvjMKFVh/8CXzBy73Jg0CSZfWf9EWwY+i+m0GTx8RaeTe9HFORbNZDpOF+u7QDWsq0RpVI0kbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4QLUjeb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4QLUjeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43C61F000E9;
	Tue, 18 Aug 2026 04:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787026741;
	bh=yCUIRmZbL4LkLChBVFGpHE+KtSp1bplB1vIknJ+0MzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z4QLUjebSuthpjj8tL0LQYw44zvhYZAiRd7V+yx2gkGq6+B4dSPV7m8/bKDTcS/M/
	 LwCQsC7pKYAQzzVPhPN2uil2KbfHb52eqVPDXmz6sYkh9Bru5f07XU0slc8/MgKzHL
	 2S6MhKF9/IS7XS1ZfmhWCaW6X9P5Sh9ShzTPisb4n6WR5cLrOy9qDEzDHM1+9Zcn7/
	 sc/kFQb797B+qKSOPRSo50ztG+2GQWtDWe22NZzZ8bPKBVcOsXeabCugYL1tmgSenj
	 1nLZQ2QV4XMvQSd9NPjACk/IsJ2/ytRfXwffuS661D9qeRwLjlFoNd6Ytg7eien6qu
	 iEKmNiIak8ucA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC V3 3/8] loongarch/mm: Stop using pte_ERROR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260818040041.1891769-4-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 04:19:00 +0000
Message-Id: <20260818041900.B43C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Directly use pr_err() in __set_fixmap() and drop pte_ERROR() which helps =
in
> eventually dropping pte_ERROR() macro across the tree. In this new printi=
ng
> __FILE__ and __LINE__ has been dropped because they are always the same a=
nd
> don't really add any value. The new ptval_to_str() helper is being used f=
or
> converting pgtable entry value into a string. The error message itself has
> been cleaned up as well.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: loongarch@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818040041.1891=
769-1-anshuman.khandual@arm.com?part=3D3

