Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263315;
	b=yxf2276c59pilaIE9BhP/E//VINPEXlUBAtNoc4aFzHVS528RW4yMesGBGay4FFXtKl2
	 f7AL/NhEjiIj/9SgnLgn5vh0K/j09HULmyyO4r269DDO0HICI0FNk2on2wrndTEzWjK3o
	 XquMqncOITDJyxGlEKKm6VlgiuD0UJ0pNqw6Dln5lURIPLoiFFPSlMZgqyWHhwVVmbY0k
	 ZeQb+B/yMnaIG5LEekc6keyfTc9MdW/YGuaIBITCCSYqqpH1LDWhuAvwu9grw1rmMImgi
	 /VPyiaan6FUTOBu3rUJmIDG3Q3mmjDs1ew3e/0Kk1PQg/BEYTD6tRXaKF2wubafMEPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263315;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pUBdHiJGzKl8l+eoQfGciTWPHYleT9VwyYuxFmTIgdc=;
	b=j6g9lgHjqal+RdBHI3WJzgmOfa85kFDPefLWbGuCJheC0FP8yawuig51wX4vNNg0NeMW
	 mBeG4KD/Qg7IMrpgbYGc3x3sIKB9MGsKNVx2GSZdAw0ZX95fvRvZLkWER6TR/o6Hba8cm
	 sLAGmFouTgdMN+gxHXrOCrQzszSQ/SaolTbqrmMzNYLJ8TgdcjGeLuescxYJxS/O5qulu
	 N8y4afyr82SW22VyHflWC+47kFO3bqdBfZX4pPp9JFbg7R++RWCgKfxQl0/lgGmCO7bNZ
	 FB+k/opg4in3siDBZbaoCdNplPbDWipJzh3/STkAc3QQSrs57row/ym6fNm/9sX+inQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YBzPL/yg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246C606A325;
	Mon,  9 Nov 2026 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBzPL/yg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4601F008A2;
	Mon,  9 Nov 2026 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263315;
	bh=pUBdHiJGzKl8l+eoQfGciTWPHYleT9VwyYuxFmTIgdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YBzPL/yg03mWS3XqRXmrHXlik/p3+jSTwgAAGv9waJZ/PkBoY9gvXMDJxA3+UW+1V
	 YN2PJJfpNM/lpuO7W3q6rqAzi6O/thqhPw+Lf0uHrG9HNBbNByHqoEr0ZSHhpajaCQ
	 p1e0B6/s9meI3vgwxyH8xxjcBkmKyF7oAu/yu2/Vxw3ByyDzge8mtbZrBNLZEMq5r9
	 rYzqh8wnInixnwxjzUsX7kEIsqdLx48mqS1LPMaXU4/SZ5fM7Ve/tELwOtqNWNptfa
	 Grm7jojkCbEGhnpUUYN9P4ZRJwEz2TOXmkmqDiGgaK81oHf+uFDp+GzFQmk/+xIPb0
	 o0YW8VFLq2G5g==
Message-ID: <sashiko-outbox-205738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/12] KEYS: key_garbage_collector(): process in
 chunks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108222719.304712-13-jarkko@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-13-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:28:34 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108222719.3047=
12-1-jarkko@kernel.org?part=3D12

