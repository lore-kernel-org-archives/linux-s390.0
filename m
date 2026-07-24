Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F877364022
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784891276; cv=none; b=vGTwRJ7fJCXNin8P0sRjVAJ+fT1QJA0zDi326PV+nYms20h0A9wZE1XU4Z4NpN9SuAgRanR9cuRr66hW4HNy2F+RvuGwCuJ1zKSppO4NuYeC2U3IwWqhna1LsTPppr943x6ag392XGKxKnSTFTBn8crgGdx584DOstuztHIbheM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784891276; c=relaxed/simple;
	bh=tDlPj5gUUPIJYuHnOEqyJDvprgVewTrK8tf8n3FaHE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=at7sQIuXvuGmDKnFILsqIq2pWdUmZkz3K78z6Re8AHReRWp5e1tZghzLQZXOY3JUPXY8SkT0FapjrJpQVCyTHNoyuPPh5TTLWj1pIw3DxIfIZOCCJMlzCnYUPZnl/BSsYJyhEJhsvuz4BYLYfW9uYH5D30d2rI+ccAAYax8QBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc2Eig7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc2Eig7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8FF1F031E2;
	Fri, 24 Jul 2026 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784891273;
	bh=HGZcu/OzDcpH/+mta6deJGHkC2ebMUdHuENvbUzFw+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bc2Eig7ys80C8+km6wWXdH61Elg1h1plsqyljO9lyDqYrYWALiru7jS2opjeQCZrT
	 J3dp4HcZEtNs527X6vQweO979bFaIZSn6EEg0L/31LNLK5gSpV3ZWQBQQLuyg4CQdi
	 ZF3HOcblhUAE9gZSFt0ImDq2ccnyNnIWVsYhu/f+iszNMhLKj5FIXe3qGibAZZgyFI
	 CR9faXLpaLjr/d5BbdoKVYmjiHlMTmvaSTIM+RlgxGk6XqDhGNSzTFMPfQyqXcvLDR
	 JkFHFkZkcDOSJShKMEPMw+Au98+Ldw263YefZllY413APKIkg4Cw0muklFIozn76g7
	 7mJvjuBLpuX5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] s390/kvm: Refactor
 __diag_time_slice_end_directed for single exit point
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciunas Bennett" <ciunas@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260724103959.14861-2-ciunas@linux.ibm.com>
References: <20260724103959.14861-1-ciunas@linux.ibm.com>
 <20260724103959.14861-2-ciunas@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 11:07:52 +0000
Message-Id: <20260724110752.DF8FF1F031E2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Refactor the DIAG 9c (directed yield) handler to use a unified exit path,
> improving code maintainability and reducing duplication.
> Changes:
>  - Consolidate all exit paths to use a single 'out' label
>  - Replace multiple VCPU_EVENT logging calls with one unified call
>  - Introduce 'result' string variable to track operation outcome
>  - Initialize tcpu_cpu to -1 for safe handling across all code paths
>  - Ensure statistics updates occur before the common exit point
>=20
> This refactoring maintains identical functionality while making the contr=
ol
> flow clearer and easier to maintain. All three possible outcomes (yield
> forwarded, done, ignored) now converge at a single logging point
>=20
> Signed-off-by: Ciunas Bennett <ciunas@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724103959.1486=
1-1-ciunas@linux.ibm.com?part=3D1

