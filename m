Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED441B346;
	Wed, 13 May 2026 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675696; cv=none; b=a+v6tEa9J2Mnle/IHYLOY0OF6rU76nJPXCSuOr74ZUaOxR0Z0NY6kw1KlsK3DiRqAXO0XcDMDcTjj/TO3iq0mzD/+L+ma+B34GsXJZKVRwvcsiUcaUQ9LtN/oHwtILe0xEUlyjDGWTlpUHV7/sYniKzilX76c6bk++LtaTVDSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675696; c=relaxed/simple;
	bh=szV/P7ioFhazhghdRtmLJtfuQPsrZ4wDLnrt2KpitwI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Av+WRUJI9wYCOIQLC5JbsSs46e8G6guzQzr058N6M9PKcV1z4m1flXSsZdXzlsHlX1Ph6euz5d6Jqe0PNSVtHCaikVPpLTWJYRxkpm5fNWQ71ViRbiZ2zxO+RPv93nth3KK8V73eSJPoyveyMCFH3kux4Z0OVpZGpBRa0Iu8/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ew2Tm7WE; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ew2Tm7WE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=IPHWVIXooSFPct2fiNJ/S4JD7wPpJJQmkFC+AWSDO/w=; b=Ew2Tm7WEXqWS9ytYwQveolteMi
	0sV2ws5DGUB8YZt62GTgjCCpQ3/iDFo7WKO4CGNi4Gl++KNJz2Qfrc27lxLl2wANhemLNMYFM/GTD
	uep1yITW8ScreuQDhBEU3S99hvKUXkiy3sdIOy1TdZ5s3drDCKyGqsRkhFj/f4vAqxzNS8Mza2W8E
	WbEBzJLOeF0epDjrKnV5/AawukmuHOIlQhaY/frUGWzTluxIZPKrZRSPCMLWfjmH3afarUAnI8XHj
	ziCqp03/GPS56dlqSU/JAFCKwTl91uJUyg6z2xWr/M+6wbPo8X6x/uutu8aAJXTq7dhmOOvTwiHUA
	PGDUCZ6w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wN8nH-003A7t-0C;
	Wed, 13 May 2026 12:34:31 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/6] net: convert
 atm/xdp/af_iucv/l2tp_ppp/rxrpc/tipc to getsockopt_iter
Date: Wed, 13 May 2026 05:34:11 -0700
Message-Id: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMRvBGoC/yXMQQrCMBAF0KsMf91AmpoIuYqI1Dito5BIJpVC6
 d1FXT94G5SrsCLShspvUSkZkfqOkO5jntnIDZHgrAvW94OZuWlJz8tUlmpsGDiMR3fw3qMjvCp
 Psv66EzI3k3ltOP9Fl+uDU/tu2PcP6HiW8noAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807; i=leitao@debian.org;
 h=from:subject:message-id; bh=szV/P7ioFhazhghdRtmLJtfuQPsrZ4wDLnrt2KpitwI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBG/PQV7f6ZIwr5oNfSQj02W9UwFMqvMC+dWzo
 RDolSz0ujKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagRvzwAKCRA1o5Of/Hh3
 bfQ4D/9vX4Vu0fdFKRms0CxWMrSMOrayNHC3TuSSbI4htxKDmhIfEiK/qKmRT/od1cg1RL8o8fX
 U5jP57OYjsU9b8pMxqjpvtTuEPK6xEblpa/S0v95ni35VhhxE7CEX9/VhrNcOfUedFFn78/aLcz
 U7jnHp+Kk4Ad1+oj8Z2c/cziMC7YBlCvYfA7+zHeP9DqZQ6mEi7s3kCDi/UxSjz9p3TL9krGurv
 WQxyjb2IGnfq/5OMPmgQUsT/qzXYeS3O+0Y6DUj/oNxL7VLh/U/3+XQQ6A9vbUPElXDNJCVU6nQ
 Q/ya7x8PBfcupMyVMtqrxwBI6cGfJ/gVQiSP6OWzpmuzhmCbTN9s3Xd0PyRlXPKhj/9QMGNuROR
 BSGN5peGDpF2oII2UGBWT7Xv1yyqLipNslrvuw0ASe9Y85Bib2dO6lKSOV3m0FwdepNmV8V/YYD
 txs+bjJjMVXxqteH4nAyKqFwMR+HcBnzvHCcQuMswhQ0XM5eLvAOEN9DrdoJExUtosou+q3mLON
 ECI6zd2iyK5A99AT/jsWMmXpIKUOCT0EQq3LBpSoLB0MzWB/ARfHDUQa2697Zvg4YQt19ZzmPHC
 +S51DCxs8Dxi1rrpuMHDkFlHsnGQHW2RR2dWopytQrqkP3hJDSYlzv6CSxy5i66PhkmXLJ2Ts8w
 7pcHjyIFL9sOuaA==
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
Breno Leitao (6):
      atm: convert to getsockopt_iter
      xdp: convert to getsockopt_iter
      af_iucv: convert to getsockopt_iter
      l2tp: ppp: convert to getsockopt_iter
      rxrpc: convert to getsockopt_iter
      tipc: convert to getsockopt_iter

 net/atm/common.c     | 18 +++++++++++-------
 net/atm/common.h     |  2 +-
 net/atm/pvc.c        |  6 +++---
 net/atm/svc.c        | 15 +++++++--------
 net/iucv/af_iucv.c   | 14 ++++++--------
 net/l2tp/l2tp_ppp.c  | 18 ++++++++----------
 net/rxrpc/af_rxrpc.c | 16 +++++++++-------
 net/tipc/socket.c    | 31 ++++++++++++++++---------------
 net/xdp/xsk.c        | 24 +++++++++++-------------
 9 files changed, 72 insertions(+), 72 deletions(-)
---
base-commit: afb06186b0a5f3ff659cfd97421660c95bbde3be
change-id: 20260513-getsock_four-063e6a724555

Best regards,
--  
Breno Leitao <leitao@debian.org>

