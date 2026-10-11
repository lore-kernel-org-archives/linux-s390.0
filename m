Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DD2EEE80
	for <linux-s390@vger.kernel.org>; Sun, 11 Oct 2026 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791687245; cv=pass; b=WudfZzVVW04N3TRhcgNEgXOjDrfP4ihex4gwlAeJLek9e0K/cUVVh06sLeOzCRO+o9c82/0CYLQpZZ1oJfQSEKfVhBMriCL7a9xmkWlNRyJnHUHDTZJpcIbFu0mYp/ts2wgkkGflpwHPDf43CDx2RnDETdy3Co/suQwasd+GWzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791687245; c=relaxed/simple;
	bh=TtyBwfmEH3Qw9cTr/b5h+StO88FfqoSbIz9e8paJbwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmM1AjJQXzQWJICMotmjKgzVDxiGQG1o87gOVNZkU4vWbac7X5tL29QXi9acT9iUQdqIwCw0hEB7ZKg+NipS7ZQUDmpYpyAJAUlSdTmmrj4dEDuqknEtVTbnvg7kJCDDmQacz/85m+GFkx3Ryev6c7pvNcifiLEZzp+djBPU1N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPUzKgJv; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPUzKgJv"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c315a445752so145463266b.3
        for <linux-s390@vger.kernel.org>; Sat, 10 Oct 2026 19:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791687241; cv=none;
        d=google.com; s=arc-20260327;
        b=sooEu8djhg6T/P9fQSg8l+UCIfy6j3SVjzd+5TUYlIJsbSbd8meRlb4mDhMRKR1TUX
         OzFKh6xBD1UZAQ5M/Gzsj6Wbp2om24gcfl5B6hOPUpykNBMMNxVn+KE3gpwOyVUPZHAQ
         7fGtZ1KF53jITnOhHqrpvlzdmxnG62wlk5bYeAgfYtm7nN4BW/Pi5i0oGDco8pScURd2
         2ria9GO9bybJbVEVqvPPGcXCy8lSUi0nQ7b93+HtBUHUfUSK9FSB0+hQ4yQtEcPpEdPS
         13nkcK7vo78PKFpozESFtLGnOSd7ojvUdJjU3LQqF4TOcPQDlQI6h6o6C7EvBHrAeh9F
         /8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fyP6CG/MmWFtaGWCfyVtclKnfvDKONsgkJWdCRKUOco=;
        fh=79DIkKQAcTVXLtG3nCjwk7eCygAzU4rOMoTxlHOkfOs=;
        b=KMVyj85FQFjbdw6feeJmGXVgY2ilVdzhMdookUmrQRKwf0dt5tmgRa6yIHt5su0MJM
         4TE+jnOMvHJAndNaPIK+peKCi3bCDdptNJF9ws7aCtAoie8KVSWcmvm0BReX4Qp5YOzq
         yGNzE6PrNQRNvrhaKtnDCMqLnlIanGT/LrBALb6pPGf8xegHkvAhxtDeqb5ONy41ppsE
         Yx8yguGzB7ilhYJmOHggQ7uDtlrh7Pzujz0SyZs/3v7Xayz1dJga+mh7VnHD03LbpOIS
         GRAKSEy74xp2TGeRsTjFOus7qB2RDCvhzYc+d6eE6Zf0vSmBEliRqEc7bLgi/j/DEzpa
         sa0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791687241; x=1792292041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fyP6CG/MmWFtaGWCfyVtclKnfvDKONsgkJWdCRKUOco=;
        b=bPUzKgJvwPHtlXuT7nptIb8ptZOT3gzx0IPNd3NEC1o3MeYiCw6xAeeaGnY1nOdir1
         3NxO5aApkrwi1yJbGPA5RZhvKf8PQGlShlTQWCpwcBcmnx9oyo75dMBRbsu2w+nNJ/i1
         GxahXolACeoajd/uPeu2vsUltM8HxgS+hEJBUX194mo6Womohe+Vo+XU558zU1+/fsRV
         KntG93zproDPSIJTso/GtEFckOQnoDQKYYPqZXAsov+4XIQwHPQLVrAD08LBZ9pZtbU/
         DEJhWbdg8jR0KzoNdYBSvog8LoZROKQ78vsapkQrD56UcQC1Pp30kIhY47rhGS0IZlpY
         NqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791687241; x=1792292041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fyP6CG/MmWFtaGWCfyVtclKnfvDKONsgkJWdCRKUOco=;
        b=jhrTYTx1Zq/uznVPv83DoxV2sXlreApzlzeeJiyv6jFq/d1bmUBjn0BloW3EY2c9Y1
         yohxNJVCpyOUD1TsO2RXENCFBdKWwcYFl1CJI1kLiS4QwVRIT0nOH5FArlcjfMl6dc0o
         IIotVKGF4x1bmDzhhaE8iI5oW9ufGa2DcTLtNv0wobRHygTEz7UChvJNqhWEZQ1YqFy1
         Eqc0jAr/1qwiZ18ENy1eEQ1OHp8W+vY5HAbCkLxUXb0fGCsAUPg1vmwblpkELkYU8/+R
         ADhkHCXSIJFZQbn9M1cShniQCc/kq5F4emx8RrIYLX2jClUyRBEjcVmGpATgcunRxekQ
         jZPA==
