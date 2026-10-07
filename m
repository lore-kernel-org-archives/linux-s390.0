Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750413CB570
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373832; cv=none; b=rfH6kBNvCrNtg2EMLpqFlHTiMR3IXtETZiaFIW19Xqt0AM3BQ2qCxaA8I6xh9edD/GyLfcOLi/kxGEZiKla/jDVmZbGCKinhQ4rgHiwbPVGFsX/4V0pnhweiNxrv0nf67KmKeNmPFtdtZC/9cUgxU0YsRbno+KzlAI5jAZNHYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373832; c=relaxed/simple;
	bh=QI6y2hM7m+An4tAVDX4N19DKMwUevnavPT3bWayZl+U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UfYNo0t0Z1TYojIMjiXvBHFhXysWqI/RglIwzHGk2JGH+eW5ShkDhyyDowhcYYdFaYi/C1zRV7aWj2nY4sATzWrZxn6kJ8TZrLX9kZy9cpsuwsGKm3m4BjHAi3LrwTNQxU/4T/qm09O+/IW35iJQ7yIsafjVfcJadujKUMJ3Ai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRKJAm19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRKJAm19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2B21F0089B;
	Wed,  7 Oct 2026 11:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791373820;
	bh=QI6y2hM7m+An4tAVDX4N19DKMwUevnavPT3bWayZl+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dRKJAm19GoxhPZ0/Uyl1llVDSrvcKU7xjKHTvM4lcrU0KrO5L85J973/5irqLn8KZ
	 xnFpMLDvVu8jP/IZFzXwXaT4qSIb55KlHkXpmZ6suajKGlp3ujH6XQRMq9CSi9VOqF
	 +E/Ef0+52EhGtk6+AAHZEgquOpogXzH7APqcaGlL/kcz92cLvo29In4Zi9jUrSaoxP
	 QPwu5JTBUTj5vPpZooT/VX45H4nBgDpt5tugH+tKHIAjMdJFvkKceP8Uceax+aN6nQ
	 oi9uHgpA6qOcTErh9hQh7HFXaH7e5ef6lwxxYMvrBKYEKIB+Kz51Qnfg/vHMMQH/sQ
	 xsbROcOq/dOLA==
Message-ID: <sashiko-outbox-162940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/15] mm: convert PTE table entry to pte
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <4151437659f71c16a136c5be941bbb44d46e6dec.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <4151437659f71c16a136c5be941bbb44d46e6dec.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:50:20 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Muhammad Usama Anjum <usama.anjum@arm.com>
>=20
> The non-MMU stub receives hw_pte_t but returns a software PTE value. It
> has no attached PTE that requires ptep_get(), so convert only the stored
> entry through __pte_from_hw().
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D5

