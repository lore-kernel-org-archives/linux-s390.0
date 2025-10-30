Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C82E1F06
	for <linux-s390@vger.kernel.org>; Thu, 30 Oct 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836687; cv=none; b=kU5rnYNmZ4xi9W3GPhQ9wYqJcmC3us8hVaXP8FFVGDzBQ1cWAz5MTiNROyZjctJ2eEck4abl57IT2EvFBtX8gcKjeqrluk+OD+tm+HfwYuqN2YdoeTZsayUvobHOuqJSnXY6SMXn3h9z0SvmIIp8FrWqcqvT9fvk3+WKaq9uc/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836687; c=relaxed/simple;
	bh=Hx/6mYoSWYm/lCYjDEINiT1xceIqhQwtdQfsRPnNRJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZypYXk3vRLbglfmIbwswOW76Ov6hdArtjFDz3iuxXg9TFVrO1onj4dIcli334tQ89S2gO6ZgtJM+uWwCxfsIMxeuW0/SRSA605xQDfyKBjyQwWetFHbpw8cUKBJPt4vow0N56T7efl3Az6ua3Ynpns62LN/b+migT8q7yYSR+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xgf8RqFK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgf8RqFK"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b679450ecb6so879258a12.2
        for <linux-s390@vger.kernel.org>; Thu, 30 Oct 2025 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761836685; x=1762441485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f00VBxUENVeblbXPvhKCpxOm0snkMJ7cmP2mPUW0kL4=;
        b=Xgf8RqFK4ZGQ/3ah55J2x4BvjiccS7qhEvcnTNB1piOpF1ol5B/5gKkExprAuqoZQf
         RWOfF2NdV6ldoIjYhmDRtijcRb6e4WB/LyU+dxTa3HZXVg1/cQ9kLFRB37lPZejiqdWb
         l8Hibp5qzbq9Xy4XUqSu7MBU3BUdHaBiaRsJ0x2fMYstQlYYQO64aj3Suy/XUAAyrJjb
         4VQrYZDy/1Ylc1O9hoQkendeMhNU1TpI6p68hZKoIffKC6NfiTYMuX7oZ8ld3yDTBIYs
         UTeg1morm56W2MMUojsMqeX+mkHhPUKqjdtjSv3YPhGl2xqjkfr6ug+MCmFYt+va0OUy
         z+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761836685; x=1762441485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f00VBxUENVeblbXPvhKCpxOm0snkMJ7cmP2mPUW0kL4=;
        b=QQadWcJgjTmfdAI2rPuSC1Rf+BpNpTAQru/EFMzUpA8KPYCCo9kU+0Y2yCrUalaZ+w
         TjUdrUqtnEZFp/hbRyqZkvHMJwo5S/MNOxLGtCfqVRb2eeLnGDJxiWsSamleyaP4eZcc
         Vs6g7/+2Rzz+kJg4VCTPF3vKu5GeBEDIL1r7Mp0W+m8JaHHfV7Q9Bxx3LZIc3gvjzIXl
         IB7MB2c/A+KxnvQXuwWSTcBDaJfz7wDPXVsiPhtib6qFsDKIPkaU5IvLqFvV20x4tf6c
         0KdKGzJ0hyaH8Mmgvsc9mgWoEW8CY4+Wi1EjvoIzyQWyRIv0IXIyyrGLXl9SeCWqfmR5
         AjiA==
X-Forwarded-Encrypted: i=1; AJvYcCVcczDbF7K17TqMa1qQ5hcghPganTI35ZLTvXMzPvI+IMYwCw36+Cfk4ck2UmlFwPdDaqoraJ8ZCMbe@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo3ONvlCUK/ixZbF16ioOeVGVWt5dL9ISqO3P27j5h46QDbJug
	VNYWowJex5j/HKitw3S7hywp+vZ1uUnu2nWUfRCsVEudDBZOlB1YcDeF
X-Gm-Gg: ASbGncss3EELaO1YvHqvmAm2+/oSx5LU0VycWdEzWPAPC6cY4piwht4yMVISwVE2jJl
	o7rAyvSe+iwYTdvGCIuwBsFWbTOqOOFWtyhBeRXr/GCoKMuLEojahMTemsmprV2HGg8HEV1jQAk
	zeXTJZrTCLwu8VKo02dgt4LT7+WgePYBHQMdxdoG+euWjsw3M7DqV2uowrxxkaRj9dFdVE/OaC/
	eUVJBDyABZg8FDOraXsmKjLNjP3Z3eGalgqezkyXzMa9dUwTv7VLnyPw9VEim3gUL8rNYC2uS9J
	nEhDUw6m+VnPdKiHPCudG/BiWH5ENbAuc38e0A/uBWPe5uCv1ql/v49T26E89Bh1LU3iZGJJoUN
	0W2uMNSZUhd6gMkbagPLv6/o8UX8fAItbQob5ekjAM1xrteqh1NJyO5aGqYWoUpBBQVCLir7fQr
	+mMr53vDc+jzO2d9qRJzy8EPTM48fUtTndE3oBWEy80tZDvQ==
X-Google-Smtp-Source: AGHT+IFxuPu5wcyDPeg3Kdk0JRjahgJ17UoLRDSJTEQ1u/yQOEaCGqjms2tHqaizN3DYh1M8w79Hqg==
X-Received: by 2002:a17:902:db10:b0:290:dc5d:c0d0 with SMTP id d9443c01a7336-2951a50c96amr102885ad.49.1761836684991;
        Thu, 30 Oct 2025 08:04:44 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d274b6sm188234395ad.59.2025.10.30.08.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:04:44 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: david@redhat.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anna-maria@linutronix.de,
	aou@eecs.berkeley.edu,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	namhyung@kernel.org,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	pjw@kernel.org,
	qq570070308@gmail.com,
	riel@surriel.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 0/3] Optimize code generation during context
Date: Thu, 30 Oct 2025 23:04:17 +0800
Message-ID: <20251030150417.684-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <c6f8871a-5118-4947-9801-43b2a7a42993@redhat.com>
References: <c6f8871a-5118-4947-9801-43b2a7a42993@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 Oct 2025 11:26:39 +0100, David Hildenbrand wrote:
>> I did some testing using my devices,
>> and the testing logic is as follows:
>> ```
>> -	return finish_task_switch(prev);
>> +	start_time = rdtsc();
>> +	barrier();
>> +	rq = finish_task_switch(prev);
>> +	barrier();
>> +	end_time = rdtsc;
>> +	return rq;
>> ```
>>
>> The test data is as follows:
>> 1. mitigations Off, without patches: 13.5 - 13.7
>> 2. mitigations Off, with patches: 13.5 - 13.7
>> 3. mitigations On, without patches: 23.3 - 23.6
>> 4. mitigations On, with patches: 16.6 - 16.8
>
> Such numbers absolutely have to be part of the relevant patches / cover
> letter to show that the compiler is not actually smart enough to make a
> good decision.

This was indeed my oversight; I did not read the submitting-patches
documentation carefully, thank you for your pointing it out, and I deeply
apologize for this.

Do I need to send the V2 version patches to supplement the relevant data?

By the way, the above data was tested in WSL. I did a more detailed test
on a physical machine. If possible, this data may be more appropriate:
Link: https://lore.kernel.org/20251027152100.62906-1-qq570070308@gmail.com

> Cheers
>
> David / dhildenb

Thanks very much.

Xie Yuanbin
