Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168952DEA94
	for <linux-s390@vger.kernel.org>; Fri, 30 Jan 2026 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769761401; cv=pass; b=hOrm809dtx6nLXddRHL2zHGYlnY6sRfO0sAw0Mw1u9lR+Akyjauj0UXzJD3vwFTBnwg1BBqCPZckEzVzs9qWycR/bE+59JZjHFsNu4ULHfE0m5Kelm106joAOdepY9SAnERL46w9/tPti5QKHILxUETQLr7y1cMxMW3hYVp6c8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769761401; c=relaxed/simple;
	bh=AS98bAXJJMLzXcNleyqqHxMtX0JyXD6KD3bumzk+64s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=m8+fxqLvmwvBR2gPa0TRGbHdopJt+LqSPjVNmKilJ6TdldkeoGexwtnCYEFjKbLD77lI2GJrRRHLFn57L4z5yPtp/2sSviC7SaPzHrDmyIS0XH9H/zMrRZ/W7VbwmuN37I27pU9JIdBbEyHgAJikQ8Hq4cwQ1u5sM/nke5XwJEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLKGR0BA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ptgjtHn8; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLKGR0BA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ptgjtHn8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769761399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aa6soRAUmPNM3opr1vbn3p+gEjebmfYvtYkCh8ygcnU=;
	b=TLKGR0BAJYxg/N1SMRvT+eAndpiXUtfJNnnyu3XzoBkgidxF4NaD1Xyjg0d/uj2XIiM0/M
	wWDZ9DEYcnEakBkTUp7xV2suG3dZoUE8bTEPS4PMf1uDC/AMXyglBh9LFOOYmNpoa0VhVL
	sLtzKhY+veVmtWlsJlyOnVGn+JgyCtw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-B1Qthe8zPn-aHIiJZuNFCg-1; Fri, 30 Jan 2026 03:23:17 -0500
X-MC-Unique: B1Qthe8zPn-aHIiJZuNFCg-1
X-Mimecast-MFC-AGG-ID: B1Qthe8zPn-aHIiJZuNFCg_1769761396
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-383558ea1b7so11677241fa.0
        for <linux-s390@vger.kernel.org>; Fri, 30 Jan 2026 00:23:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769761394; cv=none;
        d=google.com; s=arc-20240605;
        b=BXK7phwBenlFsHcb+8GPzgfzPaiaBwNOHH18j7zpQPGMKD8y7vLVl47HgJmuoBYPrH
         ZFchXLzgsT6f/Nt373JLh3rn0TeYCEuDEGFSbtHZnjbZ5I4/BRpMyx+mwyceASIE35R6
         cFiUD7ofQQwgZAi4XIDfASLRANh4ibtx82Nkhn6bkwf/Yd+DXbQqTxcqweLNBBQXwumI
         1AVDy8f4KIPim671dSKaUy5jEfeqFE6GIgO3964Mi7LyRr6InZxLxpEWCPHchQEO1pff
         VU+uCoFLNS/csJWX9TFZUnEpLJhtEjHiXufhPjUP1wpm8S8GfDeXDW2uBKm1O20rFTR/
         gc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=aa6soRAUmPNM3opr1vbn3p+gEjebmfYvtYkCh8ygcnU=;
        fh=oUzzZqQ++sXBnLnb2XFwfyJw0hEy153K2ojRz8xsUzk=;
        b=O0vxy8wV+B3A264Xpd9Xkz9lrT3GQOCbcYaQS3FhxCDGjOIavn2CqgfNnTlZDAGgQP
         tVmm5lbAxCC13d/ba4PSQTvCBnaVp1MzzI8S6L6pZAUfR2OLnjlHlOr8wB5ugL4LgHwC
         SKnHIBGluL2vLvAMghqMqQeOhUm7ONrmctuRdXoIaw0uXBklzp6QdJWEiqV6hiuGRoOh
         Xh54yUhvfLSObTrmc+ecVkv941FlmoY960gdg0KMkjufVryK76VR0NcQyPJ4LTg8qjqK
         ixLksJtVjeXVmsS2CE+SFNIXdVlpEywQrGAEaXPomZP2cK143duFnfJqZUJhNJQqzDYv
         saNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769761394; x=1770366194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aa6soRAUmPNM3opr1vbn3p+gEjebmfYvtYkCh8ygcnU=;
        b=ptgjtHn8wmthOevcadkObpHKpq8bGC24ihXq+M8nKos0Xh7KSC+uUHqPIKiGgX2TFf
         1w8j5B9y5rN9Ds17CszROqSjQ4qZExwY2wHwYpJEaNPPtw7BCaL1hQ28/HOCqk8JGIez
         UMcblcBR+Zuffj9VKdXu0nLPRbOANtdbtqAJdYHxpW6C+aujyLgFPnkvoCU64mmnu/J2
         wcjKhRnGn2dXbGWeE6ZsVQ79lpqXC1tbHFL/0WNGGibLvLORj3UKmjMp186HIcILU5lL
         5j53idYmeXFlUyRmsD+ee5SiLEegfQy9oaNphhl8/w/AEYLXe7QFYwG9d3JyN8nBodnL
         wHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769761394; x=1770366194;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aa6soRAUmPNM3opr1vbn3p+gEjebmfYvtYkCh8ygcnU=;
        b=I4xlRdkaCY4/6QNYip+vlYTNn6fanxAvM7BKaHhcdQy3X04w31CtYZifvhRxQtiKVK
         wIyhLIixzllvrVr2x9s2fAQ/qW0WuFFx2NtUI2fAvxQKs4QIF+BLZzr4fmCWcoA9uaP3
         KMc3SOMWhRpAi2Tn8DSBALtlE+sluJHQ4VTsXZXPURh3tJESoO71S1/76AaIsRwpveER
         Foql3MxL7jmMmKbMzw1e3wEDF1xX3DRKlvUNqITsxitsrhqR8KhoVrYdfi59Y9hVUXJI
         h173ZNBCZS1GuBo0eGIU8GOKVH6lsQhV9CpUhYgtcXe9l0QV9x9Sghp7g+rcoZPqtHmr
         nX1g==
