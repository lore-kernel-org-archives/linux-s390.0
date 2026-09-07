Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A34FECD7
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793288; cv=none; b=aap2VIWY6CIsTlkDM++imH2C3C2svMbhSzahUBDywzwFXXSq3maaCFWoujfoB8GQCk5Fptw+/PXuZQZyXkMp90S/BcBXL2Vsvr/2IJybtYfj9sgbBmnRY2uAFBzMcMNiZtdxMErQPsNSE3300DeaTOREca6CsmJpaND4MOUoCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793288; c=relaxed/simple;
	bh=nMqba0PLCY9uPGED8tG3zJJyaNmqT0Q3w3RJl64PkvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8Z+5GA0IduiQetqjy1H51nqREg9jFtJr+2FjClKY+BD2csWjYs2a+PzUnh7InddvK7iMvJFgsb92IJ9pzISYDYEOzUIH/Nrq5KH4fNjOFiULM8yvhyUZNUwug/cxvZ2RTZF9DnUR3fvvFpffvJcCbN7NpqQmJ0q8dbvoEwTSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnP1D1sz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=THskuGGD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnP1D1sz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="THskuGGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788793281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=paRFVhDUC8Ac0nV/S5eLXKX6HIbLso6Zrb5tMrEWLDw=;
	b=CnP1D1szv3I52kNtNyOAqcrgUzcTYEu5jqDFWVhBFKC6LE5k9Xc0p1PY7IX08yFyZBr9Ir
	oF/Na3H2jm2FdqAypUXuRv625IDBSzCslL6VvSZGM/as6I1UrABPp1t60kkSa9Z/kd8Ylo
	1R0qvlHB9SqiKokT3LxMPmkVJUwRR7A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-Gj1YdvX4M3WwoCHxlgsIVA-1; Mon, 07 Sep 2026 11:01:20 -0400
X-MC-Unique: Gj1YdvX4M3WwoCHxlgsIVA-1
X-Mimecast-MFC-AGG-ID: Gj1YdvX4M3WwoCHxlgsIVA_1788793279
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cf4cc2125so17424955e9.2
        for <linux-s390@vger.kernel.org>; Mon, 07 Sep 2026 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788793279; x=1789398079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=paRFVhDUC8Ac0nV/S5eLXKX6HIbLso6Zrb5tMrEWLDw=;
        b=THskuGGDG1dWhWqCUrSNse+XlvRPdC0R820H9cHL7sk2aQzoIDnpTPGHqIXSCjnMAu
         Doiu7cCFT2FK2iLcYP0yvAJC3mvt54ZO9LYyqdHZxMI+wDE2Y5Uath27Hum7LwcWeCtX
         w10mA38YtM1xVj3fz8Hzy0WntTe7VdVgwOGV4lxd9V7dqrs1YE4tHn7Ddj6nme9fauEZ
         F6ZWA2PJG612Sd5RuMrPPnrvuyLM8J2b/s/B5WSRf32MiEpJ+894q6wvNRRLC/vUG2Su
         vErC4Itpb09mc28Qjda5lZSMPPb3TAbUQ5j9KnokibMZ6yJZ8Vc8nsDsEF3nJexYQa6/
         8jWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793279; x=1789398079;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=paRFVhDUC8Ac0nV/S5eLXKX6HIbLso6Zrb5tMrEWLDw=;
        b=Ykh7dhi1/00inRxeU8OCIKWGVMileAFIG8TE+Q58DdRVFRdhvbJ0ZOChOAvFacgq6g
         rhnPsSPSBO/VVWuYxQYKbL/Jx48QmVR1XcbJY0uQrIaouQtjvb/tld1KxovZSJTGf22R
         +Y7RtrJARN4HS47B0OT1JwV/AemZistymBwIPGLBdz+bYHcJY9PKQmcCnbmX036O4noE
         ctzjZcSY/RyyssJv9wDKcQ5N5Bt2TJGwqSLPVRghsSMpPJNY2JsDSoJ4CpEmnaqXB7HP
         /rs40wYWAiDSvwptNn5dVy79XNbgHEQvG3qr9FD4ArtKSRcUPrY6IU8z1AGpKbYBkuJT
         meJw==
X-Forwarded-Encrypted: i=1; AKwUvBwS68XOBILmDdqRD2NkMnIptyA57ZA8ykaDMlur+HSfSGzwhLTkbxSIwN/3SboygdGaw9LHvwAx7pzX@vger.kernel.org
X-Gm-Message-State: AFuF++mi+bCzeDgCTfA8qIOTL/IlxYS1cqt03dg/ilA+bbuhEqVsrUNw
	VT4np5zcYP+nU+8vPT6he6Tg86+o+Fm3H+AEn1zJ3o03tpmZwbJKPt8HSui/yPXHHfcIF2BwCKy
	lXKiUH+3mXPKKXPpTZ+5J8YG8mkmIvg6owfrO135lK6IndfGf3lVIApcgCEMpcRA=
