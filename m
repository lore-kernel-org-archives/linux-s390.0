Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824753CC323
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851065; cv=none; b=VQJxVd12qUMzERdurXFoI9K88W2mOhkmrP7V7WT9aky+nL+3V8d57MmL01e1NUCS/x5ZV7ugZWYaSlaAbTsL/E5phXWb4T5vg9a6NyhgFXnEEfe03myHvZbghB+acc2OnFSUVlcEXd/C66wUJyz69k66Kyjc6n1XukUS3UNo5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851065; c=relaxed/simple;
	bh=lcs532HKBEsCMetbZQrmIfjiYFWLpnYofnCJwBySNcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=APBhGZkzOPwgS+3W8ul+IAhEh+/Cq6wgxCSPBKkLBr0ye+rHNVPTD9yUBvRJe/6KU59eNs4z3VXpapmmH5V9q+OaC8W5xoOMU6qTEjHK83NzxmmFiH/k4F+jGdx9gQmiw9O/z6hwFyLWhZWjHG5eP85ynaQYKTwAfF5JvIQNk6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IinjU7HK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IinjU7HK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F4F1F00898;
	Thu,  1 Oct 2026 10:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851060;
	bh=lcs532HKBEsCMetbZQrmIfjiYFWLpnYofnCJwBySNcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IinjU7HKTz185Sgo5hbdoPO6i6vtU8fq6qTpJ8tSJZS8FlgOB2NvNWnD2+wjk6gB8
	 wtIcX7W8aIgw30tMFbSG4T5xVOkO4GyE3a4JsrVXtuc6pnny63ADNhQ3s2V+BCqh5C
	 /Lesd/E0MQv2yUU3/bpG69ryBy/N5I12QcPFQcfrc2Hxa1ZBIQV/8YcdU8lfy57ioh
	 RdcCCMnpRsSs6tOKwEbCl16fanjHAFqCQTWfddpWQfJBx7UIm5IgcXAftqNuPG8lpe
	 X3gU+p6inUmpXpm9ipeX6Rh5i0xY3BlYr1MwYsQOBRpCbVnWZFYbxMybzHJDVOGTJI
	 +pPXXXwNYT/aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/32] s390/tools: Generate bitmap of nullified program
 checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-7-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:37:39 +0000
Message-Id: <20261001103739.E2F4F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add PGM_CHECKS_NULLIFIED bitmap to gen_bitmaps and add a --pgmcheck
> command line option to generate the pgmcheck-defs.h header file. The
> bitmap specifies which program checks are nullified, and will be used
> with future changes.
>=20
> Change gen_bitmaps.c so it can create bitmaps with different bit
> numbering: MSB0 bit numbering like before (most significant bit is
> bit 0), and LSB0 bit numbering (least significant bit is bit 0),
> which is used for the new bitmap.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D6

