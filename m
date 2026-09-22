Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FCF5632B0
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095776; cv=none; b=GIMPnUPj4DzihhZimufZU5Z9u0bHAVuGMoYxfF0i8DyNVFPF7R9CWXhNjxiGFT5nmD3soIZ3cRABns+yBI8JdYDVkmgTcHvnQnlh2fGnFRhGtvPpAnHuYXU5YvmXoJVKnswkab+vzLhFypEH2xtK95+EASAP559djToZ3Nkjwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095776; c=relaxed/simple;
	bh=GJ43hdw89yCJ3vRhhMDI3PqyKiLRGHSjF3h6ZMLvsW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7NXhAEkEycutLNgmekn8Ba+Ko6yFu9yLWf5sA8R4zu2Hxqbur129wM0Sm3X9W2G2yp1PAmuZ1F48XA+MJ+mUXoMlUn4NbvWBHNo2bGs1TGXNqAgI8I0NbsX7zZUvHwz4mTQ/5R7nzYI/7gRQIKBMvSP8Oc9BMiR+G8T6A51+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gql+DHAe; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gql+DHAe"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e33b917so45992e0c.1
        for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790095774; x=1790700574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vdLSWXXoLTp0VtdY+wN0aXwvoH7mzI9sSO0p8/I7hAY=;
        b=gql+DHAet3R5c3OMAmMKjDXwHmUU1zFvW4eCnkXeT7jwr5tUqP5CExQLORmJv9lYpE
         m+SqRhBGow1y9vPZFx2zoVQ+vBP7jbwnRJgfTbIQpF7OUW+170E7UGC+UVdt26Ra0K5A
         4xfrT8XmdiMNw0s6Jla+07VlTw9WZbrRcLzDd3KSbOd3YuIevinHDyZTJMgRLNd6CsNJ
         uSIbnDiIEIyrgBqdZ050lTfydRckLHmSwPffLolRSKHqg4ybOwKLw5+aAU2wIRJxAeAH
         ydP81F1uiszWiP0Qbul9/4rLmzeGgPjXOt/SbfBJozFtjAXCJPSvZfHWmeg6QSpfdBW5
         fXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790095774; x=1790700574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdLSWXXoLTp0VtdY+wN0aXwvoH7mzI9sSO0p8/I7hAY=;
        b=nD3VLGkf2k0EuFQfNQUtc/6IMF2cVHI0nkcXA4W835AiVNGJu5BmB02+s1nIepuL7/
         ZCZ96ZZORmuj+fXPiV+P2TIzhaYcsW5tME8qfvnFXTZvDAMAys166GBTYjwGk7J4knAR
         ozudXi91g1V2lIw6qrGax6tevS7qOdgKul6yH1XhTeSX56t6VcMWHRKHN5EqLUSMjjx6
         6fKYlPMtEnt4Aj/2O+QFBePNez4XalPD9esfAUhwSjCZs/A4YGi3XqU7opBHs8hclfJk
         Y3EVLmedSKdOhaHpG2yyMJGiwWFoAgfynW+Ru17GteIvfAaAbaCE5hERn/OWXtxaI6p9
         tdtA==
X-Forwarded-Encrypted: i=1; AKwUvBylWBK14EDDo6yPSoI4drJBNjPVl2fHFhSqpIJmO5ggnzvYlEgWLIPqStEAjJqIee1xZ6JYGVbEOB9d@vger.kernel.org
X-Gm-Message-State: AFuF++kU45T+BLz54vwA5n0xit6CLbIOhQtETqdFf8P/bTDCHPYxrtHy
	lVyhde5GELdPumqxpPr9m9GadHib4ez9Aw3ZCZtuF317EIAx64LKmPXp
