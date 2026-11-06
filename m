Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991846;
	b=wyImz1V0NQdVKq2Li1Xu2AiBUDrq9GnaA2ytE9uloK04icKLhigUvkz+YGfZ1nmFQDqT
	 BEvPyW1oCr94c+5Q67BctVgJrdi/DswOnXcViZk/CN2DMqBnCW1nA0h6n0wag4bcCfG7q
	 PNTttV9wfbI9my4mvfaLDGSmiDARVeB7/QrRKLvB4Cy/XMtSu8SaEhC1Dc0oP3iSAneyT
	 vDsshEwFIyG7+zRdtHyMkp2FraQG9ABJLfQMuNA/rM9lJ2zFnFWRVo5DWG4wSOt7MkFfu
	 Bd7ZmP2Nng3rXMocUUFwwXCVvh93eDd+XTiPYxErw43OXXJAO8MpLfZoXuz8FRHWt/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M4F+cGVjhTRlOYCUyyTMj5qF298Mym63HwKHgYQq9GY=;
	b=uKS6J92AGRHJD22FatNv9jwCfoMkCTEeKduQYBeBiBsdgy86iSMAHoEZZLLojWzdRyHO
	 p1aEpTclbw5gWd0cwQo1NwubR+PswBQwdEMpm0hv02YxnH0EleH4ORhHEKvm0ugwgWLvZ
	 lj5mAoTMenRUQO9/ngn3YWRx/F3KXoW5Iu17F/vpQGuXWGO8njvLl89eK00dpoDOzZDWQ
	 BfaFbXRx0UU36JqDtJO3W70tlDsYRXfvOd8wiGPzyzQaU5l2feOY7PIaRcuCQ0KBtOayw
	 TMh7a6vSrgjtOvk/QLrzn+fOqBuRMDjcxNyjJb0ukfxS7c2NdIqUKjM+aoFMYuEBrXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xzh7aoIk;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53605606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 19:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53605606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xzh7aoIk
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53669f7b518so10128421cf.2
        for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2026 11:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793991845; x=1794596645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4F+cGVjhTRlOYCUyyTMj5qF298Mym63HwKHgYQq9GY=;
        b=Xzh7aoIkNhOsCEP8LMNJotTw4ppLWYt4+8Zs4xtTFC05WrzujXx3AxI0s+4q7iJ24v
         MOKiJ00/2mEt3GiP0mQN68YbT5tClkf9QHWpH0TOWbn8eAfKRgsEAxEOtseeM/vK+Am9
         y0Y3sub6EtjOq3MhYfFiSmadQ3RkhotEvoJocbrJt9aFmomcux/47b9Et+YQQXD8Rpgl
         y/iBFrmvXVRdIWxOM34JYjhoxsklMcalQkqHIJ+ya9HDbij1djgDL45wxw6ugi4IMVmM
         W0m08FZC0g+U+jg//d4ap15xZj9TfTMbxMOrWW3s3rNqE1JvUREuCkHHtsio66C2RlOG
         TMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991845; x=1794596645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4F+cGVjhTRlOYCUyyTMj5qF298Mym63HwKHgYQq9GY=;
        b=PR+ByrKPoZKK54FjfwPXCvoyy5mc4l9/Cxbrw2wvMJzO/+PHp58kVg6jS8Vtc7vg3r
         61PICoYcU4D4WYl4K9EuXm4rHAhnROKENBXc/lab181QIhkKW/1zyN7FXdrlHeR+TXR0
         GifCqJYYoDsgGl6GNb4YIDhXXlsBexcCmOyKMbj2bQqYBOXKh0lsxSEJbeJV+r2KFz0D
         wyn42g3kLWr3MQU4Dkjzr3mWea3HuvA4MsX1x+hppufj13p6vuSIVwWVz1pWT1csuBtm
         EJf0YV8pjKDjI3gNAfpr+hrvTIlgncNjukaHRy3I9zwNpfCmbC1l9nvwJPTI3nS6GsLL
         IvuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxU5IdNX9yHCQ/M44vTPEBCXyXcdN43VFci28T1m1X0ZwK8tYtIKZ/hxbFWySUhTtUUz/McbbbW/I6c@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZlULdPn2i0ZPGPPE3GwomH/wGMYU7PT963aSTK2BWuofRM40e
	r+ESOzWrkAPxjFG6D7IrSswPPPWXRaz0TNam/yoTw1Oqt1P3hXbkhpl0
