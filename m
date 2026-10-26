Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005725;
	b=2dAy4/eYVfgvsN6PMEX/phegMBG2c6JrtNeEtS92YY/RfYwWxY8rlo2PO8QnJnsk4sH0
	 hnxzJZPjzwWIrYSyxsgCN2fg6YgVpMyYCylSs2IAruEplc4432pqyeBts4io5zV/tL7Jv
	 rJqR+6UfUiItOwVzIho2hWrsjR3ow4R7SHMS7vM0cWUjMgneq1hkY3R5p3Egy0+nx5aM9
	 bkfsbDDBdjTa7u0UKgZqqhvrvuSSrn06Z4TSexqiNcDsiraaJ3qW1oRQS3wfRxtXfJ6kA
	 Q/PIzeNRToIBT8Z3oHfQpn/jpILqrFgvdFAAOzOEzUA8hrYuggb71c7sTsh42AJ2hdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005725;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YRb1UnGMHCi8cIgkK90VIf4+1937ITy7O1yU3L5mDJ8=;
	b=fodUT0g3gMjS8eGPJIkxHpkV/kqgxux8aJnXRwD+WFhaEmtiCTLqSqCiYYmTaC3w2Kw4
	 jAuA70qjt9OF2BorsW462SFP7leVWkyEjcwQf3HGAYPAYCQWFapWi43HlD035BKd/RQyz
	 k48T3BUjIqlStmRuIGao1DxWJB/qg+4SwJBCNwE0wrYbiDelbEtYwp26dmKj8R0kxBMRo
	 BhHyZ+aXjk89qpzK4ByP8M96bXi5tt8ZaXwGQsf7WQFU0RiuFNpl6DNGTjlDbyD2Vhwbu
	 MsQH6fffUwTmLlN7tC8VD8gJBZ56RJ27LY6nVOzShOZjTfIyCWYIRPT/40r1uREk7Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pr9GY+AG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9FD606A31D
	for <linux-s390@vger.kernel.org>; Mon, 26 Oct 2026 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pr9GY+AG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427D41F01828;
	Mon, 26 Oct 2026 09:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793005724;
	bh=YRb1UnGMHCi8cIgkK90VIf4+1937ITy7O1yU3L5mDJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pr9GY+AGE2GDKQ1YCVFEyxucEsUPcZOhpiRVu8MdyRZmDaTY1vpwKr09kulGvT16y
	 rAptYvFhYUlXT2M648UMLT3wbJjGBeip+2cTcPwFOv+JFxBoC782vPcnLJMvI349YB
	 ji1ps/sSnE+uR7ug1Gzyz+X2gYvbjK9vScpdSGE56uUftvKeBeNLi5UIuDIufe30rX
	 63k7EfFWnXjWfSzH6m5rrA9ACzjAKjUXkPTCbJcxRIaQLVMEbfndb1FEz4idfZP6hA
	 f4tiXvMCPkzJM+wt7EwBoyodANF6G2gv4QSe4fSQPbo7adCQxHGeo5E5NBDypPwj5H
	 k4hU/R0ck98UA==
Message-ID: <sashiko-outbox-184737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/2] zfcp: Replace sg-list with sg_table in
 zfcp_fsf_ct_els structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "M Nikhil" <nikh1092@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261026041654.2301619-2-nikh1092@linux.ibm.com>
References: <20261026041654.2301619-1-nikh1092@linux.ibm.com>
 <20261026041654.2301619-2-nikh1092@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:08:43 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The zfcp_fsf_ct_els data structure is updated to replace the sg_req and
> sg_resp members, which are of type struct scatterlist, with request and
> response sg_table instances.
>=20
> These sg_table structure reference the corresponding scatterlists
> (sg_req and sg_resp) maintained in struct zfcp_fc_req.
>=20
> These changes allows to track the original and mapped scatterlist nents
> once zfcp is converted to use DMA-API for mapping the sg lists.
>=20
> Signed-off-by: M Nikhil <nikh1092@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026041654.2301=
619-1-nikh1092@linux.ibm.com?part=3D1

