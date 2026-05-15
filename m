Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA4378D8D;
	Fri, 15 May 2026 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834020; cv=none; b=cJ5veb7m2ECCPrbW9LALDQLBf8qbCzoXLaTThdkVHkaqIiQGjcV7r4XGoV8IY7qOXd7IFnMRTZzS54HRIQNsviIU40JxR07haT78AwxatYOuN+nBqqCFXfRLWea3FuRtNYOy7Qi1LtFsr86DV4/EE6aSu2Vxk2b/yuNLiiQwmJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834020; c=relaxed/simple;
	bh=0cISody7YAb2PZkhZH2Ka6q/ZFFj+dTiPt+pQU9bT+M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GMwRXCtjpVVddZkAKEEZ7ru2Kv1DpJWrfNlNSGeZ3qRnaH6TawOoNCTzWyPvjidYCPbMNjIe+aALhNfO8ip+DhfGLzxuw6iCWf738BgNEs1PD5EygR5WkcirnuMnK4dRWLETR8yb3IvgqvhvktSFJzaurPe4Rhk+ndjNdx9R/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dZBfiV8m; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dZBfiV8m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=tpou6ki3jAJXp90TqJk59yYkaVlW8JK+YsrVKfCVQ98=; b=dZBfiV8m4wwLpm0OL3+VFovqaK
	EwnJpucTVmDT4I1Ja2i/EoDENWhB4dPFZF9mGnNMlwFTEjtV1dPnL05oNsxF7otqEHJn2UlVEcxND
	kOZzSWqLxLD6eMg/2LPj1nMbJFY5hb0fOqwl8xaAP55HWSSJQWrTy1jPhU95VmTz18YBtILIUnvru
	W8UprivhZbs5FK3JPbxnXHxTgLClu3Gsghpu8TLFOSObmqc17xKW6RPCbxk1hcpAjTgdi85AyXiNE
	aWgVoiPsizfgO/KF9MotInjJhty7PcBTZw0IyG6bHyP+zcH3NAW7TK6tDjOGgjJfn0P57ba0ApKo3
	nHoiFvaA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNnyy-004b97-17;
	Fri, 15 May 2026 08:33:21 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/7] net: convert
 atm/xdp/af_iucv/l2tp_ppp/rxrpc/tipc to getsockopt_iter
Date: Fri, 15 May 2026 01:32:24 -0700
Message-Id: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABjaBmoC/22NwQ6DIBAFf4XsWRrEgomn/kdjGsRFt02gASQ2x
 n9vtNee37yZDRJGwgQd2yBioUTBQ8dkxcDOxk/IaYSOgRRSC1U3fMKcgn09XFgiF7pBbVp5VUp
 BxeAd0dF66u7gMXOPa4b+t6RleKLNh+1gZ0o5xM9ZLvX5+B8pNRfcYesEtko7Y28jDmT8JcQJ+
 n3fv2HpArrFAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195; i=leitao@debian.org;
 h=from:subject:message-id; bh=0cISody7YAb2PZkhZH2Ka6q/ZFFj+dTiPt+pQU9bT+M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBtpJ1ql6+kWh2Sk7mRqFW0RJgA5fXYWF+7RiV
 oQ9N0uRQjqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagbaSQAKCRA1o5Of/Hh3
 bdnCD/9F/kItVPDT/aJ3OibaUFifLnSO9z8CWVnyrIWgmI1vKVxPeAEJTpEsRTyzb5htGsJA828
 sFmprgPgwVcqugpUt94rY9VLGD8lKU66g7Bc2q/QhJKj/28jbleKzbaFiwiAsDbo6K3rjjOuryy
 6BHWrbVkfpIEcGzNOcTztluIUCOIsnQznLtoyi7gigzZlRL7xyz6alXeX/NrCZsJ64YHBCnyHC1
 SkUksQtC8RP42aOMNCCp2OxKhDK2Q3+a/+xdWKMwYGqvvcqw5+J6I+hsrlvi9xkQ+qyvopmbhFj
 +21KMSBL88ZyNW9njp1C1g/PeUXEATp8vCCa8wR/EtBoI1GZHtt4Q3Pv0DvZ6HOtaHz3w8nKI21
 EXa5PWwt6TlTgyCM17iyRyA4NsbDLtLQeQyR9RaWlzI+b6ivu0aC0VjPUaYivIEFLsycO0ZS8Kz
 Us6cTemOwHghAT5B5ckXlCJAMDnN3505SpIEbDFb/J3mzMnohRNZ+upfklH9txv4firm9gk6NVa
 /JA054zSgAjBQXrQgHnM3LSOJGDPJVfUJOUEPyGEg+dyL+X7ljII2MopupJcSDZp+6woon+5d0t
 6jC+yCpkuljNAzqPUJdiNYumbW1J93DvERms0/MDgMGO+UQ5ACCCBfBWpUlEUdRHeTwMxhSzJjV
 SuY+Bgq/jwXdP6g==
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
Changes in v2:
- Fix a issue reported by sashiko, where I was using "long int" instead
  of "int" for a value.
- Nit from Stanislav
- Added an additional patch to make the af_iucv SO_MSGSIZE similar to
  its partners.
- Link to v1: https://patch.msgid.link/20260513-getsock_four-v1-0-fe7f0e756fac@debian.org

---
Breno Leitao (7):
      af_iucv: take socket lock around SO_MSGSIZE getsockopt
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
 net/iucv/af_iucv.c   | 16 ++++++++--------
 net/l2tp/l2tp_ppp.c  | 20 +++++++-------------
 net/rxrpc/af_rxrpc.c | 16 +++++++++-------
 net/tipc/socket.c    | 31 ++++++++++++++++---------------
 net/xdp/xsk.c        | 24 +++++++++++-------------
 9 files changed, 73 insertions(+), 75 deletions(-)
---
base-commit: afb06186b0a5f3ff659cfd97421660c95bbde3be
change-id: 20260513-getsock_four-063e6a724555

Best regards,
--  
Breno Leitao <leitao@debian.org>

