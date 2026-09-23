Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A6535FBE;
	Wed, 23 Sep 2026 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177388; cv=none; b=aZSPaol93G6JlwPQwC3dzyx//Wlvkc7iL1+2/px85GlPrtSA1jgGzDa2RT6DyZiHVG4se5kAcIr0va+5iJM+Ew5Lw+OBZhpw+z1v09lTPPj86wknoikSwo+QT4knYRAZaCm2m/JT0zynmVhUhvi6LYkm30T3bHCAanHZwwTeJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177388; c=relaxed/simple;
	bh=4OvpaXyrotfEk4IPy78V9MY2X7p2/CaM+YHK2GTcm9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eBKnGzNuRR5j4uaSugzqPfMqatzd9nV0q1C6E4ggDiXnO69JPXpoVKgDvolKLAcyaYLROJ8+1wDqQ05AF7eaP1CRf5gfAGb2863Mv8y+TPNN5INd1sQx/CFc0JwCz8hSNgnc7MuTxmmjf5ZrDfBhBnCVo4XBoHT607zWdOQ9z/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfsMQKM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfsMQKM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392211F00893;
	Wed, 23 Sep 2026 15:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177378;
	bh=zvf9ajOCs9TVky6BQukfoUcHZiwGKWPuLYP0OnYNNf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UfsMQKM0nLMYzy84PmzAcEgVWYhhgd3jBkX8tm+PjmOAkJtTyx6vjUSsvxR0je5y8
	 b6yJKFvdGjzlDgMS9cbDBFiZ1S4xZd8aR/NkUlfPBso5XRY13S2iA7eZoQf2UhI3L8
	 X8QgHMrAVTwF1MYCRfigFCCzFI8hWms1E4pj9petVNMcnHPz6Zk94AGcb8W9sdvYP3
	 uisGRiNSkfjmTNgPntYFlN1UcTo+8NJQRH7kDYcQFtOC4XdSPAb+6V9QD7CkV2PIzO
	 9WKHbJi73GoXNzE+ett+tKpPvT1iNQhm/pRR2zvAPn8+BbscwHTmm2VvSlgie7mZ09
	 gAVW5SfZxgYnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/14] KVM: selftests: Enable pre_fault_memory_test
 for arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org
In-Reply-To: <20260923-kvm-arm-prefault-v4-12-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-12-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:29:37 +0000
Message-Id: <20260923152938.392211F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Jack Thomson <jackabt@amazon.com>
>=20
> Enable the pre_fault_memory_test to run on arm64 by making it work with
> different guest page sizes and testing multiple guest configurations.
>=20
> Add an assert on the exit reason, comparing against UCALL_EXIT_REASON so
> the check is portable, as arm64 exits with KVM_EXIT_MMIO while x86 uses
> KVM_EXIT_IO.
>=20
> Signed-off-by: Jack Thomson <jackabt@amazon.com>
> [ljs: merge conflict resolution with commit c847704619da ("KVM: selftests:
>  Fix pre_fault_memory_test to run on s390"), commit message accuracy fixu=
p]
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D12

