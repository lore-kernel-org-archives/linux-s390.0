Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF047318F
	for <linux-s390@vger.kernel.org>; Thu, 21 Dec 2023 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="htjTw8g8"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35fd4856abbso104685ab.0
        for <linux-s390@vger.kernel.org>; Thu, 21 Dec 2023 12:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703189418; x=1703794218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuNcu+xSyjheqKIJeQgDsNTkefgj8XV+ZlyaXQLWUtQ=;
        b=htjTw8g8ZMl5/1bCZWg7QJZ0R2bBW3H0bSln7Nk2PsHatqe4pZT9je6JGPKugqgeMB
         1p2YJvrhC+ApTKUGcYyREZFb0dq3iVhJFoyCUcYItKd2rxxcfBSJXiUoqSdtgjLYjcnK
         sadUeqkJ55d8+Dw/4ctRnY7fGXNQr4J59/yeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703189418; x=1703794218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuNcu+xSyjheqKIJeQgDsNTkefgj8XV+ZlyaXQLWUtQ=;
        b=IqLGKYqJMsLxBkI6HU5CImDgPmuvVRcEryuWr3J8VZfVhhAD2wBRwFqoCaTlB1H/X4
         vuWOdh0Ce41Kr8MMqknDD6luxYBhnozhFhKQHL9vFwXRhi2m3YvJgxkVehfPkng70AHv
         JiSivFvfMd9ESyiOE9pSvyrq8cPsqXXBNz0NK2TfeIa44Ld+f3chkhKySaOUBauYaOb9
         gPCMJilOrC9I8/OMHDPIad8gnTtju2x+dVPZCOh7+tAYo0rflCzFzj+8p3UK8ffQOC1f
         R2mASHoMlCYWdWndwR2C7ZOdf/siv/et8KN75d1inE9Yyb0fMDRZiK1fWeuD+jYDL5iK
         9v4A==
X-Gm-Message-State: AOJu0YyB459Pi731qX0g48wD7eO0oOsFjnXriw7Vc1yrZqGNC32BGipg
	J79qJJvNdnHB7ZrFqa9PA6EYghNSAbE7fg==
X-Google-Smtp-Source: AGHT+IF1UnXSpqilXx5/i0ZEyW2V9x9IQmgHrp0PwIlsARHqqwSbXr2zVL9aQML5DMWwebj2OtVrKg==
X-Received: by 2002:a05:6e02:1cab:b0:35f:d862:e451 with SMTP id x11-20020a056e021cab00b0035fd862e451mr384657ill.2.1703189418192;
        Thu, 21 Dec 2023 12:10:18 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id f8-20020a056e020b4800b0035fc47d9014sm694293ilu.13.2023.12.21.12.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 12:10:17 -0800 (PST)
Message-ID: <4fb5fac7-fa3a-4988-b5f4-8025864c4d37@linuxfoundation.org>
Date: Thu, 21 Dec 2023 13:10:16 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 0/3] livepatch: Move modules to selftests and
 add a new test
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Shuah Khan
 <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
 <55b717dba239f3bedf0da7e25925e390a63459f5.camel@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <55b717dba239f3bedf0da7e25925e390a63459f5.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/21/23 05:17, Marcos Paulo de Souza wrote:
> On Wed, 2023-12-20 at 13:53 -0300, Marcos Paulo de Souza wrote:
>> Changes in v4:
>> * Documented how to compile the livepatch selftests without running
>> the
>>    tests (Joe)
>> * Removed the mention to lib/livepatch on MAINTAINERS file, reported
>> by
>>    checkpatch.
>>
> 
> To clarify: this is not a resend, this is the v4 that people were
> waiting for. I made a mistake with b4 tool, that first I sent the email
> just to myself, for testing, and it bumped the version to v5, but I
> asked it to "resend" the v4, but it ended up adding the "RESEND" to the
> series.
> 
> Please review this patchset and ignore the RESEND word.
> 
> Thanks to Petr Mladek for spotting my mistake.
> 

Thank for the clarification. I was wondering why this is a RESEND :)
I will wait for reviewers to comment on this before pulling them in
for Linux 6.8-rc1.

thanks,
-- Shuah

