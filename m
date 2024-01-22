Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA9612C4
	for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944179; cv=none; b=X9RkXPXvIjQ0LYKHL5l2WhWa0FzMbHRWfZPMz/xOpMBWFgjQY5Qw/18uh3zrTVd+vCEAqidqCKTHtv+GFGz260cX7VGWfVtz7d1Ol/ZoAUg4xwbNqfZX1jiBwZ5OZ7588tPxms4m9CMrM/J47r/Pwu6W2Icqyc8sfHdgeE1TEPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944179; c=relaxed/simple;
	bh=bEHwRRHZEZ5muODAZZTChjTXAGcN8GLNJSdSobXIA0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bb2LZIzEGJI6pFlqCL9ShIumPS6I0vLwkLOUedUy3A+wVB4ZptkkxDLRErXvclsimGGsECtG90NxMQKjIqG1KrmQu9UH0R6fD1NO7cAaHgLxM0yRYdgrsvqxGUYxESsFrjVvrujQCljB35EuUgBKBlEGtkI2hzmKemjzfjb9++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NCIqAD7c; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NCIqAD7c"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9b760610bso794324b3a.1
        for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 09:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705944177; x=1706548977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3cKBLusi5odBbefyu3q7+UJ6/M6hhfLrmEnRO/AYdSg=;
        b=NCIqAD7cPTDcHzPOjo+YrAdQhZRnfiXAizEgkmFr/YbQQIzPn5dYBRVoS31a+ULPw8
         /R5CcIGj6Mm8eLJg3DZK7ZCJPQpjgbfXu8Q11j91CGCoGCU8BY1JBVY6JepkTDzF5D1c
         axZaTBWHcjXBZ4ya9oqXJyJ/HDv68Y293Vi/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944177; x=1706548977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cKBLusi5odBbefyu3q7+UJ6/M6hhfLrmEnRO/AYdSg=;
        b=bpcoX1y0c2sKlYDxLxqOnXHOu743t24dOtRYaD/3Bk19nh3J7KLx/O5eDI1m4xgUcl
         PxtCfYokf/dwoGPSdBWOxE6ap0dFCRMsHnZQRNMD0XoQkEnOwhJzOtKToLdKJ/iFNZPt
         MOPcGVeU0Unxxn7y3yMpTPwlER0Vm6qeGSOYZnm7JrlGjVg6X5Cl5fSrfRxrmKPGAJ0L
         q6zNoH37pZEOWLDkfCMnhoJtKAi1wBcZ4MusmgleIhCMitfuviCxUIWPVh3zi2ijTxJa
         TwOMV3lyDx6ke4J1YRgsMNu9GPsK0DTLEPyejozlDFIBwOJuJUrnRF6wjCkD6X1MY1mA
         MOKA==
X-Gm-Message-State: AOJu0YxJ6yIJmQLbZT957G7pcn+ss5qjg1MQ2I4txDhyaJzSfSca4PNH
	HR7AbYMMl9YchYTsKDtoOBqnQROYiq7uqgoB0Y+3XQ4I8wqFvzkUzcM7mwIYrsA=
X-Google-Smtp-Source: AGHT+IGjgFJLDdAfyqDNErB5PR6R2A+VDqHcrvgpf1rrqIFIthJVkNUJsACPjPjML0hqNb41Xog8zQ==
X-Received: by 2002:a62:6204:0:b0:6d9:383b:d91a with SMTP id w4-20020a626204000000b006d9383bd91amr8897256pfb.1.1705944176719;
        Mon, 22 Jan 2024 09:22:56 -0800 (PST)
Received: from [128.240.1.152] ([206.170.126.10])
        by smtp.gmail.com with ESMTPSA id y74-20020a62ce4d000000b006d9a48882f7sm10245573pfg.118.2024.01.22.09.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:22:56 -0800 (PST)
Message-ID: <f3ba4181-ab38-4779-987f-9bda47f003be@linuxfoundation.org>
Date: Mon, 22 Jan 2024 10:22:54 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org, skhan@linuxfoundation.org
References: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
 <20240112-send-lp-kselftests-v6-2-79f3e9a46717@suse.com>
 <Zap04ddls7ZvbL/U@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <Zap26MINbbxREt4c@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <53cf93b2efadc0f42712eb92436bd575b5622664.camel@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <53cf93b2efadc0f42712eb92436bd575b5622664.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 05:55, Marcos Paulo de Souza wrote:
> On Fri, 2024-01-19 at 14:19 +0100, Alexander Gordeev wrote:
>> On Fri, Jan 19, 2024 at 02:11:01PM +0100, Alexander Gordeev wrote:
>>> FWIW, for s390 part:
>>>
>>> Alexander Gordeev <agordeev@linux.ibm.com>
>>
>> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> Thanks Alexandre and Joe for testing and supporting the change.
> 
> Shuah, now that the issue found by that Joe was fixed, do you think the
> change is ready to be merged? The patches were reviewed by three
> different people already, and I don't know what else can be missing at
> this point.
> 

I would have liked doc patch and lib.mk separate. However, I am pulling this
now to get testing done. In the future please keep them separate.

thanks,
-- Shuah

