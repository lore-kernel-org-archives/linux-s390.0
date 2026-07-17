Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21164306741
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297770; cv=none; b=dt15fr06Ei2wIr0UypW8+ILIMrfEZE6tMUV+TjMxXFF6uERotqGP89ktYzkeXxkV/vT8Yt2fjqxI9krzJul8i6IApCUueKJV2MNyfVzR3wAdKSKDkcHLkyDj3SDomsgZYBcNnyfdHu4fj3B4GWLJiQbdpAuHTZIiM4+Gyh+j0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297770; c=relaxed/simple;
	bh=ZTIYqO8lvntxq7PBA88uJmOyCPtNN+lz3W5n2rnc7uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXSXNFkrGvYu44d+0ywKPY8rYLRDdjz0s2th+giFnqLt2XydmwF0ba8KukdK5COSauQe7M/xPKKrE3I7kQajDBv4h1bZXQ3ID5B3eic5PtTh7iJrA5uyR+s8NRvRMoWHDjjyaUlwOv8tj80VTF7WS2LJ3m4IhLIJcFhs+a5xLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=qn9BrZXE; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="qn9BrZXE"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so7294832e87.0
        for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784297766; x=1784902566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f1PJ2tCrZprO03QzczdHRzzYo8M3sJdRoRBqwRMce6E=;
        b=qn9BrZXENaayKwINHpBeYg0SX+uWLVMV6kswSg6qi2ce96IUgWnWfblpR4mxigu8P7
         JxEFapbX3tBkMF/7TwdD+9Uw0tKdfa6QdJMAYCk1mWqx9xpp4z8F3rYCuQKFZtUqv10F
         3ja44gijq7qGycmbSv0fn0Cqg3d/P/OlEdO+4jLkFXkxqLYEz+NTPnnko1lQMuKJKsGH
         7QT6x64u3Ry+4Dt6pWAQ1RoQ73/1UkjNdlbyltw/+b0EmLAxcL5+k+exD+UaKiLr4RVE
         8YJM66o161IUY07oPQwTvWR2DLHfgtvQv2IuzetqKZvEOdW7N3+ARmjNk046WtWYwU8r
         2U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784297766; x=1784902566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f1PJ2tCrZprO03QzczdHRzzYo8M3sJdRoRBqwRMce6E=;
        b=EXHXkp8HpUvd57sxtPKEwLCDmKz55dKaUc1TrEnsn8X7rHt/Yb1TJUwQksl1pS0bWZ
         rOd67bG9LbvZ15rTfXzueZ6FvULLYMpbbf+rnePjKEmp+WbDt9xkrXAU5CU0ERxXDCon
         5QRqsoJdc4D/p7Dc7r4uf9O5XYfvpjc04H/un8sI4T9PKgneG5K+toNY2wJ/o6fH2VuS
         E5zNzDeS+2km3bdhbtF14bXIx4HxWD1hp7LqByz7Y5T4DGlHRI+sHz9gCDlq3JmMb5RE
         4tAJGsg9ouEMU3sRU6rA7vHd2DaNZFZjwl5jWyeBFKvDq9vffgLgMY4E+j8w50frutwh
         6GaA==
X-Forwarded-Encrypted: i=1; AHgh+RpEX3Y6M8uUeE7ICKa/yv+E0Icl3P1U6tuvM84oqx9HPvh1J79wM87XKRCDw129g3z8hZISuw7XiNrL@vger.kernel.org
X-Gm-Message-State: AOJu0YxDxPTY+rJTBKNrdQ6+I9CMFrvzXpMsm0BT2YAnQmWIxTVDUPgm
	HSZn2xkVvzWgpto3iM7sX960gTeUKGqUmhVhn4Fn0wBkC5G92jnC/8QUHJhRegA4sG3ADpC7uGc
	jNVgp
