Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746DB34216C;
	Wed, 20 May 2026 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296049; cv=none; b=AOofY9L6fbQmJAP+0Y+XuqNhrIjhm7To9xmsLiqZQ3wIR8Gr6lf/aG1suB4XENPrwPxR/UyF284H/AAtun0ERUDyzXoyw1EL3tjb3KQbIt7Ln4c5jcuW5aHie30CE9jxebsSWpDCoW+K5UY8xIF4Kb3H7o/5/7TT5OP5G6Tjzu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296049; c=relaxed/simple;
	bh=U8dVlvAolBei/O5G4/Phw+TTk1VJPk6u/RJnno2HZwU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YYqqsD8mtqz1EkIKHVyxTyc3h8UgzV9kL7svvftLt/3kQzvJ2lPzRTT9c6DbNtLmouUW/1PuE7WNy4R9m0okQBZYdVhKF+ptT9YlbRVpWvQurPsVSFXRrBuwRfCiPP+aU/Tbx301ore8Fd/SfD9b6MQDteYpvYgHU+tILe0ZOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Yrd+gVqJ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Yrd+gVqJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8zXYxYxtJ4oXAiq8sHqIS8mQ2m43gH38jqOVmvsoDUY=; b=Yrd+gVqJo7uSmNE7KTAogomHC3
	xyRoJLz8XWybuw4d0gs6CQVNTzxBGfYHeiXWz3THE7zD3SM1Y/ufJikbrS1LIuAhBmtH6RTlbt5nE
	0mR/CfEkps89u2ib9fvuwrHkPvhoJNw/pU1+UOGw9CQjBZyjYcLAyS9szJoPtHKAoyGk44pafPkd/
	ZB1DsTthsLVweHRPqFDMFgUAqPZoaCQd459qCp2JNfu94tPTXLlRBJSDUeLxy02KZHoHOcsDPxohF
	O+TWwIkccvNL/id1hXWLDqo0b2h/2FK9r9/XESKw8eBBVaZNH5xoKbU5+bLD+Do0zWzx0NZ8W93fM
	jWzKw1tg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPkBC-003FTy-1l;
	Wed, 20 May 2026 16:53:59 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/6] net: convert
 atm/xdp/af_iucv/l2tp_ppp/rxrpc/tipc to getsockopt_iter
Date: Wed, 20 May 2026 09:53:45 -0700
Message-Id: <20260520-getsock_four-v3-0-b8c0b16b7780@debian.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABrnDWoC/22N0Q6CIBhGX4X919IQA8ur3qO1pvij1AYNkNmc7
 96km2pdf985Z4GA3mCAhizgMZlgnIWGVAUBNbZ2QGp6aAhwxiUTZUUHjMGp+1W7yVMmK5Rtzfd
 CCCgIPDxqM2fdGSxGanGOcHkvYepuqOJm276jCdH5Zy6nMhP/I6mkjGqsNcNaSN2qU4+dae3O+
 SG7E/+kxQ/NKaOsPyD2R8Elr7/odV1f2y18HAMBAAA=
