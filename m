Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB203264C8
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851269; cv=none; b=IC81sX9C/bcAJ5hPi2liHYKXcEOJKZeptUMMSAxYjRn74WKDOWUEs9gKFVg0hTeCEpB7hdBUy8OdSc8r5FisCG6zO4Nh6O3G/U5ynA22Zq9WTpLDCkWfQrqtgFoRkKVkT+LbZKaTUQYEIXfurh0AA8Wy4pl7uMfW0ScBh2/eGOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851269; c=relaxed/simple;
	bh=cca8vj8MUpZ6TGgscPspOucrNSUQjcOtlNlOhz2CHpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gcBFTeTwmj++a+zkbKMDb4dyc6juejl398f40i6OVbhe6l61kPghHu4XitPZMkxCTKlqCxo72QC4D79hyFUBCitdsh5zXkXeMRRyrQPvQgIAOdCSu2Z5/edZ9AUjDs+scAZrNiYagiAELdmZ+jaewI5G1QtXUW/2R2EljEIqIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJVwHKZj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJVwHKZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE06B1F00899;
	Thu,  1 Oct 2026 10:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851257;
	bh=cca8vj8MUpZ6TGgscPspOucrNSUQjcOtlNlOhz2CHpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nJVwHKZjVWLVXq3nyLMCj9pYEX3o+rPb28mlNG+Y15fpcXjqbgaK5mEU0vIpC1R4V
	 /cT+o3OczXmXanbBARZvhHg7OIfRVvFSJGf6MxnUaQka9aB3n67+Bw2LttdECI/5VV
	 JFkNLoYC+TzedDmjhzepXd+3aAiVonuyBKHgREmr2RBcFnbYpi3ayLa02vuo4Kkusc
	 nQ90gMJd3U5KbS3B1TSQx9Y/SQSE3fAIlPp6ESsTQKRw50wsG7CaOq+EfPnf/XMrnV
	 h3+6qyIFAc/r34rFGvhou2xybHNr4zP7XU/jgX7TFpB7ow/zZKbAMcgaXW9qJwLsd4
	 GdMkawwcQ24Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/32] s390/diag: Convert amode31 exception tables to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-11-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-11-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:40:56 +0000
Message-Id: <20261001104056.AE06B1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert all amode31 exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so named labels are replaced with numeric labels.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D10

