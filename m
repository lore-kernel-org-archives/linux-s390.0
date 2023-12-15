Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D036B03
	for <linux-s390@vger.kernel.org>; Fri, 15 Dec 2023 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFLKVLtd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702672593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqhsEugKtVuOP/CErLGwgtJcZIJDT+/OEzsNO/Pyaec=;
	b=bFLKVLtdwVthuoDJeRvxNahzdKf3+TEDBq+pgByr4XHfeF41NH8h/Q2HfjZ8X+ixBQ9fue
	5T5xA8a7ibVzI9ljBO1jrUJbMfMmDubFXyu0mxxCfRU8sJrzelFtqOeW8AM7kFkwu2PFii
	KAYJgV4guDcbFPd9ugwAwJf7vCkjQMo=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-UOhRvtY7NqqxLa0JtZKz8w-1; Fri, 15 Dec 2023 15:36:31 -0500
X-MC-Unique: UOhRvtY7NqqxLa0JtZKz8w-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-58dad14ab40so1330087eaf.1
        for <linux-s390@vger.kernel.org>; Fri, 15 Dec 2023 12:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702672591; x=1703277391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqhsEugKtVuOP/CErLGwgtJcZIJDT+/OEzsNO/Pyaec=;
        b=f+FyEpF31e2T4mtNNDhaa3pSrCfIE2FwAGqMLTRoY7jA6SOku5q0j2k0HG+xft6Xla
         NID3N7H4j69hh1wvsVV0IYm9w4nbum2Z83R6J+VNkeANFdymK5Ci33v4Su91OdD2l6xb
         Sn2nl4WpHVMifSLyJ10dp3NajXaSqof0nA9nc7POyRb2f+V1ypSCtwnDkTmZfP058FiX
         tFbwwGEiaH0A6VSz9RBpS/Qgd3B4wF1GHle990TyhdVlyQv2sDTevQTEZf1h3zm75HDZ
         eFRx5SfXgSsYEEG3Wzy1eKepLIqXq6d3d1TWsEPT+RRT21MpioEes8yO+ijrT/vd/Jcb
         64eg==
X-Gm-Message-State: AOJu0Yz+2pGWoHvIn7ow7cuSxuudOyNoTJL1gaLhSunrr/O6sYaxv1L7
	MwtJvmSwoRSTGrZ0hp+SJWcfC5FXJ/zsc3n7pfalbWLzewtX07x9NP68txptdw4LCPUc0PlPvfr
	0gA814Z43QvGaV8ahRrqc0A==
X-Received: by 2002:a05:6359:6b82:b0:16e:579a:4d6b with SMTP id ta2-20020a0563596b8200b0016e579a4d6bmr8756621rwb.18.1702672591022;
        Fri, 15 Dec 2023 12:36:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwpyGuMx2YomS1YYURUwzmQgXKlPAVYfeFz7G58bPgH6jpGQedpReEFTAX5oswnIusdcpIrA==
X-Received: by 2002:a05:6359:6b82:b0:16e:579a:4d6b with SMTP id ta2-20020a0563596b8200b0016e579a4d6bmr8756610rwb.18.1702672590685;
        Fri, 15 Dec 2023 12:36:30 -0800 (PST)
Received: from [192.168.1.14] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id w14-20020a0cef8e000000b0067f172531cbsm891936qvr.114.2023.12.15.12.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 12:36:30 -0800 (PST)
Message-ID: <8a433f12-b930-6095-9a49-db5f1d2836b5@redhat.com>
Date: Fri, 15 Dec 2023 15:36:28 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/3] selftests: livepatch: Test livepatching a heavily
 called syscall
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: mpdesouza@suse.com, Marcos Paulo de Souza <mpdesouza@suse.de>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
 <20231031-send-lp-kselftests-v3-3-2b1655c2605f@suse.com>
 <f9d82fa6-08d7-4ab6-badc-691987b37a82@linuxfoundation.org>
 <unpg4z7eig6qbudgulnr6sog65fq7s2dy4u2vp2dgkdrq5csdw@dltnxuw6kw5b>
 <8b95b96c-6aeb-4bf0-8ee9-2ba62330c672@linuxfoundation.org>
 <12a9ec1bc84dc6d4b461e5c780ba7d3c3aa91740.camel@suse.com>
 <76c4b967-1cb6-4f77-9402-f835b15adb10@linuxfoundation.org>
 <alpine.LSU.2.21.2312061530470.13051@pobox.suse.cz>
 <2498bf91-8057-43e8-98f2-4ed93c53ce9f@linuxfoundation.org>
From: Joe Lawrence <joe.lawrence@redhat.com>
In-Reply-To: <2498bf91-8057-43e8-98f2-4ed93c53ce9f@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/11/23 16:53, Shuah Khan wrote:
> On 12/6/23 07:39, Miroslav Benes wrote:
>> Hi,
>>
>> On Tue, 5 Dec 2023, Shuah Khan wrote:
>>
>>> On 12/5/23 05:52, mpdesouza@suse.com wrote:
>>>> On Fri, 2023-12-01 at 16:38 +0000, Shuah Khan wrote:
>>>
>>>> 0003-selftests-livepatch-Test-livepatching-a-heavily-call.patch has
>>>> style problems, please review.
>>>>
>>>> NOTE: If any of the errors are false positives, please report
>>>>         them to the maintainer, see CHECKPATCH in MAINTAINERS.
>>>>
>>>> I couldn't find any mention about "missing module name". Is your script
>>>> showing more warnings than these ones? Can you please share your
>>>> output?
>>>>
>>>> I'll fix MAINTAINERS file but I'll wait until I understand what's
>>>> missing in your checkpatch script to resend the patchset.
>>>>
>>>
>>> Looks like it is coming a script - still my question stands on
>>> whether or not you would need a module name for this module?
>>
>> I admit I am also clueless here. The module name is given in Makefile. In
>> this case in test_modules/Makefile. I do not know of anything else. There
>> is no MODULE_NAME macro. Could you elaborate, please?
>>
> 
> I see that now.
> 

Hi Shuah,

In the other replies to this thread, Marcos noted that he would add some
text to the commit / documentation on running and building the selftests
directly in the kernel tree (that would get my Ack) ... is there
anything else to be updated for a hopefully final v4 (for your Ack)?

Thanks,
-- 
Joe

