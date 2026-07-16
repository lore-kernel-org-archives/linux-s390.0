Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8040963F
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197866; cv=none; b=ady1z+/TN9NmFK2e8WFdhRiMHqFaV3zugu9+5RRgfMT942V9+khaKDw7pSwqKhElHOUZ3kxofJ+PLqayM4ieby3f5/JKWX0md3WuvC7Tni7h4+2ePrYvdv+mV7L8hznQxzyn+xcIZIq0yDZ7SspmL2vXCLkenTc3jvNs2DS2jMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197866; c=relaxed/simple;
	bh=5ubhc7oClAf6zMYdqg4KC6FNbNoCdaI7cvBU8O72Ex0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHVV93y/IyB+bc1Gh5jV5Sv1RTUUkZCEQNWxEdJY60PLWjzAoypoO+F5s1UEp3NJyLVcegsRZmulo8ch6jZ5tumlkgt/xLZn0tHFHSFW46D3SF8Bh3rQ1c1pzqwHSTriCCn5U88MgAS56SPQUF2wrngvkEhiZp9JgRKkPMjkPyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=C5R7rJiO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="C5R7rJiO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so43985625e9.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784197860; x=1784802660; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KxOFIC/lNwrjJrULah4xZJOM7YaGDvKvmR6DqO/DU8Q=;
        b=C5R7rJiOsHRC970uMezKCpVSncRZZlTj+rSHC9J6llCo1ycd1cRvR88DSPmPmldM1S
         uRSkct69rtfPY+C0WUxC5rjDeoHCCunI3gUeUA9PHe3R70RSmrc8clK0ImmcHN83gFKK
         5d05Q2HWWBl6kc48S5Q5Mp47Y1FtsXpeYrJuMH2rnafeiidxe9RI1MXNuU+3x2Dxs/jW
         /rH5Tuws6H2y9/rRVYnw9LWlN3KL3VDAWZ9uOgbUZX03bwhi2FyiSujQhoaYC2qm8nzM
         sDSdes3imK4BDQQgt99/Z/66RCZ19ZJEBC7D/efkLKmZZe2RKFqQ1IKG/p8eiRSWe4TZ
         +7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784197860; x=1784802660;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KxOFIC/lNwrjJrULah4xZJOM7YaGDvKvmR6DqO/DU8Q=;
        b=dOInnJE0j45jN8MqWnGe+d+4ViGP2aWBnHqOHGs1iUeN0qyrGu/ijflzPBwGU9vX/C
         ig6LGpieiobi9pnUiuFncbOyQ99VtpEGK6AWjv4FCFeAoYDGXSI5ZNFggiK/eGwjnjYU
         Ez33RyCe3G43e7WU9gjlAv9GMRGVhL23Z74/3Si7l7pGHrm0H3yOBt4llCkr5UvFcrPC
         5x4PZSigAhO5oMqB/CW7KE7IgK0QkG2tSJAIyDZ+iJyMPVMz0slhGr2NG/uB8cnEgrnj
         SN++Of8zQ9XhcFAw38A7vlmX+a0oasiq+65AOi4/XOOUTF8F4fLcz8p1IrUoJav4gGx/
         B0Gw==
X-Forwarded-Encrypted: i=1; AHgh+RrI31GX/lAZnlmdsvVpbAPVwXS8iop/mXusV2RLAxDqOWA6bn0t5lMFSbL/nt6e5dxixyGozqCTSfOv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6iTXAWQIn4sMqJFAdZN8vP0YT4E/OJM67tvI0gPpt1Jbfwsqf
	B42Wi70g270Vz4oN89CA55Phsnd4Phy0dSvH33ByujbFQyQoY4e5LWX0NRWN4ZZlhhA=
X-Gm-Gg: AfdE7cmiU2VFTWBOK8ExeMblIcRXIlv6isEU6xchGNOzWNhG3DZpiQTzoPJ81QbC+JI
	W+WAzyb55ANU5sT2HkLuG8tqAZzdNjtp5QCu77OH9J06p8pKfNkhXCONBTAXGrO9gq1HexNx8bM
	kzD4zF608uZzbJS5uoz/ZVF30cIXiIBoldnoYAKVGlFEo0eIiC8Ou8vEzVvkSk4K+WadbuD6HFq
	e+ikd5fb3qtMtz+hmjQ4Qn/4MJ2xe9O/UpL1NJR9pUsmLq3+WVWwUF0Z7y0iXJZuamZgNY8gwtT
	dPC7tRJtfVWz47h7xMG1N0jxatpjw4cie3JHJ6wiAeAnPGMJmSRG9v7kc8fwe3AD8ewD88JT1uk
	pyfsAQhXRCPE2aJYB63/jZ+2ZHGAAEJ+/EbswJvDBiz3ydoGSs2TE5vCfI0Mt2mJ3FQaVwWOhX2
	xJDR83MI09jGNIK5GiCtsTPg==
