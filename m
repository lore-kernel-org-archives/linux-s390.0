Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D84D7D5E
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416130; cv=none; b=U3QnipgrJPYFCuw0FVRBCNXvJ9/qt+M/Z1fF0dMiJkO3I9CaoauSwRKWL09d+9ijFDZXqGCNrGYeDzd0Y6BTacovLznxEfPsuQBcN6DXy1c/N81HCflWb7F9DYTWAmIFchQK32qtHp32JOqt2CojzYL6VrO12/ii7oSHiR6fzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416130; c=relaxed/simple;
	bh=Ci07ocsqKVYUc4crBtJ+qvBbTM0AnnmLYJITiLW/Fdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qU69F5miaPIWIu7XP9r223Pqu9p8G+SWMreg64XUrt0rNtu7azLsaomzz0aEF6VOppg4FYaL2/tjoTxCihz9tBo/3NcAfqUP38r8dS9eKu+QfPCudiQBeLo6Ln3lM1mtSg0TZ4JLZY50J87s4xrMtafDBwwvX0+QRdlfow676YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAe8t23b; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAe8t23b"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e987b4a710so14338795ad.1
        for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416129; x=1793020929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kEOpbqUrsMaPI0JFdd43F1py1ZX1UtgRPZx2PGrCqqA=;
        b=RAe8t23b+hs1lNdNC8+BkrYpsSFiQoPUhKasE+Vlz7IUCyq88wPWrSiERygApMxn9E
         SquHlzfFIzHloge+et47cUin4/QVRTrwlU2mqS3Azu+jtTPndlsxsMir1WF+AvD0rUQa
         Kp6BMVoS9MTpvLfxRaTkln4IUcIibKwY77mQeIhKPzwoM2sp3UHBPt3JKyrVPJeN4XSj
         S7A4LSypXXUBblzFPocs37gKVsbMzuoFvE4wj2+ttFnuxAzFynPwPbbFFYPgwMvzcHA2
         km8jmZFn/PTfQe5fG7Oc3J7NkSFYnCRjEqKPMr0IgVkCrQy6snUxRdPKevMIhnFhAogC
         aH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416129; x=1793020929;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kEOpbqUrsMaPI0JFdd43F1py1ZX1UtgRPZx2PGrCqqA=;
        b=Cz8YFiw+1zxONL20SrO0frtQlDLbgNc9cDwoOm2N4xE54cvt5AF9eWhtlJl0pJE7uh
         xvtyQpCdx4b+Hnz5Up4wIPO+1mCHfYC9V/EtPUaHQeHDojd9QGsODADCwLNMAGqvL8U4
         MDphbnzuTW4F1rKelq3VQ6x3geOoi2hPe8QGgYX6voMSWRdMTiKfVCcf+qbwWRvDUjPs
         6kn2K0Z/4nSzVoM5q/nErwdmOPZSi4CZk7OfT4pHEyqWRdFMvdT3xIJgdT/YPM8reHpr
         JGAbitXyn3pIXsIeT5KUpzBFXM30kEcjlbMnDPZPNaQ/OEcZnRZR1T9FawRk2ruSu5E9
         P8wQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoDbAgRpVcTrm7QOY7wJO+J3rQVJWpkFFKSFHkCklzDdLX4+kvq6/B721xpCMJ0+eO51KeaFl3Fbuj@vger.kernel.org
X-Gm-Message-State: AFq9FYIIab8lc6iQ5e1VcRKvtuHWwnbJ7veELsQYKrroX1hYS5miEgTh
	LRJNZ5ZFkveDx59ALBh7OzsQQzNosCryxTFCPeP41X9iBGBIRQOqKLL+
X-Gm-Gg: AYBFou33gACjV2psZGkDYqgeQf5AOO3AoIA8gTARdHyZd89r7egKrmuxwSmyicAk9lK
	fXM4W9EjVTwEeZ+DxrQMEkNoGvjyyvv3sUJyFb9deleY9E53DTS96vdl/IWqzhgdKZc8n0p2Diw
	aj2Iy7P3EQyFcejLrx8IRRFChNeiRe0CzHxCsO9+2db1wgO+AIzfBj60/Ui8KycenEsnMGx16wB
	vlhR08iN3Bh9uCp9a+RgYeTtAuocdeLSPyDpYpzi8bLXOP22d14e0EYXybWAnF4SvhdxwOo7BCe
	HsoLXllxDhz5Onbjg+RL6cN9fEW4EwBISjTULSCzUKtqXfZVSSDRBeKR52v4XxoKUx64HGAT9ST
	nVc4Jz5baDM9TWQ6Zc1zXOIgZEISXH0PpvUPOXSPsO5oxlTRD3m3A4/xlJwuBt/rbgZamd8kWD2
	y4UTVoDXskPN2vWfrcirsUt3uoBi9jHy2WGMggLk+nSfhGMdnJNuHnJ5jrFjJbIJEED+jPG1D7s
	MWqHJyAn8o+HLoe
