Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793249183;
	b=cQdOMoUjZeyDo+xTwHcwbx9o1zdJo2HHgaDuCNqtex2L4aLcmH1CPegQ1TYCFjpmIMbs
	 BOLE+H39yLHmrhOSRO58ieOwfzK4MqGibeEzo4CrD88YqNDPiGlm++uDXaW0DP/Q75xNE
	 Xl1B52xGyh1aFbtFuU86SwLlQpfL/64+kYpg1YCLmck90zWBq5TrcnVc3kyXjZp4Db773
	 hKmAzvrSe1LpCqhU+arU2CvQ+qkscg7W+/hkpYo8LxeOS73kLqS7511ZSprba0b3SCcv8
	 UjeLvtlkIyi1UoT8ANlCAhP+W5XfStYjBGI6yeSzfVlCoM7PqDoflv9D/YEPxtAcQHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249183;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=WyAML/Tz/H3qHeXzU/JRR8g01JzfElK9/VlQfO8M1Rg=;
	b=qUTrzWyHpJv3Yg1jKUbjGpfFlAUiQ30UixAXFZqd0VjA9fJut9VLPtWpV6X84ABFerUs
	 6XS4F4CYesSFO39cvef1HZmUI5K6nXnrzGgXb6ih7kOF0pyz2z5A6149gNf5zKHzYNVZw
	 aHrCkxh5YlNpyvmfTtwHprjQqHzs3ixou/EtlUc63fJQqio+9fhDlXXI1bk1E0O0i3uXr
	 qFIF2sKvCiKWNer1ou/+6TmuGWBjQtPJy0dlvwkJzEmrXc0sfh0pj/b1tvj33vezpFo6W
	 5M2wgPuxXWXUhLHQrb17n2sagXoSaTLQP2B+8HsUJUOEWdHRVq8jMprHeWT/twv4rWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzlCw1ie;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C21606A31C;
	Thu, 29 Oct 2026 04:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzlCw1ie
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793249183;
	b=ouGVgG4/kOo2lL8L4eUb+c5Wgq46E/pII0EL0bfM6Q6q5+s0NfaQPUEkyWLtkuIVEOqg
	 6+cBMSsvKi6QCHZsRoXWOuvvISbNbw26ZcOHPsJfZd8DS2fHNTsLchu7gdR1ZMmRLb3VD
	 AlhcdMydtHighCOgVXH1sHsK2aF3XABZ6VF8H31Bpk2zOQQ5BbQF8bZabNnfzwScRhJQP
	 QYf7pk79kcKHPWVpshzG2Qz+VFMUwWp5g7lvxHP+zWs2fmt8J87ky1BDCjPk7se+aI3lu
	 F/G6LP8U0FwJBtGApIj/i2MUE/kLcbsHp1OUMqWhZ0X7U8H+pjOfofOUo2FZnRucfeg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793249183;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=WyAML/Tz/H3qHeXzU/JRR8g01JzfElK9/VlQfO8M1Rg=;
	b=Mt2Ebz+UKcuxkVVwqMH2qtA94P7cpt+ArZ/xxoNpXKnMA4QLpYyeUqTjqOhcP2afGo0C
	 Gff7DfUU7qaB4go1BF6i47CGo2gg10WpFIHB9twlpP2lYAj4Xz3vxWe3Z7pA27YXA7nkf
	 FBlHovUmo28V/7yTFC2U6W30QTvJ/eD8cJNlxT1jfcC8WQ5xnWgmo7j8sf5PlwA5JSYhe
	 0JVkcPYM7iNPmFpLbuwo0iaoNrAfsL273Zu5ThQb59MlR6wxHLuDPtgR+oja7mRL1fm1O
	 OKsuc9KmexRoI8xEqELAlyzbGLx/zX28YMNnwQx4nXInE4hsRC+GHLGz/6V8xzZ2kLw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2138D1F01825;
	Thu, 29 Oct 2026 04:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249183;
	bh=WyAML/Tz/H3qHeXzU/JRR8g01JzfElK9/VlQfO8M1Rg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=TzlCw1ienJcVn9QR6G9TmGfkVFnULvef1fNLvmMzKlueygjLUJkaRI3KHY96NsK5g
	 dkD5L2CdCaPeA5t4UAoLW14OOg47c5ZZwDzcVlADL36zHHUcB1R0rnQeWq/Z2e2uwX
	 gpe8b6L0NOFAM6s8ZwiVzDCYcJC2Tw20EYWvlJuJ4sinpGh48X3O+Wq7pcNYetW4vM
	 qMG8mM8HrkglpwXj5E+zXBxQlv7NjskdkCuyneZrEacztHPUwzBFfBrGuhH0eQcxtg
	 Q5Wc92kfZ9ft9LhSuB57uwZsOA7nOGSk4GtmN102NjhF/KgliSKFqgXHTITxRAEuxN
	 eLC++xKTmmKAg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7928245700;
	Thu, 29 Oct 2026 04:46:21 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Subject: [PATCH net v2 0/2] net/iucv: two fixes in the HiperSockets receive
 path
