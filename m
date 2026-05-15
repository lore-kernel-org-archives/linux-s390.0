Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE55F4014BF;
	Fri, 15 May 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834022; cv=none; b=hHU9BKuUsQO+1wTQ6cA7BhU4FTvQBLkhCaqJp2rgfXG01IXIYlton45WABE2wVQgkBnZWIlg3+dUFT4kSBVbbCqWdJB1GcRQlwIBNDcLl7xxIStM06CkQwRbmzk7F/Djv1rAf2dwVWgd5OHmuG6xp1XaSHYzVhAVo5eEfFTKUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834022; c=relaxed/simple;
	bh=r3aY/St8onmv2WMn/YdM5BLkf13sTNve3esoUyo6Ius=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LK7uW2BGOsJmuGJlst6bFSCEIeqRXw1Ygm+FfuG4qBdezVEByNt2rdP+ifF8Dq/tcMZqFe93QqNAKwbHJyJb51gwQUR/m+/78HWoRwX2fuczFAj9YxwD8L1bWHz5PkUWdskxQJwMRQtpnNnEc7vMZKyuxVyyHmYeypmKk5OzGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=LqvFYMrv; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="LqvFYMrv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=QxR0E2L6NWF+6GLB+GEt4tksQju4Ihs/iQYSDJKIdbM=; b=LqvFYMrvGeDDx5WEdn6ovMeyDH
	j9GC9BsP9UKU6FpITt1CyKAuOC/qq4X+A16vYlWs3unI82VW2dSkgJwCAbBzWFABYbvTqTQeBK72M
	SEYMnKnNEfI4UzeBSFSdwddihK0QraeV1ykz0cWCECV8u4i2hmOqsK56A7/fdWnlpxIFv6O5eQ5jA
	NJCJ7yP1AfFY7HBXgZsqUgNuaL721RMXT3TvnLoDTnTQkGgUwFISOHcM7l/hmwD4XLoKGrbyLCfG4
	8TlYRDy5xSEFoOmuftA1ekTM0QtulRziTrYhfvNcHIRSkSRyN2xRJ2UJrbHUVIZaV7QTvqepBKA3p
	SS4qyz0Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNnz5-004b9G-0G;
	Fri, 15 May 2026 08:33:27 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 15 May 2026 01:32:25 -0700
Subject: [PATCH net-next v2 1/7] af_iucv: take socket lock around
 SO_MSGSIZE getsockopt
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-getsock_four-v2-1-0d8eed952627@debian.org>
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
In-Reply-To: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
To: Chas Williams <3chas3@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, 
 James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
 Marc Dionne <marc.dionne@auristor.com>, 
 David Heidelberg <david+nfc@ixit.cz>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, linux-s390@vger.kernel.org, 
 linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=leitao@debian.org;
 h=from:subject:message-id; bh=r3aY/St8onmv2WMn/YdM5BLkf13sTNve3esoUyo6Ius=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBtpKuS/NWfm4L0lPfAGkJxZnKMXJFTUlUcHap
 g1jEGEOWyOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagbaSgAKCRA1o5Of/Hh3
 bQcyD/48l4Yh2ujGKEAudnJbPj2vOqqAz8Y+aMMojwzjItuByCzEDxnStHYteaKKSckBGQPt15q
 UeGKz68CNKxOMSG9UuatV1x/Cerj7VhSiv8sApsEw/ze4iDW3xPVr0f1u7jKdUsxF2Mt48GJ065
 iQOJXcVjpR8Zyn+8972CgY0Y7ySvf1nOIeXkQ0BlPPQOm52FQvJv0ERY/EleQocLxDBPXMBQS34
 /pn7s/s4yWY6DhVmkauNTJA7uBh3PJpOe2pZuaoUw3N4LUdL34+AIYuDGj0YGob4Tq2hmigQvhT
 WnenUIDwSlJauCFDkWKza9VvzPgvp0IrBUcYaQwEF/Znt60inILK0ainmq0JAyQqFiE2dXOagBi
 L4vXsTfBGmk6vgvh6gu6Mf+G6AaMDa2ef0d5t9XR+fHC2oX0o4Co/Wh4WAtYlYeyx8JH0SVhgbz
 dON5cJvxhy0YXVbb/NYC1fex4BiXAEP/db5IPZezxH2wo+9mvzV8ueuEtayJW5DmUi6/GmEs5Lk
 OcKCpKnAR8I0UU+7HHcwTMQiHIE85tfX+pnaSxzgqUQWRzeyNeWKOk70melSEVCsT38wY6YEyqj
 IP6w2vA2AA+4EuEDsur7LMtZ5VRg1xQRYdl3WaAUcMOALllybmhjsmHHon0pPDsKMVj3oVSBHWA
 p1GvwOcEXIU+ulQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Mirror the locking used by the SO_MSGLIMIT case directly above: take
lock_sock() before reading iucv->hs_dev and dereferencing hs_dev->mtu,
and release it afterwards. This keeps the two adjacent getsockopt arms
consistent and matches the lock held by iucv_sock_close() when it
clears hs_dev.

This is not an exploitable bug. iucv_sock_close() is the only writer
of iucv->hs_dev and only runs from the protocol release callback,
which the socket layer invokes after the last file reference drops.
The getsockopt() syscall holds an fd reference for its entire
duration via fdget()/fdput(), so iucv_sock_close() cannot run
concurrently with the SO_MSGSIZE read on the same socket. There is
no other writer of hs_dev, and the aligned pointer load cannot tear
on any architecture Linux supports, so the existing code cannot
observe a NULL dereference or use-after-free in practice.

The change is purely defensive: making the locking pattern uniform
across the function avoids surprising the next reader and removes a
foot-gun should the close path ever grow a new caller that does not
hold the fd reference.

Note: For the reason above, it doesn't contain a "Fixes" tag, and is
aiming at net-next instead of net.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/iucv/af_iucv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 72dfccd4e3d58..3dd11d7a967c8 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1566,9 +1566,11 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
 	case SO_MSGSIZE:
 		if (sk->sk_state == IUCV_OPEN)
 			return -EBADFD;
+		lock_sock(sk);
 		val = (iucv->hs_dev) ? iucv->hs_dev->mtu -
 				sizeof(struct af_iucv_trans_hdr) - ETH_HLEN :
 				0x7fffffff;
+		release_sock(sk);
 		break;
 	default:
 		return -ENOPROTOOPT;

-- 
2.53.0-Meta