X-Received: by 2002:a17:903:15c3:b0:2e9:64b9:a338 with SMTP id d9443c01a7336-2e9a69e5845mr48899465ad.7.1792416128690;
        Mon, 19 Oct 2026 06:22:08 -0700 (PDT)
Received: from [58.206.202.11] ([104.28.215.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea1501e229sm644115ad.47.2026.10.19.06.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:07 -0700 (PDT)
From: Haoran Wang <haoranwangsec@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, haoranwangsec@gmail.com
Subject: [PATCH] iucv: fix lockless sk_for_each in afiucv_netdev_event
Date: Mon, 19 Oct 2026 21:22:03 +0800
Message-ID: <179241612354.5916.12881323209252769976@whr>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

afiucv_netdev_event() traverses iucv_sk_list.head with sk_for_each()
without holding iucv_sk_list.lock:

    /* net/iucv/af_iucv.c:2218 */
    sk_for_each(sk, &iucv_sk_list.head) {
        iucv = iucv_sk(sk);
        if ((iucv->hs_dev == event_dev) &&
            (sk->sk_state == IUCV_CONNECTED)) {
            if (event == NETDEV_GOING_DOWN)
                iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);
            sk->sk_state = IUCV_DISCONN;
            sk->sk_state_change(sk);
        }
    }

The list is mutated under write_lock_bh() by iucv_sock_link() and
iucv_sock_unlink() (called from the socket create/close paths), so a
concurrent close can unlink an sk while the notifier is traversing the
hlist.  The sk_for_each() next pointer may dereference an sk that is
being freed, and the per-socket work then runs on an sk whose lifetime
is not held. 

The other traversals of the same list already take the lock.
iucv_callback_connreq() and afiucv_hs_rcv() both wrap sk_for_each() in
read_lock(&iucv_sk_list.lock) ... read_unlock(). 

Take iucv_sk_list.lock around the traversal, matching the other two
sites.  The per-socket work (iucv_send_ctrl() reaching
sock_alloc_send_skb(), and the state change) may sleep on allocation
and cannot run under read_lock_bh(), so the fix collects the matching
sockets in two passes under the lock.  Count them first, then on the
second pass take a reference with sock_hold() on each and store it
into a kmalloc'd array, drop the lock, and run iucv_send_ctrl(),
sk_state_change() and sock_put() outside it.  sock_hold() pins each
sk for the out-of-lock work, so a concurrent close can no longer free
it from under the notifier.


Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
---
 net/iucv/af_iucv.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 4e5cc9da6..d2977b018 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2214,18 +2214,49 @@ static int afiucv_netdev_event(struct notifier_block *this,
 
 	switch (event) {
 	case NETDEV_REBOOT:
-	case NETDEV_GOING_DOWN:
+	case NETDEV_GOING_DOWN: {
+		struct sock **matches;
+		int i, n = 0, count = 0;
+
+		read_lock(&iucv_sk_list.lock);
+		sk_for_each(sk, &iucv_sk_list.head) {
+			iucv = iucv_sk(sk);
+			if (iucv->hs_dev == event_dev &&
+			    sk->sk_state == IUCV_CONNECTED)
+				count++;
+		}
+		read_unlock(&iucv_sk_list.lock);
+
+		if (!count)
+			break;
+		matches = kmalloc_array(count, sizeof(*matches), GFP_KERNEL);
+		if (!matches)
+			break;
+
+		read_lock(&iucv_sk_list.lock);
 		sk_for_each(sk, &iucv_sk_list.head) {
+			if (n == count)
+				break;
 			iucv = iucv_sk(sk);
-			if ((iucv->hs_dev == event_dev) &&
-			    (sk->sk_state == IUCV_CONNECTED)) {
-				if (event == NETDEV_GOING_DOWN)
-					iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);
-				sk->sk_state = IUCV_DISCONN;
-				sk->sk_state_change(sk);
+			if (iucv->hs_dev == event_dev &&
+			    sk->sk_state == IUCV_CONNECTED) {
+				sock_hold(sk);
+				matches[n++] = sk;
 			}
 		}
+		read_unlock(&iucv_sk_list.lock);
+
+		for (i = 0; i < n; i++) {
+			sk = matches[i];
+			if (event == NETDEV_GOING_DOWN)
+				iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);
+			sk->sk_state = IUCV_DISCONN;
+			sk->sk_state_change(sk);
+			sock_put(sk);
+		}
+		kfree(matches);
 		break;
+	}
 	case NETDEV_DOWN:
 	case NETDEV_UNREGISTER:
 	default:
