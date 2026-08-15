Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DBC425CD2;
	Sat, 15 Aug 2026 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786810046; cv=none; b=D6zxysOeEZfxcIgkBob4gQI37fWiA48n65sWI29HHm3KlfgQdK6jvwg0MXP9p6XqjIpLElZgRbSYpYkqc2KputVGwufpUpApO3l3B9mQBA7HM/ZojXnGZTemJXkOFODveyBbVnrHhOTf+mo8R8MSyKTpI9/f1XhKLKzxiESKI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786810046; c=relaxed/simple;
	bh=qZ0dW4sEjY6P00/iB3q5ocylvUh8bfT8JtKM9xlASfA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EeS9GflArINETp1TH86qb9BmQRl0+FV7e6wYh6L5dwllIM1yto/nBwmSxffO+9MqTS4bW2sFould7L8L4gCemkkeZ8QqWjxSAA1xHTbtGBIYH6gQ1AodNQ3xlg1ThcLmeOeRVB31FE9rA3jyf5sKF41NfW8+2mSl/7lqtHQLtus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2auRpXs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2auRpXs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4113BC19425;
	Sat, 15 Aug 2026 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786810046;
	bh=qZ0dW4sEjY6P00/iB3q5ocylvUh8bfT8JtKM9xlASfA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=g2auRpXsLSdzHV+bYyszRllei2fau4eJJnrtQ+DIFvm39FOhoXt+LV7TLWXX77H3y
	 sB+MA992sUpZrbfDtkDVwOglK0AvH3vKnH/eBOHVk6JLNtYKwDAmOYB7bzFXio4vEK
	 shCFOeNs2lGic4BAOON7PwgM27AYA/K4PIgbSQ/6gK7M/cY4Y/103pul7mpp0gWvjf
	 U3oaZaLZXO3vWOSUka29gNWkPe9ZCYOU0PPo86CjPyogSFHsXKKn7z9TnK2trMHD/F
	 QqqtSirAZhOJn6cYmwbM9SO+fvX2KnZGNVLOevJgM7wA1834mRMsn4B3ViK4mGGcAX
	 K+fAULGTUCvZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDD0C5DF67;
	Sat, 15 Aug 2026 16:07:26 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Subject: [PATCH net 0/2] net/iucv: give afiucv_hs_rcv() the preamble a
 packet_type handler needs
Date: Sat, 15 Aug 2026 11:07:25 -0500
Message-Id: <20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ6CMBAFf4Xs2U2gUoP+ivFQ2ldZDpV0kZAQ/
 t0Kx5lkZiNFFig9qo0yFlH5pALNpSI/uPQGSyhMpja3umss9y0H0YmD70wMaPnqHSyscbhHKtm
 UEWU9lk9KmOl1Sv32I/z8n9G+/wBtVxAUeQAAAA==
X-Change-ID: 20260815-b4-disp-dc82fde4-3cae5e52ae9f
To: Thorsten Winkler <twinkler@linux.ibm.com>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Alexandra Winter <wintera@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ursula Braun <ursula.braun@de.ibm.com>, Simon Horman <horms@kernel.org>, 
 Hidayath Khan <hidayath@linux.ibm.com>, linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786810045; l=1944;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=qZ0dW4sEjY6P00/iB3q5ocylvUh8bfT8JtKM9xlASfA=;
 b=qIwsnmZSn/zMILGaHfwh51RG3zZfPtha1r5PSugqAjXSY2MgcLBrg8FH+jzrjJV9vmzPb5wdC
 1h0Revd4GMoBBHEqp4eU4mWiD+Csv6P3Kr7or+e3bJnBnq9NbNty0Nr
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

iucv_packet_type is registered with no .dev and no .af_packet_net, so
afiucv_hs_rcv() sits in the machine-global ptype_base[] and sees every frame of
its ethertype from every namespace, on any device. It then trusts the frame: no
namespace test, and no private or writable reference before it rewrites the
payload in place.

  1/2 drop frames from other namespaces -- the only one that crosses a
      privilege boundary, and the only one tagged for stable
  2/2 unshare and cow the head before the in-place rewrite

The two siblings differ in how far they go, so I will not claim more than they
do: net/x25/x25_dev.c does the namespace test and then takes a full skb_copy()
of every frame, and net/ieee802154/socket.c does the namespace test but does not
unshare at all. 2/2 takes the cheaper of the two -- skb_share_check() plus
skb_cow_head() -- which costs a refcount test and a compare when the frame is
already private, and copies only when it is not.

2/2 also covers the headroom that afiucv_swap_src_dest() pushes without
checking. That started as a third patch; it collapsed into this one once it was
clear skb_cow_head() is needed for writability anyway and asking it for ETH_HLEN
rather than nothing is free.

2/2 was surfaced by the sashiko.dev review bot on the thread of a previous af_iucv
patch, which flagged both the missing unshare and the unchecked push; the Closes:
trailer on that patch points at its report.

By inspection; not reproduced. Compile-tested for s390x.

---
Bryam Vargas (2):
      net/iucv: drop HiperSockets frames from other network namespaces
      net/iucv: take a private, writable frame before rewriting it in place

 net/iucv/af_iucv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
---
base-commit: a59f57e2aa127c5354168d2ec4bac920df1be4f4
change-id: 20260815-b4-disp-dc82fde4-3cae5e52ae9f

Best regards,
--  
Bryam Vargas <hexlabsecurity@proton.me>


