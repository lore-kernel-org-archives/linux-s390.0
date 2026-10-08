Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4943FD3F
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457174; cv=none; b=jjrTpTE0VXmBVNHns/h4cn6JOxy5KzrQY93oMhgxEniYnhD/ffnQ1M6tWDV3US6QHWB3G8bBZCJKn07EgmonzETfz2Im1FlKe9MxrxSzkhkES1KjpaLHMp5mxVWKBbEuM25zLQN0uEkgQ2E01AdRK3J2clVcnioOAsfywhG9wpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457174; c=relaxed/simple;
	bh=edgrcIfWzY+BTomY/6sNKGK5dsroQOTa4I/HWlqvRcI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=A8EDzly9Btb6FVn2kvgPXX7k8d+VHMf0MVQtl3bzZmTzvfn57Zp4NR3/0wMRDHnhyrnJyW8B91hqhC+MBcxIpw2pLQ9PTRarWlJ4/x0k6u6xnxtfWRXKTSXd0bUbrfmSl22uLzQ0jA4eLDIcm9xT6CXPdAyCFcULJ8zzaIBbXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEgG4ncS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEgG4ncS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34881F00893;
	Thu,  8 Oct 2026 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791457173;
	bh=edgrcIfWzY+BTomY/6sNKGK5dsroQOTa4I/HWlqvRcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SEgG4ncSbeabS+9SfYUrRCdSDFTd7c65fOO8Q748NZ59M0UYqN8pINQgZ6W0Lf+rs
	 YCKYhanSAFhdmGY6BPAs2ef4/7tsk6HmYnH9+9Mf4CgjLi8sWZlbfHRThpVNSfy8bK
	 asQluIXkDCjYfXg+ZESB6NZ/OShUVIxLSG1c5o98Rdeh46BXBYWXkiG2Kq+5w8FUe8
	 KT5yA8LVLE9Jjt1ti+IO0MZx+dAi3SipdN7EZf5JL3AdkClVQZOhHWepPjdZe+xZMF
	 oMf/SOeUfWmHZotTYF9rLcuLVUzRI8/o2R+e0I4wOFjWVnwkLc+Ucx12xhQ7tk2fuM
	 kN/d/KAFgyizA==
Message-ID: <sashiko-outbox-164071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] s390/cpacf: Rework cpacf_kma() to return
 condition code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261008105242.20730-2-freude@linux.ibm.com>
References: <20261008105242.20730-1-freude@linux.ibm.com>
 <20261008105242.20730-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:59:32 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The KMA instruction can signal a verification-pattern mismatch (CC 1)
> when a protected key is used, or incomplete processing (CC 2) when a
> sub-block-size chunk is submitted without the appropriate LAAD/LPC
> flag. Both conditions shall be visible to the caller similar like the
> other CPACF instructions.
>=20
> So rework the cpacf_kma() inline function to return the condition code
> instead of void. However, CC 3 (partial completion) continues to be
> handled internally. Also improve the function to use the CC macros for
> better readability. Additionally add an kmsan_unpoison_memory()
> statement to reflect the updated memory by hardware.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008105242.2073=
0-1-freude@linux.ibm.com?part=3D1

