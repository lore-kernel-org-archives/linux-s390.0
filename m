Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7138D6B5
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760743; cv=none; b=Tz5WCcHg44x7tUIDJWXiWkDzo/fCZJ6V7ses+W3FLAUZvVZ65TcJP2+X/XX+n+qJTAULvzMGnIsunvMIecpmH1HVb9DcnRqqRQaV5W4ulvvpXHuFB2jCdvWkV5TCBHDEWfkZi6+uDaBXU6vmEu2eq7yVUHpTv7WCAOwqVRdqOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760743; c=relaxed/simple;
	bh=8u6RWBOwh83tvvZc3TLwaNX9CvVkv4tyJSo+YHIMMYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eIwEnbMa0DzuOs15dJhwEhTQgvJxFGNNAEWMlYTC2b4uwQgn92X86C14p8K2t3gmON7C636W8QunTm7NIfNl+OxcZ5E5DxuJeyMA9vYJFJGHjBETl5XHccJHYXX9CBaFYtGNn86DQe4rSnt98xt6w8dhDoS5Lh0IaKfHE4zwEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZuQL3cf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZuQL3cf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso46808715e9.2
        for <linux-s390@vger.kernel.org>; Sun, 06 Sep 2026 22:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788760740; x=1789365540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GZO1sjKeCa3nKTO3K84gQ7ryyzwmNZ3acfbok1I6tKA=;
        b=jZuQL3cfGj2saBmHeg8kujPA/7EMOHotqYz0/bdmRVwaTrfXm4HRKx0/04K5TdlkKG
         FN1fBc5DwKzftmOjzfZfR/PR4mQKOXL9b71Q6vOLeIWm+nYHAXNlhkL0PvF4C6cQBcWD
         6jk9RSwPNf49VLb7JJskzuIGhAhHX9s9QX7NZiE3vdGVuLbss8sIBFQNa2uVrk4aAdfv
         R8Mmnfmx4pciJNfMAf7V8BdsfTSCBOLXVWYXEtmnHqFBcM1IzwtYDF2QL1gp4L8td6As
         reiySdVv4O5hgr63TcON7tJx9KjFn84G4/RiCMXxBYsh7u8g1JDFe326Pyrliuq2QGAW
         7b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788760740; x=1789365540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GZO1sjKeCa3nKTO3K84gQ7ryyzwmNZ3acfbok1I6tKA=;
        b=l1+BXIfOuGZxiG6l7m0ODslTy6Ua4DgnVc3emrQDAUMcYYySh4pTH0fPBneafG89Sd
         zx/jI9xbfchUvdIASq51TCb0Kwtd1TakyDbrbVpwP/wiiT2q0906Bl4kcl72u6s+f/yU
         p4en1sid8/Go5xfUWfJ2OS16TM8anvO6LbMUTKCFfIxSFF9Gdq2ZI7QLOJwPx/jM9omU
         0XzPBSnFWOj2BM5WVUi/D+2G+FIIoj79V3eF7bm+IY7qtGa1brij9eiw6bTneFp2k6/6
         PVdyXMdSjra3I1P/5vzU/zAZKJ4qRNDdSozI3py9VTTm9BJDy4ZHRSEeavd8QR7sFBw4
         i3ow==
X-Forwarded-Encrypted: i=1; AKwUvByXyizJXGbKtuw4gzor7D1uIZwheIN1gUs+sHS7Lz0VV5lSYe1/p+G1fFxVKysdzaaQZRVp0ohB6Hu9@vger.kernel.org
X-Gm-Message-State: AFuF++nRsbm8+ek3RL98r/KF6bVK2daWZaxMOBwcKwzWshTDzl9Fpz64
	Z4Pnz8KNE9A8T+6epIWoH8p44blsYvKMXHtfdkrFOGni3qG1Kn3oYDqO
X-Gm-Gg: AYBFou1Yd+vF9BlQynudnMAatAP9GYZ4u87CiEjJiNLJDKXInDorGJseoyObEbeQFYK
	qhpRIS5B/csXPw7jbhQE6cLbCofXDO1u/rjUMpZzqo5AuK7ZAz8tlFlOsrKBXgzzBtkyIn8DCXo
	HEmdSJlkQdNi9zZQBnXamaEVtR9mIb0PiLKvav5ENpnA1mQmhHggtqyYNMBk82wJY/MIw09aSh1
	dDiNahLMc+l/gEZTZXVE5mj8vqYJ35e4Ur0Cgb+E1oQY6ke7xT2ijUviT7FeXRyEsBnTse/kg4y
	Jv1Uevrsl6Hz2gpHM/BmTEf67QceLa6TXsuxcX2l2iNnQ8Cr72Ybtbi0VTW/F9qGekYP21IEUOf
	EUN59m/IneHZMEIvGL4eEW02v+IAHMaairhu13q35fOf6SSLi1sDEKJd1pkxdtajocl9kUm8tey
	tXTe5PBFC+UxYwm6pUp0H50qLijFC7cSAK8J4+CRsBxYBn9Kq2Z87CATjSn0wnEMdT5eC8FyIQ+
	Ioy1aevDwfrhDmeNwy19Ie4iE/29rfs4mVJ8Pm9flwaVGtLbFPJKfuZA6nYw20R0Ebzt+Lc13sT
	mA/bjLDP2kXvTjLleqMZXOdlL/2MK28dOo9lN1oMDPwX/9TOK+Vw4hW3y5rRt1u5o64bDoMX
X-Received: by 2002:a05:600c:5303:b0:49c:fa21:1c85 with SMTP id 5b1f17b1804b1-49cfa211d81mr158899595e9.26.1788760740303;
        Sun, 06 Sep 2026 22:59:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b0c9-3601-9daa-d59e-970b-f46c.310.pool.telefonica.de. [2a02:3100:b0c9:3601:9daa:d59e:970b:f46c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm362494915e9.15.2026.09.06.22.58.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Sep 2026 22:58:59 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2] docs: s390: pci: Fix the sriov_numvfs attribute name
Date: Mon,  7 Sep 2026 07:58:47 +0200
Message-Id: <20260907055847.27992-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The attribute is sriov_numvfs (drivers/pci/iov.c); the document names it
sriov_numvf, which does not exist.

Use sriov_numvfs.

Fixes: de267a7c71ba ("s390/pci: Documentation for zPCI")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: name the file that defines the attribute, drivers/pci/iov.c (Randy);
    Reviewed-by collected
v1: https://lore.kernel.org/r/20260905091627.40946-1-kmehltretter@gmail.com/

 Documentation/arch/s390/pci.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/pci.rst
index 80f4ba193159..565434626fb5 100644
--- a/Documentation/arch/s390/pci.rst
+++ b/Documentation/arch/s390/pci.rst
@@ -67,7 +67,7 @@ Entries specific to zPCI functions and entries that hold zPCI information.
 
   A physical function that currently supports a virtual function cannot be
   powered off until all virtual functions are removed with:
-  echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvf
+  echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
 
 * /sys/bus/pci/devices/DDDD:BB:dd.f/:
 

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0

