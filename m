Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBA36A03B
	for <linux-s390@vger.kernel.org>; Tue, 20 Feb 2024 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435325; cv=none; b=cm1TVb8Uw8iUKvk0tX67gJlQaaXv1o0QbTyGn2ofDB/O709Fq/HlZ6tG0alFqafeszHCErDLlQreS2Hhf0reQU9QlUcCj1zHRfNSv0pdgy4IsgUG/waVOY1DURldu3wXytfF+IQDzuwaE0g91TqCRCgRfOpkfJUvl0amkxsLcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435325; c=relaxed/simple;
	bh=NGXD1jHINHNZY+mCOyyB934Anjl+YnZ1Y0xUYO0JiJ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TKsKV6EZt8AkJqKrehho9XqkdJ4VefKhiH9WLkkeCMDNcouqFSORoCfBLcI2qeGoujcw/pzqUMw8a2q8i36pFNuJAL7Gm7oig0Zev1IG0AKadzlYpdCZ+NUtIfjA92Ce9uewITkbpCaaHwRnbo8mW2lpVyX0jYUOcZo9PLr5Ui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U4EaD3gb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U4EaD3gb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1db8f32cae5so7457295ad.1
        for <linux-s390@vger.kernel.org>; Tue, 20 Feb 2024 05:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708435323; x=1709040123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARy7Q4Eliz2JX6LXysl5nmstDWlOnwvyUH57xirN7sY=;
        b=U4EaD3gbkDBssxO23P5k9vYtIYEhIf/7RWMIA0K30JHBiHYjnmCXphVpHLwEe0RYuu
         PLzwDZ0QX3j4RQxdV0pKFXkFG0QpnJ69U4mSTvfaXW7465QPoscfQWVXcZC+cf4FLRyk
         Cqfdd3RiGggLxQIqNw6vV5cbullvrNrcWH4s3YyJPn1pzXppZOd+ps6ShdohcPnc6SeX
         eSeiRreP8WFwSAB8EL/0rxp3RV06rJ4XKpbCqX9IfIArcoQrgB13pyR/saOCvhTbp9WD
         LETmRR5PYENeqmYcHarveOLZLgFe29nsuXMO3VkrLRNlF3Bsms8GX4PmHAujSQPawG8z
         2rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708435323; x=1709040123;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARy7Q4Eliz2JX6LXysl5nmstDWlOnwvyUH57xirN7sY=;
        b=TevNNmgr7l6l321Nzfe3pwhBQXuaiwKCsDdaK0GL5TKbugLci2DoV93nlnb+VL4hsM
         idxDXKYEBpvgt+NlYcNX4nazOrua3uEUUKAAiJxpg1Jc56C/ChrRAknQorHdfrybJKAt
         byvLmnfwYGmKg6vz5K0fkwqPKn8kwRTi0XZ+ltTRns1F0bROVTsDMgd/rt4TZUyG9uLM
         djvVBtYr+p5RD1K7Sroft/SHOdR+oiOlpFB3LgyNan/I0PiQKFbGAuChWSjSzWaVUR+n
         wZQfDKdWnHkB+sXaREAgYrLzLAWOuSrJ0AqWFtCns8ZQmbrMYoDApkEvnJQLlATXik18
         iFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKN1hiuXZXAmnEPuNQvtI7bzWsYwQaPSY3AYSipfd69PoPQl4fgaVzPAmT22NCUeXeZEnbUhTbjQVOLKcrBESwfrZVh/3UZs/DXw==
X-Gm-Message-State: AOJu0YxxGWhKrzldcyDU9r6vE6t0tU1UwMtF5qvtl7ecfDdVMmuy5/Yt
	QIdTOPpH7anUwraBUVPET+yuyrUtP++N3Lrp5y8iBBUh7Wk/e/1nfL2cTVAHYqE=
X-Google-Smtp-Source: AGHT+IFDzsxf+QvkIBQ6Yn25tgbgykQJpLVIKvsCINFaIpP2CqGk59RWuZcUGoZYhYkVR41rTlrzkA==
X-Received: by 2002:a17:902:b113:b0:1dc:e32:d0b7 with SMTP id q19-20020a170902b11300b001dc0e32d0b7mr3120302plr.0.1708435323550;
        Tue, 20 Feb 2024 05:22:03 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b001db5e807cd2sm6188911plb.82.2024.02.20.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 05:22:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Justin Sanders <justin@coraid.com>, Denis Efremov <efremov@linux.com>, 
 Josef Bacik <josef@toxicpanda.com>, Geoff Levand <geoff@infradead.org>, 
 Ilya Dryomov <idryomov@gmail.com>, 
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, 
 Ming Lei <ming.lei@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, 
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, linux-block@vger.kernel.org, 
 nbd@other.debian.org, ceph-devel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
