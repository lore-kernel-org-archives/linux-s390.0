Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6130C39DBEB
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184833; cv=none; b=kREbLVRlk0vEpToUJ8V+dh8HqbtBdptQjqPK0G6GqsTLoVL8XS6XQpWOp3F/Be0zz9YrIuoFGClLWKYkUhrUQgWT9D7ERqMlSZaWnksWfuAdUUObmdqcoFj3bXgv9UIi56QkYyUlIGGuVjrIiAKvYniXPiplHMeKgifTJ5it6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184833; c=relaxed/simple;
	bh=3nUL3rrmcUfID0DDtH+fnolF/wVDYul0PA1V7JWUZpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZY5Ff/QGBIulALjUhXqLahGAAbgpXqX42zDpuEkeBBIVG0vduiDCIb/ZoeiGhjShkkeSt3b5hoMh7nW+9ow2bUxUEF4eLOHuv112vaKoM/GxQkkVzgLxhu+t6s6Lg6JrCkdp3VVJtrigVGZqYLJyPtjPNTcqYVcwoxRuvsC67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKmwsiot; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKmwsiot"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36974217d4eso1901847a91.2
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779184831; x=1779789631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wPlnCZIGFehZKOWoeObeqnRwLPoyuMVquqLHAA3dDM4=;
        b=fKmwsiot8l+L8eXmTAA/xyJ0iGcNYQYyYhB4THzkoEsiL0mBi5jkix6UMZGu2r6A0P
         7q+J2VSjC+ORO4bC1wvD63Smef7N8LOhGX4bIa+3PfZ9mO0Ay9bDI5Zze4iHQr0tww8J
         171JN+kl0CO4RqX6qMWDBBnoZ0FMvc55vSIwb42X34iX0BsAsVepccumWOOvIZtpBQOv
         Rs8iYdJm0dLlCTKw1tP6rF4kN60pFbBwT0G2wz99EuFYdVPVbIU96e3Y4IIESEWuaxxG
         crfmUqb5FHOLjORdau0euF85cDUitY5UZO7SJEmmvcQNI4LcqLLP/a4BCz67F/Illb8r
         BUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184831; x=1779789631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPlnCZIGFehZKOWoeObeqnRwLPoyuMVquqLHAA3dDM4=;
        b=b4tTBterA1AeLp6RW2Obqk5dKp0ACpLPDTHiSlztocTk0Zm7yGDmJ8q9BsWuF8RHGO
         yStfDVwOApLsfx6XHqUDDFGpp7jZcbOlBful18sjM07flHvg6yLUteLUhQtXMEgwgB2X
         8pVAWOaGSVmY6wQ73aHXHINMlCmLAaFaWlBDTMmVH/U1zf4j3n6FIY53Enn+4VDIA6wQ
         b2UhSYZ8EYe3oLDgWSIT6Ah14xYt4WNVUvwCI9dbvUzljGoGvv8OLJQdGwjWs4CghVem
         6fftKXp6hJTNmxJG+urqAGVRbPeoj8cjmCZx54+9mNqI6otFIX+27MZm3zst/TYd220b
         N62A==
X-Forwarded-Encrypted: i=1; AFNElJ++DsocgHupAbJwuOYIYVNBujjZUfkiDSTD+vmikUAyHd/BKg6ftqodbwzxivdaVknd30oCCikABqcu@vger.kernel.org
X-Gm-Message-State: AOJu0YygkSPPhCQ/zdp8kbbbSTFf3z/pCiOmLjUJEjkPt4rmUCVKiWTP
	dniNj08pOBcXEY4qk7Vk3pvtVzzZuPhKAqLcWxcsZIQBf//teMLz5CxF
X-Gm-Gg: Acq92OFtvI71hqF854zB1yRgmtiOPjh8sdwLTMBtBJ9X+u2vg5Vo65zOJZv2QcN1CyN
	hXs/Si685RtHPHJNymCZ2CscYPOQWdzrA+15YUc6qDGdlGX1hs9D7kspdNENULN/LrJy2nEhpM5
	cTMhAZtF/uyl2wV3geJBIncsSE8EZzsKkji4hwwHjZ0yrnoM87JUhQY99jdpjYwI+uSR/8kd6Er
	1GJkXrEbqByNWMxZldt7l0I9lfFApQ1Dc9FQuAi7au22MzU3ScVPc1sfhYAjM6GhGNvR3GJSnyL
	847B/oJ0iAN51tT6hJO/OAOEG0kjhfTSGG0KZg+R87ojjPwNL46V9b/ngzHhyIZK8O9aXKSFU+I
	M29ConloDHM7E2+SpWXLZwcEu5oGwvuRk2MfVC6B/kwfHolBN2ag18/ow58tFJGHxekHOVUrYP7
	gYpM37Kwd7ZaopsPLKvPnFgMoh5Ro67mMQrz3ewrCZ3Hz2w6Pp
X-Received: by 2002:a17:90b:1344:b0:366:4f8a:9847 with SMTP id 98e67ed59e1d1-36951b711dcmr18287582a91.17.1779184830724;
        Tue, 19 May 2026 03:00:30 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3696e24e857sm6085380a91.0.2026.05.19.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:00:30 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: s390/tape: iterator after loop end in tape_assign_minor?
Date: Tue, 19 May 2026 18:00:26 +0800
Message-Id: <20260519100026.1970224-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

While reading drivers/s390/char/tape_core.c I noticed
something that looks like a past the end iterator pattern.
I would appreciate it if you could take a look and let me
know whether this is a real issue, and whether it is worth
fixing.

The site is tape_assign_minor() (linux-7.1-rc1, around
line 339):

    list_for_each_entry(tmp, &tape_device_list, node) {
            if (minor < tmp->first_minor)
                    break;
            minor += TAPE_MINORS_PER_DEV;
    }
    if (minor >= 256) {
            write_unlock(&tape_device_lock);
            return -ENODEV;
    }
    device->first_minor = minor;
    list_add_tail(&device->node, &tmp->node);

When the loop walks all entries without break (every
existing entry has first_minor at or below the candidate
minor), tmp is past the end. tmp->node then aliases
tape_device_list (the list head) via container_of offset
cancellation. list_add_tail(&device->node, &tape_device_list)
inserts the new device at the tail of the list. That is the
intended behaviour for a sorted insertion where the new
device has the largest first_minor. The dereference of the
past the end iterator is undefined per C11.

Jakob Koschel cleaned up many such sites in 2022, for
example commits 99d8ae4ec8a (tracing: Remove usage of list
iterator variable after the loop), 2966a9918df (clockevents:
Use dedicated list iterator variable) and dc1acd5c946 (dlm:
replace usage of found with dedicated list iterator
variable). This site was not covered.

A candidate fix would track an explicit insertion target.
Declare `struct list_head *insert_before = &tape_device_list`
before the loop. Overwrite it to `&tmp->node` only when the
loop breaks early. The final list_add_tail then reads
`insert_before`. On break that points to the entry right
after the insertion position. On fall-through it stays at
the list head, so list_add_tail appends at the tail. The
behaviour is unchanged in all cases, including an empty
list and a list with one entry.

If this is intentional or already known, please disregard.
Otherwise, I am happy to send a [PATCH] or to leave the fix
to you. Thank you for your time, and sorry for the noise if
this is not actually worth fixing or has already been
spotted.

Thanks,
Maoyi Xie
https://maoyixie.com/
