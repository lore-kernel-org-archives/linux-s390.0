Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A7E485518;
	Thu, 27 Aug 2026 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846727; cv=none; b=XtPh4rYtvAXPT8+xcIam+vDV5lSv11fsXj1S9Vhff5Ag0mhfYtisY9Lbc0FmOeV6+SgyC3n0CmE3/wg3Fpz7uL/fynvtoV6mucE8n15zHtpd42lc1BPv3OjBmAjfcI2++bjN2iQV46VswCykhALkRVuYsXGWeEyB+gXcnV4vOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846727; c=relaxed/simple;
	bh=bvxufr98GhWScMfrbybs+2W84ChNrkHnfej3qpZWGok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q98/4sLND5GjXzkYyt6nsfy32yaLV6koqtfSlFFVUVEWLPuQlMyyZ96PyHnjRBDytaEMLp5Uk6oJKGAgHR0Ny8VmEKqqt+khiFLr961L+acMoaUDKENtp/8t6ArO8al8MsaOVYszkZGM7ne245OvHw5bl1uuQ1VBHCWidg7IPq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBJCbEJy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBJCbEJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7771F000E9;
	Thu, 27 Aug 2026 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846726;
	bh=bvxufr98GhWScMfrbybs+2W84ChNrkHnfej3qpZWGok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WBJCbEJyjSubfOPUkfNrSlJiM1OZXavPNQEIkgi00w5QdgqMdituu3gOVKv4B7oBK
	 Gk2rhHjm7v+saZlNWBKCsgCTPQexkTBTSPJGw9XmJM6gGXfaTZH01B1o42E0DAsYH/
	 yVT+/L+U2M7tdjaO7zpMnAzpCjlysBX4EI+U6elL20G/aVS+WbWSMQXze01k8YpYp/
	 GO279jSVAnwNVmB0VQxrsMSOy4Ln2VcpcdbUcQlXUMitOLxGbXoVgCo7YqlJMnHzZj
	 B4wVmM3mWPQc2wEm638XRKVh26HiAeF87BBYftjm0lcCUsqy8KRi+1uz4bXV5lurWu
	 23/mxHHcQ/dQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/21] KVM: s390: vsie: Add helper to pin and unpin
 multiple guest pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-14-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-14-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:05:25 +0000
Message-Id: <20260827160525.CE7771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message claims to move the existing pin_guest_page() and=
 unpin_guest_page() functions up in the file, but the patch diff does not i=
nclude this move.
--

commit a11cc329acfe8885a8df6bb69ed2fa17d85d1e17
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add helper to pin and unpin multiple guest pages

This commit introduces helpers to pin and unpin multiple consecutive guest-2
pages in guest-1 to handle vSIE configurations with an ssca. It iterates ov=
er
the pages and stores guest and host addresses for later use.

> Since the new methods use the existing {,un}pin_guest_page() helpers,
> they are moved up unchanged in the file to avoid having to resort to
> forward declarations later on.

[Severity: Low]
Is this portion of the commit message accurate for this specific patch?

It appears the relocation of the existing {,un}pin_guest_page() functions=20
was already performed in an earlier patch in the series. The diff for=20
this patch only introduces the new plural helpers without moving any=20
existing code.

Could the commit message be updated to avoid confusion and reflect that=20
the code movement was already handled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D14
