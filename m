Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A7314A6F
	for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236511; cv=none; b=SUKEYy40agy21Os5qcQUrFVUJ+pXZUnPUxek53QEL0tUfA0fhAhpG7SO7UHdXQg3NQUM0QCNa58xqsQ4+9AkJrKNpAnYy2lVJZuxmM+lO+y7x9MfsZDlV1vPMDmoOIuT7ex7fWa7E/XqS/GmgPal9GJVE+tZParPguJnL/PmN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236511; c=relaxed/simple;
	bh=TMbl75biRN2tZcah2WMOVFdw/0ad6wDd8wn7go8elMs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rwVdzFG8//aNLRuP0in6D1wYg2F8focYQ0YD8CWbmAc0Or9eMpS/MqjXL2ZKFRAdK39XI2IT4e7rwuXuNnGssXJRUwAXhszTSUl/SDOstT1DaO5FlIJh4oFUZgV7Z5j+1vtdHYgdCy4rcL4RcAedxwPJoQDQiM9RXtM5Df1iXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLVEPwqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLVEPwqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02C21F00893;
	Sun, 31 May 2026 14:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780236510;
	bh=j0r0Wag0qC7W82/xkf7jiA0L1rqFPSq8jzMKxrnAGzY=;
	h=From:Subject:Date:To:Cc;
	b=QLVEPwqKktbGx6I/0s2e+6EDciqY3jfBinLc3C+ButeFLQ0/4g9pBD/KFp7dUbKoP
	 Nq1Bp2mZPQJEDxtiL8uY0H5Y/avMmiLdQYPu60FIT3jE7U6S4y2XONh2uoTtkJI0/e
	 2UeaGMWmXUqajyibfq6svDhp79ZmUZWCvz0eMs7hj/kuoEqS80e6Os0nVaL5tIhhJm
	 rWblSXMIDvFPNUiij82e0XPsfVMji7DkuuS82/bWWtonBaAP+OmQY3Y486zLWh1yhh
	 zSOAD6qlsOn4VFzJHUa1c3v9QpihYxKtvv51Lv3CXDc2b57SBHp9L+HXm6gkIc65tS
	 31dmwbIjtv/gw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v2 0/6] s390/drivers: replace __get_free_pages() call with
 kmalloc()
Date: Sun, 31 May 2026 17:08:21 +0300
Message-Id: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVAHGoC/3WOyw6CMBBFf4V07Zi2vFn5H4ZFCwNUTTEz2GgI/
 y7Ftctzc1+rYCSHLJpkFYTBsZv9DvqUiG4yfkRw/c5CS13IXFdgM+C0ltCTC0gMRVbWuVVWmzo
 Ve+pJOLj30Xhtf8wve8NuiTXRYQ0jWDK+m6IUMcqT42Wmz/EkqBj/PxoUSLClktWQZ32p9eWO5
 PFxnmkU7bZtX5nwPgzYAAAA
X-Change-ID: 20260528-b4-s390-drivers-64795b1b2a93
To: Alexander Gordeev <agordeev@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, 
 Aswin Karuvally <aswin@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>, 
 Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
 Stefan Haberland <sth@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2

This is a (tiny) part of larger work of replacing page allocator calls
with kmalloc.

Nowadays the right way to say "I need a buffer" is kmalloc() rather than
ancient and ugly __get_free_pages().

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-drivers

---
v2 changes:
* dasd: fix wrongly converted freeing of rawpadpage
* qeth: make 'info' void * to actually kill the castings
* add tags, thanks everybody!

v1: https://patch.msgid.link/20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org

---
Mike Rapoport (Microsoft) (6):
      s390/con3270: replace __get_free_page() with kmalloc()
      s390/dasd: replace get_zeroed_page() with kzalloc()
      s390/hvc_iucv: replace get_zeroed_page() with kzalloc()
      s390/qeth: replace get_zeroed_page() with kzalloc()
      s390/trng: replace __get_free_page() with kmalloc()
      s390/zcrypt: replace get_zeroed_page() with kzalloc()

 drivers/char/hw_random/s390-trng.c | 5 +++--
 drivers/s390/block/dasd_eckd.c     | 8 ++++----
 drivers/s390/block/dasd_eer.c      | 4 ++--
 drivers/s390/char/con3270.c        | 8 ++++----
 drivers/s390/crypto/zcrypt_api.c   | 6 +++---
 drivers/s390/net/qeth_core_main.c  | 8 ++++----
 drivers/tty/hvc/hvc_iucv.c         | 6 +++---
 7 files changed, 23 insertions(+), 22 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260528-b4-s390-drivers-64795b1b2a93

Best regards,
--  
Sincerely yours,
Mike.

