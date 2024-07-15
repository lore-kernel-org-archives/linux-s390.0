Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C7846522
	for <linux-s390@vger.kernel.org>; Mon, 15 Jul 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062684; cv=none; b=BQrw6glv/GTAEy+gQnLlxIdVn4HNisEQq73LdlPN0MhgI3K8TFVXAzvVT9z1EbofU5fB9SJ7Ta5NKkUEO1nKVPrnjsN8BbxXoXY041FlAK63ZLTNuxBcYGzVpTxX2o+jm/ovejmOzKA5I30nWyP4JyajVtQNYOVIe+ztZ/PzfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062684; c=relaxed/simple;
	bh=IxJz1HEy+JpE1vJBiifQpmCm2PJ240J6ITqDKSCG/L8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pd28bGr20/D0bGIMEO7nXSswGDpko/y1IYTtqNd0PZF4nZAVl3iIlnQrTYn23c86zQZKkhgJj788L/hWS0v20/b5fNmEBK31KM7t2R+9u2V75mFcFBA65bK8hNI6R87Fdl/+8plTzhxEDNv8/oZd9ivH0GdncjoWVcUq2fIBVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Zwm6SCo4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Zwm6SCo4"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6266de87cfso35424366b.1
        for <linux-s390@vger.kernel.org>; Mon, 15 Jul 2024 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721062680; x=1721667480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Dp6fCCpQAFiJ7LQFdQvbhCZwILPCOZWlXEg9XyHob0=;
        b=Zwm6SCo4IORJmyW5XhWW+BGQhOx+9ph2Gl+ysuliRCbfxrX62SDz53gwU5df6XLTvl
         JTQE8DdCFPAdQGWW+90dxL4rGIk7G6IpsAT2eMydlrPM9uAZpqhpfhWrn93aayoRtQfA
         nyE/+mvXlR9WS654Yjh7skzZMFvoNSziTVLdTPjEQoCuQorXt0F56mYC4McLgqOtB7lW
         9wTqbshcASWBAhG9lFJpHVotUKQdsYhoaI0c6bpO7k4Nh5IkbHOyqYhbGnKBJD+q83z2
         SYm8E8n7hz/7vYvLbQW8cw5aatHU3AqQC+ayDpquPyGTDu6QcBo0+qLIUZN329GinNSD
         hibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721062680; x=1721667480;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Dp6fCCpQAFiJ7LQFdQvbhCZwILPCOZWlXEg9XyHob0=;
        b=Zu8jonJCzr9BjD7d3+oX5/es1XUmY+xXLAglQzagD0zkwn1JgDl6nacqOpI2LcX10V
         +ok3yW2ZPJdnqiYF5kCTeB0JDB2h2bPDLBEPuPi3uK5ZGqS1OCv2m1OCMLuSb8GpLDqA
         0imdF79r5BLHy3PRIt65oAbInETHDuHFZeqzZp+apqtjgdCuuqAUB7deLXiBAqglSZCS
         qttrDNyXP3cOuEmgn4oooDoDP8hUYhtozw2SsJxaA3mj/oPyDq0s9hoUKC5DwRqED/CA
         OM1jUfrpsrCfEorG1MQ3VhDpqqGTrtpmu2sY0T6Hqk1PGEESvbURzcDOK0FBCwIMnaQM
         IGrw==
X-Forwarded-Encrypted: i=1; AJvYcCWkNkx+42Rr6NTU25ZJRZCWTtjsQ5Qt3NT4tsKYn3c8e3pjT3cR/fzve3GAoFpU/grqT4V6SFeeoSdQDDTFpMYeujk5UWLfNhUxaA==
X-Gm-Message-State: AOJu0YzyswIqVenqx7v9GmIeZI5TJokD3ze3cuiThVZUNAeZonl13iuz
	iPX6kDR5NANiV7fXKiF794BeLl7DzJ5ddcmzQQk2EevXlT0A/Rvm9W7/I3dofTc=
X-Google-Smtp-Source: AGHT+IFXHNVR4+Mql83LD/nzPrlDHiA9SFqIznByjudVAKR6dxhYzi7ejPm9gDaXQitj7dgXQ0e+oQ==
X-Received: by 2002:a17:906:7216:b0:a77:cb9c:e806 with SMTP id a640c23a62f3a-a79e6a915e0mr18337566b.3.1721062680449;
        Mon, 15 Jul 2024 09:58:00 -0700 (PDT)
Received: from [127.0.0.1] ([80.208.65.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc821809sm221453866b.208.2024.07.15.09.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 09:57:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 Carlos Lopez <clopez@suse.de>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240715112434.2111291-1-sth@linux.ibm.com>
References: <20240715112434.2111291-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/dasd: module warning and error check fix
Message-Id: <172106267901.10201.11169554689467623987.b4-ty@kernel.dk>
Date: Mon, 15 Jul 2024 10:57:59 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.0


On Mon, 15 Jul 2024 13:24:32 +0200, Stefan Haberland wrote:
> please apply the following two patches for the merge window.
> They fix module description warnings and an error check in a dasd function.
> 
> Carlos López (1):
>   s390/dasd: fix error checks in dasd_copy_pair_store()
> 
> Jeff Johnson (1):
>   s390/dasd: add missing MODULE_DESCRIPTION() macros
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: add missing MODULE_DESCRIPTION() macros
      commit: 1f5a33315362cb8ade2b15489c985ada0cc8623b
[2/2] s390/dasd: fix error checks in dasd_copy_pair_store()
      commit: 8e64d2356cbc800b4cd0e3e614797f76bcf0cdb8

Best regards,
-- 
Jens Axboe