X-Gm-Gg: AfdE7clVL3B0LObcHBdkJEhNcqbIgXmNidOHJ17UpYlbJZ8WWorepcVVY4zVETViuB7
	X2FbXN4pI4WAF686jXe+jG5oLgsZE1zy0IdL+2Og4kWs4lc2+NQRLTl3O1jDI1lctc7eJ1fQPAc
	x/K/8AeVXKqthjSkhAGiVVzbpFXtvZSn1Vjc4pTA+m/s5pw5iqCXeMXJi0tKi+8N4PUZ67kexww
	o2T7Wvt4YAck3KkLDcsKaVSMX31XEneJLcEb/z57xSZcB/pY9XSCtZ617DobmpiMP8MSXIhJLTC
	b2bxSZN5o91p403DdbW8dmBFXFVw3+arxy2yVkRlY+IspD7zhBxGHCSp3R2sB9MpVRKsjBpO7ez
	Jik/OSci9nGL+E+iNJZylp7iZuStiFeVeRqphJAeaQ8HfTjDilVwr6gQwAFY+3TbxYcuh5JD05b
	90va3tZWnZhuY=
X-Received: by 2002:a05:600c:1c20:b0:493:e97b:3b9c with SMTP id 5b1f17b1804b1-4954b560583mr24280245e9.29.1784297395233;
        Fri, 17 Jul 2026 07:09:55 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495499f3f99sm49884525e9.0.2026.07.17.07.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:09:54 -0700 (PDT)
Date: Fri, 17 Jul 2026 16:09:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, 
	Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH rdma-next v3 14/14] RDMA/selftests: Add rxe_netns_names
 test
Message-ID: <alo3nS7XrhjdRsSJ@FV6GYCPJ69>
References: <20260716132316.1495242-1-jiri@resnulli.us>
 <20260716132316.1495242-15-jiri@resnulli.us>
 <20260717132429.3DE161F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717132429.3DE161F00A3D@smtp.kernel.org>

Fri, Jul 17, 2026 at 03:24:28PM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>- [Medium] `wait_rdma_devs_gone()` fails to wait for dynamically renamed RDMA devices (e.g., `ibdevX`) to finish asynchronous unregistration, potentially causing module unload failures.
>--
>
>--- Patch [14]: [PATCH rdma-next v3 14/14] RDMA/selftests: Add rxe_netns_names test ---
>commit dabec57822c009814520c6cece67efb39fb7b1f8
>Author: Jiri Pirko <jiri@resnulli.us>
>
>RDMA/selftests: Add rxe_netns_names test
>
>This commit adds a kselftest script that exercises per-netns RDMA device
>naming with RXE. It covers duplicate names, conflicts, move-with-rename, and
>same-namespace rename requests.
>
>> diff --git a/tools/testing/selftests/rdma/rxe_netns_names.sh b/tools/testing/selftests/rdma/rxe_netns_names.sh
>> new file mode 100755
>> index 0000000000000..f40118407f4c0
>> --- /dev/null
>> +++ b/tools/testing/selftests/rdma/rxe_netns_names.sh
>
>[ ... ]
>
>> +wait_rdma_devs_gone()
>> +{
>> +	local i name ns
>> +	local names=("$RXE_A" "$RXE_B" "$RXE_SAME" "$RXE_NEW")
>
>[Severity: Medium]
>Does this hardcoded list of names miss dynamically assigned fallback names
>like 'ibdevX'?
>
>During the TEST_TEARDOWN_RETURN test, the device moves back to init_net and
>conflicts with an existing name, receiving a dynamic fallback name (e.g.,
>ibdev0). When cleanup_devs() deletes the underlying dummy netdevs, it calls
>wait_rdma_devs_gone() to wait for asynchronous unregistration.

*Very* unlikely. Ignoring.


>
>Since the dynamic name isn't in this list of expected names, the function may
>return early before the device actually finishes tearing down. Could this
>cause the script to fail to unload the rdma_rxe module or leave a dirty state
>for subsequent tests?
>
>> +
>> +	for i in $(seq 1 50); do
>> +		local found=0
>> +
>> +		for name in "${names[@]}"; do
>> +			if rdma_dev_exists "" "$name"; then
>> +				found=1
>> +				break
>> +			fi
>
>[ ... ]
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260716132316.1495242-1-jiri@resnulli.us?part=14