X-Gm-Gg: AYBFou3WQkDt2LuWsVf3Z8HfPanKO1hzYnsbcDorrz+qQ7oDfw0ClMyupLyK0i6vKoJ
	g4unHQnRpZ+VsoIvgnbv6laxhZZ7L3cgbwwFqiC65JgEpi/aYuhedCUgGV4Qvz8ctVEhkTDm16d
	mrjrDW5SC5pb8XYC/ta2xf9wNTp1Za8dcGMwDPUxDPWdhHAL6zkCRGQA3l01Abh6UHyb0G51zgG
	AjpKdhwcCGv4JF2JsxK2whHLxTeyUVRPYhjKyjfC3MFCP2ejFqIAXqdy1nzIonXTm5oPwYTbpg7
	gGgm8Jmk7spKMmeC4rSBRqTx6qvp7wjkF/FU3om/7IG03EGnuvkQNVJJRj+zYrazcJfC4pXm
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr414856825e9.4.1788793279221;
        Mon, 07 Sep 2026 08:01:19 -0700 (PDT)
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr414855735e9.4.1788793278808;
        Mon, 07 Sep 2026 08:01:18 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm845235665e9.0.2026.09.07.08.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 08:01:17 -0700 (PDT)
Message-ID: <3399a986-a8b6-4aed-80fe-19f12f3b68e2@redhat.com>
Date: Mon, 7 Sep 2026 17:01:16 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests GIT PULL 00/13] s390x: stflei test, fixes and sie
 lib rework
To: Janosch Frank <frankja@linux.ibm.com>, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, borntraeger@linux.ibm.com,
 linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
References: <20260824143740.291583-1-frankja@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260824143740.291583-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/08/2026 16.35, Janosch Frank wrote:
> We've finally accumulated enough patches for a pull/merge request:
> 
>      STFLE interpretation facility tests (Christoph & Nina)
>      stsi 3.2.2 regression test (Christian)
>      sie lib rework & fixes around test execution
> 
> Please pull/merge.
> 
> Thanks,
> Janosch
> 
> Pull:
> https://gitlab.com/frankja/kvm-unit-tests.git s390x-pull-2026-08
> 
> Merge:
> https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/merge_requests/88
> 
> Christian Borntraeger (1):
>    s390x: stsi: regression test for the STSI 3.2.2 count clamp
> 
> Christoph Schlameuss (4):
>    s390x: sclp: Remove unnecessary padding from struct sclp_facilities
>    s390x: sclp: Check sclp byte before reading feature bits
>    s390x: sclp: Use sclp_feat_check directly to read DIAG318 feature bit
>    s390x: Add test for STFLE interpretive execution (format-2)
> 
> Janosch Frank (6):
>    lib: s390x: Add function to get page root
>    lib: s390x: sie: Allocate physical guest memory via memalign
>    lib: s390x: sie: Memory rework
>    lib: s390x: snippet: Add function to create a guest of specific length
>    s390x: unittests: Reenable tcg for migration tests
>    s390x: skey: Fence TCG protection checks
> 
> Nina Schoetterl-Glausch (2):
>    s390x: snippets: Add reset_guest() to lib
>    s390x: sclp: Add detection of alternate STFLE facilities
> 
>   lib/s390x/mmu.h     |  7 +++++
>   lib/s390x/sclp.c    |  8 +++--
>   lib/s390x/sclp.h    |  8 +++--
>   lib/s390x/sie.c     | 22 +++++++++++--
>   lib/s390x/sie.h     |  3 +-
>   lib/s390x/snippet.h | 25 ++++++++++++---
>   s390x/diag258.c     |  4 +--
>   s390x/edat.c        |  5 +--
>   s390x/mvpg-sie.c    |  4 +--
>   s390x/pv-diags.c    |  2 +-
>   s390x/pv-icptcode.c |  4 +--
>   s390x/pv-ipl.c      |  2 +-
>   s390x/sie-dat.c     |  4 +--
>   s390x/sie.c         | 13 +++-----
>   s390x/skey.c        | 15 ++++++---
>   s390x/spec_ex-sie.c | 12 +++----
>   s390x/stfle-sie.c   | 74 ++++++++++++++++++++++++++++++++++++++++---
>   s390x/stsi.c        | 76 ++++++++++++++++++++++++++++++++++++++++++++-
>   s390x/unittests.cfg |  7 +----
>   19 files changed, 237 insertions(+), 58 deletions(-)
> 

Thanks, finally applied now!

  Thomas

