Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562333A7820
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186376; cv=none; b=ZZihxe/VAk2FOQb7/rmQxhL0cfT8RGOjXSpT1TmrsSFWrdmMndKpRR5Mu6yzEyLVI4+8PrREDXHrJ5+9y+swdvyOzVMpX+6ZQNAUQiqt13FXLf3uEOyQjHFtuculh1UfIboOPa/wCrrEwcclUo3N2bkaionP9c7IaqufXeRuBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186376; c=relaxed/simple;
	bh=y4yHZGxT74a6MspUjQGJIAo038r7XXw7zxCaM56ULQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMe90IxBFEZkoLu5REmmCLW3HDqHFN1L/grQOCjSCfcqVpsJyCrBAHU4jWm4hoBIRqTTD8jNaiux2Q4NdamgYgPbJ+r/LcX7hpi50BXkhVP9OGgCdnsVQut7TwIMXyPZ76ASVTIbbTCL64Mh8WU0LF6caABRPfl74fjLfZguAKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=BaGoAYgB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="BaGoAYgB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so19457965e9.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784186364; x=1784791164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xo+t1wRWpFilpcKELYi9v4ykQHKL/M+Rp1FsYxe7xSM=;
        b=BaGoAYgBYwRUiVM8idV46rUKTymCduvvTyUq/PN3G9c9TOP850sdFr2AMVYIYa3j4O
         LNjkHs5bvcYIy9XUgh6cNnWJX61+yqCzmgKXK6M9wv/X9Us9nLH6nG/Zcl/hKwoP6vrH
         jer7yHajQeKMMNLZ+JLJPasNL63oZtMkoegsytoI+9rTqNMkbu+5kuzX2/KL4lwrb+ns
         o5i7G9fhgmY2a/ts8HN1RcLDrG8ZzrwgNtUNzDRXtg71gvHFwrmcqjHlpgavKM0mtEps
         +4Z6R8YnAvJ2sNOVQsbwaKzNVBb9PGSRo8jn8pHSMZwwxcK+skov+15APmDIcqEwowpi
         xBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186364; x=1784791164;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xo+t1wRWpFilpcKELYi9v4ykQHKL/M+Rp1FsYxe7xSM=;
        b=svQxJozPHEYB59TAZTs+kujVSrAW9QDdvvYDG8Jt50/cDlGbxe9f/smIJ596RfsFb5
         akANEnu9w9Sr3CukLBh9Icf98t2y1nx08lROg+egzXYCCzqjX5AcRvUbesx092DiQ9Wa
         WEOCI9Ri+6RBHVGu2VLqYDMZk0DZWN7+zxWOEUiBfEKQir6NYHRXGXV1lzp8doLR/9SD
         uV+wjXw2odbnm2ocAjOFEV3EFZ1lHk3EfoEJq8nE631eIPPyR03wrrwAhVhgufWIAcf0
         si6eO0rDZCZ3N8l8W6dzOTBNq4VLm4Wd6qcv8aHUDFtu1Ok2IdD/q8Md598BIxI7cqpx
         +v0g==
X-Forwarded-Encrypted: i=1; AHgh+RqBpVje8BzuwCLYEJ6MMFuRagjpHkDduGRpFttUY+6J/fUPc6F2REZSDmXLGjn7Ycs2cpNq7yHx0tas@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr0jlWmSa/yCP+dk/fqfpHGKOeK2YlZooKII+LYa2NDpUP+nKt
	J/zctRHWedkVet/7m1ifsMSJ4VIucMifQ99oPudDguvnUfAl3Zi0PNWLm5dV4cVxdgk=
X-Gm-Gg: AfdE7ckMZA0BqDooXwvodseFGE8LVCdz7c/sVFt0by/C632MxQd+DQwVvvBM7I4/ySR
	vapnTWgU2bfMv4XaDNeYp7h9dwKR2dECtGEEIOHKgayu00UgctgKrrZl2VsfYOj2HQ6fq1NDHfX
	nYGXogniN9mrTnD6xn+rcEnNL2GI2qImHPoG4JIVQwHtHQ9qgxf3Y9k4LZI7upA9ZB7P25rUrFG
	wLufsEnZgLpyAy2mQLfl2/+DqdIkE4tRChy3IBLMkWghC1gcLNhPPOF3dyY5skwXxexhKQ3uDM5
	lBjWIh0eOVME13XAO+sFzuxwy6JPhzy+f3GGaiaZYxkTrtZwrpb2Bv16nkGxILVOFq+/hTKykAI
	c7Aa82vx+VjBQOG9T4mNmID2GYrGR1de7Pbx0pUYuxnPzrJmRC7undt3CcQFz6HcLjWwNOtRk1n
	xvWrkD8FgTY84=
X-Received: by 2002:a05:600c:528d:b0:493:b4cf:d37f with SMTP id 5b1f17b1804b1-493f87e5e0dmr226727475e9.16.1784186364315;
        Thu, 16 Jul 2026 00:19:24 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9a7bbsm36681925e9.13.2026.07.16.00.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:19:23 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:19:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH rdma-next v2 06/14] net/smc: Look up the pnetid ib device
 within the net namespace
Message-ID: <aliF6MhKWL_iilRP@FV6GYCPJ69>
References: <20260714142927.1298897-1-jiri@resnulli.us>
 <20260714142927.1298897-7-jiri@resnulli.us>
 <20260715143043.4F3CC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715143043.4F3CC1F00A3A@smtp.kernel.org>

Wed, Jul 15, 2026 at 04:30:42PM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
>Pre-existing issues:
>- [High] Returning unreferenced device pointers from `smc_pnet_find_ib()` and `smc_pnet_find_smcd()` causes Use-After-Free vulnerabilities when devices are concurrently removed.
>--
>
>--- Patch [6]: [PATCH rdma-next v2 06/14] net/smc: Look up the pnetid ib device within the net namespace ---
>commit 4529cf06709604767797679d2d489bb89001f950
>Author: Jiri Pirko <jiri@nvidia.com>
>Date:   Tue Jul 14 14:29:19 2026 +0000
>
>    net/smc: Look up the pnetid ib device within the net namespace
>    
>    Scope smc_pnet_find_ib() to the caller's net namespace so pnetid setup
>    cannot bind to a same-named RDMA device from another namespace once names
>    become per-netns.
>
>> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>> index 63e286e2dfaa8..ff9c9c35cc2f5 100644
>> --- a/net/smc/smc_pnet.c
>> +++ b/net/smc/smc_pnet.c
>> @@ -408,8 +413,8 @@ static int smc_pnet_add_eth(struct smc_pnettable *pnettable, struct net *net,
>>  	return rc;
>>  }
>>  
>> -static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
>> -			   u8 ib_port, char *pnet_name)
>> +static int smc_pnet_add_ib(struct smc_pnettable *pnettable, struct net *net,
>> +			   char *ib_name, u8 ib_port, char *pnet_name)
>>  {
>>  	struct smc_pnetentry *tmp_pe, *new_pe;
>>  	struct smc_ib_device *ib_dev;
>> @@ -419,7 +424,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
>>  	bool new_ibdev;
>>  
>>  	/* try to apply the pnetid to active devices */
>> -	ib_dev = smc_pnet_find_ib(ib_name);
>> +	ib_dev = smc_pnet_find_ib(net, ib_name);
>
>[Severity: High]
>This is a pre-existing issue, but can this lead to a use-after-free?

Unrelated to this patch/set. Ignoring.
