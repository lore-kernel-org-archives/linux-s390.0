Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F373DCD95
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037422; cv=none; b=csw2bSSH7gZMkPrHmsIQlN/zTM52gTpDg4OB7rVVssMC2L8VsuCy01Wp7BrHxJBQq73G7Pt4cwQB2a2gB/TBH9/Cb6CH3kdHhGqI0FWG35Xp1QCXGAkJUsV0/JwOa3V98dpTHZ68k4owdAZXNk6ahqTgKdkZwtKEDBpNHBj96SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037422; c=relaxed/simple;
	bh=lrIXAC8cYNoVygFDFSiOCaWQyot7ZJ6zRghfRlFdzz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLt9a9TR32LaX1oroBFIs+vwST5m2Hr5PaR69jvzPPTZgBwpFTRSWxOb3xAZXDrHHuonDbO3p/lqAdnhNAk2FcyjviFDzuBcFvFvG3R69pPeKLvYuUjMLw1yPWrMxul/s6Z1HZ37+8rW9Jj3azvbf4o6TUEPE10HcxIOv1fpy/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFD4U32w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJlqgjN8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFD4U32w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJlqgjN8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789037415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7hkRUQ+GXdK6lyDfi0TTOprM8ecwt5B1P/G3pNJiII=;
	b=FFD4U32wNygbsyWKXWU8fp8eBBVFdlLhK6cY8EbXxC1bXxfUyjYvabygJcJ1mQ3WZ8PtHp
	9iekiAFdOyrNNIaVYvIgFmTTE7H9/svsDQxClWeJjLHSEwWZ37YQwBxYcZpAZ/EDITyncP
	uVNWB25jPPIYtub9IEN1xPWSuV24Xy8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-UOnjJhbaNYWr9OdAQB3dUQ-1; Thu, 10 Sep 2026 06:50:13 -0400
X-MC-Unique: UOnjJhbaNYWr9OdAQB3dUQ-1
X-Mimecast-MFC-AGG-ID: UOnjJhbaNYWr9OdAQB3dUQ_1789037412
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cced8309bso66213665e9.3
        for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789037412; x=1789642212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7hkRUQ+GXdK6lyDfi0TTOprM8ecwt5B1P/G3pNJiII=;
        b=FJlqgjN8fNyj5sUYVLFPkFRJG6Y0kKHLxxFnbt2KmfRizK09cozWMJv9g7/1liRo/S
         lnTipB7cSn/g28p8+6yKRv/uZUAGDJNCN3KDsxTKKWlR5ybpQ8eo0tibXN1pIvrpjEAz
         hoo2f41QeVz6Z38mgd7b3C12uhs6Ikvz+GurbGPxy15kNd0jAZKjsfoBcNFk98Tb/VWn
         LaiEGKtGhB7hZg4ZR63BvHCdP53QM6k1fKGCiTl3unNtxbxPh1eHQCmWeVpQzvhaiq1h
         q6KcKWOBvxTk+0B9xc4jGlQ2zipM5RTy0Wo7k8XD6k1ljlreBJjvxz0/dkAuvcgnI7ZW
         8VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789037412; x=1789642212;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t7hkRUQ+GXdK6lyDfi0TTOprM8ecwt5B1P/G3pNJiII=;
        b=GUOUMBPyA4mR3ahTCbZLsJit29LP2W1yeifhZ2lrYlBXKgq+FfMS7qdymAIA/64ZAw
         kpawY4nxf+FgbAixASQ+wv5bHOkUJX62hZ31PWLhHzFFv8NI5b/880fRnrHyek8J9Zsq
         5Z4k5mCWc/ganMA9m0Q7WOK/FXv0bbONTV8uKaaSJlQ2nQFoggxcyFs1cw2zouKX3Rnd
         VijDWugK7rY9e3+gJdu+PJtnn1hmawDKOM2TVGeCqdorLnjU0FLxyk9qzS5zJpM09R2e
         wU+sJi3dp5ofAfMh71mjnH02gfdsU4EFrLyRHmPdxiMWiyO6aa0ehowh4K6bn9NHkyGY
         2jIg==