X-Gm-Message-State: AOJu0YwmArAXq4R/E2DnTORYB1MK26NXahNIoCp1NeHmfNdVC/YkxEKc
	Y3o39Ddo9kBTJ3uxBMEVJhLH9gXg40JBdNyyBqC0SXWDZKluCR8pPM03bel83uJdY65TAund0AL
	gClkDJbGG6p1batvPXjfUVaptPG1oOtUQMeHj6qcuLnvqkNWlC3oG94+NKYltZIcwiLvZz7WC82
	4pSKdUhiKNm3ik0628NfmC76QUMH6QGUqDGdcmkmpoqhySdOxjMWO/xw==
X-Gm-Gg: AZuq6aLNLU3g0UVsILGNIBgX3sMjbQ5yB/Iq7JUViVOL75j3RzqJIMMdnTQnNhR4JZz
	JoUdEljAbYEE+6mkKg/5vnFP8XLjLJxVdFt6E+jbPZXCtk9tcge3qQDpmU6zm3Mw8gwEHg7hlcJ
	izNNe48zjfMrxPQ/Rr22xJ3Nf6A/rcngMWOHVWtwEl8kWRyWaz28nsVBrO+tYP6/p0mtA=
X-Received: by 2002:a05:651c:550:b0:383:16e7:9c3 with SMTP id 38308e7fff4ca-38646513dc8mr6044031fa.3.1769761394336;
        Fri, 30 Jan 2026 00:23:14 -0800 (PST)
X-Received: by 2002:a05:651c:550:b0:383:16e7:9c3 with SMTP id
 38308e7fff4ca-38646513dc8mr6043951fa.3.1769761393926; Fri, 30 Jan 2026
 00:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 30 Jan 2026 16:23:02 +0800
X-Gm-Features: AZwV_Qh8VUMimPys1ieuq1HdgTTLRP_rwfWN6KMiGl_Y5IfSdYt2FFRHzQvLH-Y
Message-ID: <CAHj4cs_GH0O7-nkh=8EhwscjzesawBJ+6b0MxuWZOOsp4B7HsA@mail.gmail.com>
Subject: [bug report] kmemleak observed on zcrypt module after system boots up
To: linux-s390@vger.kernel.org
Cc: freude@linux.ibm.com, dengler@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hi
I found this kmemleak issue after the system boots up with
linux-block/for-next, please help check it and let me know if you need
any test/info.

# uname -r
6.19.0-rc7+
# dmesg | grep kmemleak
[ 1648.765780] kmemleak: 1 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[ 6148.698090] kmemleak: 2 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[10419.366662] kmemleak: 3 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[14843.424498] kmemleak: 2 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[20987.442195] kmemleak: 2 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)

