Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6C12B71
	for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793862; cv=none; b=ILPHv6S58WCi3GLKqFEdAVDoZUynOYZ3pHLyY6ctPQBVe5OSlDi24qWaI/XKCk84Jb7dXETobTpBsY1qk3XKP/BDMHv8XDZgW8irxXxAeRw3TDCepWdZkBG6KdEuHCUzMTQh/iF/i6iGWG/AOULfhLCwBqVOTBGsLe29+5imUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793862; c=relaxed/simple;
	bh=DLfk4z4idT51OJOgXMVKV/LtQINKpqymjYqIY15f0xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNYRCrOX9QeXD6sMGSnYkgJ07oQWLEV4QCq8EWFchHikEeCkTmsnNS4mgc6LuPPR0dUyaGzRIPTR1Xhem7MwkavGP82/HY5gA4aCDC3Kpyg3ZbBXIWGD3DTmkRpWdQaJ9CfW8DIm3VsaSgiIovfKeXf1v6pKwtWSqvvHP3lo2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=A7G3Z7Ka; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="A7G3Z7Ka"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb1c69e936so13483405ad.3
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2024 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1720793860; x=1721398660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxldwXqPRlcf+W8ezIU28MreTJcWOo0OxTO8mHG2BTc=;
        b=A7G3Z7KailTSskSc7QRTCHk0Lkh/DflMi0XDgOgOiMJpOe56NsZ7i7o5hgSL/ycvKe
         znvI3ff1c/QqhuKq/scoB2huyaRu2qsEOsYWi7GJjRNHSRiSZKtlM4rrK/1YTTKrFQOV
         3eDZbasw7Hb0nvd2GVfZQc/SaPx5R/fnKkqH0W/g3wyV1SX8u3Ol2GHOUycy8lRN4k30
         b5XZEEN9dgovRsxbb0VILqGFBv4I/gYNPTp/2BriQRDApDuRQEB/HgjXvECw139/dL1b
         nHv2DWfE0D3lgkBRZ3c++QJgD8pP01g2CS0Bo8Qr0irakpBdHvu/bs9Ncb8WESs0cSCZ
         Emjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793860; x=1721398660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxldwXqPRlcf+W8ezIU28MreTJcWOo0OxTO8mHG2BTc=;
        b=hfaovnlw5238H9BkmwFHWhXgrUi13koa3/OoG8afD9iIq6TjxfOWIyJyd5jlLcBW2y
         br3F3IasxSpwN2pXofitJfUoyjlef9sLWeH/vYlgK+v5xAFJd4nyQ3I8IsVymkRSRqoo
         XtPvh7qenF6hrtbMg4OlKDDtNEXDHXbq0jRUMGu3tCc1bC2R1WvcuIHCij1cxVJcVm9y
         M/cF2QwagGQFPo7FmK5/LFqsAHlZbKmjoueVASS3CZDe9yVoBrBNOzqzunHwbT0Xzged
         4ZGyYTqaEa6Ak9dpS7h/9sgwzBAEa1BgUW1LFr4Wfsuts+2Sl14M3tOrXwF7pB5l9Ead
         OdUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRSUiSK0n7BupQxhd1eZM9Ciol9/WCQYWeI+js64AgrwRL6xg6ZD1kDJ3zlP81fWsA2Y/Xs82oibrr5EDwhcd8bzUBEuZvNzGHzw==
X-Gm-Message-State: AOJu0YwrD+Oewg5JxtA9EtWyBbcCzyCaQYLmD28xLi+XASvixx71R5R7
	HbK4Du+VW99ToARg/E5HQ+kmTz0SYqmkBq/jgkllLMsEqjKUhrjR1dTYqfe2LU8T4XhiorkXJN8
	I
X-Google-Smtp-Source: AGHT+IE7zkC+SPu2MydMq/DLByO6pqE349BFOLq+/IxhzglyCzU0zzmd+YNf4Y0k7Ac0UWDO1NN65Q==
X-Received: by 2002:a17:902:654e:b0:1fb:24ea:fe02 with SMTP id d9443c01a7336-1fbb6d3d8f6mr67729295ad.18.1720793859951;
        Fri, 12 Jul 2024 07:17:39 -0700 (PDT)
Received: from telecaster ([2601:602:8980:9170::7a8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6abfc56sm67356375ad.196.2024.07.12.07.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:17:39 -0700 (PDT)
Date: Fri, 12 Jul 2024 07:17:38 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
	linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <ZpE7AsR-nD2tNuTn@telecaster>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
 <Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20240709212141.31160508@meshulam.tesarici.cz>
 <Zo5L9xZtIs4dCf0E@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ZpBrDvUpn4SzaqND@telecaster>
 <ZpEyucQA1rctAts6@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpEyucQA1rctAts6@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>

On Fri, Jul 12, 2024 at 03:42:17PM +0200, Alexander Gordeev wrote:
> On Thu, Jul 11, 2024 at 04:30:22PM -0700, Omar Sandoval wrote:
> Hi Omar,
> ...
> > I'd be really grateful if KERNELOFFSET was always the difference between
> > addresses in the kernel image and in memory like it is on other
> > architectures, or even if there was another, s390x-specific field in
> > vmcoreinfo for that.
> 
> Do you mean another s390x-specific field that would be the same
> as KERNELOFFSET on other architectures?

Yeah. I'd still prefer if KERNELOFFSET itself was updated, but if that's
really not an option, another field could be a workaround.

Thanks,
Omar