X-Forwarded-Encrypted: i=1; AKwUvByX49oNpRj7msErZ5zkb8xQIO5c3we8gxx0naXZqETq7ET1dcxR+AdzA4K3yM5gqhujTOPAobLi/8db@vger.kernel.org
X-Gm-Message-State: AFq9FYKg8FPlwUgx/LdfYUKy//1f2oiwe5ceod5nHBEdjWIY4Msw1hvL
	FUPe+9Swie0XCNd0I+QTytbQgboOBx7kzP8vi7AQ3FLvxKKWl4Ro3lEhxkkqE7dhOd2TjevAgFc
	U8GqauZ9GpHt4/YsiJMGpd9rFUitGMzc=
X-Gm-Gg: AYBFou1fXvqu+zr+yL5/mA/e+GNK+P5Jif9a9hB9dCyNNuvPQli8vI3wOcZzocwHK7j
	oit5n33DiRbPFG0ZxNTWseT2pinH0VM5243RxP5fVls/FSgi7aI9Fw1tt8CVnQm4Hyz1MnyWZLh
	VWPy9KboFIgEi0AuE3ddxXcsDvavb9tNXEE93nCcv8ZyCfGCt/qz10kEeO/iupBTQyKbxSjQUol
	q5CG/17GaARnmAqGBO5uEanvaF75zDVTc+Bk20+ZKPdRnN5tdtsPq/Ishpuro7yR9PLlUQVgBsM
	7PAknpSPeAwYpiBueNDmWnbd2fwfSnVchQunb/fASbWRa1ektacOnpC1lBiio8FvsUTr2PeglS5
	QDDhwWLqB3Mp/dkiqnmcLWWvvjjP2uPXkutwQphB9qL4LZ9TaSfGLd98pZKZv0Jvg0SQQDwCwag
	QWWZ5fj0VxH8Bl2QHAg0e5UXl8rNpdy1Dno8f+65/j3KHXDNH1SxyAzjZIXTl+wK7MLNLNpF0g2
	4hirK+YCejo2zudD771kocq8fKJFin6m3Ktn4677SZyJu3wFTl7faOf6zKz2bv+8FwDPEzhemCn
	xFup9rf3
X-Received: by 2002:a17:907:2d12:b0:c2c:d06f:cf89 with SMTP id
 a640c23a62f3a-c31a9a10df4mr535728966b.2.1791687240866; Sat, 10 Oct 2026
 19:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007040009.137568-1-atharva.a.vartak@gmail.com> <sashiko-outbox-162620@kernel.org>
In-Reply-To: <sashiko-outbox-162620@kernel.org>
From: Atharva Vartak <atharva.a.vartak@gmail.com>
Date: Sat, 10 Oct 2026 22:53:49 -0400
X-Gm-Features: AclHuK_VRhFl2QnU4-PLdqLkG3n2BnlNN5bAfz2ea1QbUuSDNKyKsM4qI9CZFqE
Message-ID: <CAMaGtJZa8FvAYP9aq3JZsL6u6xN1MpaM_mj0yAmhp+RDAfg76g@mail.gmail.com>
Subject: Re: [PATCH v2] net/smc: hold a reference on net_device returned by pnet_find_base_ndev()
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The bug was found through manual code auditing.
It was confirmed with a proof-of-concept that triggers a KASAN
slab-use-after-free report.

Regards,
Atharva

On Wed, 7 Oct 2026 at 00:07, <sashiko-bot@kernel.org> wrote:
>
> > pnet_find_base_ndev() resolves the base net_device for stacked devices
> > under RTNL, then drops the lock and returns the raw pointer without
> > taking a reference.  All three callers dereference the pointer after
> > RTNL has been released, creating a use-after-free window if the device
> > is concurrently unregistered.
> >
> > Take a reference with netdev_hold() before dropping RTNL and add the
> > matching netdev_put() in every return path of the three callers:
> >
> >   - smc_pnet_add_eth()
> >   - smc_pnet_find_roce_by_pnetid()
> >   - smc_pnet_find_ism_by_pnetid()
> >
> > Fixes: 0afff91c6f5e ("net/smc: add pnetid support")
> > Fixes: 1619f770589a ("net/smc: add pnetid support for SMC-D and ISM")
> > Cc: "D. Wythe" <alibuda@linux.alibaba.com>
> > Cc: Dust Li <dust.li@linux.alibaba.com>
> > Cc: Sidraya Jayagond <sidraya@linux.ibm.com>
> > Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>
> > Cc: Tony Lu <tonylu@linux.alibaba.com>
> > Cc: Wen Gu <guwen@linux.alibaba.com>
> > Cc: Willy Tarreau <w@1wt.eu>
> > Cc: linux-rdma@vger.kernel.org
> > Cc: linux-s390@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Atharva Vartak <atharva.a.vartak@gmail.com>
>
> Sashiko has reviewed this patch and found no issues. It looks great!
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007040009.13=
7568-1-atharva.a.vartak@gmail.com?part=3D1
>
