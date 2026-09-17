Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C13AA4E8
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689247; cv=none; b=J2a4Mr8d8oczgmQ/3gzebkJkQ/fSFrknOuuFIgu0jH/UWLmfE+0b3/C7LqymvISsur4e4E1KwASZ22HRvEBTm+eade957NELBVVpyCM3j8bcJpqhDdIO3I0E7gz0evVqXzQ2jBHNdwmc/QhCGABFDH6vPxdDAEOx8/Ye46ARrRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689247; c=relaxed/simple;
	bh=Zi5mEomaCyP8bfJyo9ggzeZRcf4XbxLIxbCaIU29W5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pcpJHYCe088CgpiRSQoifOxBH5d3Ouv/WP529RurQwXHL+gw7IVpHhsoJR+qokntzRLY/NzFvOYJpNJY7RxS4kput2DS82bdjHkLLBe+vPQLvD5tzFPn3s4iaVcB+rsuHKfnhfO2E6zTBuWkmjHteIeDZfYguvWOSO3Ay4cCkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB5d4gbi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB5d4gbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E821F000FF;
	Thu, 17 Sep 2026 23:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689246;
	bh=TjB4ZkSEIwOMC+kZ/zuVf6JpWxLIDvi6oEWhVsu/2bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gB5d4gbiwgW3B7K5gG7XXIys9MdlXqxh0LIPeCJkJzQ+8nF2U+pbrzOAMriw7FkWb
	 5PJQSOjgS4eq3LOgma0GSCxp/wke4rHanGcitc6QvzNNBLejmonFcSqt/WahmfE6bu
	 S0NU8LNiBpgmyAQFjh4l1cAvgsOEniI4gbkQuq8XGUSTQ302GL9sPeNb10gVXIZY9j
	 SuYiT/71rq1WOKX1iVYoFKJRl5srHfB8MWn+z1Zh4h9OhUF6Lk8JpwFKEG2pan+RNg
	 Wg3jC0epZs0fwNJtZIH+DwK8ovIr1uP8AfinKpMV7IXJo2b1WX3U7Ko0hQhpkl4Xxp
	 4PYqiNiTbPfIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/13] mips: Get rid of custom mips ABIs for syscall
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-8-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-8-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:54:05 +0000
Message-Id: <20260917235405.E6E821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: MIPS syscall tables in tools/perf out of sync
--

commit 19b1ee646fc4511ddca3c13a30ae4d1f9c4582bd
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
mips: Get rid of custom mips ABIs for syscall tables

This commit replaces the MIPS-exclusive ABIs (n32, o32, n64) with "common"
in the syscall tables. It simplifies and unifies the tables without any
functional changes.

> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel=
/syscalls/syscall_n64.tbl
> index 83dc93a0712f1..4341b2fd96dad 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -5,385 +5,385 @@
>  # The format is:
>  # <number> <abi> <name> <entry point>
>  #
> -# The <abi> is always "n64" for this file.
> +# The <abi> is always "common" for this file.
>  #
> -0	n64	read				sys_read
> +0	common	read				sys_read

[Severity: Medium]
Does this change break the perf tooling build?=20

Building perf via make -C tools/perf runs tools/perf/check-headers.sh, whic=
h=20
compares the kernel's arch/mips/kernel/syscalls/syscall_n64.tbl against=20
tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl.=20

Since this patch updates the kernel copy to use common instead of n64 witho=
ut=20
updating the perf copy or its generation scripts, it looks like it will=20
trigger a Kernel ABI header differences warning. Furthermore, if a later=20
patch deletes the kernel table without updating perf, perf's MIPS syscall=20
tracing may be permanently frozen using the old, stale table.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D8
