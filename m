Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FFD47F7F
	for <linux-s390@vger.kernel.org>; Thu, 11 Jul 2024 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720740625; cv=none; b=r87K3nFml0SNCJOxxWVQke0k6FpEFtfMrZx5l+QPESfXYXNOmayw1L5YqdLRMXi1Mxg7Aj+CxB7zJjDEk6VzsRIGrQiQ+FwYM4fxF75fumh/CIsNaA7yA8KehjRvOCu1YxswSLvL23XHOrjH1S8lA6YFLNBs2J/oZR4SzP9j//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720740625; c=relaxed/simple;
	bh=F9nF7Yz+m4NZkGQG1EYxTjeg9ipPUN02ti/KDvrxsGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp508lv4Px/YpMwaSAs7uhlC1SKWgZKort6eeGtS4CMIfo2vSPkBKkm40caj94bR+cSJEDYoRXup70RQd5zoujBch1UJa5CbnaNYrq6dDgKf6VrpRODyemzYpGanzBqUu65nbtsDI39hBAPHjn7ojP3MIp00CjA8RvE+nXYPzdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=mTPGotz5; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="mTPGotz5"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25e24900a82so693676fac.3
        for <linux-s390@vger.kernel.org>; Thu, 11 Jul 2024 16:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1720740623; x=1721345423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y9TzbTVOG0XYLX4YLa6pgHfPR+pAPCJVHykkOmeg+tM=;
        b=mTPGotz5Nc9FTvq4KC9F21e5yTax2i1kauy2WRXpIuSu3lAmRdBn1UVikOomg+l5o1
         l+XhiM1+ciWUw7qvVAhCN7CodBlSYZFsWgYIbrCjZglj13mQNlAXhb04kKLAjd5Z2Hja
         WHTeAfMJ1UWpaDM4gA6AloXXKgks9sIIu/s1u6UeySP3twvzpofw8mFmFPlcyL0ta2Vf
         PZDLjbL5P4BIy57vBHZTa/20h50rshjo0tdN4eFON8cckF8M2zL8qyMna1cqxoPKuTLK
         /h2ZkPnzScmLRwED40okroEiNQ0wW+0nDo7OgTwDr6sFgSQm5WZzdBKNeDSAZsqRb0oP
         MgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720740623; x=1721345423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9TzbTVOG0XYLX4YLa6pgHfPR+pAPCJVHykkOmeg+tM=;
        b=rE1cNp908S35Y1W1jkALAaDI7xJ+IDY0I3nCzhNeJr1aFxqLviNdxIua0nvLV371KN
         j6PRU5+9LJvBfez31fCAcevtDJsuCJpNUZoANgAVnFsIzFT6m8J5Ur09vQCVsP+3mYLw
         RrsUFNePFyKUHXifgg6gjWN6H6nPrXsXwimjimprwv28XJ8P2LV3L0SNo+e3zNXG7CpF
         OcUFK88iFl3TNsW11W346fJWwNv5yUchcEQpilEuwc7+0YVChUL+zKg3Kx1Ol+4nD5bH
         ym3FzN/5fR1tCE0SkQWHXYERwS+V34cRJfiUWwv2Eizq3gYB8iWN8SlXXwHq8/q6I00Y
         BGgA==
X-Forwarded-Encrypted: i=1; AJvYcCWK8SigJnfER6s/z+GEg4zLRu4z02vTfEW7xEUWqt1Evg7KaG+9ftHrkF128HP2Mpb2bWxLHtfqjBrWEEGfFtvIRwhQjEDP9ObKTQ==
X-Gm-Message-State: AOJu0Yxvl9yzbinf3RZ+0tanh++CkuNhvMBJtlgrYGXajCicXbws4Pz2
	Y+FSuIfhTrCW5GxsoBda+RHL/DWkp46SZdAW7/LwYEnloa3SwyZ/kRPxUAoirNc=