# cat   /sys/kernel/debug/kmemleak
unreferenced object 0x990d0000 (size 12288):
  comm "dnf", pid 48539, jiffies 4296356469
  hex dump (first 32 bytes):
    00 00 00 00 99 0d 36 30 00 00 bb af 00 f7 1d 60  ......60.......`
    00 00 00 00 99 0d 00 10 00 00 00 00 99 0d 00 10  ................
  backtrace (crc 9893fb1d):
    kmemleak_alloc+0x6c/0xc0
    ___kmalloc_large_node+0x106/0x160
    __kmalloc_large_node_noprof+0x32/0x170
    __kmalloc_noprof+0x6d8/0xa00
    ap_init_apmsg+0xf6/0x190
    zcrypt_rsa_modexpo+0x15c/0x1310 [zcrypt]
    icarsamodexpo_ioctl+0x110/0x270 [zcrypt]
    zcrypt_unlocked_ioctl+0xc60/0x10e0 [zcrypt]
    __s390x_sys_ioctl+0x178/0x1e0
    __do_syscall+0x166/0x460
    system_call+0x6e/0x90
unreferenced object 0xae148000 (size 12288):
  comm "dnf", pid 48539, jiffies 4296356470
  hex dump (first 32 bytes):
    00 00 00 00 ae 14 b6 30 00 00 bb af 00 f7 1d 60  .......0.......`
    00 00 00 00 ae 14 80 10 00 00 00 00 ae 14 80 10  ................
  backtrace (crc 41938ebb):
    kmemleak_alloc+0x6c/0xc0
    ___kmalloc_large_node+0x106/0x160
    __kmalloc_large_node_noprof+0x32/0x170
    __kmalloc_noprof+0x6d8/0xa00
    ap_init_apmsg+0xf6/0x190
    zcrypt_rsa_modexpo+0x15c/0x1310 [zcrypt]
    icarsamodexpo_ioctl+0x110/0x270 [zcrypt]
    zcrypt_unlocked_ioctl+0xc60/0x10e0 [zcrypt]
    __s390x_sys_ioctl+0x178/0x1e0
    __do_syscall+0x166/0x460
    system_call+0x6e/0x90
unreferenced object 0x87dd4000 (size 12288):
  comm "dnf", pid 48633, jiffies 4296914470
  hex dump (first 32 bytes):
    00 00 00 00 94 c7 20 00 00 00 00 00 00 fe 90 80  ...... .........
    ff ff ff ff ff ff ff ff 00 10 63 c9 1e a5 48 b8  ..........c...H.
  backtrace (crc fb3113e3):
    kmemleak_alloc+0x6c/0xc0
    ___kmalloc_large_node+0x106/0x160
    __kmalloc_large_node_noprof+0x32/0x170
    __kmalloc_noprof+0x6d8/0xa00
    ap_init_apmsg+0xf6/0x190
    zcrypt_rsa_modexpo+0x15c/0x1310 [zcrypt]
    icarsamodexpo_ioctl+0x110/0x270 [zcrypt]
    zcrypt_unlocked_ioctl+0xc60/0x10e0 [zcrypt]
    __s390x_sys_ioctl+0x178/0x1e0
    __do_syscall+0x166/0x460
    system_call+0x6e/0x90
unreferenced object 0x8e65c000 (size 12288):
  comm "dnf", pid 48633, jiffies 4296914470
  hex dump (first 32 bytes):
    00 00 00 00 aa 22 2e 00 00 00 00 00 00 fe 90 80  ....."..........
    ff ff ff ff ff ff ff ff 00 10 63 c9 1e a5 48 b8  ..........c...H.
  backtrace (crc 1b33772d):
    kmemleak_alloc+0x6c/0xc0
    ___kmalloc_large_node+0x106/0x160
    __kmalloc_large_node_noprof+0x32/0x170
    __kmalloc_noprof+0x6d8/0xa00
    ap_init_apmsg+0xf6/0x190
    zcrypt_rsa_modexpo+0x15c/0x1310 [zcrypt]
    icarsamodexpo_ioctl+0x110/0x270 [zcrypt]
    zcrypt_unlocked_ioctl+0xc60/0x10e0 [zcrypt]
    __s390x_sys_ioctl+0x178/0x1e0
    __do_syscall+0x166/0x460
    system_call+0x6e/0x90--



Best Regards,
  Yi Zhang

