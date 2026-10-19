Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442102;
	b=o6slQhSkNSHMOBCqDf/ufjPyPqWquucCl20JL/jICGk6zHwmWT6rgymvL/cvdyLw3dOY
	 vjVSGd2s7ks/ziVPI7S4Kvi0V6n0mbvQiyz23NnC81JbRZQf1Pw/x/zlsKtwsIWFY72Po
	 LSfa9HLlrvl482/tYTcVoYaNYzVHI2YnyryHDi43d7bkSfjTsWc77zGvZih2DK5qQfvpg
	 wKiJvuHgseoN9O/LBXgFD5ZbOomYLQMP/mJnv14M+I9+h49QEUPdkzedTeskGz99VEmXO
	 7cwwFdxNuT1ehGXxic6+NJsMnHFjJu9J9gmAiE5SH+utwkbETympua7UNGKZSsRFSNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QiKFKvXps967wwyLmEJ59eoTg+fbLeK6RWK4w7bM5/w=;
	b=036jWc8l2XZ726AcX/rW5fdyu80vRt6Rkxoj7zsrewOH/YSgYXgKN/nzHl1MYTldScD+
	 fnIRE/CEckDjeHBcvj1lY7O5VyLTdPnh+8xUgZMTl6ByHz3Cqo6oDvzGenkfrRysC4oHd
	 9wLi09MEij9I8ndUblscQ2tvMM7CqZuaaA+3EqP82/l2jQx4Sq+aqoQF/V6L0ioOASS+C
	 b+AoLPjx36CcmrRDmIPn3WIUxYFM8PcFGF27kjplpEM7h1Bz2b9XqKRK2g354G6M4HI0v
	 rSV4BUS9qzCKEQ3JWSbEEdqtm1aGcrBwSzMFaWNkegd2Xkq7AqP3VsAe0S9bAVDwzQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BZk3+FV5;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC85606A337
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 20:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC85606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BZk3+FV5
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956869750eso20458805e9.2
        for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792442100; x=1793046900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QiKFKvXps967wwyLmEJ59eoTg+fbLeK6RWK4w7bM5/w=;
        b=BZk3+FV5sP7TvpXJf9JI4+NIrngTAnbwPLj5823EEz1Z0X5cG+mkg9zSiurXIUT7oG
         jTRhyO7gBRMCKOJZvPC37cDLRbenfqi/xkzVh5VU6UqfsX6qSrHtAhN1J5qJisRGQB8R
         ai2jRPg61ASl7Ys8//+9Ry1aGySqhbXR9hH1X2UdV+2jheAhovhf0sYxgK8lmS3kj3F5
         4mEMFCBGQfbqD5inyct3EVbTiznmcU8UbYSPjol/pmTNiRURmX/zEZuAa8L+0Kp5WmLv
         E2GbDFsdFbmlCx+95Pboyf/+atdik0lAnXIpYs0Y+a1W4TMOhrKe1eV4bR390Zpz+gx0
         PfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442100; x=1793046900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QiKFKvXps967wwyLmEJ59eoTg+fbLeK6RWK4w7bM5/w=;
        b=Zp7gaAxnNGyl5MjPHzaieswWhLa7O8tiGdere2ZSNysHxAKr1vhwrI4MHOipaiXGQh
         oBszWEB8+02aMCbscOMb4lxm9V6Jc/9NlwMGldcbAjOB9swqryFJS1ZZuzyJhIY5gYCd
         nfFCJv7g2E0QZzoOlzouvvMNpgt9tg/dX45CqhmcyZ0+s+6ZyWWnp+x6XXXX/HC1dI/0
         A4RdXjNdSBcbim2B9ZlzN+oZQ1CDoCE6GduLm0HBP8gOuM+ktHbACIRoyjsQK7EtKq3W
         mBU1esm8a2CDA+sy5uMrUalEynBSGNYvrIcsvJsZHv8mq8/AWaW6fCBWOssTMXVWkRXB
         5Xqg==
X-Forwarded-Encrypted: i=1; AKwUvBxljlwt6/GP3/vk0S4rkV/2J+u0286NpFHS7epwc9mnDg5zAOmIOZKqrn4GnEIcHMIu6Bezlj7MuwfD@vger.kernel.org
X-Gm-Message-State: AFq9FYLBiEV6UJ0BJkHqDko7PPq7rI2W5GGscKPSEDXQ28l+Zf7o2QFj
	Zqxl+3/2/E/+D4EhbljVUKfDm834Fa/nOexHRo8nwafR7JmE/nr/BI0=
X-Gm-Gg: AYBFou0plYJpMYKOcWQoGZ5Dqcr3f2XXCqEqZPQ+5LyjeX54uvMIS34pWjrozoH2o6R
	jjwv9wAM2M52mbIhxI2EGprtDiWAQMi/NBitHpLP18fX1sJSq2s66lqIQbv2iQsU01mWXeuU3hR
	7WE9Ys0HCXPAqH/6IkOnPi068SHW+kmvvgznPhaNZXYVZutDnZszfIZOiwNKd1NziJZMwesJ9X9
	MuPuQ8P2di44Gy2p2FoGvB1GDs8CFSgF4lk0qU5SBOaP0ONaAfooLGAJ6Pe1YRF9U5zx2eKVcac
	Dj5k4oqmN9q0T/IvWyFSKf1u6t8hrhoIXjhfS6DfnQJTJjCs7+mm1KoxQrjonrbr8wqk1+qmOPk
	MaQqRyyxyfeB/oWJ8cSeS8a5lrTaukD9lxwnNkiFwddcQ+b5tqBmdHi5W5G68tilwU0OIAjC2Nt
	llZY5J3pRaxOthuslL8iwat0xlXbM08kQasjcV5lY=
X-Received: by 2002:a05:600c:6217:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4a1dda8eca9mr131113225e9.27.1792442099905;
        Mon, 19 Oct 2026 13:34:59 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d43242sm15802805e9.9.2026.10.19.13.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:34:59 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Cc: Stefan Bader <shbader@de.ibm.com>,
	linux-s390@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] s390/tape: cancel delayed work before freeing device
Date: Mon, 19 Oct 2026 20:34:57 +0000
Message-ID: <20261019203458.1365046-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

tape_put_device() frees the tape_device on the final reference drop
without cancelling the pending delayed work tape_dnr. If
tape_delayed_next_request() is still scheduled or running when the
struct is freed, the work function accesses freed memory via
container_of().

Add cancel_delayed_work_sync() before kfree() to ensure the work is
fully completed before the struct is freed.

Fixes: 4111796d89b8c ("[PATCH] s390: channel tape fixes")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/s390/char/tape_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index bd8e3deb11993..e3aacfab2cc7a 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -532,6 +532,7 @@ tape_put_device(struct tape_device *device)
 	DBF_EVENT(4, "tape_put_device(%p) -> %i\n", device, count);
 	BUG_ON(count < 0);
 	if (count == 0) {
+		cancel_delayed_work_sync(&device->tape_dnr);
 		kfree(device->modeset_byte);
 		kfree(device);
 	}
-- 
2.47.3