X-Google-Smtp-Source: AGHT+IENmtYjz2Xe/Odml24hk8FwPfoHqTNBkomJYWb+XMfDl0LlNdqT1m/JXqE2cTHVl8fZIAR/xw==
X-Received: by 2002:a05:6870:610a:b0:254:88ea:6d90 with SMTP id 586e51a60fabf-25eae756125mr8026175fac.2.1720740623428;
        Thu, 11 Jul 2024 16:30:23 -0700 (PDT)
Received: from telecaster ([2601:602:8980:9170::7a8e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438cbac9sm6222705b3a.77.2024.07.11.16.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:30:23 -0700 (PDT)
Date: Thu, 11 Jul 2024 16:30:22 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
	linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <ZpBrDvUpn4SzaqND@telecaster>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
 <Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20240709212141.31160508@meshulam.tesarici.cz>
 <Zo5L9xZtIs4dCf0E@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zo5L9xZtIs4dCf0E@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>

On Wed, Jul 10, 2024 at 10:53:11AM +0200, Alexander Gordeev wrote:
> On Tue, Jul 09, 2024 at 09:21:41PM +0200, Petr Tesařík wrote:
> 
> Hi Petr,
> ...
> > > I would say to some degree there is also inconsisten with regard
> > > to /proc/ files existence:
> > > /proc/kcore    is enabled by CONFIG_PROC_KCORE option, while
> > > /proc/kallsyms is enabled by CONFIG_KALLSYMS option.
> > > I assume drgn expects both files exist and does not work otherwise.
> > > 
> > > Nevertheless, it is still possible to refer to only one file for
> > > symbol resolution and use an always-present symbol. E.g _stext
> > > could be leveraged like this:
> > > 
> > > # grep -w init_task /proc/kallsyms
> > > 000003ffe13e9400 D init_task
> > > # grep -w _stext /proc/kallsyms
> > > 000003ffe0000000 T _stext
> > > 
> > > 0x3ffe13e9400 - 0x3ffe0000000 == 0x13e9400
> > > 
> > > # eu-readelf -s vmlinux | grep -w _stext
> > > 178112: 0000000000100000      0 NOTYPE  GLOBAL DEFAULT        1 _stext
> > > 
> > > 0x13e9400 + 0x100000 == 0x14e9400
> > > 
> > > # eu-readelf -s vmlinux | grep -w init_task
> > >   498: 0000000000000000      0 FILE    LOCAL  DEFAULT      ABS init_task.c
> > > 182344: 00000000014e9400   8960 OBJECT  GLOBAL DEFAULT       28 init_task
> > > 
> > > I guess, the above holds true for all architectures.
> > > If so, I would suggest consider using that approach.
> > > 
> > > Having said that, we will try to turn KERNELOFFSET from a synthetic
> > > value "Used to compute the page offset" to what drgn expects it to be.
> > 
> > Thinking about it now, I'm not sure it makes life easier. Because then
> > we'll have some old kernels with the current (unexpected) definition of
> > KERNELOFFSET and some new kernels with a more standard definition of
> > it, but if I read vmcoreinfo, how do I know if the value has the old or
> > the new meaning?
> 
> The approach I suggested to consider would not use KERNELOFFSET at all.

Hi,

Unfortunately, using kallsyms isn't feasible for a few reasons:

1) /proc/kallsyms is not available when debugging a core dump.
2) As you pointed out, /proc/kallsyms is not necessarily enabled
   together with /proc/kcore.
3) Reading /proc/kallsyms is slow. On my system, drgn starts up in about
   250ms, and reading /proc/kallsyms takes about 110 ms.  This would
   slow down startup too much.

drgn intentionally avoids kallsyms for these reasons. (There is one
corner case on old < 4.11 kernels where we need kallsyms, but that will
go away eventually.)

I'd be really grateful if KERNELOFFSET was always the difference between
addresses in the kernel image and in memory like it is on other
architectures, or even if there was another, s390x-specific field in
vmcoreinfo for that.

Thanks,
Omar
