Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625086;
	b=3gNTBZZGE4KsinABetJMz9Hs+J1ZI9bXdvI0MdwZFELvLNpPad5NW4OhwkbuMGic88bA
	 Tg6YcQJQgh78h4o8QcYPSap2evBfgHuiD89Kt7OOJ6iVy7VwejRT1vQDk+PsiqE3B5QoM
	 BvIopIzzYQJhlzvV5h/lx4qVUYsvH3JlDqGI1XX7J/uNLPCYeRWepr60NlTU/4ZqvSKzR
	 mZt0L46b202f9ilWBUVcQF5nyXRyztRCgQGAvlXMglVwqZ/V7WVLVBel+FVtGFadqMGBi
	 3TCoAa2aS3Rteq3b7mfNykoSiH858924uYRf/uzy+CSlGzjXOie3I5j50yN6oaop6jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625086;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s7ytD3qruX0pLO0p3jN8uu2pJK+W0G/dlm92F/CaYlg=;
	b=C2ZGEOpEjPBcj+UmLP5i84azzMc/l6wpFRxKqtMvhmK8eLKud46mGsD6W1yvNsn1tFXU
	 JOKh1824IwzLH2STQXQq0/zFaMtf+aA/Irj2O2p+JBPjHSkyqmJCBKb55m6SDuuP/wA96
	 iBKwI0SLgogFNdjt5BwL9tKBzKA6AL+od+TzbERTGaQ7vmHUTkgxv9vAcfptScCgmQm1K
	 vPSeHzlVtp4oe5JIBS0Qb7sz3h+shFIahdgNRiUoZwfoQwo52uDTU5B5s5SxznsFlZZjf
	 OF528iwpk9zYvZss8sHstrA3UKLEzWVAb1wB/edcmNuoyuMgiHOt6a87bSHtnKcddqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zv82LPHJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BB1606A32A
	for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2026 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zv82LPHJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55271F000EC;
	Wed, 25 Nov 2026 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625086;
	bh=s7ytD3qruX0pLO0p3jN8uu2pJK+W0G/dlm92F/CaYlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zv82LPHJwYphbLk9EflT1S0QezdKcu2MmrRoZ6s03UuD+rds5uXQonfi5enI3U+db
	 V5JYbe2V6xLqzrSwyREgUN7ErtTi8e7jVcw6n6Bi0oYvOFAa+7JiCSbEtAzyz22Fbj
	 IbWZZpfmj74xfUaf6E16rM983/zMixVA7cJ1B6EN7QdKJmxdLKj0i7w4iyBIgAPWyb
	 4b8Wd9HI7r9AWmxXHgsMlJgHrk7e+jw07v6SzSD+VvLiWUu64zPgjQVDf2yL6GKa+O
	 YF8/Sowa0IEu4ZWjaKUNen2BQssp7V81/aVRKuifsK0ddgLYDY1yqvpJ3UnhJ63U+/
	 r/1+TO80Te6Qw==
Message-ID: <sashiko-outbox-233775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/2] KVM: s390: Enable vCPU kick infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261125-vcpu_kick-v1-0-a203b01ab957@linux.ibm.com>
References: <20261125-vcpu_kick-v1-0-a203b01ab957@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 16:44:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-vcpu_kick-=
v1-0-a203b01ab957@linux.ibm.com
