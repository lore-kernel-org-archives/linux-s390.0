Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61568451996
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932398; cv=none; b=mS9nreEAmIRytTSbAxk6RBCJN4FnmrndYtLp6ltKeHnuRAKqb1qC4SChwv3F+gmk21x11mfvSjH/AG0b1YK90Ik36yKPexl2ZAGP8gw9OWzuBhx4eL7Ogsu8A/sJtrvZ7G1w8H9QyQ/rA6PtIw5+D/DDmVFJ29/oz10jwEBk+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932398; c=relaxed/simple;
	bh=i/9Gw5L68iBMxWtmOCq/WZpUXO2XOTUek7+YMsaXeyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iebNqOjpqbja9PnE2EbH8BZtpAbM7/nOu5mDxC3lhdWQsh0YjpNyglEfysK4LW9udAZk3YgNnYFiM1HRERU1QthynJI80Ooc4M/GZUKbol0+D4FiRE/JFX9SnVUKreCWWayXo3mTmjrqOsS237DQkdFOn6lLqE0/E2dx8pyvZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbgBTB6E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbgBTB6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D871F00893;
	Fri,  2 Oct 2026 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932397;
	bh=i/9Gw5L68iBMxWtmOCq/WZpUXO2XOTUek7+YMsaXeyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VbgBTB6EDzLyTqL2BvaLE6fhwAOnOZtnw1oZ8jMKOGeydeFkObEzQgAkMlr1jbj9r
	 p3eSnJEiJQ8f1vvCQZ/lz0oj6Q1IK7SHXpw8jAib5UETqLaVTnDh8CfdjCAYUJpphB
	 DLn8BPj6sXrAGWF+I3hGN8dctwIrAVBWqhj1ikBPUVAdP9X7AXHWZq5UtuFh81ypT0
	 SMAtV1GOGk06se5iehUQPy5KukG3H3TlU1ryLhWKShLklGlWZz3B5Yf8aBXzF4575y
	 v5pxGMCyit+7sVAk6CWM6fg6zpW/jrTk5f5G0m+7JgxW85y55XHXs6fAxRb+O8R/a6
	 F6MpITL8EjSgg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 04/13] LoongArch: Configure sbm topology during
 SMP preparation
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001192849.74788-5-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-5-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:16 +0000
Message-Id: <20261002091316.F1D871F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Configure the sparsebitmask (sbm) topology for multi-node processors
> once SRAT is parsed and cpu_to_node() mappings are stable.
>=20
> Former commit enabled parsing node mappings for disabled CPUs during
> SRAT parsing and every CPU will have a valid mapping before the sbm
> topology parsing is attempted ensuring correct bounds for
> max_threads_per_instance.
>=20
> XXX: If _PXM mappings cannot be trusted for disabled CPUs, an alternate
> logic needs to be added. See PowerPC enablement later in the series.
>=20
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D4