X-Gm-Gg: AYBFou2gQPDHDItM9g8a6yTqd1fwrPxRSuDqVVNBRIAJJ9apmiSkdUvMdrjJhy8J3/a
	LM+Ye5P1luQoN/F2ABjC5vsWCrnwS+6faxRsrXrcV3aDZqpqPMyqi/Uz+na2J/8SvaQhhB05Dgj
	ZTGAHoaNb8sbVi0/DcezWF3apmaAPrVkShwr7Ag8Kea8kNdYaF5WeYgEyxt1noDmWO7FTTN1l9g
	RoerP1upEKgunHk7vDhFVYyzvJyr3d2Bn64H2Jk/8DhlZRSLrzfjGC/KjJ9bd+ldSAvDp8sZOX7
	6vvf9OcHCmMK88poO/GsCZUzwMecDAh0IFoER4wW+SPtjpZsTpJnHE/COqgosjwCTgCfJW7SoGm
	G6QC9G+PSqH5d2OzrYtwdcaKE/boIpF9OINtvGUuvPXbZgj6JLcR5T5+/zmsqCercxlu4m4ydru
	v6iwmomrFZZC4ki1VuxftFOaJ8qm7sy7YO7of0Tqy0wobdZnRe3+jAU+a++VjUh1S1dUVzCcTbg
	FK958v2ozY8tQTlJcOoNc91M2lF++4x9V0zkt/AWybFceNXnRdz8cMMmKod9GyZt9/cFf5cZq2C
	FcztPgrVRCwNAV60aWjZse8QJo3YbNQ0d0AlKgXQQEqONpWkonR6
X-Received: by 2002:a05:622a:a1a:b0:536:10a3:2b88 with SMTP id d75a77b69052e-54e1377e37emr50771971cf.20.1793991845345;
        Fri, 06 Nov 2026 11:04:05 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e25785f09sm26979611cf.9.2026.11.06.11.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:04:04 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: s390/vfio-ap: NIB unpin when the IR bit does not clear
Date: Fri,  6 Nov 2026 14:03:59 -0500
Message-ID: <20261106190401.468289-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hi Tony, Halil, Jason,

I have a question about how vfio_ap turns off AP interrupts before it
unpins the guest page that holds the NIB
(drivers/s390/crypto/vfio_ap_ops.c, v7.4-rc1).

vfio_ap_irq_disable() issues PQAP(AQIC) to disable interrupts and then
calls vfio_ap_wait_for_irqclear(), which checks the IR bit with TAPQ
five times, 20ms apart. If the bit is still set after that, or if AQIC
keeps returning BUSY or RESET_IN_PROGRESS, the code only warns and
unpins the page anyway:

	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
		  __func__, status.response_code, apqn);
	...
end_free:
	vfio_ap_free_aqic_resources(q);

This path is reached both when the guest turns interrupts off with
PQAP(AQIC) (handle_pqap()) and when user space unmaps the IOVA that
holds the NIB (vfio_ap_mdev_dma_unmap()). In the second case, user
space may free the page right after the unmap.

My questions are:

1. While TAPQ still reports the IR bit as set, can the adapter still
   store into the NIB?

2. Can that state last longer than about 100ms on working hardware,
   for example while long-running requests are still outstanding on
   the queue? Or does it only happen when something is broken?

If both are possible, the adapter could write into a page that is no
longer pinned.

I found this by reading the code and have not reproduced it.

Thanks,
Yuho
