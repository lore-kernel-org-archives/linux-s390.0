Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9621481ABA
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336765; cv=none; b=LkxxDlhtuOp2IxJMBFb108tSC1BnSwY0D9Dh3gMzgrJQQyzyeu4jA0ZV8IFgEYpckAIkimk68K9QLo99CRsUKzsHqGDHSTJp0sNInf/+2Ujllxe7OHJPsZumBVgOPDSv9IJtvmPp3qIaJVuL9uADmy1FMUCC44Uimd1vfH3Xf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336765; c=relaxed/simple;
	bh=XxTNCmodEn2cdMOqMqmo42fcdrdVqcb0IHeRk0zGNd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UiHzasLe0faPueXWJugbqyQvZaXUdwOclgasHSAPD+OpovIBrsx0MTAXhyNMCNy5R7c7CvMpxgqBkUcZ2qbtZKr/4eSMRr9xrMVCe/zl0C1c8cOPQR3N9j0m8tHCBQhp62mMntOLxdH3soyq3JdVS6lV/S84oBp6fx/cb/2QGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7jGwhiq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7jGwhiq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5151F000E9;
	Wed, 29 Jul 2026 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336764;
	bh=WfB1ErkInJpJwAq/++3YS3IiVk+VMMUV/DigrRPyZuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7jGwhiqshAcaTDevRPGaEvyJ5kdGSHwVXIHsMfDco+VIqFCooRwT7M2ucB1nY2eX
	 +KtF46KmlvOkqEe8BL/M7LFx2A0XrIjunM3LcxRoy2YW8BNIbNCFfh8xZzBBwlfzNn
	 yopaFOOZHnpDXeAziY0y5Wg/2yOx4tcFRjWcraIjwpNROOwLGsUPBMI7buzTHJi57Y
	 OnkOt7zciwxcXUEWz2HrUlAp6GZ5cNPAjO/LMajFhqPcN6AsID+3xsgGGmBHd9NC6d
	 9iibyO6qog31qZEdc5cUl5qh+RA9dfvztdKeu/8aVA5VUqOhcFi0jkB6apL9o9GIwW
	 rxzd+hzWKC3QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/5] s390/zcrypt: Improve EP11 CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260729143928.191969-4-freude@linux.ibm.com>
References: <20260729143928.191969-1-freude@linux.ibm.com>
 <20260729143928.191969-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 14:52:42 +0000
Message-Id: <20260729145244.0A5151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
> validation, creating security vulnerabilities:
> 1. Missing minimum size validation: The ep11_cprb structure and
>    subsequent payload fields (pld_tag, pld_lenfmt) are copied from
>    userspace without verifying sufficient buffer length.
> 2. Arithmetic overflow in length calculations: CEIL4 alignment could
>    overflow, bypassing size checks and enabling buffer overflows.
> 3. The payload is asn1 encoded but the function just uses a simple c
>    struct overlay to access some fields of the payload.
>=20
> Fix by using size_t for length calculations, adding U32_MAX boundary
> checks after alignment, and validating minimum request size and
> minimum reply size before copying from userspace. Do a very simple
> asn1 parsing of the payload up to the function value field.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729143928.1919=
69-1-freude@linux.ibm.com?part=3D3

