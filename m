Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177DD2DF719;
	Fri, 31 Jul 2026 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505830; cv=none; b=AB6vaPXeUtEklg4KyIejAsRjnR9FN6XWGZTnwyjwReazZZL1wxGWT1hmV4adhAZDFIJhuFVrl4dG+70dJ5MOf+4f14jMZKItYP7In/rCOxOL40zN9z9pLdVV6sMR8H/uZP3MsjD372V5NDOuMdygGPkuaQCTOIru2+dznBMvN/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505830; c=relaxed/simple;
	bh=Qa9IxbMMf+gkHKKw4+N/ag8fKIk/gRps8MpGEZ2WwFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PtL/0aKHzVU5o43oxHQ3KkKOzO2128kp8wKbDvD5pfqtKMyk7bX1tv85sbsz1BUy97xim8KTp6vhXnPNb1fmNAh9SbLLddxxZvgrWaYw4G5k6pf4kMheaAJEBqa4k853n/2aJRhakOeUyVUeMtNPCparyZNiaCynYewQf70Px+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUAq/ZQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUAq/ZQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344FE1F000E9;
	Fri, 31 Jul 2026 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505828;
	bh=Qa9IxbMMf+gkHKKw4+N/ag8fKIk/gRps8MpGEZ2WwFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MUAq/ZQSo4Kanuyu5MSXI6D/7UPTj5WAvutSKnVOPojpx/EnEtKOZ5LwULqNj+kEM
	 TooV150F3rExRDaGkBH71gOneGT1/PIZFCbv8kkAtRZIXnfPhOkVmjFMG2+w8vHIN0
	 xI8ZZIKtZcuU9zWSYetfJag2sIAtNoWV0eNyIAe0Chen1tWHisyJR5QieWf8BL4GVI
	 tYtl1DkBOLE4skhI28Gmd8dY1I4glFUUa9uoTMVEH6FK2WD8dOFdjYilf0pqX74y2B
	 gnmD30Nc0iB4r/HBM7M50+lYQsbJTdiZbiZPUSCs94qKjAAiEHF9MN8VKrnR0C1r2P
	 JMgHFYd0ZP7cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 20/31] KVM: s390: Prepare KVM/s390 for a second KVM
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731130902.654679-21-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-21-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:50:27 +0000
Message-Id: <20260731135028.344FE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The second KVM module will have a different Kconfig set. When both
> modules are compiled the Kconfig sets get merged and the native s390 KVM
> needs to implement functionality required by the respective config
> options. Ensure that s390-KVM will still compile by implementing a stub
> for kvm_arch_vcpu_run_pid_change if CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
> is enabled and defining KVM_NO_MMIO to disable KVM_MMIO.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D20

