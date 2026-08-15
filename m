Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71C360EF3;
	Sat, 15 Aug 2026 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809886; cv=none; b=EJXtGHL4r6kNyxjVRBVa//9giKI0fj1KZY4qasF3QhxdznVKcsTV4EmkSodnAbXoSc9C7wPbY8onuMrj0BIliyRl2jhK73WVkithscP54bB3MrWuLXceXAmFFY3jJvFmwxXVTjDCEhP91PNeT4jx3WomElqXilajFM+6UgtIZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809886; c=relaxed/simple;
	bh=lxCJFVEWw4OrMoY95QwH9gqQaRnelqKQW25ZWcmYKfI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FFa3H8Qv9VXonlhO7BhxCKgVGTRrGU0Msd1n/1sxgZKkBC0oS3YPFVloIpuBWTNiiNFy+/2opQVE4GJ2NiIjNmlFQLktga+FeH091Pz2QdFSC8Denkdx+j3dvANtWAZkPDLLy5rw1mVk4AmTU9q2hvvnDVRCTVR5xqwstI0mV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXtV6FTh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXtV6FTh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA05DC19425;
	Sat, 15 Aug 2026 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786809885;
	bh=lxCJFVEWw4OrMoY95QwH9gqQaRnelqKQW25ZWcmYKfI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mXtV6FThcA1nphE+1AVneVQerMTttqX6yJk85/j3V/QYrLlkeTgaCFr+uLJK22Zs9
	 YDmqGNWFFgn931f9HEBKf7tgFYxbDYRqfKLtnH0gGjuzWDgkVxrRMwB2JtRnO3taM/
	 K5rJYVcfBb7iw//4dp5NGRyG3jaZhGiTNmG7B316AzsStDT8LEUEch7BgXmvIH/0u1
	 YmaOK4eVDFLkNqGJ9ZRqLE5QcnOIswRPsf7ni8Q1kzPtrRgXt6DeEt/UbuJv+OOxpw
	 dbWraev3Qg304ByUPWwODru9Ng47rWgdNMMAwTqrjLXXWbaAR5ekUVMMWXFzJFlgZ/
	 Hx3Cv1c9O+Szg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D626C5CFDB;
	Sat, 15 Aug 2026 16:04:45 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Subject: [PATCH net 0/2] net/iucv: fix the recvmsg window update
Date: Sat, 15 Aug 2026 11:04:44 -0500
Message-Id: <20260815-b4-disp-8a791503-v1-0-fbae9a511144@proton.me>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMzQ6CMBAGX4V8Zzdpy0/BVyEcSll1PVTSRWNCe
 HerHmeSmR3KWVhxrnZkfonKIxWwpwrxFtKVSZbCcMZ1prctzQ0toiv1wQ+2NTUZ58MQmug661G
 yNfNF3r/liMQbpr/U53znuH1nOI4P5MXkrnkAAAA=
X-Change-ID: 20260815-b4-disp-8a791503-027a9a4c2617
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>, 
 linux-s390@vger.kernel.org, Hidayath Khan <hidayath@linux.ibm.com>, 
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786809884; l=1404;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=lxCJFVEWw4OrMoY95QwH9gqQaRnelqKQW25ZWcmYKfI=;
 b=LAoLU1jM2OVywsGUP/5QozfGXtCPTOKKvzHf/BHkIx2+DCrG17ARrv10YsCnkiKw5wcrllMzr
 uGmnPdRK7pFAEibifId3sRBVCFjcN20wUTyFaZ6t4gLK0EiJAmTEljW
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

Two independent defects at the same call site, found while accounting for the
socket-locking rework and kept apart because they fail differently.

The first is a missing transport test: recvmsg sends AF_IUCV_FLAG_WIN, which
only exists on HiperSockets, without checking that the socket is on that
transport. Reaching it takes an application that sets SO_MSGLIMIT to 1 on its
own socket, so it is a correctness fix rather than a security one, and it is
first only because the second patch reads better on top of it.

The second is a sleeping allocation under spin_lock_bh: iucv_send_ctrl()
allocates with sk->sk_allocation, which is GFP_KERNEL for these sockets, inside
a section whose other allocation uses GFP_ATOMIC for exactly that reason.

By inspection; not reproduced. Compile-tested for s390x. Both are tagged
for stable: the second's context comes from the first, so tagging only
the second would hand the stable team a patch that does not apply.

---
Bryam Vargas (2):
      net/iucv: only send the window update on HiperSockets sockets
      net/iucv: send the window update outside message_q.lock

 net/iucv/af_iucv.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)
---
base-commit: a59f57e2aa127c5354168d2ec4bac920df1be4f4
change-id: 20260815-b4-disp-8a791503-027a9a4c2617

Best regards,
--  
Bryam Vargas <hexlabsecurity@proton.me>


