Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792723716;
	b=J6Ik6/AQf91kiEnV/D1R1j5tSQXqFrX+XeOLi90SkBHbWdr/FxE4HMSbSgiu690HUtWT
	 VkHWBYulUY0qnfRk+F5apaHhECpZFQm4ay0HR/HnACLAeyMKPMSpaS2pE6UXcVfbDahV1
	 XlZ+c62/EqcVDCIX8T3uOK6WombX3rvd8Rhq0+QAowA2cGs0V2nObjTYQr/8M7fa4ys2E
	 unEOVDTVKOGNrwNv8jndI44HRbd3FuIdbqri3kgkmFfNM3RY6544b12CwBDR5OWIvpqcb
	 9SKavNpARupSmLfNk34YJAQuYx88IEzG+yDEzYm+FvSvfBLM+CDkm46WGRAScJ+Rxhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792723716;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=WeAvoBILKk6jbccyVF2QndAahtzVXNM6BmMESGlsxUA=;
	b=Nd3sFuXImi/1RmAF8ui2CxgHhePMpWtLs2H1IvnECDmdljkbdp+xUKQoTXm/KYk2gjeZ
	 4v9phMuGkRezDykdkYX3CeXNBGX5qf7rHGzOJqUKE8JH2Vi+7mlXuf+Gfuvfo5KNlg3xf
	 RBpNDK/+tZjkeBypx+bCcNoiQ6d6m9PzaWhdk3p7ulTFETdcjUGq5VleLx1mhRpIPc515
	 riqEtijS9RYbdym9PWHGGlQneLQxIw0EaxMt3TFVfLIDFG14r/4qH4WsJHBNqtbpI9vMu
	 SdrpvYAN2QjVFgMK5u7EbfJ/lwLrP/zZA4IW8t1utrCp4ZekmE1WmbLaGUFHCwojHsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=McScDRnO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CBC606A319;
	Fri, 23 Oct 2026 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=McScDRnO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792723715;
	b=FBByhU8hHeAZNXnNbBwG8g1MHAvCnn3f1gyJjXO9GIpp+sKNt0pjNsJdPydMJwv41WGm
	 Vx/QZN1ivaP4wVeZNdnpL3RCc7m6Rj8ZqV+4dTt7EoWBXyCbajaOfQwamTdXVSxmbT5O0
	 0ukqfdi9JWHrEVzR62//qRp8CG+hNgo/5Qxi6HiP3KyOMM25FMOA7EcUym7wxo6Pvf4q8
	 dRehxql74qEu+2iD3TIm9O0CdWxbY+WU+/Mx7FicJUVFhHaolI35y7tumYGH3tAG4pmhQ
	 cVpiRogx+gEPLayj4bQXL5mtkgjXikQbKCThJHKYOToiQhKQxHuhpDsKV1ZekOs94JQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792723715;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=WeAvoBILKk6jbccyVF2QndAahtzVXNM6BmMESGlsxUA=;
	b=yfrwGAwP21KFcnRQ4hl58aQ2d0Z15pdiOmoXU4mex2nWqHXmtSdqF2uesXUDnXEHOVyY
	 +wwTkCgFhJlXZYV0uig1ivKNLAKR4tceWd9nHwwnLmy56ArMkfy9dQtgIDYKKn2f/EGeF
	 /DsfHu8VsxfDwqL/PQJ33aU1Utxmbr3qBK3XWYyeSm3MKM0Yo85j96BHTDj2onCVKqRvC
	 4rKrUdx9um2vrBbpAZ5fuOWf1Jt/RcbzHjDh+d8Omeda8ieDGSVua8TGIC4hpOO69o5s6
	 hWtHlRPAFLO0sK5STSmW/EDVQJ7uHkPhZaKiW2SxryztXHhLzDKaHygu1JVCZVVFytA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 11E0F1F01825;
	Fri, 23 Oct 2026 02:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792723715;
	bh=WeAvoBILKk6jbccyVF2QndAahtzVXNM6BmMESGlsxUA=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=McScDRnOQhLciNbsLedzBA6GrIBMoDpR96hO9saqHKkuQ1YaPXXddFCKweEPuHO3+
	 bLkn2+AN7pYq81q662f2ATCybui+Z6m3gMy4lsdZJ7QbRF4cS2epfNQ2W1lu29gCIS
	 Zh/zxOBqP/FLwp51KWbdFplJYiTciVAxlPRVTRW8w2bfRjVfFkGQzQ38/ZPFg5OMDA
	 FlxB2sRT8BoX4bImsj4wgd+OM9JmIBTc9uzjq/Aqu1D8Psk+IVkXcwPaL8m85tLNH8
	 mslv2JbcTgdqsqol3mixdiHFqAXcv3OT5Q8Apyj6BGQkBKR3ErqIQJOxuZjC/y1OXQ
	 6/pYuaeZ1fcXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 622E9421B2;
	Fri, 23 Oct 2026 02:48:34 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Subject: [PATCH net 0/2] net/iucv: two fixes in the HiperSockets receive
 path