X-Change-ID: 20260513-getsock_four-063e6a724555
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3395; i=leitao@debian.org;
 h=from:subject:message-id; bh=U8dVlvAolBei/O5G4/Phw+TTk1VJPk6u/RJnno2HZwU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqDecgqhGcppWkZJXBATn0wKOKcERm7xYLRfIYi
 OcW2ICvMfiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCag3nIAAKCRA1o5Of/Hh3
 bSUsD/4z1tCEk27rFb83pLCxGD3N59hMqcwo3v/KyU1akUACgaNMfqozW38FJi2pSvOcgzH1IOv
 G13BnR8AivOWzd1Ci/mQQlOpCoCSxmjmPDBUX1eVVXwN9w+YIczfLh5Ip+xyhjh1v1+T0Axw/Z+
 y17Av3LHwa8XSM21lMUg2Wwi34YD/naNBVpTS3g4V2+MRrK8iX3azwLyYMCIJaLuUPxeXXoJDOK
 aN0pGOpdx/iIQ2G/gBO2f7rG+cb4xL9J8TJFq9vQRYwd93Dj3xldPEjRu4HucsAOE3mgnS0uaqs
 e5qeaIWThYAfApRavLUTy8h4fDXEl4MES7Cvg0iJL3hYHVcoRi2OSSsuT+R2Xsi8kTo4p3dXmVg
 H86aM+D5vmaAUczIueOKo4+rpIr02v6kL69bMuTnGkDOt9GY4iWc+bQclTXbclnbroNpE+iQ0rr
 A8y9n95iJwo7ujNgzr7i6xTiOaVBEchDuet3FUFAwU7curZFHUwpEwTrYCEm0dINajvlNtlx6z6
 br8l4wB80qNEJeNRP6lSUxRRG9Htxzb2dpEy/RVfW3Y0yKFEbQ0qawdJkvhXytwVGlTcEN0MnFq
 amB+n6XZ1xKkdLKCDAOxjgBeOTv3TrF8DhZ1Bpy9UzwCk5O7HPha695jpgofYApIuKUtCzFMTRw
 S5UGVf9yHdYO0Fw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

This series continues the conversion of the remaining proto_ops getsockopt
callbacks to the new getsockopt_iter callback introduced in commit 67fab22a7adc
("net: add getsockopt_iter callback to proto_ops").

The new callback takes a sockopt_t — a type-safe wrapper around iov_iter
plus an optlen field — instead of raw __user pointers. This:

    - Replaces (char __user *optval, int __user *optlen) with sockopt_t *opt
    - Reads the input buffer size from opt->optlen instead of get_user()
    - Writes the option value via copy_to_iter() instead of copy_to_user()
    - Reports the returned length via opt->optlen instead of put_user(),
      independently of the bytes copied through the iter

Each conversion is a behaviour-preserving and code-style-preserving refactor;
no big changes being introduced, even when the code looks weird.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v3:
- Drop the "af_iucv" fix, and I will send it separately
- Remove a left-over comment (Paolo)
- Link to v2: https://patch.msgid.link/20260515-getsock_four-v2-0-0d8eed952627@debian.org

Changes in v2:
- Fix a issue reported by sashiko, where I was using "long int" instead
  of "int" for a value.
- Nit from Stanislav
- Added an additional patch to make the af_iucv SO_MSGSIZE similar to
  its partners.
- Link to v1: https://patch.msgid.link/20260513-getsock_four-v1-0-fe7f0e756fac@debian.org

To: Alexandra Winter <wintera@linux.ibm.com>
To: Thorsten Winkler <twinkler@linux.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Chas Williams <3chas3@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Jesper Dangaard Brouer <hawk@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: James Chapman <jchapman@katalix.com>
To: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
To: Jon Maloy <jmaloy@redhat.com>
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-atm-general@lists.sourceforge.net
Cc: bpf@vger.kernel.org
Cc: linux-afs@lists.infradead.org
Cc: tipc-discussion@lists.sourceforge.net

---
Breno Leitao (6):
      af_iucv: convert to getsockopt_iter
      atm: convert to getsockopt_iter
      xdp: convert to getsockopt_iter
      l2tp: ppp: convert to getsockopt_iter
      rxrpc: convert to getsockopt_iter
      tipc: convert to getsockopt_iter

 net/atm/common.c     | 18 +++++++++++-------
 net/atm/common.h     |  2 +-
 net/atm/pvc.c        |  6 +++---
 net/atm/svc.c        | 15 +++++++--------
 net/iucv/af_iucv.c   | 14 ++++++--------
 net/l2tp/l2tp_ppp.c  | 20 +++++++-------------
 net/rxrpc/af_rxrpc.c | 16 +++++++++-------
 net/tipc/socket.c    | 33 +++++++++++++++++----------------
 net/xdp/xsk.c        | 24 +++++++++++-------------
 9 files changed, 72 insertions(+), 76 deletions(-)
---
base-commit: 95c1d0b80d73a9508ceea198c6132500410846e5
change-id: 20260513-getsock_four-063e6a724555

Best regards,
--  
Breno Leitao <leitao@debian.org>