Date: Wed, 28 Oct 2026 23:46:20 -0500
Message-Id: <20261028-b4-disp-dd3e4ebb-v2-0-3747658d59bd@proton.me>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6Xs2YUkFmn9FfGQdF90PcSSbUUo/
 XejHmdgZiNDVRidu40qXmr6LA3CoaPpHssNrNKYggsn78LAqWdRm1nkiB4pcYb3Qx7FjTFSy+a
 KrO/f8kIFC13/0tb0wLR8Z7TvHyPtMV95AAAA
X-Change-ID: 20261028-b4-disp-dd3e4ebb-fe118f9d09aa
To: Thorsten Winkler <twinkler@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Hidayath Khan <hidayath@linux.ibm.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793249180; l=3861;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=9bkBzsEfH1ypgz3kHKz5eZsv445/cpLKteXX+59ppss=;
 b=UCUr01jNTk+8uV+df1acsNPs1oHRikajSTatFtvl3XYxg0GGfQaPfD1UsrhD14Yj8d6t6rAca
 6tLBgClli4wAdTMsRdUzA6DFz9pA5i9al4wrZlobJK7EPXKDedkqZkF
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

Based on net at fcc00b15cb21, after the net-next merge (iucv_sock_close()
is split into __iucv_sock_close() there). The same two patches apply on
mainline. Tested on an s390x guest under QEMU TCG with KASAN and lockdep
on, on net f4377bf85887 and net-next 8df0638138d3; the base moved to
fcc00b15cb21 afterwards, same hunks. QEMU has no HiperSockets adapter:
the one here is mine, under the real qeth and qdio drivers, on a QEMU
with my own patches to the s390x machine (the adapter's interruptions
through the FLIC, a z/VM CP model), and there is no IBM Z to compare
against. With 2/2 an SHT read while frames wait in backlog_skb_q gives
EOF instead of WARN plus -EFAULT. 1/2 does not change any result in the
rework's test set; its race shows under KCSAN, not here. Logs on
request.

v2:
- 2/2: an empty frame read after the close over the window reached
  iucv_send_ctrl() with hs_dev already cleared (the AI review of v1
  [3]); the window update now goes out only while the socket is
  connected. Repro on the same machine (SO_MSGLIMIT 2, SO_RCVBUF 6144,
  two sends, one frame injected over the window, the SHT, 16 more
  behind it; the parameters are below 2/2), counting iucv_send_ctrl()
  entries and the frames at the adapter: v1 attempts one update after
  the close and nothing leaves; v2 attempts none. The reads are the same
  on both (1, 1, -EFAULT, -ECONNRESET, 0, -EFAULT; the last is a data
  frame behind the SHT closing again); net without the patch reads
  -EFAULT at the SHT with its WARN.
- 2/2: the commit message now says "a zero-length data frame that
  reaches recvmsg()": a zero-length send with a piggybacked credit is a
  window update and never reaches it [3].
- 1/2: code unchanged. The review's point on it (the child's device
  reference when a SYN races the listener's close) is the pre-existing
  orphan the notes below 1/2 describe; the rework [1] closes that race.
- Both commit messages say how the patch was tested.
- Rebased on net after the net-next merge.

v1: https://lore.kernel.org/netdev/20261022-b4-disp-b35a9153-v1-0-d74645876195@proton.me/

[1] https://lore.kernel.org/netdev/20261022-b4-disp-1d26b87a-v2-0-7ee1264d812a@proton.me/
[2] https://lore.kernel.org/netdev/b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com/
[3] https://lore.kernel.org/netdev/179306942509.3134.1109951482403010755@kernel.org/

---
Bryam Vargas (2):
      net/iucv: clear hs_dev before dropping its reference
      net/iucv: do not count the SHT frame against the receive window

 net/iucv/af_iucv.c | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)
---
base-commit: fcc00b15cb21a6de76826e5012b2c758505f5e65
change-id: 20261028-b4-disp-dd3e4ebb-fe118f9d09aa

Best regards,
--  
bryamzxz <hexlabsecurity@proton.me>