X-Gm-Gg: AYBFou2i0tOM/1sTqMSiB63j4+0SQKL3ILLP5LI3XIaDFayPvtl2n1h4gZbNxdoXvrF
	NNaOZ7+wSf+W3El2whDvrnE2qfmR9zZE6LDFHjtRGjh6/WL/CgpcKuqWTFP0hwmyne1YB0R3s6Q
	YioKbUXq/Wei7H/FM2pV+jQ6KGXTeWmfVkDaJiol610A1NDcv/Qj+qEnznsZ6QcWR5QVVqwlPfX
	DKUOwxbfk+OZkt/7Gmw+8Qds0hxVtlsKjeUWTWuUXp7fzvoFgW+B/wMwwo/cI4WLzI1sQxtRsQh
	N1EMogWI+lpxlhERXW+epvrrz4DjzZaiNwz280YKo1Kq4oP/af5PNaP6OHahmZsc2gUbWBmI2QD
	Rts/biY1/kpVZfm3V7bfjfPRj5mLfrSR55HcjLAqdot3Tiw4kh7gLUqxl/08RV8ng441qSmJWOK
	WCHv8B6TObtSAINQhJpn6cwIR4sAsqtlUwoysDuQ/nNQpU6+c2ZEmJNBXpW8h0xeBNMHCx31Xyw
	WBnhx+6HFeyUI9LMkLxDA==
X-Received: by 2002:a05:6122:3d0e:b0:5c5:ad20:1fc3 with SMTP id 71dfb90a1353d-5c9f159af26mr163724e0c.5.1790095773653;
        Tue, 22 Sep 2026 09:49:33 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c47d8a0sm1147936d6.45.2026.09.22.09.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:49:33 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] vfio/ccw: Flush notoper_work before returning from reset
Date: Tue, 22 Sep 2026 12:49:28 -0400
Message-ID: <20260922164928.477669-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_ccw_dma_unmap() is the DMA invalidation callback, which must unpin
the pages covering the range before it returns.  It calls
vfio_ccw_mdev_reset(), which raises a CLOSE event.

On the normal path fsm_close() calls cp_free() itself, so the pages are
unpinned synchronously.  But if the subchannel cannot be disabled or
quiesced, fsm_close() falls through to a NOT_OPER event, and fsm_notoper()
only queues notoper_work, which is where cp_free() then runs.  Nothing
waits for that work, so the callback returns with the pages still pinned.

Because notoper_work runs asynchronously, vfio_dma_do_unmap() can exhaust
its 10 retries before cp_free() completes, hitting BUG_ON(++retries > 10)
and taking the host down.  A further CLOSE cannot help either, as both
CLOSE and OPEN are fsm_nop in the NOT_OPER state.

Flush notoper_work after the CLOSE event, as vfio_ccw_mdev_close_device()
already does for the same reason.  The flush returns immediately when the
work was never queued, so the normal path is unaffected.

Fixes: ce4b4657ff18 ("vfio: Replace the DMA unmapping notifier with a callback")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Found by code review.  Cross-compiled for s390 with gcc 14.3.0, W=1 clean,
but not tested on s390 hardware and I have no reproducer.

VFIO_DEVICE_RESET also reaches vfio_ccw_mdev_reset() and benefits from
this flush, ensuring channel program memory is cleanly released before
the reset ioctl returns.

On locking: the flush is not called with io_mutex held.  cp_iova_pinned()
takes and drops it before vfio_ccw_mdev_reset() runs, vfio_ccw_fsm_event()
takes no lock, and the VFIO_DEVICE_RESET path holds nothing.  This matches
vfio_ccw_mdev_close_device(), which already flushes the same work.

 drivers/s390/cio/vfio_ccw_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 5ce91285c7d5..8e0a2edbd34a 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -25,6 +25,14 @@ static int vfio_ccw_mdev_reset(struct vfio_ccw_private *private)
 	 * and re-opening the mdev, return an error.
 	 */
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
+
+	/*
+	 * A failed CLOSE leaves the FSM Not Operational and defers cp_free()
+	 * to notoper_work. Wait for it, so the channel program pages are
+	 * unpinned before this returns.
+	 */
+	flush_work(&private->notoper_work);
+
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_OPEN);
 	if (private->state == VFIO_CCW_STATE_NOT_OPER)
 		return -EINVAL;

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0

