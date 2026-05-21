Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CEB34753B
	for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779401620; cv=none; b=QMUGmNw01syHVK4wfonVBSi25fRMS2F6BB5v3DWEMnE+sOqRNofzKvmsM0WwrF2TLJEyVJ2IXtW+zwwJAa0mPs2SJCn945K+fCH/cdkyCBhvirf+arKnaRKMO75DtRzF3ow80L3+FaDsuMfnyCRIfLGEuy3N0yi247XEhAz/Aso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779401620; c=relaxed/simple;
	bh=R7WsN4z6EjgmoX/FEiW2LPeLsl6WX2AHzNxJSevq+bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JD200ZdXeejvbypToT/dZfdqFTZYEDMatr5ZXtqFGysm0yPGY+L4vAFSdVBz41P6QcHWE+oCFg/u+MWOicA76WhlQsm3M6yAljAGNIL9wRn6eJD7dyvvNeUN1b1T9Cg35dtCbnZIefP4dllx/o+KeTEfNgK9ZmyfjorcW3Jk1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPR3/yjM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPR3/yjM"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903cbfad68so7279835e9.0
        for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 15:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779401618; x=1780006418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Apv4BVfh2CBdAgPohTzEnCX66gLKozYK0MvWW1yk0T0=;
        b=dPR3/yjMjxTSpVslM5s/SdZd1V/ldLwtSN1EXoSfZOxInGn13Rk1btcu4gcmX/GDMg
         N3eQ2UfwFbHBI3zMqU5KIImtc0B2Z43mSwXUNGGWnwVUY/iYR6ScQz64kkxDPsKgF7X3
         pMWOuKG2UNPUKDpaxGaZ3MzSaEp9NfNm6gPDYgzIOVa+z1coWmaxlNLUvveonKiTrVvq
         8PeTPxyjgUEYudNbsAulrtCq1U78RMG6XNdMDRbZxcI8ThkzelRVX0n207E3O5S04hZv
         NK1fCtbKt2k2byHjBUYb1v00ciLMaOCCqn/5rutn1TrO8Q7eirztZnNCmV8CsF2fIqtt
         Xzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779401618; x=1780006418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Apv4BVfh2CBdAgPohTzEnCX66gLKozYK0MvWW1yk0T0=;
        b=f33JTUtRBv1qMw0psSmXwAJbjcaIylCwm7rSdWfNzaEPCtbs6leCf8c5H8OiR+HZUi
         FPyN0mlYz9dazV50NP0vgfSESPBV9WtcA5qrhACBH4gpBTyM0yYd69s6BJJiky+7qf5a
         QW2sMbVqq47943M8iI5Gg4n7xbNSr6GWkwgA4xUg6+Dt3K4qf7J2xD2nKM6OSsn4BWF/
         7awMwRx2SrS+I1zuX5dJP+cLLhY8Qv6chJ3t8yFMVqRHZpgtQmnkGjdtS0CuzPaJZ7gM
         f9XLfT5cDXcqjB2pgIm3IbMCKyjRbK2pSlY5wWisDKfmdXNwmS6DOadbG8bFOPrdMu0M
         gDQg==
X-Forwarded-Encrypted: i=1; AFNElJ/navGEjjg2RcaCsj7aqL9QKBC68baxj9DEcGioy6XMAV9sr3mowRY6MxszeAYV95KNyNux4fbEEQVz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02/IU/8HvPfJcP5PfqdE++hPjleprp/Gap9/U43d1YPipErcU
	JMrCPO2zFPgFeJ857ste2FHZtoyWv6eVFiPxhx48zdYNK/ZbjsIoeMfI
X-Gm-Gg: Acq92OFYI3T9xWVqkSNOyEnPHsRAVOwetsGaARTBaPb9xgQbjeUUUB1JUFkitN9o0yo
	n6nXzQLb8/nv42my/XxHeXxwu9jOkU1Mr9C3o9ZbGJYRcNJX44tB9LgHAhhK3/DZzQpDKMtnxQE
	M4Pxj8TrWNQgSnBpUcVYmSXlx1H9TITywbUbWlHP8EUy4lngySISzDbqWxTUbbD6tVewliNyD+P
	Uo/x6GZCKV6aHFfUJ5QFel93sxuK7jiw2ka4myDhAWL/OBXNbNO7DFHUBOme3HPcptP3mEtg5qq
	Za88Ha0/YFSAjx8cXQEpRXcE7JF9Gqc7Jb12NcTmFvIHsgk1xmANWpGG0Q5bkFThHF4i5FwvbVn
	v2KMX+CmEcRhzuimIZOoJzDO7TXzt6wqLn+EGtgLam7/ffpvI5aotBp+DFGUhgJyLdPMZeVyyYa
	aM1zVdWSKHjxu+3/o9k5dhAuEsTNLDvWueOisuyX0DZdnewuPdCJSq1QYw0VYOw2gy
X-Received: by 2002:a05:600c:1c0b:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490426a495amr7073795e9.14.1779401617652;
        Thu, 21 May 2026 15:13:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490452545a4sm427045e9.4.2026.05.21.15.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:13:37 -0700 (PDT)
Date: Thu, 21 May 2026 23:13:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Juergen Christ <jchrist@linux.ibm.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Peter Zijlstra
 <peterz@infradead.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
Message-ID: <20260521231335.2fd3f7e3@pumpkin>
In-Reply-To: <c29b201e-f839-4702-be60-f8c38ef637ee@os.amperecomputing.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
	<9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
	<20260520233409.0683f595@pumpkin>
	<d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
	<20260521111744.6e58bfd6@pumpkin>
	<592ea7fb-b836-4c47-a0cb-248a185cbaa8@os.amperecomputing.com>
	<20260521185532.002541c6@pumpkin>
	<c29b201e-f839-4702-be60-f8c38ef637ee@os.amperecomputing.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 13:46:25 -0700
Yang Shi <yang@os.amperecomputing.com> wrote:

> On 5/21/26 10:55 AM, David Laight wrote:
...
> > The 'trick' here will work for reading/writing values if you don't
> > care that the value read is stale (or might have been written to
> > the memory for a different cpu).  
> 
> If you don't care the stale value, you can just call __this_cpu_read().

You can get an impossible value.
The generated code might be like this:
	this_cpu_data = xxx;
	preempt_disable_count = this_cpu_data->preempt_disable_count;
If the count was non-zero at the start you'll read the value from
the current cpu and all is fine.
But if the count is zero you can get preempted between the instructions,
the process now running on your 'old' cpu can increment the value
and you then read the new non-zero value.
That won't be good at all.

You can only use __this_cpu_read() for things that don't change.

The big problem with using per-cpu page tables is there will be absolutely
nothing stopping code taking the wrong address of a per-cpu variable and
saving it somewhere.
At the moment you have to use the helper so always get the global address.

-- David
	
> 
> Thanks,
> Yang
