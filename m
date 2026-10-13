Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2D3AB498
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860055; cv=none; b=BcezBSI9ROqkiC39FNYrmSbAfkjUWMzVN+jrnP5PS4pJZMceNRLY6+GDYhFWry0E7MSli8SAmP2uW9srBnGJZhRBylKsTMW1OtPDQfojIqA7g8Jxgz2Zf30r07XLp23nbrl0qelAqSKtm5yPM/UraqruFCIedvLVlXOxuWOtc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860055; c=relaxed/simple;
	bh=jA7cbkK/RotdYPTGdjALsfDQrne2p08SfqT6bXge22c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZN5iBes8zyjPM5VzNytcH6z90D3ulwd160Xn/dPXuHDnWSHuap8RTDo2cgAu+RsqPu3So6wFGRWhXEb2bY13Y/eVM+UlLL5QUwN0KqsupSoX+pjEcRsp7cC32gnvUY8AEI2qaxfipFemBhCCTx4cbx2gPLuebfhEaxsIJvsx320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1cYBG9v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1cYBG9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8961F000FF;
	Tue, 13 Oct 2026 02:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791860053;
	bh=jA7cbkK/RotdYPTGdjALsfDQrne2p08SfqT6bXge22c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C1cYBG9v9IbYTQ1u5vItTpgRfz6ogx30k/dYhU7Zj4PfBZoZLaZYyv1uERcH1bOoW
	 uzLxuZwVf65T0SCbQkDpfnjB6tayKMeZmY+6C46i+4Xh0orLOJ4BRVQA3nIkWbBD2/
	 ViqPqJ9qTtqtierFyPBDZG6WaPWjZnJU+yJ/70vRUcUZK/e6NOnjngUQqEuXqnzZT6
	 uPIvCl8VBmwr7CM/YwL+evQl3TNkmUvnGXVY7Q9l1nxsnsJgStSRHdXyiT32hSWRf7
	 PPZIfK6rpkjlhd7jtxVztZ5KFTmpvaChjkGgkBzb/8RgRWuGeKBQxGaa3+dHBKgvZw
	 QcB/yHcYL/ulQ==
Message-ID: <sashiko-outbox-168879@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] zfcp: Fix integer underflow in status read buffer
 payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ajaykumar Rajappa" <ajaykr@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013023817.1468967-1-ajaykr@linux.ibm.com>
References: <20261013023817.1468967-1-ajaykr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 02:54:12 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> zfcp_dbf_hba_fsf_uss() only guards against a zero-length status read
> buffer. If srb->length is smaller than the fixed header size of
> struct fsf_status_read_buffer, subtracting the payload offset
> underflows and can lead to an out-of-bounds read.
>=20
> zfcp_dbf_san_in_els() has the same issue, where the underflowed value
> is used as the scatterlist payload length.
>=20
> Fix both cases by validating payload access against the payload offset.
> If the reported buffer length does not reach the payload area, suppress
> payload reads and avoid constructing a scatterlist for non-existent
> payload data.
>=20
> Fixes: a54ca0f62f95 ("[SCSI] zfcp: Redesign of the debug tracing for HBA =
records.")
> Fixes: 2c55b750a884 ("[SCSI] zfcp: Redesign of the debug tracing for SAN =
records.")
> Signed-off-by: Ajaykumar Rajappa <ajaykr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013023817.1468=
967-1-ajaykr@linux.ibm.com?part=3D1