X-Received: by 2002:a05:600c:e548:10b0:493:bc31:b2ae with SMTP id 5b1f17b1804b1-495389957a1mr81189495e9.10.1784197859472;
        Thu, 16 Jul 2026 03:30:59 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c599049sm94687865e9.0.2026.07.16.03.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:30:58 -0700 (PDT)
Date: Thu, 16 Jul 2026 12:30:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: hannes@cmpxchg.org, mkoutny@suse.com, linux-s390@vger.kernel.org, 
	tj@kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH rdma-next v2 14/14] RDMA/selftests: Add rxe_netns_names
 test
Message-ID: <aliywIUtRHBCv5Rp@FV6GYCPJ69>
References: <20260714142927.1298897-1-jiri@resnulli.us>
 <20260714142927.1298897-15-jiri@resnulli.us>
 <20260715143046.020451F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715143046.020451F00A3D@smtp.kernel.org>

Wed, Jul 15, 2026 at 04:30:45PM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>- [Medium] Asynchronous RXE device deletion causes race conditions and test failures.
>- [Medium] Asynchronous network namespace deletion causes test teardown to permanently leak the exclusive netns mode.
>--
>
>--- Patch [14]: [PATCH rdma-next v2 14/14] RDMA/selftests: Add rxe_netns_names test ---
>commit dcc30384e696a4047f319e3b7139b30b3ddc09f4
>Author: Jiri Pirko <jiri@resnulli.us>
>
>RDMA/selftests: Add rxe_netns_names test
>
>Add a kselftest script that exercises per-netns RDMA device naming
>with RXE. Cover duplicate names across namespaces, move conflict
>handling, move-with-rename, and same-namespace rename requests.
>
>> diff --git a/tools/testing/selftests/rdma/rxe_netns_names.sh b/tools/testing/selftests/rdma/rxe_netns_names.sh
>> new file mode 100755
>> --- /dev/null
>> +++ b/tools/testing/selftests/rdma/rxe_netns_names.sh
>
>[ ... ]
>
>> +cleanup_devs()
>> +{
>> +	ip link del "$DUMMY_A" 2>/dev/null
>> +	ip link del "$DUMMY_B" 2>/dev/null
>> +}
>
>[Severity: Medium]
>Will this cause race conditions between test iterations?
>
>The ip link del command returns as soon as the netdev reference is dropped,
>but the rdma_rxe driver handles the NETDEV_UNREGISTER event by scheduling an
>asynchronous unregistration of the RDMA device via
>ib_unregister_device_queued().
>
>Could the next test iteration fail with -EEXIST when attempting to create or
>rename a device to the exact same name (like $RXE_SAME) if the asynchronous
>device_del() from the previous test hasn't finished?

will be fixed in v3

>
>[ ... ]
>
>> +cleanup()
>> +{
>> +	cleanup_devs
>> +
>> +	ip netns del "$NS1" 2>/dev/null
>> +	ip netns del "$NS2" 2>/dev/null
>> +
>> +	if [ "$MODE_CHANGED" -eq 1 ]; then
>> +		rdma system set netns "$OLD_MODE" 2>/dev/null
>> +	fi
>
>[Severity: Medium]
>Does this cleanup sequence permanently leak the exclusive netns mode?
>
>The ip netns del command initiates asynchronous teardown by queuing
>net_cleanup_work. If rdma system set netns "$OLD_MODE" is executed
>immediately afterwards while the namespaces are still in the process of being
>destroyed, the kernel might reject the mode change with -EBUSY.
>
>Since the script redirects errors to /dev/null, it seems the system's RDMA
>subsystem could permanently be left in exclusive mode instead of being
>restored to its original shared mode.

will be fixed in v3

>
>> +
>> +	for m in "${MODS[@]}"; do
>> +		modprobe -r "$m" 2>/dev/null
>> +	done
>> +}
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260714142927.1298897-1-jiri@resnulli.us?part=14
