Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE92931FB
	for <linux-s390@vger.kernel.org>; Sat, 25 Jul 2026 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784964537; cv=none; b=Bu3Xkkc2M9Oqp/6eD+NtGBGIE/7CId/BQcTh8Rx3Xe1tzSNjHphRzn1UtqTKtLSiWvbr3tjLgnuNrO3Rb3G1g198U8cXnErfDiS6mtChXWg1zgTpvTPVc+ls+Mf1tO+KTl3wROBS1iJ93zc4S4h/l2vmWbhT7dXxI8/SQGePQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784964537; c=relaxed/simple;
	bh=SSLJagnbu4Y4sdJaQ2cdZ0xfhpJEivTWo/FIOSkE5Wc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K8rOCwWcA2+SQ9X1Khs0yuxnmb6TrdCh+M7yCINhb5UyNfPTgXIGaZZn/t2hC3adSOy4AAd/on0PiKUCl5DnfDcNkm5H8fV7jRZ3l3Ppsos5y6lJVPG1TtVH9xOdGb+ybSeeTAPMBFgtzLqZ7eyYHDNMj7IrPmaJHwLN5ZjptZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsDPY/5B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsDPY/5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AC01F00A3A;
	Sat, 25 Jul 2026 07:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784964536;
	bh=SSLJagnbu4Y4sdJaQ2cdZ0xfhpJEivTWo/FIOSkE5Wc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QsDPY/5Bi/hQHC0Qq7VvxGZecVVtVXGRzYi7Pq5OrqRXB5IMiId0SlVPQl9wgVJig
	 pW6l4O3xfN3eIMpYcRGiZKPnWWt5JtGa21rWqmpATWU7CvF4kPxRIP7gR/8X8mOQB8
	 +3dHDtsA1Zx9fwSjfF1pITiQp9vHU3zsyVwrdQnEz/nvGyiRunftKp4DiQ5wi+UnGs
	 gKkpxTxs8oTJubtIpIKrCYPDBdEjllKTJJbTqUC04DLr5w2RVDPvihcANKuGCe0yst
	 lZWvGkcXf8P/27DcXDAum2nlNGhsZFLK6U70v0MzURGKnYf1Rz4AND/+0BHTJvS/+F
	 5ZDsxWvv3iSJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/36] iommu/s390: remove conditional return with no
 effect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sang-Heon Jeon" <ekffu200098@gmail.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260723184538.3888637-23-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-23-ekffu200098@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 07:28:55 +0000
Message-Id: <20260725072855.E1AC01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
>=20
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
>=20
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723184538.3888=
637-1-ekffu200098@gmail.com?part=3D22

