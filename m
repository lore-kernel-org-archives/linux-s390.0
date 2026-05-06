Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A34495528
	for <linux-s390@vger.kernel.org>; Wed,  6 May 2026 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086285; cv=none; b=rBDGp5ienjdzdtBXabPFHusShlU4qGQXs5NZFxsn6C8wATwEqEbGaiM0gEsgGiVNtK2dapb5xQRiWTP0hTcoEqi8q+J4ysLyXPkvRm8gCik3SeGqcPFbNepJ3IVhtBR/mDz2RO4PD7ajFASAjSkWHhr2kjmb3g7m6Do6USRDr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086285; c=relaxed/simple;
	bh=kmXO6bOal8e9S0vy/8CkGtirU+4n84kejo4Z5qjB0Ls=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LFD52X61HEyiA2CqmGsx2nVtNEcwcUgFJSsq2qsoGoA4lm/ajH1hcii1x2TPF9CrsXrc+OPdRnbBpieQBiGR2yB86F8GdMO2kkAR66vsnIPW1fVoB5j4hB7umOmw4pUtkPYeYJRoElENrjsZT5luGy5GbTFhSpAIBS4ttKUjH9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUNAr+rv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUNAr+rv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so94370725e9.0
        for <linux-s390@vger.kernel.org>; Wed, 06 May 2026 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086281; x=1778691081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmXO6bOal8e9S0vy/8CkGtirU+4n84kejo4Z5qjB0Ls=;
        b=nUNAr+rvWR9omzI5gurtfdB9dtcQ9wGJv2Hs3veELq4aoIvJP4ARuE/4SfpJX9ZBXH
         0SDd9RYFy3iJu3F1WER7quD/BU+8eajBzNQN/c3tmhcf0oPerhHPSa2sP8YZaSnbwSdg
         bY2VBC1A0/+FxAdoc+QO2X4qSYECbmu0MCeMWyKmKyfW9loEyeACJ/nBYiVF9FWO6sWs
         gvpB/rF1v67uNHKquNNz/LbXUsqc0wlQQY+VzYJz/uAR1wNdokcPQSCS8zCP4toHf8Cj
         Vx+uB+OhIx7N0SaAVlqaVx9xAzr5FZDATC4MIhORyNlr6L22gbNPh+EYDUQ8DBJTkRYw
         rVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086281; x=1778691081;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmXO6bOal8e9S0vy/8CkGtirU+4n84kejo4Z5qjB0Ls=;
        b=pLbVXYHokgANXrMSYXGbqK5Npt5mrEVU86Qju0/r8hSvrt/4e2px3285xNh4VpBMw+
         Ri5wfkPwbBav2NkfitBmXv6IiTxBQpN2o28qbIEnmjTAvzUzr6QNjiChdWFn1sxwPl0j
         NS98131A6Uks44bSwGZu5ZV221LnZ0vK+W3Y++T97YJInR5OdeJ+j8UicIY4bO9opjXA
         92Ec7+ZBOIIVV7txHHBEVDwNOfPMGACOI3R3fDSyRyfmDao+pTgIgqQnRL+XOSaeh4ON
         45bQIzw6kuKW0EQeyW2twnLgpNAFsv0YfjKOz/u+M3UinCe7M7JwpmKGgUK+S9DgzSti
         lt9w==
X-Forwarded-Encrypted: i=1; AFNElJ/I63XjuqqJR0+Bp30MQffTG+G1nT33vrha9+I+tvxeJ+Qnf3+gqh2cjq7ChP2nC8kPAkXJ3o6WVmcT@vger.kernel.org
X-Gm-Message-State: AOJu0Ywul0pg6v91cFm3vZjFdfd/gb6PkFaoNXVOYq3VBmBsBADpaRWZ
	A1puofud5eNhgQGdjd151FQlwkbiopcCHcMvYNlHXVc+quD/g1LwRgh+
