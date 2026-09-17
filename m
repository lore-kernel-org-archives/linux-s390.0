Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931D47CC73
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689201; cv=none; b=ne2pD4cwVaacFkarYl7EZKS0KJskddwmzcZpzbVcVIW1rRhc6ehZ1N3gBIgHEkSV9Am+Hd/dRUaU4ZlgphYaZh7O7sbx9GZX/CBqFexTWcqVU/s57q1oJm6IOjNjjVXIMWFWCjkRFVXAZPIChOwJBX+5DJfx3NHQaBZ4a0TgQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689201; c=relaxed/simple;
	bh=0o8gZY60ezG4dvpqSkdM3Mi7lvWdHV//e5Qur/bbjzs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RfnzYsv3W4otUwPL0H7aEZCMHcKCQBkQvC4KMeHUVM/p+IvQ0JQKX7SNU7SvoRYuIyNfTxtdnD7GTox60Z+J3B9KMAJlRJkAOq59urPB+HFDmg8+FELqVq/qqV5OZxDVaj5LKXOFLgz5C/cuqRFDWOujRFRcznB2Cpzt511J/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS22aXKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS22aXKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D26D1F000FF;
	Thu, 17 Sep 2026 23:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689200;
	bh=lZsR1qO4SfgeWOzE21epYFpBgKxc0ZfFdrv+AcJFMlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AS22aXKp8LvSzjG+BsYNRrdGlKImyPpzENVi+vPUVFLsOei2Hh1m6iIVUvLDW47QN
	 xPgS969exB6x2CnTbdWSaTMlmPpzl3LLoy7QcyqIckG9v8w3XVeM/FDv4stU6u0ZZ9
	 wg7zZWQ5ka3DghnXss6g1UKNqzwv31dA8XlUIu46mEY5gyOO4bj2SFGhoLD2dgudFp
	 qxKEkeuKO+/5Uy7FI4dC6UDuOJv/yAf+5bVY8fJsabtJBCrbtotjfjYEYxFDQaQD9X
	 t0Nm1RoTpCyUR85OQi1nMyLjDzxOqTvU9E+29Q2xoDtQVRczlgcpDPsuG/Kx/J/RPs
	 jT9CK/QEN9Aeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/13] sparc: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-6-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-6-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:53:19 +0000
Message-Id: <20260917235319.9D26D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove some of the duplicated code by using the common syscall number
> table.
>=20
> The generated files are not exactly the same as before, but they have no
> functional changes:
>=20
>  - syscall_table_32.h would generated lines like the following
>    __SYSCALL_WITH_COMPAT(422, sys_futex, sys_futex), which is equivalent =
to
>    __SYSCALL(422, sys_futex)
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D6

