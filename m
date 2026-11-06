Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980399;
	b=18DAoxsdNgKQVnqepvxfS/nrWJb7Y2ulFi7b4/dKXwEi9crnpuBRUgNoflZdc/4u3hoc
	 3nJBY/yO6YdeQZ9VwNSU2HGWwxdfwgC5SiT8xOPT6/VtMTHT3nunfvaSS+isIYTQkvBEs
	 frr81ytz1IbHF/PNexlRAUXxoDgPbG0q6kd6+u/JThhOVfWvdGniFLkynYhJCBQhaxzd+
	 pDxrWl2jhCqJsci9l57o5a0rhm5IvZYInBPR/Czjroh3wJs+R21fALUXt7p7NKBGSjgmk
	 Xh08cv5xhOanX/9tj1w+zHe4Sv5oaVmkwQB7L3vqy5kD7674VqLuCRkv/vrKBhu3K+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980399;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O2OXYWgcujnIUzWaWF0uX+iRGIhqT9JkyOlHVhvgxCM=;
	b=mrTRhw/+PrMR+gmxvTmKJxmv/aU5B8gpbLT+GGCSDmPf8CWiVHg/Ol2W8O7wXoW9WbM7
	 33p43nK1DKbER0VvyKJj27pIelgviDjpRnMeUBYJ7YADps+nZudSMZFD5FCqCPf3LlpGj
	 9PKToGDqcfBvlH5yaSR1I52q15iCemTfXLYEctpPiYF9mAGJAs3mumJmGU9p0/cp2RM1u
	 b0MSmi0Oqzla+riMrCjTroPez+wivvwGMEZ7wVKDyQPMt7xTC7oWzR+ftCBLeGy3Ae8ms
	 vNlAqTqVgZ5Cr62y50+4a5vkRShr5QQg/NM4MDNDoFG1fWJwZlib3+yIS4nk9QI6KEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvMI8MHG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF3606A32D
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvMI8MHG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EC71F0089F;
	Fri,  6 Nov 2026 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980398;
	bh=O2OXYWgcujnIUzWaWF0uX+iRGIhqT9JkyOlHVhvgxCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MvMI8MHGJV7n+nxF14bCPHZ4lsfwRD/4CHTqtvRECj1VqbdmZwOBr+10aVLOfxIlm
	 BEtpRcwSsW3nOZFWsJ7Um5D8rg9qP7TRSvYC6j7qh1o4aqiiqfub1xBjfLI3LNFmXH
	 MWBL+Xsu318V6TjcvVOwpU/iGKQLM0FrvfaPrRXa2wTwl+rvxoiW+kM+OlIEVGvZzr
	 MLWFUBst3qjmgWkFHotbz/QCFHBoTf+EvuRsKyCTbEryx8W3oG79EqrDMtcMJe0KPq
	 8A494evPNCxc708s1Xqd/zc2NPLD6S3EVQ3XtPaJaLPwRdqJHd4EbsMgnl/T2xAdRh
	 bIUmgTi0eF6TQ==
Message-ID: <sashiko-outbox-201742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 09/14] s390/vfio-ap: File ops called to resume the
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-10-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:53:17 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Implements the 'write' callback function for the file stream created to
> restore the state of the vfio-ap device on the destination host during the
> RESUMING phase.
>=20
> Userspace reads the source guest's saved AP configuration metadata from t=
he
> STOP_COPY stream and writes it to this stream in chunks. The write callba=
ck
> accumulates the stream into a pre-allocated vfio_ap_config buffer. Once a=
ll
> data has arrived, the configuration is validated against the destination
> mdev's pre-configured shadow_apcb and hardware capabilities.
>=20
> In order for the source guest's configuration to be considered compatible:
> * The migration data must carry the expected magic number and version.
> * Every APQN and control domain in the source configuration must be prese=
nt
>   in the destination mdev's shadow_apcb.
> * The hardware facilities and AP type of each queue must be compatible
>   between source and destination.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D9

