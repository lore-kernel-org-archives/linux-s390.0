Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4347838E8D8
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527036; cv=none; b=nxoH06vxi70hZBsTAwSjJ9sc+ErNSA5sCafXq0GmviEdt8/1fOc8A8DGqvoLcF0Ag5xRAqT1jLGaBCNX16piE3BptwmD7Zz91aZu4VlPsjlYW5Mzeze0KDaCC2u3WwUc7zUyAwnrmHapejBq/dvtumAbTN+FlXEETvpEEyaRjyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527036; c=relaxed/simple;
	bh=SgxXFwHradiJzRn5iejuiZxu5y9RqfJTuXKL91nW92c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gNiJ9XSGtZY43bwFtpTiSFoxebQ7g+pG98Iz8ctNYkemMKXhV+FQd4PDiMrCW4VVMf1YkVWJO+K31qYrQ3g6bA0qBASI5oiCSsKqEPAdpxN4OkPHOFymjsLB1fYoOx2LF6tutMv4URZQvDSRFWQxDk5q5YoWAv2prD6Yre5zV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXcnbTFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXcnbTFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DF11F000FF;
	Fri,  9 Oct 2026 06:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791527034;
	bh=SgxXFwHradiJzRn5iejuiZxu5y9RqfJTuXKL91nW92c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aXcnbTFXMqeZEXun9ZwpQFS+8V7/nix/Y0IbsUIR1jTg9RvQpQCRsy/ZjKs2UT6Xj
	 PCzs8zebFUdnOWSFyRByGUTmXofBYt3sIENi8IxxpaXLPSSKZuQ9ncIPRjUrUBEOPJ
	 77FhDU8P3+We5fguYemzGQYmav8VUtc74BSA2/OTezn1CC6WV5f1lCjf3hAOmVEKQ8
	 CjMRk38NrHj7VpM7bAo+lrQIjj5RY6HGDlsV5GYykJhtM/EdldQNw8uDR1+28zwRYp
	 7HS5xpjVVsme1Y3tDtLC2AFLlIt7vtPEvVA67av9GFxumFBTkCeg/9+PzTFqyA6/AJ
	 fUxxYlKRODOHQ==
Message-ID: <sashiko-outbox-164925@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] s390/pci: Drop the unused index argument of
 zpci_msi_clear_airq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-7-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
 <20261009-s390_irq_domain_fixes-v3-7-ced19028da3c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 06:23:54 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> zpci_msi_domain_free() passes its loop index to zpci_msi_clear_airq(),
> which adds it to an offset that already accounts for it.
> zpci_msi_domain_alloc() stores hwirq + i for each vector, so
> zpci_decode_hwirq_msi_index() hands back msi_index + i and bit is
> already zdev->msi_first_bit + msi_index + i.
>=20
> The doubled index never selected a wrong entry. An irq domain's free()
> callback is only ever invoked from irq_domain_free_irqs_hierarchy(),
> which walks the range itself and passes a count of one. So, the loop in
> zpci_msi_domain_free() runs once with an index of zero.
>=20
> Drop the parameter and the addition.
>=20
> No functional change.
>=20
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-s390_irq_d=
omain_fixes-v3-0-ced19028da3c@linux.ibm.com?part=3D7

