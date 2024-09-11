Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2814D702
	for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726092102; cv=none; b=qdsSXoFfVqtC3IDLeRaZux4YDLxAX+HdcbtAoQICF8FErhX2HR0B9h+0z2sOHlHM8ulnC2DuL4G25JQ0qhK6HapUFR2BA0rVblyOZameZIX5Wmzh96pA33KBxhruIlygErcz5XuBeeUdWMkXWmSdmW5bz+XjFH+s2ycc3R4VSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726092102; c=relaxed/simple;
	bh=Agciipw5hWkC4EpzVmCjBUgtbk1AQ5kWWqM/SSA0exk=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=J7s2jnWH+nwH1K4Zb/GszXfanqjODVo+zTY/zBBO7drhmnGfrsvZvHhfHpF3o7w/8TedtRCSYHCxvreDGR9mZxFdnntGAmlTYa+H19XWHlQp2rgk/hnLIU2qqQ2TEeIYkFWhgqvxQmfkl8JI7d4afWpmPnJ8nTibKKCMeuBbWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tE2eLl+H; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tE2eLl+H"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d54ab222fcso13804747b3.1
        for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2024 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726092100; x=1726696900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q13JQ4aJstpTY70GjrenWYuGyd1pnSkxKkLl8Jd4LLI=;
        b=tE2eLl+HXo3H6oZbJnL998LFc8kJQ8Iyhs6fxaXP7Wy4z+bq87DM7WD21u/O3arYql
         yGM1u+QACFLyRzgEZ3UvSCe650KX7q1PEh4JwSkUWwiaAWt72e6hZgfbSJvyNwp40QST
         dp9wXVmyUmd7SdJviNN0orJKif009zsbl1ka2OzDyGXU7ZaL2dgvV8MFg2Y2p5mC2kLo
         1WZIDYHGPD2gMxfzUNy1+jmnnoKPS0olJx9KBDqONpNxqELCabNXseHlH/tA3ALywS8y
         tqydpkhwSkWgSpsH3SwZZPZ4hPr6FI/D0LghwRnBRPBmf5IrGYyOH55LkfHGxwMq+nX+
         zWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726092100; x=1726696900;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q13JQ4aJstpTY70GjrenWYuGyd1pnSkxKkLl8Jd4LLI=;
        b=TmV8bYSjbN72ksAzU3H44lVP7IFMXs+v745gUq3KH63mMlLKPtRiCBSihgKf7OLhkh
         4P+lcdzVymGojXoaD7D3cicg2TRq7xt0yg99NFjk2NKPCCCfw/z/vAserdz5q9qKnXa3
         26No7IxUHvxUKZUzgQf9T+vwUv6AJqBY9Srw/rNsU4uhao4bjCEIRi3uSQpnsLJfRgWX
         LmzyWmiTWF1iYPT7yDVTeAwmGSIXujuoaNgCfHps20psyrracDwybUi2eyV1XOj4Lrw3
         BhGpcGvQNG12IKcTt6MLz3i+JQCNMFHz4jLA7rsvIYksyD2VoyJm2X16FkOI6r3nftRs
         8rDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLJwe68AMa4D4X3gHNdeWU270cZpleqI26hbiS8QMJytPvT0bsSSV1xpMbNYLU87kYkoDH82KggMcq@vger.kernel.org
X-Gm-Message-State: AOJu0YxHEuJ2CQGm+AE9OvSf760EIWwC/beBwvoELMZ5i/l0vgiciHfl
	C6ud4jQXO85xQaK8Pdv7YNdzQQNmHvVeSspfFNVaTxBWZMJRy4yjFLXeEjv1poKlIfAGOyU2aNY
	MdfpB8HiqSNHQyhX6cN53+g==
X-Google-Smtp-Source: AGHT+IEh6F4b46/1LwAS/WUGX/NAwM3UP2BxZSsRe7RROOaYU54OCz40zI1kT+hftf0HBDiAU78eGBwhCC/X5Gc0CA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:1743:b0:e03:3cfa:1aa7 with
 SMTP id 3f1490d57ef6-e1d9db9e1b8mr1014276.1.1726092099527; Wed, 11 Sep 2024
 15:01:39 -0700 (PDT)
Date: Wed, 11 Sep 2024 22:01:38 +0000
In-Reply-To: <Ztl-AjEEbIbX4lnm@gmail.com> (message from Ingo Molnar on Thu, 5
 Sep 2024 11:46:42 +0200)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntr09pdf3x.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 2/5] perf: Hoist perf_instruction_pointer() and perf_misc_flags()
From: Colton Lewis <coltonlewis@google.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: kvm@vger.kernel.org, oliver.upton@linux.dev, seanjc@google.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	will@kernel.org, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
	naveen@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Ingo Molnar <mingo@kernel.org> writes:

> * Colton Lewis <coltonlewis@google.com> wrote:

>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -6915,6 +6915,16 @@ void perf_unregister_guest_info_callbacks(struct  
>> perf_guest_info_callbacks *cbs)
>>   EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
>>   #endif

>> +unsigned long perf_misc_flags(unsigned long pt_regs *regs)
>> +{
>> +	return perf_arch_misc_flags(regs);
>> +}
>> +
>> +unsigned long perf_instruction_pointer(unsigned long pt_regs *regs)
>> +{
>> +	return perf_arch_instruction_pointer(regs);
>> +}

> What's an 'unsigned long pt_regs' ??

That is fixed in a later commit. I will correct this one also.

> Thanks,

> 	Ingo
