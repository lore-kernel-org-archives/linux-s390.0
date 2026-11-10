Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309712;
	b=KqBw9W1sftJ9tuVPWwug563KxQg/nVWCje83MVNqXCQvePAzbPHJUixb0eWDJh670EhN
	 8GdeAnPfPy2+NU2kuBQymBod6ECRjiD2fCsIe1yGvoJDwtislm4zWwXMPODzqdY6Iabvh
	 JJSvOgYU86wvfHvgioRkt+D0bczcUuPQKlLlN1ahVutKu2YZ8zN33VqUntb11wg38UK4Q
	 ZOT94uA652O2k+RpHMdyBK5rlSHa+maSsMm6/R6cHMtkNNTPEdn9CPmoe9bJ+Icc1kgp1
	 S1Wyve2jJLH/nr4FacSDGMeE9EbZ8/BiRa0zaldycgwB1xF5F2ynrVvsxr8JkG0iDTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eLJtqe7noHa4z1O2eDW3mGvyZa+Ag7QilTnTobebDJc=;
	b=gpBwl5spcWldUq5LeeAYfMbXp+vQ0k0xEhNMBjVeJqqICP7t1aUKOGueMjSPdDJD4aKC
	 sU7KQIqeGP4Wu8mYRkyWY0QSWOOkHx+A5c6W2TcN7oa2R1++lvHJoP6PFyMQQf2iyNdmA
	 MU+5gKJFqv5APGptPc+j/CRe21H3+lmReJTXjhlU9Mn0cF8nRiJiQ4Z0c9VGZMJod64ul
	 qmMBV2sX5G28tzHQ8Pz37szAiEhDBeYee5BgqHqMvqn48YU/uHGhoiP1oQt2dwYVzXyfV
	 4KrZmzBufB1frwnZHuQSFma3AhOm9313y7nmnSvJ9fL7Ze3iPbmftTvL2CrMtYv59dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBEOkYDm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85991606A31C
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBEOkYDm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A831F0089F;
	Tue, 10 Nov 2026 11:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309712;
	bh=eLJtqe7noHa4z1O2eDW3mGvyZa+Ag7QilTnTobebDJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBEOkYDmmDVJ3NVvmEvuprMyn1K/YUKfoaCunKo4Xi1qCSPm8DvmvBczqvT1kY+Jl
	 790VxpGlvlDKGCa5aC4QwXblfgMN/fDeOv0BZKqjfMoNqUIpO6ylaZjbyksjXeK3cc
	 I9e6ucnw4kI2f5MPTEI9RScZcxY8lCcR5naS6G8qnVNHzTFwYUc8bEAJr04gYAKaKE
	 XRR7NCd0D64UPerJdS6hVTi0lGKCQJfaGd0B73WEBS2urBJOJHVsj/MypOYscvodDK
	 qOB2AQr90EO6Jd2WmiRgDClmmYBGXY6UkuvrvPyH1mXyvphcGmVlYeUpJIWrKJTXbj
	 MUtvL2kELdkiQ==
Message-ID: <sashiko-outbox-206929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] KVM: s390: selftests: Add wait state and VM
 lifecycle tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron M. Brown" <aaronmbr@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110111619.61760-4-aaronmbr@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
 <20261110111619.61760-4-aaronmbr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:21:50 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add two tests:
>=20
> - Wait state: the guest loads a PSW with the wait bit (bit 14) set and
>   the I/O, external and machine-check masks (bits 6, 7, 13) clear.
>   Check for ICPT_WAIT and the wait bit in the PSW.
> - VM create and destroy: before the first KVM_RUN, check that
>   exit_reason is KVM_EXIT_UNKNOWN and immediate_exit is clear.
>=20
> Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110111619.6176=
0-1-aaronmbr@linux.ibm.com?part=3D3

