Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD6397921
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572163; cv=none; b=e1UxTdynrO7dT3e9zjrVXAqlbTMXsy/LOfzwvNkbNcFeBLiajN5wF7/xVwqEhblF1zscWhvbm4owLEYyPMZKRf5ZwDVmohrPUC65UvLtGrNxlyu3FECoL2INupcM9zGgw9MOJrL+1oF7q/g+6x9XJ7fRUPSpAZMGfsghHdOYmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572163; c=relaxed/simple;
	bh=nnrg8wcCBkxUZk+Rse39qj3QxfEpe1IuzBPfG5Ui2a0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MbQfU88e0YIi6rpFoYKjQZw0/eczVHLnazFQ9La2qKzPlwoPy4oPL59+vtlXDTuQKbmlg4LAWjUFVH+3jBDSyveRRxRT0qL8TDI7bpicqfel3A/o/2390lRxjLaSg5W39/0iyl6CngmzhKrZcPbnKMULor/t8DybjHPgUGoYSgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr6uEf/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr6uEf/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A126F1F00893;
	Wed, 16 Sep 2026 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789572160;
	bh=nnrg8wcCBkxUZk+Rse39qj3QxfEpe1IuzBPfG5Ui2a0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hr6uEf/M8FWSDtNGIftjFU733HoH+600yGcrPAeT4EUqH9aQ2H7QNXdfdPuLWIKq2
	 qYElJg6cJd0NHwcSFU1gkTN9umW9dZRE32I+GbLQQJnHwet2w/90TaQGBbsJaeT0Gu
	 AdG6v55bwwKrtIET/sxKgDOKKkXELQIlX6mjEKKttc38Ya+dYmxJiMPoKcRtToAEeJ
	 xUQZ/y+6gQwBenAeS5eZm9kFKYC1Z9ODHnln21x1xeji4jFxZty7vCkJfIbNIwI0fT
	 S14Dpkkptn5Z5LHyPsmW9gwNLOqlLQTevmtp2bqp/qDyesC4DtACqrwQGIslg/bITA
	 1S6RqSjJN3l/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] s390/pci: Report SCLP status on error events
 when no pdev is associated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-3-61a2f980e71d@linux.ibm.com>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-3-61a2f980e71d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:22:39 +0000
Message-Id: <20260916152239.A126F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With commit 4ec6054e7321 ("s390/pci: Report PCI error recovery results
> via SCLP") SCLP reports are generated when recovery is performed in
> response to an error event. If such an error event arrives but no pdev
> is currently associated with the zdev, e.g. because it was removed or
> not yet probed, no report is generated. Fix this by generating a report
> specific to an error event for a zdev without an associated pdev.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCL=
P")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-fix_zpci_r=
eport_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com?part=3D3

