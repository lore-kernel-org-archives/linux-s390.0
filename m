Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143788;
	b=K5tvUZZSrke4o3Di0C0v1MojWLwUZEmmGZCP2RggOqsnTzsC3wtTb3joitz0soOqATud
	 xjn4B76ZlLchzd6q5pxlWo50OW7J/by2KYf9QBS69pyLz97fercRdQv79OqyGwTz/My1p
	 BeU1EtqHOnTlMbXfXljwARjV+Yl0yAG8NdXQAdAg6y1EbpeGf2xzG1bet7trsGfGWpXC3
	 Bq18HWgb8dzFUtMK7B3CND0xhuA3w3jsVPG3Cj7gRf5nWROZnTJYJj/Qa+8bs45uvL0aw
	 5PFM3x54ETJBZPKr+/CsAeN0SyfNpwIEs1CBbbYEt0y/b0yW1g2MD/Lxro5LXt8kkTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143788;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q+nnojVXa4NsAOUSZuLRdLe09cqs88FQXiU4YHDsTWo=;
	b=0p7hlI07wvmENz9lYnys/AtYHdiFvH6+bfZAgKQta6DFcC7MymoS091Uh49u45HIZgzW
	 cVwFDmMg3Lno5Ni6wx2cLoyw5taVOH9E+599PSCslA4HlyMNMllURIq9x9FcwOmymjHbm
	 oV6kk+7RhLC/Bqol0RbvOnNvmJUV29gWp7gpDbuIOanr8G12oJPe7SWrMP5jckzJ3CGs9
	 aT48QtWdB7D6xxPLrU3q5x8fGm2iDB8CFpEEzNJhDpL8gfm9pZL6slWC3B8eA1tJMNTJp
	 zBYFO4GSM3Gc7vxMKj0uWmRtIGzGRNS5iIEnZPtz9rqatHZ2vxBXsDzkYYzvJw3DiiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dkjfUgL/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217AE606A322;
	Sun,  8 Nov 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dkjfUgL/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639991F008A6;
	Sun,  8 Nov 2026 13:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143787;
	bh=Q+nnojVXa4NsAOUSZuLRdLe09cqs88FQXiU4YHDsTWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dkjfUgL/3H4bpbFf/zqj3gUuFSOMVY2O5xArETrR4t9paA6dvEDFNqlXd4A7FLHxN
	 9sEK/vGf9vE6Pd47wRd4ZJe9jR+sJPZ3xPB62hfXZOqokAAiK616HP8zkUsa3EE/+W
	 +g7uKprHM4YAAa6i9j2+kDlxwV+7rwyhO6x/kcyTlwqA12iuTybhyH+hTcWlh86vC6
	 jcACBKybYiloj+Y2CN4UJiWVfpteg7h8TbbBG+yvrdHy2nbbw7MfTg79H4TA47RY8T
	 oRUchKwbPNUTBOmtTjrqVTXwgdodxyCFyW4pRd9aeisJI84lt+PLx+K3ZQGrLa9Y15
	 atiqCEldcFvqQ==
Message-ID: <sashiko-outbox-203770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/11] KEYS: key_garbage_collector(): process in
 chunks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261107131512.3603168-12-jarkko@kernel.org>
References: <20261107131512.3603168-1-jarkko@kernel.org>
 <20261107131512.3603168-12-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:16:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> key_garbage_collector() has a design that is not resistant enough for
> workqueue lockups. The duration scales up relative to the number of items
> in the serial tree, which causes a reoccuring theme of being guilty of
> causing workqueue lockups.
>=20
> Resolve the problem by processing in chunks:
>=20
> 1. Declare a static variable key_gc_work, which owns the garbage collecti=
on
>    in-flight state, and key_schedule_gc_work() for re-scheduling the work.
> 2. Define KEY_GC_CHUNK_SIZE, set to 64 keys, as the bound for the number
>    of items scanned and destroyed.
> 3. Define KEY_GC_DESTROYING to mark resume to destruction without repeati=
ng
>    the RCU grace period.
> 4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
>    the continuations.
> [ ... ]
> decline.
>=20
> Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their key=
type is removed")
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-=
test.git/tree/package/keygcbench
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107131512.3603=
168-1-jarkko@kernel.org?part=3D11

