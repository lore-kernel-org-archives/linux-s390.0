Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9D3D7A07
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327213; cv=none; b=BGctHBn9khGsvIm8tg297d8tcU+oj74ZGdeqZqd9n+4+Zq77vV7Q1KglbwKqK1PasfGUfeX9jWSTwZFA0ZpohtUZIebVM0YnMme0L9Q6u6aw4PUPkQMkI849OMy2adlaN3Mz873QSNNPvELas+aEKwrDTuyNOYUOKnAV4/oWOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327213; c=relaxed/simple;
	bh=z2vzzUU9AdhfZh4TpPBi0E2NHAyN0OiZYk7GbkDEDFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeEY2lFq/sluNqbEx2MwIMc/xk0OovJEWMEocztdmfecBMWUZM6ydbMbhBz9OpnfoXQXbZYGkmxzJaDJD1ROPwoRgnAAh+OOUFUFRDRnwiBSFs7KFkHtjmm6jOoJMkKDxsuZP7twwc49Ym1Q8WtZl6af6iELtSPAkhWFfMocJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4jOWQCX; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4jOWQCX"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-69d7f4cc61aso3938936eaf.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327207; x=1780932007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXR0o/ax1hkvEGDJ8bUniOsmAfk5/s8y29rVFNL4VdY=;
        b=q4jOWQCXL/6NF8DOYVv1DcZfxifD9x0jWVDcKB3Ifvv6dnpVmeK6F4VjzNhpUrNA69
         wY9DB2JEl2S9onADA+Or57F/TjZLWQGOso5JhPmylGS1ZvaRU8rBwP+hvDvPtLGLP+h7
         SLHuS3/0NPDI/UwZQKe9s7PfdqIZVdgBfKnXpIVLmOXM5Q+cI7QgMgOPUUwJ2yuY8m7l
         yoFaoMxw4PMR4jFj+jIh1hrIvF41DX04uxRCBUD2vx6SZqR0Eqm556iDrWav2r98JZ36
         vZ+sAVmxZpfoku4XdjvvVHG0sSVQ+OiBOhDGvEEDEEViYTpCai4V0PN/brscato8SINi
         N4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327207; x=1780932007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXR0o/ax1hkvEGDJ8bUniOsmAfk5/s8y29rVFNL4VdY=;
        b=pSPhZAaUxoZjIhwVPBB9OpTfAScNV9uQOJd4HVHhBV3rGaqlmiy6+4VH9PvX8w2jOt
         Xx62cGVO70sHQgg0SJAymSXDB4/GrxwlZ+BVeQkhP4vPqeQweGf+TzWklexVYJgNrlzM
         GeGAQejYCkjHmPbV2z3F5JYhz48zyCJDEDnpSRnGK4tb4yvZ71DlN1V53miABCciQumV
         nkndLsb5o7xj1/+Gti0fhqnJqqcDOmeSEE0WKfjxddGCV89pLgFC5k10VcoZbsp5GHPo
         p0s07Q3qOjX63H2ewIphSboIAL4+q5FQs2+WcT6hPAKC8J3dfrgkOeDk6s0UleltD4ku
         sgZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YGGezdzkXi+xdxSxUUdGKuJnHwoPguwAtAJiZG9SR5GO0Tf8e9M/N1UOr4ifivPTtUrIbIiNmXgJu@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqyqXCGiy6Tn7fdm6HjtVg4ZOdiqVDPTN4Oal2IlsGkas1AAP
	HoDR01JKxAYSNigEpy9DoNB12LfsE+958/4ODCHI1agEN9XhhHsJaD3G
X-Gm-Gg: Acq92OG7LdgNDKHphNaJrDsqaNC+HivWRQXAnrdnuKF6qcJTo3iIBbowBKaT/1ujMA1
	KwiWBtENd+DXIBVAlp0o8Iui+pkWeSCTnR02OKZBPxiysRzgRUbfGbXn51Zb35syxgzxLSAxenm
	HqDRquMUrKLmody2tsIjy1ULVpVoHeO1CJLFrQDkEFxJ7IWs43VWTarkuuk3Qf+FCehPIZ9qtU4
	KtMKTza6nDD1ZgJOEd63JrafsVHoy6Lo4j2DtYNZWlRz6MYUwq94hilnh2a9S/+nspd4b+q0yJn
	m13ty3d0+iCqWpLfKlut5OBL3MsctrmrJsje3WxGknH8kgLC2LY35aj7kn/TuNP/QUpfbVnPup8
	1URVTBKSpmlRVudc0kywo7HD2Hnylt8ge/WpCsgcIJ84sn1KXpJcx2K40gea7iAeJhyMk88MnMj
	qKlkb6HFlFsodNFTNZA4cG6LFjlzFqN7C+6kor+he6eqad/63wX2q6
X-Received: by 2002:a05:6820:c82:b0:694:8fb2:2c35 with SMTP id 006d021491bc7-69e104765bcmr6510105eaf.2.1780327206868;
        Mon, 01 Jun 2026 08:20:06 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e06587eecsm6357598eaf.0.2026.06.01.08.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:20:06 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:20:02 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Wen Gu <guwen@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>,
	tglx@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jstultz@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	daniel.lezcano@kernel.org, sboyd@kernel.org,
	vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	yangbo.lu@nxp.com, svens@linux.ibm.com, nick.shi@broadcom.com,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
	imx@lists.linux.dev, linux-s390@vger.kernel.org,
	dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
	mani@kernel.org, imran.shaik@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
Message-ID: <ah2jIt2DqI1ZZJx8@hoboy.vegasvil.org>
References: <20260407104802.34429-1-guwen@linux.alibaba.com>
 <20260407104802.34429-3-guwen@linux.alibaba.com>
 <20260412084704.743482ad@kernel.org>
 <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
 <20260412095301.4fe1fe65@kernel.org>
 <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
 <1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
 <ahzQZg_v4bxFfGdj@hoboy.vegasvil.org>
 <3908843460c4864eef79cced40d897f793c7ae2a.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908843460c4864eef79cced40d897f793c7ae2a.camel@infradead.org>

On Mon, Jun 01, 2026 at 08:03:26AM +0100, David Woodhouse wrote:
> If we move all the plain non-network PHC drivers (which, as noted, is
> basically *all* of them) into a drivers/ subdirectory, then perhaps we

Sorry, just catching up here, so the idea is to have

 linux/drivers/ptp/drivers  ?

Thanks,
Richard