Date: Thu, 22 Oct 2026 21:48:33 -0500
Message-Id: <20261022-b4-disp-b35a9153-v1-0-d74645876195@proton.me>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyQrCQBAFfyW8sw2zZEF/RTzM0mp7GMN0IkLIv
 zvqsQqqNihXYcWp21D5JSrP0sAeOqR7KDcmyY3hjButcY5iT1l0puiHcLSDp5BNn9M0TtYHtGy
 ufJX3b3lG4QWXv9Q1Pjgt3xn2/QNSgGrJeQAAAA==
X-Change-ID: 20261022-b4-disp-b35a9153-ad04dc76713a
To: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>
Cc: Nagamani PV <nagamani@linux.ibm.com>, netdev@vger.kernel.org, 
 Hidayath Khan <hidayath@linux.ibm.com>, linux-s390@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792723713; l=2328;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=BNJJOuLjMNRhAx5T7Da8KhKmOmXfQyl0MXLk28E4drE=;
 b=Z8InjL46QKi0duh6ud0YXgHDg5z3Pou/y/6UaKe6E6PVWr6eJPcSeyD1Nbzl6PFt6V64p3KHL
 SDS+sLZnONUCKabpDPw0vkcm6jMuVKIn0dYchNRPVsSb6Xk4/Y6fX4e
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

Two bugs in the HiperSockets receive path that predate the socket-locking
rework [1]; review and testing of that rework turned them up. Neither
depends on it.

1/2 clears hs_dev before the socket drops its reference on the device and
marks the accesses that race with it: afiucv_hs_rcv() compares hs_dev
under iucv_sk_list.lock while close() clears it under lock_sock().
Hidayath Khan caught the racing pair with KCSAN under z/VM [2] and
suggested the fix. The listener's child now takes its device from the
frame instead of reading the listener's field in softirq. This is an
ordering fix with no known crash.

2/2 stops counting the SHT's empty frame against the receive window (the
peer does not count it) and drops the WARN_ON on the overrun path, which
a peer reaches from the network by sending past its window. Only frames
with data count now; a zero-length data frame, which already ends the
stream for its reader, is no longer counted either. 2/2 applies on its
own and goes to stable.

Based on net f4377bf85887. The same two patches apply on net-next
8df0638138d3, where the test set ran, and on mainline (7.3-rc7); the
SHT case below ran on this base as well. Tested on an s390x guest
under QEMU TCG with KASAN and lockdep on. QEMU has no HiperSockets
adapter and its s390x CPU emulation lacked things this needs: the
adapter is one I wrote, under the real qeth and qdio drivers, the CPU
carries my patches, and there is no IBM Z to compare against. With 2/2
an SHT read while frames wait in backlog_skb_q gives EOF instead of
WARN plus -EFAULT. 1/2 does not change any result in the rework's test
set; its race shows under KCSAN, not here. Logs on request.

[1] https://lore.kernel.org/netdev/20261011-b4-disp-410518f4-v1-1-753bf3258292@proton.me/
[2] https://lore.kernel.org/netdev/b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com/

---
Bryam Vargas (2):
      net/iucv: clear hs_dev before dropping its reference
      net/iucv: do not count the SHT frame against the receive window

 net/iucv/af_iucv.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)
---
base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
change-id: 20261022-b4-disp-b35a9153-ad04dc76713a

Best regards,
--  
bryamzxz <hexlabsecurity@proton.me>


