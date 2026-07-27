Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D6388377
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162937; cv=none; b=V/l3bW8DQoSYj3joB8SvJU96XJuZ64kd6tJhUEtEwIKDlXYSm+f37R9TPYd5oHqlph3Y5uFjkkkHCZAWu1zjfMSpiMIuog1Jip0KeIYpUK2vpXQ71zSAnLyyh6MHxS64pg2npbEJ0CrKS0yrn1n6K4RwYJ7Gkzm2m9flEnjrsx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162937; c=relaxed/simple;
	bh=oH7G0c+45xYt5TaX1K+d5Q+DC0feHGpmXFEJTjEFtl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZH0kT27w/NfFXZydstgcybW/5RE87qcXFKiYrK9KKBj3K9irBQGUBES3TVCqvmDpDfpMfJSajWpcPhAg/+8M+IwiEXkZ5NrZJN1t42Uh+FeXlKeBJ6Nzm1s+uZnckgQDi0mxRNUhyecnTiN1kuyIIW1j7I8I5V2h6BK3wfE3twA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NseVeIFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NseVeIFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34701F01559;
	Mon, 27 Jul 2026 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162935;
	bh=oH7G0c+45xYt5TaX1K+d5Q+DC0feHGpmXFEJTjEFtl8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NseVeIFJaE7EkmNLX7DNFG/LruLq+rdFiUEfW6RFGQZIKrishMwqBDCX61nHZ6XnZ
	 MeSRiuSUezRNQEAqqTdUkiFMz9wF2wTw3lQNCIosiEGax/2OSRaqpLoWbZE8l+usuO
	 F8o6nOlRDUuTFb8a0yJmXaZf8JORubTplTlyzMbl7XYAHpoDf0n92jReHZ6Vfdmcgd
	 yFFbEEmlJNpOv8wEcAP5DHyd7TbZMCtf/k+5W3MnvYClCfx4S0EDVk104m79JTjBbD
	 cuTPOPdDe5EmeNWYEKNrBegPpAs7XtpRWzB20JIwiM4V1NvfS9Fh/fbDKRGyHhvhzu
	 XWFF9DbAD7z0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/dasd: Fix path verification interrupted by
 concurrent dasd_sleep_on_immediatly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727142840.567286-2-sth@linux.ibm.com>
References: <20260727142840.567286-1-sth@linux.ibm.com>
 <20260727142840.567286-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:35:35 +0000
Message-Id: <20260727143535.A34701F01559@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When all channel paths to a DASD device are lost and subsequently
> recovered, the path event handler starts one IO per path via
> dasd_sleep_on_immediatly() to execute read configuration data (RCD) with
> high priority.
>=20
> dasd_sleep_on_immediatly() works by terminating the currently running
> request before inserting the new request.
> If a concurrent caller, such as the attention handler
> dasd_eckd_check_attention_work() or the summary unit
> check handler summary_unit_check_handling_work(), also calls
> dasd_sleep_on_immediatly() while a path verification RCD is in progress,
> the RCD gets terminated.
>=20
> The problem is that a terminated request transitions from CLEARED to
> TERMINATED without going through the normal retry path in
> [ ... ]
> (attention handler, summary unit check handler, reserve/release/steal-loc=
k)
> benefit automatically without requiring changes.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727142840.5672=
86-1-sth@linux.ibm.com?part=3D1

