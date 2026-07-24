Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE5C3E717A;
	Fri, 24 Jul 2026 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902888; cv=none; b=hGbS6+ntP5zON0gltZ5SbrLL8EAz67xaSHbc/zdlER3uHVsRm0AmjybCZZ3+EyYh8mn//jSFSFs2j5SWVm4I/KNKUtU8dVOD1ehLDHbNq3OK+qrMRDZT6ahWaKTKwM5RcmvenM4rwF18rBEDyhWLAsAtD+JuUXzUs7SUAiQuIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902888; c=relaxed/simple;
	bh=cWLLx//HBLkeb+a2tYj8T8xxm2v7tGYobHhwRRuUgtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YSQZ8zHqU27c2LXshNzONleVKAHEPHCWjOuLzTI3jyvOOhmdbC94Tv8DMRQ+nSrKrGzpKC5Cbjk+Cee68BIboSpiFK2rxOp1o19GEoJCQOI4zMPiiwUDCiQ26Ojk0kr4Xj5hfzED5XDayf4Tcs6eh+6rhBW2UHF62shCsrvZ4K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlEpyENQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlEpyENQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C1E1F000E9;
	Fri, 24 Jul 2026 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784902886;
	bh=cWLLx//HBLkeb+a2tYj8T8xxm2v7tGYobHhwRRuUgtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BlEpyENQO7iQF4OFa7x+JqfXllZW9/MgxkIZ17QhdM73x20LizajOm4Em3PLReDp8
	 glvrJ0spfR5ppAlVLC94eUOS7AMI/ZOD4Ar8FRUgq+FsoczO1HVUdXo37HeZEgF3Zl
	 Env0+Ozq7nSvE3KGd7LwT3uigwGpTgMzc4SlqQr8CcsWr4G0tmeqhk570prap8pADt
	 bj275Nbh0lASKi6Zkgfa7/HFG3/FM+ynnCHnRmH6BaDa+nPyqlJ5ZTb6XfmXWDsabG
	 9Ji2SE7sL6vD9AP3lU/UYrZLIHimzbcILIhAatFalsFFgud4biE7w+Mvf04cTuGo3X
	 U3cZ4e4kdH4Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] s390: Add ftrace_stub_graph
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260724141318.1037434-4-hca@linux.ibm.com>
References: <20260724141318.1037434-1-hca@linux.ibm.com>
 <20260724141318.1037434-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:21:25 +0000
Message-Id: <20260724142126.62C1E1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724141318.1037=
434-1-hca@linux.ibm.com?part=3D3

