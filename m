Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62B46C4A7;
	Sat, 26 Sep 2026 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431321; cv=none; b=DKd9VsQVjwT+URPBdQxUxTvypXSZsHAVxRbPoqTRoMtmA3YbTdu2v/NKc9Mj2l07uxFxHPPAv3hhUcOzuhbGWjtgxD9r6khsSqaEtveqdxukVAV21PGCvMxbmk3bkSAosxr2GFYFU4X+uONUF92yEOOZ2XPGGlYSyGZfjny3sUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431321; c=relaxed/simple;
	bh=rOzwv+RXST3vhc8rnHZaeWaAOKKKVtWMtQT1hdHXK6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MqEVRnOoeb8UWB9t8bC7Tlqp7uRE1OmmxIrRZFjwP9zf6EQoJAJxd9/yWxMyzAE+WmDxycUNPxrNgLlnh0C0U2iGFxuzgBDE+MoRaqxSroBt+HW3GfM3Y7r1yl9ZPgNd8Yd4htt8c+cDyFTDhmRLicWSv8o+P6vmmb7Pwof7FrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/L71WSi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/L71WSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77C11F000FF;
	Sat, 26 Sep 2026 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790431308;
	bh=M24wL+22kKLphV9B0KKjn9XUd7cjbkZHfniUwCJLg9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V/L71WSi4qCESzuhrKUpiTlO29P0LpuUMlIlgXc3jyaVhwwZNIh43XVhD9pg0WrzN
	 IM2Y6EwqJJ6F39L04uVzoEbeAQfrztmt+7Deo3i1r3K/NdhzHbzP4uAVsCCj/VrIKX
	 1ww+8z5CsLxfG5uCZ48gOXV897TjAOtzQdioahFDmKV7SZfyc4qcXnFD2FZZbWJga/
	 slmYZYQC+cuMAkaSd5nGcqTUxeJrd8Lj6Bo7NtWzeYlu4CgWQvs6mkgWb9c2MpQi2j
	 R07cVBSDywuJDrZs8KcgGMHzxN6NChTBbTkLpdecWGXVA2bZCj1IcYs/ca5JuxlTWI
	 gpUiSk7iyRvdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v5 3/3] selftests/bpf: Detach a trampoline prog
 while a task sleeps before it
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RmxvcmVudCBSZXZlc3QgKEFudGhyb3BpYyk=?= <florent.revest@linux.dev>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, bpf@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260926135605.1217928-4-florent.revest@linux.dev>
References: <20260926135605.1217928-1-florent.revest@linux.dev>
 <20260926135605.1217928-4-florent.revest@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:01:47 +0000
Message-Id: <20260926140147.E77C11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add a test for the use-after-free fixed by the previous commit. A
> sleepable prog on bpf_fentry_test1() blocks a task on a userfaultfd
> page, like bpf_mod_race does, while the two progs that run after it in
> the same trampoline are detached and freed one after the other, which
> the test knows from their .bss maps going away. After the first detach
> the task is in an image that isn't the trampoline's current one
> anymore. The task is then released and must not call into the freed
> progs. This is done with fentry progs, with fexit progs, where the task
> is already past the original function, and with a task sleeping in a
> fentry prog while fexit progs are detached, where the original function
> must still be called. bpf_mod_race's userfaultfd helper moves to
> testing_helpers.c so that both tests can use it.
>=20
> Without the fix, on a kernel with KASAN:
>=20
>   BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_enter_recur+0xed/0x1e0
>   Read of size 8 at addr ffa0000000144040 by task test_progs/171
>   CPU: 6 UID: 0 PID: 171 Comm: test_progs Tainted: G           OE       7=
.2.0+ #1 PREEMPT(full)
>   Call Trace:
>    <TASK>
>    __bpf_prog_enter_recur+0xed/0x1e0
>    bpf_trampoline_6442545468+0x72/0xe3
>    bpf_fentry_test1+0x9/0x20
>    bpf_prog_test_run_tracing+0x183/0x3e0
>    __sys_bpf+0xd3f/0x38f0
>    ...
>=20
> Assisted-by: Claude:unspecified
> Signed-off-by: Florent Revest (Anthropic) <florent.revest@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926135605.1217=
928-1-florent.revest@linux.dev?part=3D3

