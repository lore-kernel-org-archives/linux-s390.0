Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5943E2769
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851370; cv=none; b=IaqGhYmSPgbxAuxua27B62qL4LKnZBC7wdZq814ASEoqJMnKWJ3teLHNafRhqVuC4+gsjMyhzimp8gzhzw78Vy581nCpOsdBoT7VWXO2OIA2TLZt/eYfW38RU5ZPXn2oK1e3mEtqhmi/s5G3hfN+P27i+kbvAqma50fb8vzwg2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851370; c=relaxed/simple;
	bh=9EHq4qKY+u2skPcj7lWjKsNcTB5PsLLI1HUPfztVmb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P5DMI4zJNINmpOdADJn9pK0cvkYhnMo15/xt/R3rqecYe95KlbsPBpv44M3HYElT7Nj8COIxvh0zpQexDvTvKls/fk7ny9acazzAKbZp6pnVBK36yZgoUUd/a5tEbdwo7junW1w8D4BfjES0s3Yih0h5n9gHCdPntJbS5XEAG1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnRxm4hZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnRxm4hZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DCB1F000FF;
	Thu,  1 Oct 2026 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851364;
	bh=9EHq4qKY+u2skPcj7lWjKsNcTB5PsLLI1HUPfztVmb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UnRxm4hZPfBdwHM7O1QfRhGdVVyCrqrpwG/u+d5jDwNP/6egDYNttq86KgdMgrvd2
	 7T/z75KXWH0B2ruNq9Esurw+FDQlyB022Ow+NDo15ZIoVpu3E5ImEhkrPrsDRXqnnp
	 HpJz7GVllUg74TAiRRNoOGyAkd6LMzNyWXAu4N5kzMCzY5D19coLuz8xD8FLmlTfZk
	 EsogO9EJi2BSFraR2f9V6/dgR3qMa0bD6XjCpcsagUXYSK1pdXG3nyGrvkAZfHxyft
	 tyfpcJV3t/ROvbe9SXKh3Q4MsS2daP4iffR+do2kzg4jWKolmoNVn4nedG955f5X1p
	 AirbkTAin6Xfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/32] s390/fpu: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-22-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-22-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:42:43 +0000
Message-Id: <20261001104243.E5DCB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert the fpu_lfpc_safe exception table entry to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so nopr padding is no longer needed and removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D21

