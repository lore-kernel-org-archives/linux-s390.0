Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1253B329;
	Wed, 23 Sep 2026 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177044; cv=none; b=k8/g2OhavMtffrReY5bq6HbbV6bEcRArsAJNdz/dusybBL4rKB6Fi36A/E8N7xiUXYxQ+7H0CxBcKkGazRi28dtGa7eyhPJpAbN37HgGID8lHN+c20F++QdhBlXj4a/oA9wtzd/EMTLnytpeBLlbJ+5KFTeKu3F5P6kmJT1dOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177044; c=relaxed/simple;
	bh=BL34Ca2ApXDPTuj18G2TUvDGkdoLvKb3alMvhMiqOVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cql9J+2ozZyPdqjUzuNZrndDUEal6Df5sIDwav+XTvDjfxF5qYny2tn6boES1cF6fYxfQu49aYYBK8Q5ymPuY7hWMl8v24TDyek63h2pA/MANYnivDnsMJ/xVTwyBeMgUP5AZ9dKHDY9ZqMVGJUpwIHtaMjZshXyLz2tUhnhE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P75L6nfd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P75L6nfd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014581F000FF;
	Wed, 23 Sep 2026 15:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177042;
	bh=BL34Ca2ApXDPTuj18G2TUvDGkdoLvKb3alMvhMiqOVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P75L6nfdpfSJDMFGOnO7yRg9nALFUMKhpXVRzN4Yr58YU9L3hYGxJWPVOyIPlTqzS
	 SboaRbqaAFH+3JmDvbWXFOR7z1lUr/HjJUFS1nt/uuV+iIC6rNt61Mp4mdiBJY5j0w
	 SE8hxcPuV6H6z7gwbkf8wlpIGDszyRuYG+dq0OcHLB9qSi6MwzqFVTCXRI0KWTN8Tb
	 gkBrUiCsG5OUEzsx3NfFZOBAJhtsCq1waGtNZJ4dIFocf+IgDZvKgUopqKKoJnFUnf
	 YVdGmTRdWwwel7liFF2TSmVX3XTEd4+mzBxa1rdWWc8dGNi1IVQT6ZceDKoXOBJvFL
	 QFl87p4eTEHDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/14] KVM: arm64: Propagate and use esr in s2fd when
 handling guest aborts
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260923-kvm-arm-prefault-v4-4-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-4-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:24:01 +0000
Message-Id: <20260923152402.014581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> kvm_handle_guest_abort() establishes a kvm_s2_fault_desc data structure,
> s2fd, to store and propagate state to either pkvm_mem_abort(), gmem_abort=
()
> or user_mem_abort() handlers.
>=20
> Each of these, however, examines the Exception Syndrome Register (ESR) via
> s2fd->vcpu.
>=20
> Introduce an s2fd->esr field to abstract this and propagate it to callers.
>=20
> The value of this (beyond refactoring) is to be able to later generate
> faults with a synthetic esr, specifically to implement stage 2 page table
> pre-faulting.
>=20
> Abort handlers which use kvm_s2_fault_desc - gmem_abort() and
> user_mem_abort() - now only reference s2fd->esr and do not look it up in
> any other way, which makes it safe to pass a synthetic s2fd->esr value to
> these functions.
>=20
> No functional change intended.
>=20
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D4