In-Reply-To: <20240215070300.2200308-1-hch@lst.de>
References: <20240215070300.2200308-1-hch@lst.de>
Subject: Re: pass queue_limits to blk_mq_alloc_disk for simple drivers
Message-Id: <170843532172.4095460.11560055671499890721.b4-ty@kernel.dk>
Date: Tue, 20 Feb 2024 06:22:01 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 15 Feb 2024 08:02:43 +0100, Christoph Hellwig wrote:
> this series converts all "simple" blk-mq drivers that don't have complex
> internal layering or other oddities to pass the queue_limits to
> blk_mq_alloc_disk.  None of these drivers updates the limits at runtime.
> 
> Diffstat:
>  arch/um/drivers/ubd_kern.c          |    8 +-
>  drivers/block/aoe/aoeblk.c          |   15 ++---
>  drivers/block/floppy.c              |    6 +-
>  drivers/block/mtip32xx/mtip32xx.c   |   13 ++--
>  drivers/block/nbd.c                 |   13 ++--
>  drivers/block/ps3disk.c             |   17 +++---
>  drivers/block/rbd.c                 |   29 +++++-----
>  drivers/block/rnbd/rnbd-clt.c       |   64 +++++++++--------------
>  drivers/block/sunvdc.c              |   18 +++---
>  drivers/block/ublk_drv.c            |   90 +++++++++++++++------------------
>  drivers/cdrom/gdrom.c               |   14 ++---
>  drivers/memstick/core/ms_block.c    |   14 ++---
>  drivers/memstick/core/mspro_block.c |   15 ++---
>  drivers/mmc/core/queue.c            |   97 +++++++++++++++++++-----------------
>  drivers/mtd/mtd_blkdevs.c           |   12 ++--
>  drivers/mtd/ubi/block.c             |    6 +-
>  drivers/s390/block/scm_blk.c        |   17 +++---
>  17 files changed, 222 insertions(+), 226 deletions(-)
> 
> [...]

Applied, thanks!

[01/17] ubd: pass queue_limits to blk_mq_alloc_disk
        commit: 5d6789ce33a97718564d0b8d2ea34e03d650e624
[02/17] aoe: pass queue_limits to blk_mq_alloc_disk
        commit: 9999200f583107f7e244e50935d480433b7d8a3b
[03/17] floppy: pass queue_limits to blk_mq_alloc_disk
        commit: 48bc8c7ba6fb39a4325b07f3abe8fe5a77361c7e
[04/17] mtip: pass queue_limits to blk_mq_alloc_disk
        commit: 68c3135fb5fbd85c7b2ca851184f30f54433a9d3
[05/17] nbd: pass queue_limits to blk_mq_alloc_disk
        commit: 9a0d4970288de29191fa45bf0ab4d8398bfa3a01
[06/17] ps3disk: pass queue_limits to blk_mq_alloc_disk
        commit: a7f18b74dbe171625afc2751942a92f71a4dd4ba
[07/17] rbd: pass queue_limits to blk_mq_alloc_disk
        commit: 24f30b770c0f450346f1c99120427b2e938cdfd0
[08/17] rnbd-clt: pass queue_limits to blk_mq_alloc_disk
        commit: e6ed9892f10d7195d621ede1cedc41421f1ca607
[09/17] sunvdc: pass queue_limits to blk_mq_alloc_disk
        commit: d0fa9a8b0af71b69cf3dec10feaebe19d55a72cf
[10/17] gdrom: pass queue_limits to blk_mq_alloc_disk
        commit: a339cf2bbfbe6e16ead79276d608912d36065884
[11/17] ms_block: pass queue_limits to blk_mq_alloc_disk
        commit: f93b43ae3feafedc5777099ca1a0e05352b92671
[12/17] mspro_block: pass queue_limits to blk_mq_alloc_disk
        commit: 9f633ecd43046659e3345bc4a4404e1d2ba67463
[13/17] mtd_blkdevs: pass queue_limits to blk_mq_alloc_disk
        commit: 3ec44e52bfce60f6da65165bc86eb382462d173d
[14/17] ubiblock: pass queue_limits to blk_mq_alloc_disk
        commit: 21b700c0812b6aa8f794c36b971772b2b08dab9a
[15/17] scm_blk: pass queue_limits to blk_mq_alloc_disk
        commit: 066be10aef5a7ddd8ad537db7a5145c6d79d4ea2
[16/17] ublk: pass queue_limits to blk_mq_alloc_disk
        commit: 494ea040bcb5f4cc78c37dc53c7915752c24f739
[17/17] mmc: pass queue_limits to blk_mq_alloc_disk
        commit: 616f8766179277324393f7b77e07f14cb3503825

Best regards,
-- 
Jens Axboe



