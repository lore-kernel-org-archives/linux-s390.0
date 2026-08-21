Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D153352F95;
	Fri, 21 Aug 2026 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343007; cv=none; b=Qhf6NLm7P4Uoh/ReiqAtB+4F+rS9v7vP8HPLgW41Y+NeWwW4062E97+fZmtw5HP1MB5KJLDRmz/Jj0Q386PTz/PZRCwnz2RVA5wm3IGvmVr6MHp09zDu/AxayTGHoCaJopHbHQ8h+Ii3BpPgnnzjioW+6BkLCN+M6mQkJ67nRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343007; c=relaxed/simple;
	bh=uvjXAhvyyhct9a/9vdRWEj9OiXRgp1voK1RDQeUmJ0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T+RfnGu3xt51a3pM7ra6PmgeWBSruA5RmS6k3Mvmfu6/t00Anb5CQYa6tAJgN1OcGKvLawNkmKuNydegb43Kik3IoAJvuKTXbOsuAkKByyDwuVmPbnfDcx0vX9GGFvtx8KvYdlGYJ8yyD3fWCxjzx/cBF/wHCMyA/BQTT9D9HG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTAXkx0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTAXkx0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A8C1F000E9;
	Fri, 21 Aug 2026 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343006;
	bh=uvjXAhvyyhct9a/9vdRWEj9OiXRgp1voK1RDQeUmJ0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gTAXkx0a/GTi5jHccCax/7fM5RIzx6214m2Xmhow0RE2qTWPUcwGI/tb3HLGO0elt
	 SUxt/97GFMs7V11Jls6DWHCiAxji+4lOAJDP1ntmERkUT36UApUSVKV4OWIruF8IzX
	 ayUCNSa6BRX88nm74m1c0V4Vl0XQUWyWLhJYrycVX3aD0CdKcT8fhTVK23Fd+tFWoK
	 j6lIvkL9wXBXLMhi/C9FklIf36UnrP4XoB108h9CwcGrOllEykwLp771B86K3rJl1t
	 aShKHHawVqhnrw7SaWVUuR37ILnVWl+xzwfEstBs+UAYMooMjz+Qvoi7QAglPstYlF
	 4DR3vj8h8xveA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/24] unwind_user/eh_frame: Detect .eh_frame_hdr
 sections in executables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-11-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-11-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:10:05 +0000
Message-Id: <20260821201005.95A8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When loading an ELF executable, automatically detect .eh_frame_hdr
> sections and associate them with the mm_struct.
>=20
> Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
> implementation.
>=20
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D10