X-Gm-Gg: AeBDiev66Ssx+3eo98NaFL4AGTURTIxRyQ/L5HmxHGS+xKuRdgFeJ7l75qYb4cE5vyJ
	xDDTrxmPgfrskhWCkYbQfHqHKrcu7JU5J2UcZzgzAWhSxAvdCPqR63ddZ3sGi4THQLj3+gIPKmH
	TIiQ/Da6r87ox+hVH0o6qISvt7fWpSMXWaZUDGerH83TmxpUCZYSXVW/v3Hke2E8764sTQnZ+ek
	PHEcQslKrh2alvZMaCVYoZPkoV7mdyytxd8JV81rPVGdZtitQZxgv+7rhnZk6P/UZ+WA3lJaVRl
	86upwPvovEAJLwGerMY3ZBYjE97R+fg2b2f32GsS8EgFjBVgIZdx4pZWwIdTj++Sr+KdDV0Dfab
	qXJg/s5w5GJchEHfvwpl8wRmxvNjD3/eaajAYyRIrdGQNVAr+FUpdEQZUuLEXlzS4ZyvG9cfnWc
	j6EhmCD8PLK2NSWYCHGpZVwl1bO88AqEQhMfMqMSRVvuaksCqJidJXxfjGZtRCO596OgllXQ==
X-Received: by 2002:a05:600c:871b:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48e51f45eddmr69388035e9.17.1778086280581;
        Wed, 06 May 2026 09:51:20 -0700 (PDT)
Received: from [10.128.10.158] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53895f0asm65146955e9.2.2026.05.06.09.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 09:51:20 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <cffeec5e-068c-4562-98ef-f65e346dff3c@gmail.com>
Date: Wed, 6 May 2026 17:51:19 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Julian Braha <julianbraha@gmail.com>
Subject: Re: [RESEND PATCH] s390: fix dead defaults for
 S390_MODULES_SANITY_TEST and S390_UNWIND_SELFTEST
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
 meted@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 akpm@linux-foundation.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260414215651.151228-1-julianbraha@gmail.com>
 <a3adc8e8-ce4c-458c-a0c8-c0e66078589d-agordeev@linux.ibm.com>
 <b3dba59d-22cc-4404-8876-8fd4e22021b5@gmail.com>
 <3ec20142-09d1-436f-a623-21a2440ef7f0-agordeev@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <3ec20142-09d1-436f-a623-21a2440ef7f0-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/26 13:37, Alexander Gordeev wrote:
> In the end of the day I see no impact on the end result (aka the
> generated config) - please correct me if I am wrong.

Yes, there is actually an impact on the end result / the generated
config:

When a user of the kernel build system (e.g. 'make menuconfig') enables
the config option KUNIT_ALL_TESTS, the user expects *all of the tests*
to be enabled. Which is what commit
25d36a85c61b ("s390/test_unwind: convert to KUnit")
was attempting to do with these tests, but it appears they made a
copy-paste mistake. This is the commit referenced in the Fixes tag.

The point is, these tests were intended to be included with
KUNIT_ALL_TESTS, but aren't. This is unintended behavior, and the
definition of a bug in the kernel configuration spec.

That being said, I do agree with you that this is pretty low in
severity, as far as bugs go. It is kunit tests we're talking about,
after all. I'll check with Greg to see if he thinks this is worthy of
a Fixes tag. Another, similar patch I sent out includes the Fixes tag,
and has not received any objections from its 3 reviewers and testers
so far:
https://lore.kernel.org/all/20260405161545.161006-1-julianbraha@gmail.com/

> I think once the tool is officially included you could refer to it
> in the commit message,

I will also check on the best practices for tool-assisted development.
In the past, I have received encouragement for acknowledging the tool:
https://lore.kernel.org/all/bfdfdb05-77e2-455d-b68d-9da3fd9d1c0d@lucifer.local/
and the official kernel docs require an acknowledgement for AI tool
assistance (although this tool is not AI and doesn't generate code...)

- Julian Braha
