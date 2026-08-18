Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA2537FF70;
	Tue, 18 Aug 2026 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065797; cv=none; b=AWCnSI3hjO4t2dPAw1xxfnxYvy/UW/NYzyi/Czpc7xRnS923xgQf7ZYe0oDThGQkMKuunUYUgsPwMmfayBmrf8kfqx3vGrR5TL6cYe/wLuhxaoVxUGecBjC89W280j5iiMuws2cGG9oCg7SPIpem4/UEmsaR7DJDtK2/+nHQrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065797; c=relaxed/simple;
	bh=4frpJ/w1Iiy/k97sfXGEGehnLv3o3dPCRO4d2SUL4QE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J8dQma/7fiATk8exMvoSiafKlSEwvl0cYGjcEBZTO/Xi0UGl9SSw9mIz3fOIuuCOjQeGOLjm7sO8vy1m65VmOPSLBmDER2Ae3k3qbXF3/opddSOtB7oLvS+OjFZQTXspyKkBT5y5BTCZvlD/Uf99zUOE/F6rzQfR/t+MYBWVAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAkz6aKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAkz6aKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FF11F000E9;
	Tue, 18 Aug 2026 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065796;
	bh=d07rECp8xbd7vKMh6S+XNCGwL72XhBlcUJJ+w2hvvt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gAkz6aKiVRw9UgC7f+NxLvNLxZvG/zQ9n/x8Ss1DG80LaLyJtMTq/e+ZeBeAakO9F
	 3+HW2vr3NbbnMjwTQd0BlS/AfVwhLxj6YbX26a4S3z+A/KXwaKmQ5JWmiFLWcWHmVs
	 8HRl0x255tXoft1OTF0ORl3AyuVmL4fZskoEGn0DWuY/wSiwOma6Fv0vb/3spkr7jU
	 D4JPJuJb7KOllFIX0oBhTtPqhAN8z6FIdLBd3tj9wn7bWB0omU+Oh2dS0IO1Wo3nXC
	 +6YG4UfScn3mjgShh2+YEdDK2fjjDUG9rJKyIBczaqwQaio/hopjVQnPSBBGHZtxIS
	 YvYTnTHD90v4A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 11/25] unwind_user/eh_frame: Wire up unwind_user
 to eh_frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-trace-kernel@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-12-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-12-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:09:55 +0000
Message-Id: <20260818150955.96FF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The unwinder fails to adjust the return address before looking up =
the FDE for non-topmost frames, leading to unwinding failures or incorrect =
CFI state at function boundaries.
- [High] Child processes created via fork() do not inherit the .eh_frame tr=
acking structures, silently breaking user stack unwinding for all child pro=
cesses.
--

--- Patch [11]: [RFC PATCH v1 11/25] unwind_user/eh_frame: Wire up unwind_u=
ser to eh_frame ---
commit 409d12d48faaa34ee17f2272fc9cad1cbf48d5d0
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Wire up unwind_user to eh_frame

Now that the eh_frame infrastructure is fully in place, make it work by
hooking it up to the unwind_user interface.

Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
implementation.

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 830c620fe453c..85fc82252af15 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
[ ... ]
> @@ -173,6 +174,16 @@ static int unwind_user_next_fp(struct unwind_user_st=
ate *state)
>  	return unwind_user_next_common(state, &fp_frame);
>  }
> =20
> +static int unwind_user_next_eh_frame(struct unwind_user_state *state)
> +{
> +	struct unwind_user_frame frame;
> +
> +	/* eh_frame expects the frame to be local storage */
> +	if (eh_frame_find(state->ip, &frame))

[Severity: High]
Does the lookup need to adjust the instruction pointer for non-topmost fram=
es?

When state->ip holds the return address (for non-topmost frames), it points=
 to
the instruction after the call. If a function call is the last instruction =
of
an FDE block, passing the unmodified state->ip could cause the lookup to fa=
ll
outside the FDE or into the next function's FDE.

Could this lead to incorrect unwinding state or unwinding failures at funct=
ion
boundaries?

> +		return -ENOENT;
> +	return unwind_user_next_common(state, &frame);
> +}

[Severity: High]
Are the .eh_frame tracking structures properly inherited by child processes?

When a process is duplicated in dup_mmap() in kernel/fork.c, it seems the
parent's mm->eh_frame_mt maple tree is not duplicated. The child's tree is
initialized as completely empty in mm_init_eh_frame().

Will this silently break user stack unwinding for any child process created
via fork(), since unwinding attempts will search an empty tree and return
-ENOENT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D11
