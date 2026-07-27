Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5E32779D;
	Mon, 27 Jul 2026 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163208; cv=none; b=JvS19RGIybb9wGyRNCC8XkVQdSB4Oq5+cMBAzkqBDoZug5vvA7aAHbYYqQ6iNYhU4mxGx2PtDyONOy+swOiG761uq7L5P4qsibuhIRea7ZL3dpkTt1H9aV0AR3t6Gtsw/l+VvgJw2EWp6bEPVYbUOyN1fzznmyXF1iq/UoNEVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163208; c=relaxed/simple;
	bh=EAcVS4BHwRTrzyEttSsCo8WmSVw5OSP5803dfc0CaZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MN91J4MW/sAgq7YgiyzYehUnVA5jmqCq25/Y2NR+RDqZ+ZES7wXupj7C56ZpZmYx2vIYWp/MQUiGu8jodakT0LjtWeSIEBCaLx6aqdNMQazGfQDu1hDjoDazuivjlpenxT+c/FxhgliB3Gpyyj6l4Flrg29ZhC0WbZ6cwxSclQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObfP5dHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObfP5dHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED4D1F00A3A;
	Mon, 27 Jul 2026 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163207;
	bh=EAcVS4BHwRTrzyEttSsCo8WmSVw5OSP5803dfc0CaZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ObfP5dHaSbndrXFRtrgqvTWGUdWHokAR+I5CJ1azJxnnamXfmMh4gQa2tXbxn1StW
	 bQ3bdzEkwet9ody2Av0VZunbD8moGP57e30J7w7qN1xEds+YFSjD/1UgWbAH97fzCI
	 thP5Yc8e1sG4lK1pLCpOu51PjCemGD3uyRocczowv3eqMFOaLxkfJlaEBGu7os+qO+
	 mkcyaVI8dkTj5eZam5ogmCBP5tKrL/KEqMu15F96J89W48a7O+cX7/TeefW1k404l5
	 QedP4boXXA7LUTjQ0KvwLt2bOFnbJ/tBZ8LHarfwUXG4qZrNLLHVe3k5iPgWSbIJ7C
	 8pBoVRpm8KfTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] s390: Add ftrace_stub_graph
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727140514.116501-4-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
 <20260727140514.116501-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:40:06 +0000
Message-Id: <20260727144006.BED4D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> This is the s390 variant of commit f3a0c23f2539 ("riscv: Add
> ftrace_stub_graph"):
>=20
> "Commit 883bbbffa5a4 ("ftrace,kcfi: Separate ftrace_stub() and
> ftrace_stub_graph()") added a separate ftrace_stub_graph function for
> CFI_CLANG. Add the stub to fix FUNCTION_GRAPH_TRACER compatibility
> with CFI."
>=20
> Reviewed-by: Jens Remus <jremus@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727140514.1165=
01-1-hca@linux.ibm.com?part=3D3

