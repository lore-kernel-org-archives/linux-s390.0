Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48551AECB;
	Fri, 18 Sep 2026 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749842; cv=none; b=NdZEB+DVAqqmbP2y1EBx29RIL2fUppKspwLI7jZ4CFahocbbWheRzlwF/lIFSLcSZL3Mi02EJs/TEio/HfE1whpdkSpp0dEqd3QIeTfiSi9flJIZBa4BH6KWT2FcAB4lPwhCbn0GRYrkPzvZ5Mgy1I8zciND1XjPuH2tEtubMuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749842; c=relaxed/simple;
	bh=+kJt3Ok/RCtacwPlMYiCOnSej1ZuWB7X9JG7ix5EIos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j/CuS1GIDLAljDzU1ek80wYauWJdZMdhVT9FitFHit6y8u7d++E1323R066Nzgc0EkZ1IaKfkZF1B+d5/sHbCJfBXkltim5M9bld89kze1NnP/Whh7Cw+dj6uzq+Em4JmEqAyYHFNtm+638JUGtaVgpB6ljEuJCppeToNyNiBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+Uk3yTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+Uk3yTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE7E1F000FF;
	Fri, 18 Sep 2026 16:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789749841;
	bh=+kJt3Ok/RCtacwPlMYiCOnSej1ZuWB7X9JG7ix5EIos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y+Uk3yTKVKWWQAWBG5GENocgVZufYuufJVu1ZCmtYtKJsSTbqyQC/7nGFDKxDfeS2
	 g3ERQK5YYZnPfOolcHjEOqYIkYyJ+eSbHKC7qEYKmRvFqA/UyHOCvi9WSEyNMPSc0c
	 69GMp8VpNVhK9FsOFJKFLkumN96lJxcs1hYrtz/4+yMy/ookQUcUIwMALeLu63n+VU
	 L/bfDrhTaka3tF0xxtxgs3iDkLaMHpgqw76r21J8vIbbWGcUT438XOU+YPIC4GlJo5
	 Wbbi8lX5bmlrMCa7yTTdT5DeI2tqAb8/zzknywe3SOjh1cA6U9iri80Tk4qdSXpXPL
	 LFN90aRGX4DaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 21/29] KVM: s390: arm64: Introduce host definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918133107.1042730-22-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-22-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 16:44:00 +0000
Message-Id: <20260918164400.8AE7E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add all basic definitions the arm on s390 KVM host requires. Including,
> but not limited to, struct kvm*arch definitions, various functions (to
> be implemented in the following patches), and various defines required
> to run arm64 guests.
>=20
> Enlighten asm/kvm_host.h for the new header variant. The new
> header is chosen instead of asm/kvm_host_s390.h if KVM_S390_ARM64
> is defined.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D21