X-Forwarded-Encrypted: i=1; AKwUvBzve5TIc35FsoLakNKl+kH4aOYGzJMKkw/9vbGQAsT+ZRtLEcaSAxMvJzUL2VfPP37VjeMVoj1fxNI3@vger.kernel.org
X-Gm-Message-State: AFuF++lRLIQyjQsYOYJDvFcpIffM9VJ/ns0Z1DRVINDCbtSI4K8QizEe
	973VyKvZhd+FjgIFIsDqy6qDIRjN+vZuv1wbLbHSDYeyDZpPYLHE2rJw83EwCvYhkJl8fSbv618
	S1QD/U7bs4fVzLcPmYR+qdkEn26UsR+NoLb3swAlGGuqCW19MVrhNDBrgyr6J2pqwKhOR4JE=
X-Gm-Gg: AYBFou2I/52MXuH3Fv619ZbhzwTXL9OSnS9FnlT4nLnYwooZhuinv2ZWwRV44Q1UW4d
	KKaTIJGmPzPv6kWAwbPE73p2a45hTyI9K925T6UKb4yE0tRcBnxwxQhR0xUlP85y0v9EXL1arGb
	wlkkzg02ZrjJMPXml2dMIzYO7X+dyboXDzwbkSWFkJDuCb3tCGHFZc84v7OkGyzAp3rIBzHwUKH
	dtxF6gKD2GVOScRcuY9wSK2Yccgwpaf3+r9Z/jcPS95aerx9fkSuAn2RPfRpsWN1QZ4XObDJjYS
	I43hoaC2/B1vepWqO573+sg4THt+eoXWwlUhXtizoVK/O31ftCxnNzw6o4C2XZY6XnUDvqQN0iu
	Myquqnf+TtB5YZkniK0N0P0jka/Q0e2zaj0H28QCAsefIvfRvTPQuqKacO6PvLj9Y9boHde++Zg
	==
X-Received: by 2002:a05:600c:1da8:b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49cf825a530mr490158065e9.12.1789037412237;
        Thu, 10 Sep 2026 03:50:12 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49cf825a530mr490157565e9.12.1789037411810;
        Thu, 10 Sep 2026 03:50:11 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bfc1sm81538805e9.4.2026.09.10.03.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 03:50:11 -0700 (PDT)
Message-ID: <ebded824-c858-4187-948c-b5444f4bf82c@redhat.com>
Date: Thu, 10 Sep 2026 12:50:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/smc: fix abort_work termination in
 smc_conn_free()
To: Hidayath Khan <hidayath@linux.ibm.com>, sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260907114721.1303498-1-hidayath@linux.ibm.com>
 <20260908114743.481841F00A3A@smtp.kernel.org>
 <3991782b-7a63-4bc9-94c2-02b3f9173586@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3991782b-7a63-4bc9-94c2-02b3f9173586@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 8:48 AM, Hidayath Khan wrote:
> 
> On 08/09/26 5:17 pm, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [Critical] Late-queued `tx_work` can execute on a freed socket because it does not hold a socket reference, causing a use-after-free.
>> --
> Thanks for the Sashiko AI review. The finding is correct.
> 
> tx_work is the only one of the three connection work items with no socket
> reference:
> 
>    close_work   sock_hold smc_cdc.c:420   sock_put smc_close.c:444
>    abort_work   sock_hold smc_cdc.c:324   sock_put smc_core.c:1754
>    tx_work        none                                  none
> 
> The link group holds a reference while the connection is registered, which
> is what hides this. smc_conn_free() drops it in smc_lgr_unregister_conn()
> and never cancels tx_work - it only cancels abort_work - and the link
> group usually outlives the socket, so lgr->tx_wq is still there to run an
> item that was queued late.
> 
> Worth noting the fix in this patch does not transfer. conn->freed works
> for abort_work because abort_work holds a reference, so the socket is
> alive and the flag is safe to read. tx_work holds nothing, so by the time
> it runs there may be no conn to test. It needs the missing reference
> rather than a guard: sock_hold() at the three queue sites, sock_put() in
> smc_tx_work(), and the reference returned at the cancel sites that report
> they removed a pending item.
> 
> I will send that separately, since it is a different work item and a
> different fix. This patch is unchanged.
Could you please have a look at clashiko report, too? that looks
correct, too and more strictly tied to the issue addressed here.

Also note that netdev-wise the most relevant sashiko instance is
the nipa/clashiko one, as it includes reports/reviews/findings
from the public clashiko instance.

/P

