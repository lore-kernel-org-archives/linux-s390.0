Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5162138C2C7
	for <linux-s390@vger.kernel.org>; Sat, 21 Mar 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774103308; cv=none; b=fSWRtO5eVIn5hgEz7IC0UdAQ2wZpbqj6Yowy4D/nWaNkT4E/WRg9+Ww0SPjQCPI82EzkIgewW4Jx+rJJ+wL+ZNZCh14X+MWPyt5MyupEngtoEN5GkerMCs8zvpEwZs8EGhhKsVi6wewq7fj84zJfUcyYUQ871SwHqagCvzWmHKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774103308; c=relaxed/simple;
	bh=Ljm9lHSWHJuvEOaPyKMhOHXf0fTCsJ/D9lwyKKoju7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqBf0FN1FD/VzkMujtYYZvWL4Nun62HooE6+QjB+viZ5NAAzbNvwTK/KEblN+NNwVDcURdWI2QVSAADCfwOQlzBG1rC6oO/2bs7vQIzWkR4O5u/kU6e/5fAmqaqAuuVQeCAg3L69iWd/92sjOH1qXh7msSxmvNMfXffZLpvKh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=D/3B61aJ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="D/3B61aJ"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-464ba2bb3aeso1791449b6e.1
        for <linux-s390@vger.kernel.org>; Sat, 21 Mar 2026 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774103304; x=1774708104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGeFtEcePrRuGM6CVPtSo2iuVcZXXricGsZQ7tQ5chQ=;
        b=D/3B61aJ8a8WPzCw5ztDzz0FSJUiv/Qr9mA2lG235GydGFjAmzb1xZQeGuOxmxFYxx
         9g/O2OMTTMLLOaKS+Kkl7Mxi4zlKIngC2tIdx3fTsn56oaaaUMAFWhVEse+CmNAoWJWE
         n7rDD3EUYIA0GnTI+duQdSCQ06hHgD4Fdy+ptJC7B6EXwcDPmeS16DnBsXzBiewmKmkq
         RXCcD9a9Z1fvapboemM+kMRBzjQ3uikJbGtTP1jVe+LvytJSy9Z4QxfJ2DBOYzmkyUP4
         vcOYFMkkxoA5qQhsKyiK/HutQhxhEhM1LFAEqTtQCY3/6mJb4T+wRZNryQ/Yg/A6ytIL
         yjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774103304; x=1774708104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGeFtEcePrRuGM6CVPtSo2iuVcZXXricGsZQ7tQ5chQ=;
        b=eGhzO+iSaK7D1K2EYWZzu0QPEMwCPEMVuoZ/wjJovjlVkJ5uRWmzbWji9zKSMEmiXI
         TFUlgD31grClnUpNTaoqMWtu+O78UEu/CHEONVm1xE7Oaf+oVVSIq2W5Xdx/4hqXv2BQ
         uENMqlaetDUDjmlSJwYtqe+pCL7wlpP5vz0S6IOje4eemXiNKk/lic9xJdn3l+8fbyLW
         lGlwd0Hn299Ri1BwdfnSD9ebe0KGjlzODvupn5Z25vcxPmHUID9AAGAvU85E/GFhNnkb
         hPyVkzLvtDORSnwh5wtvIUW6H2uQ0tOU8S1LSnjYfIoUPFEUeBAKi0kXcl8pF4dXG8N7
         Vy0g==
X-Forwarded-Encrypted: i=1; AJvYcCUnPsHIelbm1pDmD3SGGRX+33drbRMeQ/atbO5mZ8c40sQppWnPQhwlRIjh0+87MWBdE/YUcG2JmKW4@vger.kernel.org
X-Gm-Message-State: AOJu0YwukOuZhoku50gQ8x8MVACz2tTvZ4hnp+tZls2UKsxgoXLw6b+I
	L4V2F2mAuiUlvWtwA/nnZ1GfVWQkZ/tG0oDe4lXHbcvHCepIG2wUbeSlytw39EnQVHE=
X-Gm-Gg: ATEYQzyYs6dRM9elZJdJe5ET1eCIK/bCEOJEX8hTyUA7iXeWL5BtDULu2b/U1Dat6MT
	9DFr3bMEnI1A/DAKndAnkxEZh4oWcmB2hKn0eXgU/3VmYGxxQg6HCorhDiLgDleXMKPte8dIvfI
	KscJ2UMY4S5WOJ+s83lga8Eoo7Oju9spGXdH3LQ/Mh80u5tSn+DgLvh+vD21wRd+mLKwCmLx4X5
	fnXBFHBs24nk5O8Fs61nAxdau51VPMLNaVSCtPrHL1dmiX1mf4bM+72wKd06sa6A6qpyuLNhwxl
	vvHp1wB2HKm8Y9OUi+n6lY25E0NEPb7krbvtwEcRdsBSuT5igyerACW2eXmXc/MrJ8Xu9TQQXlj
	SrkPi/dWJc7hcQMl389pu+S6RIYZLzoJZkcfZj8+H2CMCs4rbs8DnjnDjl81lGl2rawBWgwfnzy
	jfS4+a+VC/LKri1SYFBOLcq0cxTyO3jxNvOBBj/UvA2hFuW6/ejrar1/+DfUc9+cn2dGffhPpUm
	oahoORVgA==
X-Received: by 2002:a05:6808:a607:10b0:467:f56b:5267 with SMTP id 5614622812f47-467f56b6c30mr1978974b6e.10.1774103304390;
        Sat, 21 Mar 2026 07:28:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddf9d4sm4797944fac.16.2026.03.21.07.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 07:28:23 -0700 (PDT)
Message-ID: <12bb0db8-e8a3-4e08-89e9-db9a1348bea3@kernel.dk>
Date: Sat, 21 Mar 2026 08:28:21 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: partitions: Replace pp_buf with struct seq_buf
To: Josh Law <objecting@objecting.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Stefan Haberland
 <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Richard Russon (FlatCap)" <ldm@flatcap.org>,
 Thorsten Blum <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 linux-hardening@vger.kernel.org
References: <20260321004840.work.670-kees@kernel.org>
 <D47F8215-FD08-45ED-AB01-0A5C48CD41DD@objecting.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <D47F8215-FD08-45ED-AB01-0A5C48CD41DD@objecting.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/26 6:08 AM, Josh Law wrote:
> Reviewed-by: Josh Law <objecting@objecting.org>

Please don't quote 1000 lines just to add that, that's somewhat annoying
in terms of scrolling to find wtf was said, and it's hugely wasteful.
Prune your replies.

-- 
Jens Axboe
