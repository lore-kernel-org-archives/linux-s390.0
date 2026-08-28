Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830B3AD530;
	Fri, 28 Aug 2026 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942091; cv=none; b=JlGwCxzVmxWgqVXp34gcYl0EqC9ADQFzousDVFBvNUrU9woMJDmxIjydUpVgw5R4UPJi6hOd8yA8o9AsQf51XuHXOtaVF8UE2VKahvjDeZ8c4bi6VmmjGITX9wfcYh4Mhw8o1EzX9RbmiZ/97RMEseR1X80/EzpnB/7kzUlPtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942091; c=relaxed/simple;
	bh=bPZUsoU6njNJJodvUEfBisKbLN9MZEaSCb77w7jau9o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCm5FUAbfH+aZQUarO+bN0zOu2fAgjYn3ryoeeR8C79kS/s/ZOlV9ntIxGl/a4N5WqBw9gxVSjarKf2jU6V8LPWNDWWdF7Dody+c5h2sTJ61LwlAZiBKZ+Zvfr52ORzXKQphvrmDZPx0xpiB6FnqNWO430zEwv/6llwv0kcYVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=T9H9gi1K; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="T9H9gi1K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1787942083; x=1788201283;
	bh=bPZUsoU6njNJJodvUEfBisKbLN9MZEaSCb77w7jau9o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=T9H9gi1KbVgbugyaeV/2mKNNJpr1croDJ29KTjMj7lCNRiTOXAVCGuiyB21Jz608x
	 dLFbmZTKS1B9nawRPtdg1OcGQH4soHC0J8liXzKBgMdsN0T30kdJkxs9yJqT1NomyF
	 eeue7mnywGMyQ2ckn9hYec+I6yOd32N1Wf3T2aTlMjLRLnaj0u6gvp1REME8pMwFS3
	 7d+pBZdfCUU6H66Pn2FPU08LioG7hRLGeSrqyUaZMBExbCzifqd45WTXDyG1VkkKtu
	 Wl3zqeZtbTyfjaD9KXO3eGuk4/RjAM2Y0kZkrFFDQGUS9ProsQRq7EOkkq7fP/5yvq
	 yaskcAPcD9GVg==
Date: Fri, 28 Aug 2026 18:34:39 +0000
To: Hidayath Khan <hidayath@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] net/iucv: af_iucv socket locking - accounting, and a staged plan
Message-ID: <20260828183431.21830-1-hexlabsecurity@proton.me>
In-Reply-To: <5f88daf4-cd8e-4464-b132-ac45be205121@linux.ibm.com>
References: <20260724222917.134769-1-hexlabsecurity@proton.me> <f74b9587-c09c-4fce-9415-e2d3b49d0247@linux.ibm.com> <5f88daf4-cd8e-4464-b132-ac45be205121@linux.ibm.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: cbb7ea84ea102673dc379a83493996ca29f6f599
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hidayath,

> Let me know how you'd like to sequence it.

Don't sequence them behind me. Send the accept_q_lock patch now, and take
iucv_callback_connreq() back. I asked for it on the 21st assuming the rewor=
k
would move, and it won't for a while: I'm in the middle of a larger project=
 and
have only a few hours a week for this at the moment. Holding two patches an=
d a
leak fix for that is a bad trade for you.

One thing worth having before the walk fix goes out. The lock on the walk i=
s
necessary and it isn't sufficient. Both producers link the child and set it=
s
state afterwards: iucv_accept_enqueue() at af_iucv.c:1916, then
nsk->sk_state =3D IUCV_CONNECTED at :1917, and the same order at :1693 and =
:1696.
So the state store sits outside accept_q_lock, and a walker holding that lo=
ck
still reads sk_state at :1372 with nothing ordering the two. iucv_accept_po=
ll()
tests exactly that field to decide EPOLLIN, so a poll landing between :1916=
 and
:1917 sees a child that is on the queue and not yet CONNECTED. Moving the s=
tate
store ahead of the enqueue in both producers closes it. The lock alone narr=
ows
the window.

> while iucv_accept_enqueue() appends from the IUCV tasklet and the
> HiperSockets softirq under bh_lock_sock(parent)

Small correction that doesn't change your conclusion: the append's own lock=
 is
spin_lock_irqsave(&par->accept_q_lock) at :516-518, not bh_lock_sock. The w=
alk
takes neither, so the finding stands either way -- it matters only for wher=
e
the fix goes.

You're right about iucv_accept_dequeue() too. Its walk at :542 is equally
unlocked and can't be wrapped the same way, because the loop body sleeps in
lock_sock() at :544.

All of that is source plus a model, not a run. I have no Z.

Thanks,
Bryam

